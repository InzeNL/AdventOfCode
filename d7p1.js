const fs = require('fs');

fs.readFile('./inputs/d7.txt', 'utf8', function (err, data) {
    if (err) {
        console.log('An error occurred while trying to read the input: ' + err);
        return;
    }

    let input = data.split(/\r?\n/);

    let dependencies = [];
    let passed = [];

    for (let i = 0; i < input.length; i++) {
        let item = input[i].split(' ');
        if (item.length > 1) {
            let firstChar = charToCode(item[1]);
            let secondChar = charToCode(item[7]);

            if (!dependencies[firstChar]) {
                dependencies[firstChar] = [];
            }

            if (!dependencies[secondChar]) {
                dependencies[secondChar] = [];
            }
            dependencies[secondChar].push(firstChar);

            passed[firstChar] = false;
            passed[secondChar] = false;
        }
    }

    let order = '';
    while (order.length < passed.length) {
        for (let i = 0; i < dependencies.length; i++) {
            if (!passed[i]) {
                let dependency = dependencies[i];
                let canBeAdded = true;
                for (let j = 0; j < dependency.length; j++) {
                    if (!passed[dependency[j]]) {
                        canBeAdded = false;
                    }
                }
                if (canBeAdded) {
                    passed[i] = true;
                    order += codeToChar(i);
                    break;
                }
            }
        }
    }

    console.log(order);
});

function charToCode(char) {
    return char.charCodeAt(0) - 65;
}

function codeToChar(code) {
    return String.fromCharCode(code + 65);
}