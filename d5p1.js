const fs = require('fs');

fs.readFile('./inputs/d5.txt', 'utf8', function (err, data) {
    if (err) {
        console.log('An error occurred while trying to read the input: ' + err);
        return;
    }

    let matches = [];

    data = data.split(/\r?\n/)[0];

    for (let i = 0; i < 26; i++) {
        matches.push(String.fromCharCode(97 + i) + String.fromCharCode(65 + i));
    }
    for (let i = 0; i < 26; i++) {
        matches.push(String.fromCharCode(65 + i) + String.fromCharCode(97 + i));
    }

    let hasMatches = true;

    while (hasMatches) {
        hasMatches = false;

        for (let i = 0; i < matches.length; i++) {
            data = data.replace(matches[i], '');
        }

        for (let i = 0; i < matches.length; i++) {
            if (data.match(new RegExp(matches[i], 'g')) !== null) {
                hasMatches = true;
            }
        }
    }

    console.log(data.length);
});