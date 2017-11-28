// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/02/Add16.tst

load Negate16.hdl,
output-file Negate16.out,
compare-to Negate16.cmp,
output-list in%B1.16.1 out%B1.16.1;

set in %B0000000000000000,
eval,
output;

set in %B0000000000000001,
eval,
output;

set in %B0000000000000010,
eval,
output;
