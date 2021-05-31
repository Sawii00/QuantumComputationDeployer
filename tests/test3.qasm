OPENQASM 2.0;
include "qelib1.inc";
opaque entangle a, b;
opaque remoteCX a,b,c,d;

qreg alice_qubits[4]; //must contain the node name in the name of reg
qreg bob_qubits[4];


h bob_qubits[0];
x bob_qubits[1];
entangle alice_qubits[2], bob_qubits[2];
remoteCX alice_qubits[0], alice_qubits[2], bob_qubits[0], bob_qubits[2];
entangle alice_qubits[2], bob_qubits[2];
remoteCX bob_qubits[0], bob_qubits[2], alice_qubits[0], alice_qubits[2];
entangle alice_qubits[2], bob_qubits[2];
remoteCX alice_qubits[0], alice_qubits[2], bob_qubits[0], bob_qubits[2];


entangle alice_qubits[3], bob_qubits[3];
remoteCX alice_qubits[1], alice_qubits[3], bob_qubits[1], bob_qubits[3];
entangle alice_qubits[3], bob_qubits[3];
remoteCX bob_qubits[1], bob_qubits[3], alice_qubits[1], alice_qubits[3];
entangle alice_qubits[3], bob_qubits[3];
remoteCX alice_qubits[1], alice_qubits[3], bob_qubits[1], bob_qubits[3];

cx alice_qubits[0], alice_qubits[1];

