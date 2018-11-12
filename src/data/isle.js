var currency = require('./currencies.js');
var fs = require('fs');

let object = {currencies: currency};

var json = JSON.stringify(object);

var fs = require('fs');
fs.writeFile('currencies.json', json, 'utf8', () => {});