const fs = require('fs');

fs.readFile('./inputs/d1.txt', 'utf8', function (err, data) {
    if (err) {
        console.log('An error occurred while trying to read the input: ' + err);
        return;
    }

    let input = data.split(/\r?\n/g);

    let fuelRequirement = 0;

    for (let i = 0; i < input.length; i++) {
        fuelRequirement += calculateFuelRequirement(parseInt(input[i]));
    }

    function calculateFuelRequirement(input) {
        const fuelRequirement = Math.floor(input / 3) - 2;
        if (fuelRequirement < 0) {
            return 0;
        }
        return fuelRequirement + calculateFuelRequirement(fuelRequirement);
    }

    console.log(fuelRequirement);
});