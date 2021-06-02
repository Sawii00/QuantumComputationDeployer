import re
from netsquid_netconf.builder import Builder


class CouplingMapQubit:
    """
    The class CouplingMapQubit is a simple structs which holds information regarding the coupling map of different nodes
    in the network. For communication purposes, a coupling map is specified to explicitly define which ebits are reserved
    for the communication with a specific node.
    The entanglement generation will only allow for the entanglement of coupled ebits.
    """
    def __init__(self, name: str, index: int):
        self.name = name
        self.index = index


class EbitCouplingMapBuilder(Builder):
    """
    The class EbitCouplingMapBuilder implements a builder for the "ebit_coupling_map" element of the YAML description of the
    network's topology.
    It extracts the name of the node and the index of the qubit for each party specified and saves it into a list.
    This does not perform checks on the coherence of the coupling map. They will be carried out subsequently.
    """
    @classmethod
    def key(cls):
        return "ebit_coupling_map"

    @classmethod
    def build(cls, config_dict):
        """
        Builds the coupling map by parsing the coupled pairs specified within the "entries" list
        Args:
            config_dict: dictionary with all the key - value pairs of the "ebit_coupling_map" component
        """
        entries = config_dict["entries"]
        coupling_map = []
        for e in entries:
            qubits = e.split("<->")
            if len(qubits) != 2:
                raise Exception("Error in defining the coupling map")
            try:
                first_node = re.search('(.+?)\[', qubits[0]).group(1).strip()
                first_indices = re.search('\[(.+?)\]', qubits[0]).group(1).strip()
                second_node = re.search('(.+?)\[', qubits[1]).group(1).strip()
                second_indices = re.search('\[(.+?)\]', qubits[1]).group(1).strip()
                for e1 in first_indices.strip().split(","):
                    for e2 in second_indices.strip().split(","):
                        found = False
                        pair = (CouplingMapQubit(first_node, int(e1.strip())), CouplingMapQubit(second_node, int(e2.strip())))
                        for t in coupling_map:
                            if t == pair or t == (pair[1], pair[0]):
                                found = True
                                break
                        if not found:
                            coupling_map.append(pair)
            except AttributeError:
                raise Exception("Invalid syntax in coupling map")
        return coupling_map


class Ebit:
    """
    The class Ebit is a simple struct which describes an ebit of a QPU. In particular it keeps track of the index within
    the node's register and whether it has been paired with the ebit of another qpu or not.
    """
    def __init__(self, index: int):
        self.index = index
        self.paired = False
