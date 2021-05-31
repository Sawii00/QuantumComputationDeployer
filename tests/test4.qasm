OPENQASM 2.0;
include "qelib1.inc";
opaque entangle a, b;
opaque remoteCX a,b,c,d;

qreg alice_qubits[2]; //must contain the node name in the name of reg
qreg bob_qubits[2];


h alice_qubits[0];

entangle alice_qubits[1], bob_qubits[1];
remoteCX alice_qubits[0], alice_qubits[1], bob_qubits[0], bob_qubits[1];
entangle alice_qubits[1], bob_qubits[1];
remoteCX bob_qubits[0], bob_qubits[1], alice_qubits[0], alice_qubits[1];
entangle alice_qubits[1], bob_qubits[1];
remoteCX alice_qubits[0], alice_qubits[1], bob_qubits[0], bob_qubits[1];

entangle alice_qubits[1], bob_qubits[1];
remoteCX alice_qubits[0], alice_qubits[1], bob_qubits[0], bob_qubits[1];
entangle alice_qubits[1], bob_qubits[1];
remoteCX bob_qubits[0], bob_qubits[1], alice_qubits[0], alice_qubits[1];
entangle alice_qubits[1], bob_qubits[1];
remoteCX alice_qubits[0], alice_qubits[1], bob_qubits[0], bob_qubits[1];