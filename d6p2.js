const fs = require('fs');

fs.readFile('./inputs/d6.txt', 'utf8', function (err, data) {
    if (err) {
        console.log('An error occurred while trying to read the input: ' + err);
        return;
    }

    let input = data.split(/\r?\n/);

    let positions = [];

    let minPos = [Infinity, Infinity];
    let maxPos = [0, 0];

    for (let i = 0; i < input.length; i++) {
        let item = input[i].split(', ');
        if (item.length > 1) {
            let coords = [parseInt(item[0]), parseInt(item[1])];
            if (coords[0] < minPos[0]) {
                minPos[0] = coords[0];
            }
            if (coords[0] > maxPos[0]) {
                maxPos[0] = coords[0];
            }
            if (coords[1] < minPos[1]) {
                minPos[1] = coords[1];
            }
            if (coords[1] > maxPos[1]) {
                maxPos[1] = coords[1];
            }

            positions.push(coords);
        }
    }

    let matchingPositions = 0;
    for (let x = minPos[0]; x <= maxPos[0]; x++) {
        for (let y = minPos[1]; y <= maxPos[1]; y++) {
            if (isWithinArea(x, y, positions)) {
                matchingPositions++;
            }
        }
    }

    console.log(matchingPositions);
});

function isWithinArea(x, y, positions) {
    let totalDistance = 0;
    for (let i = 0;i < positions.length;i ++) {
        totalDistance += Math.abs(x - positions[i][0]) + Math.abs(y - positions[i][1]);
    }
    return totalDistance < 10000;
}