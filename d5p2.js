const fs = require('fs');

fs.readFile('./inputs/d5.txt', 'utf8', function (err, data) {
    if (err) {
        console.log('An error occurred while trying to read the input: ' + err);
        return;
    }

    let input = data.split(/\r?\n/g);

    let vowels = 'aeiou';
    let disallowedStrings = ['ab', 'cd', 'pq', 'xy'];

    let niceStrings = 0;

    for (let i = 0; i < input.length; i++) {
        let item = input[i];
        if (item.length > 2) {
            let containsTwoLetterPairs = false;

            for (let j = 1; j < item.length; j++) {
                let charCombination = item.charAt(j - 1) + item.charAt(j);

                if (item.indexOf(charCombination, j + 1) !== -1) {
                    containsTwoLetterPairs = true;
                    break;
                }
            }

            let containsPalindrome = false;
            for (j = 2; j < item.length; j++) {
                if (item.charAt(j) === item.charAt(j - 2)) {
                    containsPalindrome = true;
                }
            }

            if (containsTwoLetterPairs && containsPalindrome) {
                niceStrings++;
            }
        }
    }

    console.log(niceStrings);
});