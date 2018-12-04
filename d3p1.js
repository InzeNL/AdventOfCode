const fs = require('fs');

fs.readFile('./inputs/d3.txt', 'utf8', function (err, data) {
    if (err) {
        console.log('An error occurred while trying to read the input: ' + err);
        return;
    }

    let input = data.split(/\r?\n/g);

    let claimedSquares = {};

    for (let i = 0; i < input.length; i++) {
        let item = input[i];
        if (item.length >= 2) {
            let claim = item.split(' @ ')[1];
            let startPosition = claim.split(': ')[0];
            let startPositionX = parseInt(startPosition.split(',')[0]);
            let startPositionY = parseInt(startPosition.split(',')[1]);

            let claimSize = claim.split(': ')[1];
            let sizeX = parseInt(claimSize.split('x')[0]);
            let sizeY = parseInt(claimSize.split('x')[1]);

            for (let positionX = startPositionX; positionX < startPositionX + sizeX; positionX++) {
                for (let positionY = startPositionY; positionY < startPositionY + sizeY; positionY++) {
                    let positionString = positionX + ',' + positionY;
                    if (!claimedSquares[positionString]) {
                        claimedSquares[positionString] = 0;
                    }
                    claimedSquares[positionString]++
                }
            }
        }
    }

    let duplicateClaims = 0;

    for (let claimedSquare in claimedSquares) {
        if (!claimedSquares.hasOwnProperty(claimedSquare)) {
            continue;
        }

        if (claimedSquares[claimedSquare] > 1) {
            duplicateClaims++;
        }
    }

    console.log(duplicateClaims);
});