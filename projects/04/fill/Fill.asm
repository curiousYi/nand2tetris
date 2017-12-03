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

  @StartingPoint  //M[StartingPoint] = 16384 at this pt
  M=D

  @24576  //D Register =24576
  D=A

  @KeyboardInput //M[KeyboardInput] = 24576
  M=D

  @KeyboardInput //A Register is pointing at 24576? and M[24576] is the keyboard
  A=M  //HackKeyboard single-world key map RAM[24576]
  D=M //I think M is now point at the keyboard status

  @29  //skip filling
  D; JEQ

  @StartingPoint //D=16384
  D=M

  @i  //A=16384 and M[16384] = -1
  A=D
  M=-1

  @i
  D=A

  @StartingPoint
  M=M+1
  D=M

  @24576
  D=A-D  //calculate D-16384
 

 //iffy statement checking iterator starts here
  @29  //if we are done looping ie i =24576ish go terminate
  D;JLE

  @13     //Not done looping? 
  D; JGT   //Correct this JMP
  
  //ends iffy
  @4  //go back to checking keyboard input 
  0;JMP //go back to beginning for infinite loop

  (CheckKeyboardInput)


  (DoINeedToFill)

  (FillinStuff)
