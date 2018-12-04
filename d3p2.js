const fs = require('fs');

fs.readFile('./inputs/d3.txt', 'utf8', function (err, data) {
    if (err) {
        console.log('An error occurred while trying to read the input: ' + err);
        return;
    }

    let houses = {'0,0': 2};
    let santa = true;
    let santaX = 0;
    let santaY = 0;
    let robotX = 0;
    let robotY = 0;

    for (let i = 0; i < data.length; i++) {
        switch (data.charAt(i)) {
            case '^':
                if (santa) {
                    santaY--;
                } else {
                    robotY--;
                }
                break;
            case '>':
                if (santa) {
                    santaX++;
                } else {
                    robotX++;
                }
                break;
            case 'v':
                if (santa) {
                    santaY++;
                } else {
                    robotY++;
                }
                break;
            case '<':
                if (santa) {
                    santaX--;
                } else {
                    robotX--;
                }
                break;
            default:
                console.log('Unexpected character "' + data.charAt(i) + '"');
        }
        let house;
        if (santa) {
            house = santaX + ',' + santaY;
        } else {
            house = robotX + ',' + robotY;
        }

        if (!houses[house]) {
            houses[house] = 0;
        }
        houses[house]++;

        santa = !santa;
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