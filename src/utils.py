import re
from netsquid_netconf.builder import Builder

'''
The class CouplingMapQubit is a simple structs which holds information regarding the coupling map of different nodes
in the network. For communication purposes, a coupling map is specified to explicitly define which ebits are reserved
for the communication with a specific node.
The entanglement generation will only allow for the entanglement of coupled ebits.
Arguments:
- self.name: name of the owner of the qubit
- self.index: index of the qubit inside his register
'''


class CouplingMapQubit:
    def __init__(self, name: str, index: int):
        self.name = name
        self.index = index


'''
The class EbitCouplingMapBuilder implements a builder for the "ebit_coupling_map" element of the YAML description of the 
network's topology.
It extracts the name of the node and the index of the qubit for each party specified and saves it into a list.
This does not perform checks on the coherence of the coupling map. They will be carried out subsequently.
'''


class EbitCouplingMapBuilder(Builder):
    @classmethod
    def key(cls):
        return "ebit_coupling_map"

    @classmethod
    def build(cls, config_dict):
        entries = config_dict["entries"]
        coupling_map = []
        for e in entries:
            qubits = e.split(",")
            if len(qubits) != 2:
                raise Exception("Error in defining the coupling map")
            try:
                first_node = re.search('(.+?)\[', qubits[0]).group(1).strip()
                first_index = re.search('\[(.+?)\]', qubits[0]).group(1).strip()
                second_node = re.search('(.+?)\[', qubits[1]).group(1).strip()
                second_index = re.search('\[(.+?)\]', qubits[1]).group(1).strip()
                coupling_map.append((CouplingMapQubit(first_node, int(first_index)),
                                     CouplingMapQubit(second_node, int(second_index))))
            except AttributeError:
                raise Exception("Invalid syntax in coupling map")
        return coupling_map


'''
The class Ebit is a simple struct which describes an ebit of a QPU. In particular it keeps track of the index within
the node's register and whether it has been paired with the ebit of another qpu or not.
'''


class Ebit:
    def __init__(self, index: int):
        self.index = index
        self.paired = False
