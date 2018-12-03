const fs = require('fs');

fs.readFile('./inputs/d2.txt', 'utf8', function (err, data) {
    if (err) {
        console.log('An error occurred while trying to read the input: ' + err);
        return;
    }

    let input = data.split(/\r?\n/g);

    let containsTwoOfAnyLetter = 0;
    let containsThreeOfAnyLetter = 0;

    for (let i = 0; i < input.length; i++) {
        let item = input[i];
        if (item.length >= 2) {
            containsTwoOfAnyLetter += containsXOfAnyLetter(item, 2);
            containsThreeOfAnyLetter += containsXOfAnyLetter(item, 3);
        }
    }

    console.log(containsTwoOfAnyLetter * containsThreeOfAnyLetter);
});

function containsXOfAnyLetter(code, number) {
    for (let i = 0; i < code.length; i++) {
        if (code.match(new RegExp(code.charAt(i), 'g')).length === number) {
            return 1;
        }
    }
    return 0;
}