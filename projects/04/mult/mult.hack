@2
M=0
@0
D=M
@10
D;JGT
@22
D;JLT
@34
0;JMP
@0
D=M
@34
D;JEQ
@0
M=M-1
@1
D=M
@2
M=D+M
@10
0;JMP
@0
D=M
@34
D;JEQ
@0
M=M+1
@1
D=M
@2
M=M-D
@22
0;JMP
@34
0;JMP