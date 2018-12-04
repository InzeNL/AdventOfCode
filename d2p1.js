const fs = require('fs');

fs.readFile('./inputs/d2.txt', 'utf8', function (err, data) {
    if (err) {
        console.log('An error occurred while trying to read the input: ' + err);
        return;
    }

    let input = data.split(/\r?\n/g);

    let requiredWrappingPaper = 0;

    for (let i = 0; i < input.length; i++) {
        let item = input[i];
        if (item.length > 4) {
            let dimensions = input[i].split('x');
            let l = parseInt(dimensions[0]);
            let w = parseInt(dimensions[1]);
            let h = parseInt(dimensions[2]);

            requiredWrappingPaper += 2 * l * w + 2 * w * h + 2 * h * l + getLowest(l * w, w * h, h * l);
        }
    }

    console.log(requiredWrappingPaper);
});

function getLowest(a, b, c) {
    if (a <= b && a <= c) {
        return a;
    }
    if (b <= a && b <= c) {
        return b;
    }
    return c;
}