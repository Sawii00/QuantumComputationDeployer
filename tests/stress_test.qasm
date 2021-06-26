OPENQASM 2.0;
include "qelib1.inc";
opaque entangle a, b;
opaque remoteCX a,b,c,d;

qreg qpu1[2];
qreg qpu2[2];
qreg qpu3[2];
qreg qpu4[2];

h qpu1[0];
x qpu3[0];


entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];


entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];


entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];


entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];


entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];


entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];

entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu2[0], qpu2[1], qpu1[0], qpu1[1];
entangle qpu1[1], qpu2[1];
remoteCX qpu1[0], qpu1[1], qpu2[0], qpu2[1];



entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];


entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];


entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];


entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];


entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu4[0], qpu4[1], qpu3[0], qpu3[1];
entangle qpu3[1], qpu4[1];
remoteCX qpu3[0], qpu3[1], qpu4[0], qpu4[1];

