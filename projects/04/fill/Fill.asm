// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.
  @16384 //initializing iterator?
  D=A //beginning of the Hack Computer Screen

  @StartingPoint
  M=D;

  @24576
  D=A

  @KeyboardInput
  M=D  //HackKeyboard single-world key map RAM[24576]

  @KeyboardInput
  D=M

  @2 //just go to the end of the loop for now  
  @KeyboardInput; JEQ //equal 0 skip filling //with black characters?

  @startingPoint
  D=M

  @i
  A=D+M
  M=-1

  @i
  M=M+16

  @i
  D=M-16896

  @25 // done looping
  D;JGE

  @KeyboardInput
  M=D

  @47
  D;JNE

  @11
  0;JMP //go back to beginning for infinite loop
