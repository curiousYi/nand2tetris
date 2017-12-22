class Parser {
  constructor(input){
    this.once= 0;
    this._input = input; //don't mess with this
    this._formattedSplitLines= this._input.split("\n").map((line) => { return line.slice(0,line.length-1).trim() }); 
    this.commands = this._formattedSplitLines.filter( (line) => {
      return line.length > 0 && (line.substring(0,2) !== "//")
    });
    this.currentAddress = 0; //where I am at in the address;

    this._compDictionary = {
      '0': '0101010',
      '1': '0111111',
      '-1': '0111010',
      'D': '0001100',
      'A': '0110000',
      '!D': '0001101',
      '!A': '0110001',
      'D+1': '0011111',
      'A+1': '0110111',
      'D-1': '0001110',
      'A-1': '0110010',
      'D+A': '0000010',
      'D-A': '0010011',
      'A-D': '0000111',
      'D&A': '0000000',
      'D|A': '0010101',
      'M': '1110000',
      '!M': '1110001',
      'M+1':'1110111',
      'M-1': '1110010',
      'D+M': '1000010',
      'D-A': '1010011',
      'M-D': '1000111', 
      'D&M': '1000000',
      'D|M': '1010101'
    };

    this._destDictionary = {
      'null': '000',
      'M': '001',
      'D': '010',
      'MD': '011',
      'A': '100',
      'AM': '101',
      'AD': '110',
      'AMD': '111'
    }

    this._jumpDictionary = {

    }
  }

  hasMoreCommands() {
    return this.commands.length > 0;
  }

  advance(){
    if(this.hasMoreCommands()){
      console.log('we advanced!');
      this.currentAddress++;
    }
  }

  commandType(){
    //return command type of current command
    const currentCommand = this.commands[this.currentAddress];
    
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
    if(this.commandType() !== 'C_COMMAND'){
      throw 'NOT A C_COMMAND; dest() was called in parser';
    }
    else{
     //return dest mnemonic 
    }
  }

  comp(){
    if(this.commandType() !== 'C_COMMAND'){
      throw 'NOT A C_COMMAND; dest() was called in parser';
    }
    else{
     //return dest mnemonic 
    }
  }

  jump(){
    if(this.commandType() !== 'C_COMMAND'){
      throw 'NOT A C_COMMAND; dest() was called in parser';
    }
    else{
     //return dest mnemonic 
    }if(this.commandType() !== 'C_COMMAND'){
      throw 'NOT A C_COMMAND; dest() was called in parser';
    }
    else{
     //return dest mnemonic 
    }
  }

  convertTo16Bit(numb){
    let numberLastHalf = numb.toString(2);
    let firstHalfArray = [];
    for(var i=0; i < 16 - numberLastHalf.length; i++){
      firstHalfArray.push("0");
    }
    return firstHalfArray.join("") + numberLastHalf;
  }

  parseCInstruction(){
    const cInstruction = this.commands[this.currentAddress];
    eqlLoc = cInstruction.indexOf('=');
    compEndPt = cInstruction.indexOf(';');
    
    const dest = cInstruction.substring(0,eqlLoc);
    const comp = cInstruction.substring(eqLoc+1, compEndPt);
    const jump = cInstruction.substring(compEndPt+1);
    
    console.log('parseCInstruction ran ', cInstruction, ' ',dest, ' ',comp, ' ', jump);

    return {
            dest: dest,
            comp: comp,
            jump: jump
            };
  },
}
module.exports = Parser;
