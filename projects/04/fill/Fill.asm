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
  
  @16384 //initializing iterator
  D=A //beginning of the Hack Computer Screen

  @StartingPoint  //M[StartingPoint] = 16384 at this pt
  M=D

  @24576  //D Register =24576
  D=A

  @ColorBlack  //flag to indicate what we are filling with
  M=1  //initially screen's white so the answer is yes

  @IsScreenBlack //indicating what the screen is filled with
  M=0  //initiall the screen is blank so it's false

  @CHECKKEYBOARDINPUT //Output is D which will contain the keyboard input
 
  @SHOULDWEFILL

    
  (CHECKKEYBOARDINPUT)
    @KeyboardInput //M[KeyboardInput] = 24576
    M=D

    @KeyboardInput //A Register is pointing at 24576? and M[24576] is the keyboard
    A=M  //HackKeyboard single-world key map RAM[24576]
    D=M //I think M is now point at the keyboard status
    
    //loaded the keyboard input time to see if we should fill
    @SHOULDWEFILL
    0;JMP
    
  (SHOULDWEFILL)
    @IsScreenBlack //if the status flag for fill differs from the keyboard input then we should fill 
    D=D-M  //D contains keyboard input at this point since it is downstream of keyboardinput
    @FILLSCREEN
    D; JNE
    @DONTFILLSCREEN
    D; JEQ

  (FILLSCREEN)
    
    //at this point we know we need to fill
    @IsScreenBlack
    D=M

    @FILLWITHBLACK
    D; JGT
    @FILLWITHWHITE
    D; JEQ

  (FILLWITHBLACK)
    @1
    D=A
    
    @filler
    M=-1

    @FILLINGLOOP
    0;JMP
  
  (FILLWITHWHITE)
    @0
    D=A
    
    @filler
    M=0

    @FILLINGLOOP
    0;JMP

  (FILLINGLOOP)
    
    @StartingPoint //D=16384
    D=M

    A=D
    M=-1
    
    @StartingPoint
    M=M+1
    D=M

    @24576
    D=A-D  //calculate D-16384

   //iffy statement checking iterator starts here
    @DONTFILLSCREEEN  //if we are done looping ie i =24576ish go terminate
    D;JLE

    @FILLINGLOOP     //Not done looping? 
    D; JGT   //Correct this JMP

  (DONTFILLSCREEN) 
    //ends iffy
    @4  //go back to checking keyboard input 
    0;JMP //go back to beginning for infinite loop

