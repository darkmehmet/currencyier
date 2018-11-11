var countries = require('./_countries.js');
var fs = require('fs')

var err_count = 0;

console.log(countries.length);

// countries.forEach((country) => {
//     let name = doDashes2(country.name);
//     if (fs.existsSync('./' + name + '.svg')) {
//         fs.copyFileSync('./' + name + '.svg', '../flags-codes/' + country.code + '.svg');
//         console.log('/n');
//     }
      
// });




function doDashes2(str) {
    return str.replace(/[^a-z0-9]+/gi, '-').replace(/^-*|-*$/g, '').toLowerCase();
}
