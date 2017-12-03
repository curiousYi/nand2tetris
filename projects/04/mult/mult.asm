// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

  @R2
  M=0 //initializing sum = 0
 
  @R0
  D=M

  @ADDLOOP
  D;JGT //go to add 15

  @SUBTRACTLOOP
  D;JLT //go to below 15

  //if a multiple = 0 just set it to 0 and call it a day
  @34
  0;JMP
  
  (ADDLOOP)
    //start multiplication iteration below
    @R0
    D=M;
    
    @34 //Fillin
    D;JEQ
    
    @R0
    M=M-1;

    @R1
    D=M;

    @R2
    M=M+D;

    @ADDLOOP
    0;JMP
   

  (SUBTRACTLOOP)
    //start multiplication iteration below
    @R0
    D=M;
    
    @34 //Fillin
    D;JEQ
    
    @R0
    M=M+1;

    @R1
    D=M;

    @R2
    M=M-D;

    @SUBTRACTLOOP
    0;JMP
  
    @34
    0;JMP
