const fs = require('fs');

fs.readFile('./inputs/d1.txt', 'utf8', function(err, data) {
    if (err) {
        console.log('An error occurred while trying to read the input: ' + err);
        return;
    }

    let input = data.split(/\r?\n/g);

    let frequency = 0;

    for (let i = 0;i < input.length;i++) {
        let item = input[i];
        if (item.length >= 2) {
            let operator = item.charAt(0);
            let number = parseInt(item.substr(1));

            switch (operator) {
                case '+':
                    frequency += number;
                    break;
                case '-':
                    frequency -= number;
                    break;
                default:
                    console.log('Unexpected operator "' + operator + '"');
            }
        }
    }

    console.log(frequency);
});