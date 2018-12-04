const fs = require('fs');

fs.readFile('./inputs/d3.txt', 'utf8', function (err, data) {
    if (err) {
        console.log('An error occurred while trying to read the input: ' + err);
        return;
    }

    let houses = {'0,0': 1};
    let currentX = 0;
    let currentY = 0;

    for (let i = 0; i < data.length; i++) {
        switch (data.charAt(i)) {
            case '^':
                currentY--;
                break;
            case '>':
                currentX++;
                break;
            case 'v':
                currentY++;
                break;
            case '<':
                currentX--;
                break;
            default:
                console.log('Unexpected character "' + data.charAt(i) + '"');
        }
        let house = currentX + ' ' + currentY;
        if (!houses[house]) {
            houses[house] = 0;
        }
        houses[house]++;
    }

    let giftedHouses = 0;

    for (let house in houses) {
        if (!houses.hasOwnProperty(house)) {
            continue;
        }
        giftedHouses++;
    }

    console.log(giftedHouses);
});