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
 
  @123
  @ColorSelected  //flag to indicate what we are filling with
  M=-1  //initially screen's white so the answer is yes
  
  @222
  @IsScreenBlack //indicating what the screen is filled with
  M=0  //initiall the screen is blank so it's false

  
  @RESETITERATOR 
    0; JMP 
  
  (RESETITERATOR)
    @333 //initializing iterator USING magic constants to help me trouble shoot the machine code
    @16384
    D=A //beginning of the Hack Computer Screen

    @StartingPoint  //M[StartingPoint] = 16384 at this pt
    M=D

    @INITIALIZECONSTANTS
    0; JMP
  
  (INITIALIZECONSTANTS)
    @24576  //D Register=24576
      D=A

    @CHECKKEYBOARDINPUT
      0; JMP
   
   @423
  (CHECKKEYBOARDINPUT)
    @KeyboardInput //M[KeyboardInput] = 24576
    M=D

    @KeyboardInput //A Register is pointing at 24576? and M[24576] is the keyboard
    A=M  //HackKeyboard single-world key map RAM[24576]
    D=M //I think M is now point at the keyboard status
    
    @SelectBlack
      D; JNE

    @SelectWhite
      D; JEQ

    (SelectBlack)
      @ColorSelected
      M=-1
      @SHOULDWEFILL
      0;JMP

    (SelectWhite)
      @ColorSelected
      M=0
      @SHOULDWEFILL
      0;JMP
    
  (SHOULDWEFILL)
    //Loaded D input from keyboard 
    @6666
    @FILLSCREEN
    0; JMP //just fill the screen for now
    //TO-DO make it optional to fill the screen otherwise you have situations where you do unnecessary work
    
  (FILLSCREEN)
    //D should have keyboard input and it SHOULD be accurate 
    @FILLINGLOOP
    0;JMP
    @666
  (FILLINGLOOP)
    @ColorSelected
    D=M

    //you are coloring the blocks black so D = -1
    @ColorABlockBlack
    D ; JLT

    @ColorABlockWhite
    D ; JEQ

    (ColorABlockBlack)
      
      @StartingPoint //D=16384
      D=M

      A=D
      M=-1

      @ResumeRestOfFill
      0; JMP

    (ColorABlockWhite)
      
      @StartingPoint //D=16384
      D=M

      A=D
      M=0

      @ResumeRestOfFill
      0; JMP

      
   (ResumeRestOfFill)  
      @StartingPoint
      M=M+1
      D=M

      @24576
      D=D-A  //calculate D-16384

      @11111
      @DONEFILLING //if we are done looping ie i =24576ish go terminate
      D;JGE

      @FILLINGLOOP     //Not done looping? 
      D; JLT   //Correct this JMP

  (DONEFILLING) 
    //ends iffy
    @RESETITERATOR
    0;JMP
