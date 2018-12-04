const fs = require('fs');

fs.readFile('./inputs/d1.txt', 'utf8', function (err, data) {
    if (err) {
        console.log('An error occurred while trying to read the input: ' + err);
        return;
    }

    let floor = 0;

    for (let i = 0; i < data.length; i++) {
        switch (data.charAt(i)) {
            case '(':
                floor++;
                break;
            case ')':
                floor--;
                if (floor < 0) {
                    console.log(i + 1);
                }
                break;
            default:
                console.log('Unexpected character "' + data.charAt(i) + '"');
        }
        if (floor < 0) {
            break;
        }
    }
});