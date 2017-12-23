const fs = require('fs'),
      path = require('path');

const Parser = require('./parser');

const filePath = path.join(__dirname, process.argv[2]);

fs.readFile(filePath, {encoding: 'utf-8'}, function(err,data){
    if (!err) {
        const parser = new Parser(data);
        const length = parser.commands.length;
        parser.initializeSymbolTableWithLabels(); 
        parser.initializeSymbolTableWithASymbols(); 
        for(var i=0; i<length;i++){
          parser.advance();
        }
        console.log(parser.translation);
        fs.writeFile(`${filePath}.hack`, parser.translation, function(err) {
          if(err) return console.log(err);
          console.log('Done!');
        });

    } else {
      console.log(`Something went wrong! ${err}`);
    }
});
