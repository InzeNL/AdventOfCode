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
            let vowelCount = 0;
            for (let j = 0;j < item.length;j++) {
                if (vowels.indexOf(item.charAt(j)) !== -1) {
                    vowelCount++;
                }
                if (vowelCount >= 3) {
                    break;
                }
            }

            let hasDoubleLetter = false;
            for (let j = 1;j < item.length;j++) {
                if (item.charAt(j) === item.charAt(j - 1)) {
                    hasDoubleLetter = true;
                    break;
                }
            }

            let containsDisallowedString = false;
            for (let j = 0;j < disallowedStrings.length;j++) {
                if (item.indexOf(disallowedStrings[j]) !== -1) {
                    containsDisallowedString = true;
                    break;
                }
            }

            if (vowelCount >= 3 && hasDoubleLetter && !containsDisallowedString) {
                niceStrings++;
            }
        }
    }

    console.log(niceStrings);
});