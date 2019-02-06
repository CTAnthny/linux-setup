#! /usr/bin/env node

const fs = require('fs');
const itermcolorsToHex = require('itermcolors-to-hex');
const iTerm2Colors = itermcolorsToHex('./Cobalt_Neon.itermcolors');
let jsonContent = JSON.stringify(iTerm2Colors, null, "\t");

fs.writeFile("CobaltNeonHexColors.json", jsonContent, 'utf8', (err) => {
    if (err) {
        console.log("An error occured: ")
        return console.log(err);
    }
    console.log("Conversion successfully written to CobaltNeonHexColors.json")
});
