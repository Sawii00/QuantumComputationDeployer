from netsquid.qubits.operators import H, CNOT
from netsquid.components import Message
from netsquid.protocols import NodeProtocol
from netsquid.components.instructions import *
from netsquid.qubits import create_qubits, operate
from qiskit import QuantumCircuit
from qiskit.circuit import Clbit
from netsquid import sim_reset, sim_run

from .network import *


class ExecutionProtocol(NodeProtocol):
    """
    The class ExecutionProtocol implements the protocol for executing the distributed computation that will be assigned
    to each node of the network.
    It stores internally information such as: the network, the circuit is has to execute, and a reference to the node itself
    Each node is given the entire circuit and will execute in parallel with the others only the instructions
    that involve him.
    """

    def __init__(self, node: Node, gate_tuples, network: NetworkWrapper):
        super().__init__(node)
        self.gate_tuples = gate_tuples  # List of gates of the algorithm
        self.node = node
        self.network = network
        self.coupling_map = self.network.coupling_map  # List of coupled ebits between QPUs

        self.instructions = {
            "h": INSTR_H,
            "y": INSTR_Y,
            "z": INSTR_Z,
            "x": INSTR_X,
            "s": INSTR_S,
            "t": INSTR_T,
            # "toffoli": netsquid.components.instructions.INSTR_TOFFOLI,
            # "swap": netsquid.components.instructions.INSTR_SWAP,
            "prep_z": INSTR_INIT,
            "cz": INSTR_CZ,
        }

    def is_local_qubit(self, qubit: Qubit):
        """
        Returns True if the given qubit belongs to the node executing the protocol.

        Args:
            qubit: qubit to check if local

        Returns: True if qubit is local, False otherwise

        """
        return self.get_local_qubit_index(qubit) is not None

    def is_local_cbit(self, bit: Clbit):
        """
        Returns True if the given classical bit belongs to the node executing the protocol.

        Args:
            bit: bit to check if local

        Returns: True if bit is local, False otherwise

        """
        return self.node.name in bit.register.name

    def get_local_qubit_index(self, qubit: Qubit):
        """
        Returns the index within the local register of the specified qubit or None if it does not belong to the node
        executing the protocol

        Args:
            qubit: qubit of which to find the local index

        Returns: qubit's position inside local register or None if it is not there

        """
        if self.node.name in qubit.register.name:
            return qubit.index
        return None

    def get_local_qubit_indices(self, qubit_list: list):
        """
        Returns the indices within the local register of the specified qubits

        Args:
            qubit_list: list of qubits of which to retrieve the indices

        Returns: list of indices of the input qubits

        """
        res = []
        for qubit in qubit_list:
            index = self.get_local_qubit_index(qubit)
            if index is None:
                raise Exception("Cannot retrieve qubit indices... a qubit does not belong to the current node")
            res.append(index)
        return res

    def remote_cx(self, q0: Qubit,
                  ent0: Qubit,
                  q1: Qubit,
                  ent1: Qubit):
        """
        Performs the "Remote CNOT" operation between two QPUs by specifying first the control qubit and communication qubit
        of the "Control QPU" and then the target qubit and communication qubit of the "Target QPU".
        The specified Ebits must be entangled or an error is raised.

        The remoteCX operation is executed as:
        cx q0 [0] , ent0 [0];
        cx ent1 [0] , q1 [0];
        h ent1 [0];
        measure ent0 [0] -> ce0t1 [0];
        if ( ce0t1 ==1) x q1 [0];
        measure ent1 [0] -> ce1t0 [0];
        if ( ce1t0 ==1) z q0 [0];

        Args:
            q0: control qubit
            ent0: control communication qubit
            q1: target qubit
            ent1: target communication qubit

        """
        # let's find the two nodes of the gate
        node0 = self.network.get_owner_of_qubit(q0)
        node1 = self.network.get_owner_of_qubit(q1)
        if node0 is node1:
            raise Exception("Cannot do remote CX on the same node")

        # Qubit and Ebit must belong to the same node
        if node0 is not self.network.get_owner_of_qubit(ent0) or node1 is not self.network.get_owner_of_qubit(ent1):
            raise Exception("Malformed remote CX: make sure each node has a qubit and ebit")

        # Let's find the classical connection between the two nodes
        connection = self.network.get_classical_connection_between_nodes(node0, node1)
        if connection is None:
            raise Exception(f"There is no classical connection between the nodes {node0.name} and {node1.name}")

        # We check if this node is supposed to be the control or target
        if self.node is node0:
            # We are the control (The first node specified in the instruction is the Control)

            # We identify its endpoint within the classical communication channel
            if list(connection.ports.values())[0].connected_port.component is node0:
                port0 = list(connection.ports.values())[0].connected_port
            else:
                port0 = list(connection.ports.values())[1].connected_port

            # The control asserts that the ebits are currently entangled
            ent_index = None
            for i in range(len(self.network.entangled_qubits)):
                if [ent0, ent1] == self.network.entangled_qubits[i] or [ent1, ent0] == self.network.entangled_qubits[i]:
                    ent_index = i
                    break

            if ent_index is None:
                raise Exception("Ebits must be entangled for remote CX to work")

            # Entanglement is consumed
            self.network.entangled_qubits.pop(ent_index)

            INSTR_CX(self.node.subcomponents["main_memory"],
                     positions=[q0.index, ent0.index])

            meas = INSTR_MEASURE(self.node.subcomponents["main_memory"],
                                 positions=[ent0.index])
            # The control outputs the result of the measurement through its port
            port0.tx_output(meas[0])
            # Waiting for the measurement of the target
            yield self.await_port_input(port0)
            mex = port0.rx_input()
            val = mex.items[0]
            if val == 1:
                INSTR_Z(self.node.subcomponents["main_memory"],
                        positions=[q0.index])
            # To synchronize the execution of these complex gates an Acknowledgment Protocol is employed.
            # The header has the purpose of allowing the selective extraction of the ack even if multiple messages are
            # ready to be read from the input queue.
            port0.tx_output(Message("ACK_RCX", header="RCX"))

        elif self.node is node1:  # The current node is the target
            # We identify its endpoint within the classical communication channel
            if list(connection.ports.values())[0].connected_port.component is node1:
                port1 = list(connection.ports.values())[0].connected_port
            else:
                port1 = list(connection.ports.values())[1].connected_port

            INSTR_CX(self.node.subcomponents["main_memory"],
                     positions=[ent1.index, q1.index])
            INSTR_H(self.node.subcomponents["main_memory"],
                    positions=[ent1.index])
            # Waits for the control's measurement
            yield self.await_port_input(port1)
            mex = port1.rx_input()
            val = mex.items[0]
            if val == 1:
                INSTR_X(self.node.subcomponents["main_memory"],
                        positions=[q1.index])
            meas = INSTR_MEASURE(self.node.subcomponents["main_memory"],
                                 positions=[ent1.index])
            # Sends its measurement to the target
            port1.tx_output(meas[0])
            # Waits for the acknowledgement from the target before proceeding
            yield self.await_port_input(port1)
            mex = port1.rx_input(header="RCX")
            if mex.items[0] != "ACK_RCX":
                raise Exception("Could not synchronize nodes")
        else:
            raise Exception("Invalid parameters in Remote CNOT gate")

    def entangle_qubits(self, q0: Qubit,
                        q1: Qubit):  # AT SOURCE https://github.com/Wojtek242/draft-irtf-qirg-principles/blob/master/draft-irtf-qirg-principles-07.txt (line 672)
        """
        Allows for local as well as "AT SOURCE" entanglement of two qubits:
        - If the two qubits are local to this Node, they are entangled.
        - If the two qubits are of different Nodes, they are entangled only if coupled.

        Args:
            q0: first qubit to be entangled
            q1: second qubit to be entangled

        """
        if q0 == q1:
            raise Exception("Cannot entangle a qubit with itself")

        node0 = self.network.get_owner_of_qubit(q0)
        node1 = self.network.get_owner_of_qubit(q1)
        # Local entanglement
        if node0 is node1:
            ent_q1, ent_q2 = create_qubits(2)
            operate(ent_q1, H)
            operate([ent_q1, ent_q2], CNOT)
            self.node.subcomponents["main_memory"].put(ent_q1, q0.index)
            self.node.subcomponents["main_memory"].put(ent_q2, q1.index)
        else:
            # We retrieve the quantum connection between the QPUs
            quantum_connection = self.network.get_quantum_connection_between_nodes(node0, node1)
            if quantum_connection is None:
                raise Exception(f"There is no quantum connection between the nodes {node0.name} and {node1.name}")

            classical_connection = self.network.get_classical_connection_between_nodes(node0, node1)
            if classical_connection is None:
                raise Exception(f"There is no classical connection between the nodes {node0.name} and {node1.name}")

            # Checks the ebits are coupled before allowing the entanglement
            found = False
            for entry in self.coupling_map:
                if (node0.name == entry[0].name and q0.index == entry[0].index) or \
                        (node0.name == entry[1].name and q0.index == entry[1].index):
                    if (node1.name == entry[0].name and q1.index == entry[0].index) or \
                            (node1.name == entry[1].name and q1.index == entry[1].index):
                        found = True

            if not found:
                raise Exception("Cannot execute entanglement between uncoupled ebits")

            # TODO: check ebits are not already entangled with others at this point

            if self.is_local_qubit(q0):
                # We identify its endpoint within the quantum communication channel
                if list(quantum_connection.ports.values())[0].connected_port.component is node0:
                    port0 = list(quantum_connection.ports.values())[0].connected_port
                else:
                    port0 = list(quantum_connection.ports.values())[1].connected_port

                # We identify its endpoint within the classical communication channel
                if list(classical_connection.ports.values())[0].connected_port.component is node0:
                    port0_c = list(classical_connection.ports.values())[0].connected_port
                else:
                    port0_c = list(classical_connection.ports.values())[1].connected_port

                # The first nodes created the entangled pair and distributes it
                ent_q0, ent_q1 = create_qubits(2)
                operate(ent_q0, H)
                operate([ent_q0, ent_q1], CNOT)
                self.node.subcomponents["main_memory"].put(ent_q0, q0.index)
                # Saves in the global list of entangled pairs the current ones
                self.network.entangled_qubits.append([q0, q1])
                port0.tx_output(ent_q1)
                yield self.await_port_input(port0_c)
                # To synchronize the execution of these complex gates an Acknowledgment Protocol is employed.
                # The header has the purpose of allowing the selective extraction of the ack even if multiple messages
                # are ready to be read from the input queue.
                mex = port0_c.rx_input(header="ENT")
                if mex.items[0] != "ACK_ENT":
                    raise Exception("Could not synchronize entanglement")
            else:
                # We identify its endpoint within the quantum communication channel
                if list(quantum_connection.ports.values())[0].connected_port.component is node1:
                    port1 = list(quantum_connection.ports.values())[0].connected_port
                else:
                    port1 = list(quantum_connection.ports.values())[1].connected_port

                # We identify its endpoint within the classical communication channel
                if list(classical_connection.ports.values())[0].connected_port.component is node1:
                    port1_c = list(classical_connection.ports.values())[0].connected_port
                else:
                    port1_c = list(classical_connection.ports.values())[1].connected_port

                # Waits for the entangled qubit coming from the first node
                yield self.await_port_input(port1)
                mex = port1.rx_input()
                ent_q1 = mex.items[0]
                self.node.subcomponents["main_memory"].put(ent_q1, q1.index)
                # Sends acknowledgement
                port1_c.tx_output(Message("ACK_ENT", header="ENT"))

    def condition_passed(self, gate_tuple):
        """
        Checks whether the gate is controlled and, in such case, if the condition is satisfied.

        Args:
            gate_tuple: instruction to be checked

        Returns: True if the node can execute this instruction, False if a condition prevents it.

        """
        gate, qubits, bits = gate_tuple

        if gate.condition is None:
            return True
        else:
            # Checks if the name of the current node appears in the condition register and if such register is equal to
            # the value which satisfies the condition.
            if gate.name.lower() in ["remotecx", "entangle"]:
                raise Exception("Controlled remoteCNOT and controlled entanglement are not supported")
            return self.node.name in gate.condition[0].name and self.node.register_equal(gate.condition[1])

    def measure(self, qubit: Qubit, cbit: Clbit):
        """
        Performs a local measurement and saves the result in the specified bit of the register.
        The specified qubit and classical bit must be of the same QPU.
        Args:
            qubit: qubit to be measured
            cbit: classical bit in which to store the result

        """
        res = INSTR_MEASURE(self.node.subcomponents["main_memory"],
                            positions=[qubit.index])
        self.node.classical_register[cbit.index] = res
        print(f"{self.node.name} measured: {res}")

    def local_cx(self, control: Qubit, target: Qubit):
        """
        Performs a local cnot between the specified qubits only if the topology of the current node allows it.
        The specified qubits must belong to the same QPU.
        Args:
            control: local control qubit
            target: local target qubit

        """
        if control == target:
            raise Exception("CNOT is a two qubit gate... cannot execute on a single qubit")
        if self.node.topology is None or (control.index, target.index) in self.node.topology:
            INSTR_CNOT(self.node.subcomponents["main_memory"],
                       positions=self.get_local_qubit_indices([control, target]))
        else:
            raise Exception(f"Invalid CNOT with the given coupling map of node {self.node.name}")

    def execute_instruction(self, gate_tuple: tuple):
        """
        Executes the specified instruction on the current Node.

        Args:
            gate_tuple: instruction to be executed

        """
        gate, qubits, bits = gate_tuple

        if self.condition_passed(gate_tuple):
            if gate.name.lower() == "entangle":
                yield from self.entangle_qubits(*qubits)
            elif gate.name.lower() == "remotecx":
                yield from self.remote_cx(*qubits)
            elif gate.name.lower() == "measure":
                self.measure(*qubits, *bits)
            elif gate.name.lower() == "cx":
                self.local_cx(*qubits)
            else:
                # Calls the specific instruction within the Table specified in the constructor.
                try:
                    self.instructions[gate.name.lower().strip()](self.node.subcomponents["main_memory"],
                                                                 positions=self.get_local_qubit_indices(qubits))
                except KeyError:
                    raise Exception(f"Instruction {gate.name} has not yet been implemented")

    def can_execute(self, gate_tuple: tuple):
        """
        Checks if the current Node is allowed to execute the specified instruction. The instruction must make use of at
        least on qubit pertaining to the current Node. For remote instructions such as entanglement or remoteCX, both
        parties execute the instruction but will behave differently according to the inner implementation.
        (See remote_cx and entangle_qubits)

        Args:
            gate_tuple: instruction to be executed

        """
        gate, qubits, bits = gate_tuple
        one_local = False
        # We check if there is at least one local qubit.
        for qubit in qubits:
            if self.is_local_qubit(qubit):
                one_local = True
                break
        if not one_local:
            return False

        # RemoteCX and Entanglement are executed by both parties.
        if gate.name.lower() in ["remotecx", "entangle"]:
            return True
        elif gate.name.lower() == "measure":
            if self.is_local_qubit(*qubits) and self.is_local_cbit(*bits):
                return True
            else:
                raise Exception("Remote measurements are not supported yet")
        else:
            # For normal instructions it checks that all qubits belong to the current Node.
            for qubit in qubits:
                if not self.is_local_qubit(qubit):
                    raise Exception(f"Invalid qubits were specified in the gate {gate.name}")
            return True

    def run(self):
        """
        Executed the protocol
        """
        for gate_tuple in self.gate_tuples:
            if self.can_execute(gate_tuple):
                yield from self.execute_instruction(gate_tuple)


