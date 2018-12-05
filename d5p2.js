const fs = require('fs');

fs.readFile('./inputs/d5.txt', 'utf8', function (err, data) {
    if (err) {
        console.log('An error occurred while trying to read the input: ' + err);
        return;
    }

    let shortestPolymer = data.length+3;
    for (let i = 0;i < 26;i++) {
        let length = dataLength(data, i);
        if (length < shortestPolymer) {
            shortestPolymer = length;
        }
    }

    console.log(shortestPolymer);
});

function dataLength(data, i) {
    let matches = [];

    data = data.split(/\r?\n/)[0];
    data = data.replace(new RegExp(String.fromCharCode(97 + i), 'g'), '');
    data = data.replace(new RegExp(String.fromCharCode(65 + i), 'g'), '');

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

    return data.length;
}