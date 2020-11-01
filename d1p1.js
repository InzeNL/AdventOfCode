const fs = require('fs');

fs.readFile('./inputs/d1.txt', 'utf8', function (err, data) {
    if (err) {
        console.log('An error occurred while trying to read the input: ' + err);
        return;
    }

    let input = data.split(/\r?\n/g);

    let fuelRequirement = 0;

    for (let i = 0;i < input.length;i++) {
        fuelRequirement += Math.floor(parseInt(input[i]) / 3) - 2
    }

    console.log(fuelRequirement)
});