class SymbolTable {
  constructor(){
    this._table = {
      'SP': '0000000000000000',
      'LCL':'0000000000000001',
      'ARG':'0000000000000010',
      'THIS':'0000000000000011',
      'THAT':'0000000000000100',
      'SCREEN': '0100000000000000',
      'KBD': '0110000000000000'
    }
    this.freeAddress=16;

    for(var i=0; i<=15; i++){
      let label = `R${i}`;
      this._table[label]=this.convertTo16Bit(i);
    }
  }
  
  addEntry(symbol, address){
    if(!this.contains(symbol)){
      this._table[symbol]=address;
    }
    else{
    }
  }

  contains(symbol){
    return Object.keys(this._table).includes(symbol)
  }

  getAddress(symbol){
    return this._table[symbol];
  }

  convertTo16Bit(numb){
    let numberLastHalf = numb.toString(2);
    let firstHalfArray = [];
    for(var i=0; i < 16 - numberLastHalf.length; i++){
      firstHalfArray.push("0");
    }
    return firstHalfArray.join("") + numberLastHalf;
  }
}

module.exports = SymbolTable;
