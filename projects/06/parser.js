const code = require('./code');
const SymbolTable = require('./symbolTable');

class Parser {
  constructor(input){
    //removing new lines and white spaces 
    this._formattedSplitLines= input.split("\n").map((line) => { return line.slice(0,line.length-1).trim() }); 
    //removing comments lines
    this.commands = this._formattedSplitLines.filter( (line) => {
      return line.length > 0 && (line.substring(0,2) !== "//")
    });
    
    this._compDictionary = code.compDictionary; 
    this._destDictionary = code.destDictionary;
    this._jumpDictionary = code.jumpDictionary; 
    this._symbolTable = new SymbolTable();
    this.translation="";
  }

  initializeSymbolTableWithLabels() {
    let counter = 0; 
    this.commands.forEach((command) => {
      if(this.commandType(command) === 'L_COMMAND'){
        let symbol = command.substring(1, command.length-1),
        address = this.convertTo16Bit(counter);
        if(!this._symbolTable.contains(symbol)){
          this._symbolTable.addEntry(symbol, address);
          counter--;
        }
      }
      counter++;
    });
  }

  initializeSymbolTableWithASymbols() {
    let counter = 0; 
    this.commands.forEach((command) => {
      if(this.commandType(command) ==='A_COMMAND'){
        if('0123456789'.indexOf(command[1])!== -1){
          
        }else{
          let memAddress = this.convertTo16Bit(this._symbolTable.freeAddress);
          let symbol = command.substring(1, command.length); 

          if(!this._symbolTable.contains(symbol)){
          console.log(`heres the free addres ${this._symbolTable.freeAddress}`);
          this._symbolTable.addEntry(symbol, memAddress);
          this._symbolTable.freeAddress++
          }
        }

      }
      counter++;
    });
  }

  hasMoreCommands() {
    return this.commands.length > 0;
  }

  advance(){
    if(this.hasMoreCommands()){
      let currentInstr = this.commands.shift();

      let type = this.commandType(currentInstr);
      if(type==='A_COMMAND'){
        if('0123456789'.indexOf(currentInstr[1])!== -1){
          let numb = Number(currentInstr.substring(1));
          if(numb.toString() !== "NaN"){
            this.translation += this.convertTo16Bit(numb);
          }
          else{
            //if for some reason I have @1dslkfjadfkl this would be error catch
          }
        }else{
          this.translation += this._symbolTable.getAddress(currentInstr.substring(1));
        }
        this.translation += "\n";
      }
      else if(type==='C_COMMAND'){
        this.parseCInstruction(currentInstr);
        this.translation += '111'
        this.translation += this.comp();
        this.translation += this.dest();
        this.translation += this.jump();

        this.translation += "\n";
      }
      else{
        //at this point symbol table is initialized so should be good
        //console.log('TO DO L COMMAND'); 
        //convert to a memory address here?
        //at this point L label defined so we can skip it
      }
    }
  }

  commandType(currentCommand){
    //return command type of current command
    if(currentCommand[0] === '@'){
      return 'A_COMMAND';
    }
    else if(currentCommand[0] === '('){
      return 'L_COMMAND';
    }
    else{
      return 'C_COMMAND';
    }
  }

  symbol(){
    if(this.commandType() !== 'L_COMMAND' && this.commandType() !== 'A_COMMAND'){
      throw 'Not an address instruction; symbol() was called in parser';
    }
    else{
      //TO DO
     //return dest mnemonic 
    }
  }

  dest(){
    return this._destDictionary[this.tempDest];
  }

  comp(){
    return this._compDictionary[this.tempComp];
  }

  jump(){
    return this._jumpDictionary[this.tempJump];
  }

  convertTo16Bit(numb){
    let numberLastHalf = numb.toString(2);
    let firstHalfArray = [];
    for(var i=0; i < 16 - numberLastHalf.length; i++){
      firstHalfArray.push("0");
    }
    return firstHalfArray.join("") + numberLastHalf;
  }

  parseCInstruction(currentCommand){
    const cInstruction = currentCommand;
    let eqLoc = cInstruction.indexOf('=');
    let compEndPt = cInstruction.indexOf(';');
    
    this.tempDest = "null";
    this.tempJump = "null";
    
    if(compEndPt !== -1 && eqLoc !== -1 ){
      this.tempDest= cInstruction.substring(0, eqLoc);
      this.tempComp = cInstruction.substring(eqLoc+1,compEndPt);
      this.tempJump = cInstruction.substring(compEndPt+1);
    }
    else if(compEndPt !== -1){
      this.tempComp = cInstruction.substring(0,compEndPt);
      this.tempJump = cInstruction.substring(compEndPt+1);
    }
    else if(eqLoc !== -1){
      this.tempDest = cInstruction.substring(0, eqLoc);
      this.tempComp = cInstruction.substring(eqLoc+1);
    }
    //console.log(`parse C instruction ran ${cInstruction} tempDest: ${this.tempDest}  tempComp: ${this.tempComp} tempJump ${this.tempJump}`);
  }

}

module.exports = Parser;
