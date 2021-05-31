import netsquid as ns
import qiskit as qs
from utils import *


'''
The class QuantumNode is a wrapper of ns.nodes.Node with added support for a quantum memory,
created as a subcomponent of name 'main_memory', and a classical register.
Parameters:
- name: name of the node
- n_of_qubits: number of qubits available for computations. This will be checked against QASM for a match.
- ebits: list of communication bits
- topology: list representing the internal topology of the QPU (bits on which a CNOT can be applied)
'''


class QuantumNode(ns.nodes.Node):
    def __init__(self, name: str, n_of_qubits: int, ebits: list, topology: list = None):
        super().__init__(name)
        self.add_subcomponent(ns.components.QuantumMemory("main_memory", n_of_qubits))
        self.ebits = set()
        self.classical_register = []

        # Adds the specified ebits to the set.
        for e in ebits:
            if int(e) < 0 or int(e) >= n_of_qubits:
                raise Exception(f"Invalid EBIT definition for node {self.name}... check indices")
            self.ebits.add(Ebit(int(e)))
        # Asserts the correctness of the topology for the current Node and creates the inner map.
        if topology is not None:
            self.topology = []
            for t in topology:
                elements = t.split(",")
                if len(elements) != 2:
                    raise Exception(f"Invalid format for the topology of node {self.name}")
                if int(elements[0].strip()) >= n_of_qubits or int(elements[1].strip()) >= n_of_qubits:
                    raise Exception(f"Invalid values for the coupling map of node {self.name} defined in YAML")
                self.topology.append((int(elements[0]), int(elements[1])))
        else:
            self.topology = None

    '''
    Initializes the classical register with zeros.
    Parameters:
    - n: number of classical bits in the local register
    '''

    def initialize_classical_register(self, n: int):
        self.classical_register = [0 for i in range(n)]

    '''
    Treats the register as big endian bits of an integer value and checks if it corresponds to the given parameter.
    Parameters:
    - val: value to checked
    '''

    def register_equal(self, val: int):  # only integers for now
        if val >= 2 ** len(self.classical_register):
            raise Exception("Register Overflow in conditional gate")
        res = format(val, "b")
        for i, c in enumerate(res):
            if int(c) != self.classical_register[i]:
                return False
        return True


'''
The class QuantumDirectConnection identifies a connection for quantum communication that can be 
setup between two nodes. It employs ns.nodes.connections.DirectConnection to establish a full-duplex
connection between the nodes.
'''


class QuantumDirectConnection(ns.nodes.Connection):
    def __init__(self, name: str, length: int):
        super().__init__(name=name)
        q_channel_AB = ns.components.QuantumChannel(name="q_channel_AB",
                                                    length=length,
                                                    models={
                                                        "delay_model": ns.components.models.delaymodels.FibreDelayModel()})
        q_channel_BA = ns.components.QuantumChannel(name="q_channel_BA",
                                                    length=length,
                                                    models={
                                                        "delay_model": ns.components.models.delaymodels.FibreDelayModel()})
        self.add_subcomponent(ns.nodes.connections.DirectConnection(name=f"{name}_q_direct_connection",
                                                                    channel_AtoB=q_channel_AB,
                                                                    channel_BtoA=q_channel_BA))
        self.port_A.forward_input(self.subcomponents[f"{name}_q_direct_connection"].ports["A"])
        self.subcomponents[f"{name}_q_direct_connection"].ports["A"].forward_output(self.port_A)
        self.port_B.forward_input(self.subcomponents[f"{name}_q_direct_connection"].ports["B"])
        self.subcomponents[f"{name}_q_direct_connection"].ports["B"].forward_output(self.port_B)


'''
The class ClassicalDirectConnection identifies a connection for classical communication that can be 
setup between two nodes. It employs ns.nodes.connections.DirectConnection to establish a full-duplex
connection between the nodes.
'''


class ClassicalDirectConnection(ns.nodes.Connection):
    def __init__(self, name: str, length: int):
        super().__init__(name=name)
        c_channel_AB = ns.components.ClassicalChannel(name="c_channel_AB",
                                                      length=length,
                                                      models={
                                                          "delay_model": ns.components.models.delaymodels.FibreDelayModel()})
        c_channel_BA = ns.components.ClassicalChannel(name="c_channel_BA",
                                                      length=length,
                                                      models={
                                                          "delay_model": ns.components.models.delaymodels.FibreDelayModel()})
        self.add_subcomponent(ns.nodes.connections.DirectConnection(name=f"{name}_c_direct_connection",
                                                                    channel_AtoB=c_channel_AB,
                                                                    channel_BtoA=c_channel_BA))
        self.port_A.forward_input(self.subcomponents[f"{name}_c_direct_connection"].ports["A"])
        self.subcomponents[f"{name}_c_direct_connection"].ports["A"].forward_output(self.port_A)
        self.port_B.forward_input(self.subcomponents[f"{name}_c_direct_connection"].ports["B"])
        self.subcomponents[f"{name}_c_direct_connection"].ports["B"].forward_output(self.port_B)

'''
The class NetworkWrapper acts a simple wrapper of netsquid.nodes.network.Network to extend with useful information
for the simulation such as the coupling map of the nodes and the list of currently-entangled qubits.
'''


class NetworkWrapper:
    def __init__(self, network: ns.nodes.network.Network, coupling_map: list):
        self.network = network
        self.entangled_qubits = []
        self.coupling_map = coupling_map

    '''
    Returns a list of (Name, Node) for each node in the network.
    '''
    def get_node_items(self):
        return self.network.nodes.items()

    '''
    Returns the owner of the specified qubit from the nodes of the given network by matching the names.
    '''
    def get_owner_of_qubit(self, q: qs.circuit.Qubit):
        for name, node in self.network.nodes.items():
            if name in q.register.name:
                return node
        return None

    '''
    Returns the classical connection between the two specified nodes. By exploiting Netsquid's default naming convention.
    '''
    def get_classical_connection_between_nodes(self, node1: ns.nodes.Node, node2: ns.nodes.Node):
        for conn_name, conn in self.network.connections.items():
            if node1.name in conn_name and node2.name in conn_name and isinstance(conn, ClassicalDirectConnection):
                return conn
        return None

    '''
    Returns the quantum connection between the two specified nodes. By exploiting Netsquid's default naming convention.
    '''
    def get_quantum_connection_between_nodes(self, node1: ns.nodes.Node, node2: ns.nodes.Node):
        for conn_name, conn in self.network.connections.items():
            if node1.name in conn_name and node2.name in conn_name and isinstance(conn, QuantumDirectConnection):
                return conn
        return None
