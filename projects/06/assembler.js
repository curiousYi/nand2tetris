const fs = require('fs'),
      path = require('path');


const Parser = require('./parser');

const filePath =  path.join(__dirname, process.argv[2]);

fs.readFile(filePath, {encoding: 'utf-8'}, function(err,data){
    if (!err) {
        //console.log('received data: ' + data);
        const parser = new Parser(data);
        //set-up symbol stuff first
        
        for(var i=0; i<10;i++){
          parser.advance();
        }
        console.log(parser.translation);
    } else {
    }
});

//remove comments //strip '//'
//remove white-spaces