class Simulation:
    """
    The class Simulation contains all the objects that are required to execute the simulation and performs an initialization
    of the system as well as asserting the coherence of the structural topology of the network and the algorithm to be
    mapped upon it.
    """

    def __init__(self, network: NetworkWrapper, quantum_circuit: QuantumCircuit):
        """
        Performs coherence check of the topology and quantum circuit to be executed.
        Args:
            network: network on which to execute the computation
            quantum_circuit: circuit description of the computation
        """
        self.network = network
        self.quantum_circuit = quantum_circuit
        self.__check_classical_registers()
        self.__check_quantum_registers()
        self.__setup_classical_connections()
        self.__check_coupling_map()

    def __check_classical_registers(self):
        """
        Checks if the QASM definition of registers and the QPUs definition in the YAML are coherent with each other.
        Requirements:
        - Each node must contain 1 classical register in the QASM and the node's name must be contained in the reg's name
        - There cannot be registers which are not mapped to QPUs.
        """
        # Setting up classical registers
        for reg in self.quantum_circuit.cregs:
            found = False
            for node_name, node in self.network.get_node_items():
                if node_name in reg.name:
                    if len(node.classical_register) != 0:
                        raise Exception("Another register is already bound to this node")
                    node.initialize_classical_register(reg.size)
                    found = True
                    break
            if not found:
                raise Exception("No node maps to the specified classical register")

    def __check_quantum_registers(self):
        """
        Checks if the QASM definition of registers and the QPUs definition in the YAML are coherent with each other.
        Requirements:
        - Each node must contain 1 quantum register in the QASM and the node's name must be contained in the reg's name
        - There cannot be registers which are not mapped to QPUs.
        """
        for reg in self.quantum_circuit.qregs:
            found = False
            for node_name, node in self.network.get_node_items():
                if node_name in reg.name:
                    if reg.size != node.subcomponents["main_memory"].num_positions:
                        raise Exception("Node definition and circuit do not match")
                    else:
                        if node.subcomponents["main_memory"].num_used_positions != 0:
                            raise Exception("Another register is already bound to this node")
                        node.subcomponents["main_memory"].put(create_qubits(reg.size))
                        found = True
                        break
            if not found:
                raise Exception(f"Register: {reg.name} does not match with any node")

    def __setup_classical_connections(self, CHANNEL_LENGTH: int = 20):
        """
        A classical connection is automatically setup between each node of the network.

        Args:
            CHANNEL_LENGTH: length of the classical channel

        """
        node_list = list(self.network.network.nodes.values())
        for i in range(len(self.network.network.nodes)):
            for j in range(i + 1, len(self.network.network.nodes)):
                self.network.network.add_connection(node_list[i], node_list[j],
                                                    ClassicalDirectConnection(
                                                        f"c_conn_{node_list[i].name}_{node_list[j].name}",
                                                        CHANNEL_LENGTH), label=f"classical_{i}_{j}")

    def __check_coupling_map(self):
        """
        Checks that the specified coupling map is coherent with the network's structure and specifications.
        Requirements:
        - Specified nodes must exist
        - Specified qubits must be defined as an Ebit of the specified node
        - An Ebit cannot be coupled with more than one other Ebit
        """
        for entry in self.network.coupling_map:
            for operand in entry:
                try:
                    node0 = self.network.network.nodes[operand.name]
                except KeyError:
                    raise Exception(f"Invalid node {operand.name} defined in the coupling map")
                found = False
                for ebit in node0.ebits:
                    if operand.index == ebit.index:  # and not ebit.paired:
                        found = True
                        ebit.paired = True
                        break
                if not found:
                    raise Exception("Invalid coupling map defined")

    def start(self):
        """
        Starts the Simulation by executing a protocol for each node.
        """
        sim_reset()
        for node in self.network.network.nodes.values():
            protocol = ExecutionProtocol(node, self.quantum_circuit.data, self.network)
            protocol.start()
        stats = sim_run()
        print(stats)
