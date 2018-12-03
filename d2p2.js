const fs = require('fs');

fs.readFile('./inputs/d2.txt', 'utf8', function (err, data) {
    if (err) {
        console.log('An error occurred while trying to read the input: ' + err);
        return;
    }

    let input = data.split(/\r?\n/g);

    let containsTwoOrThreeOfAnyLetter = [];

    for (let i = 0; i < input.length; i++) {
        let item = input[i];
        if (item.length >= 2) {
            if (containsXOfAnyLetter(item, 2) + containsXOfAnyLetter(item, 3) > 0) {
                containsTwoOrThreeOfAnyLetter.push(item);
            }
        }
    }

    let matchingCharacters = null;

    for (let i = 0; i < containsTwoOrThreeOfAnyLetter.length - 1; i++) {
        for (let j = i + 1; j < containsTwoOrThreeOfAnyLetter.length; j++) {
            let string1 = containsTwoOrThreeOfAnyLetter[i];
            let string2 = containsTwoOrThreeOfAnyLetter[j];
            if (stringsAlmostMatch(string1, string2)) {
                matchingCharacters = stringMatchingCharacters(string1, string2);
                break;
            }
        }

        if (matchingCharacters !== null) {
            break;
        }
    }

    console.log(matchingCharacters);
});

function containsXOfAnyLetter(code, number) {
    for (let i = 0; i < code.length; i++) {
        if (code.match(new RegExp(code.charAt(i), 'g')).length === number) {
            return 1;
        }
    }
    return 0;
}

function stringsAlmostMatch(string1, string2) {
    if (string1.length !== string2.length) {
        return false;
    }
    let unequalCharacters = 0;
    for (let i = 0; i < string1.length; i++) {
        if (string1.charAt(i) !== string2.charAt(i)) {
            unequalCharacters++;
        }
    }
    return unequalCharacters === 1;
}

function stringMatchingCharacters(string1, string2) {
    if (string1.length !== string2.length) {
        return false;
    }
    let equalCharacters = '';
    for (let i = 0; i < string1.length; i++) {
        if (string1.charAt(i) === string2.charAt(i)) {
            equalCharacters += string1.charAt(i);
        }
    }
    return equalCharacters;
}