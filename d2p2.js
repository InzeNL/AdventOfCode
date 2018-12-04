const fs = require('fs');

fs.readFile('./inputs/d2.txt', 'utf8', function (err, data) {
    if (err) {
        console.log('An error occurred while trying to read the input: ' + err);
        return;
    }

    let input = data.split(/\r?\n/g);

    let requiredRibbon = 0;

    for (let i = 0; i < input.length; i++) {
        let item = input[i];
        if (item.length > 4) {
            let dimensions = input[i].split('x');
            let l = parseInt(dimensions[0]);
            let w = parseInt(dimensions[1]);
            let h = parseInt(dimensions[2]);

            requiredRibbon += getShortestDistance(l, w, h) + l * w * h;
        }
    }

    console.log(requiredRibbon);
});

function getShortestDistance(a, b, c) {
    if (a >= b && a >= c) {
        return 2 * b + 2 * c;
    }
    if (b >= a && b >= c) {
        return 2 * a + 2 * c;
    }
    return 2 * a + 2 * b;
}