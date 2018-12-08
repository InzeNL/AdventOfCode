const fs = require('fs');

fs.readFile('./inputs/d7.txt', 'utf8', function (err, data) {
    if (err) {
        console.log('An error occurred while trying to read the input: ' + err);
        return;
    }

    let input = data.split(/\r?\n/);

    let dependencies = [];
    let passed = [];
    let beingWorkedOn = [];

    let workers = [];

    for (let i = 0; i < 5; i++) {
        workers[i] = {workingOn: null, doneAt: 0};
    }

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

            beingWorkedOn[firstChar] = false;
            beingWorkedOn[secondChar] = false;
            passed[firstChar] = false;
            passed[secondChar] = false;
        }
    }

    let passedSteps = 0;
    let currentTime = 0;
    while (passedSteps < beingWorkedOn.length) {
        for (let i = 0; i < workers.length; i++) {
            let worker = workers[i];
            if (worker.doneAt <= currentTime) {
                if (worker.workingOn !== null) {
                    if (!passed[worker.workingOn]) {
                        passedSteps++;
                        passed[worker.workingOn] = true;
                    }
                }
                let firstToWorkOn = getFirstAvailableStep(dependencies, passed, beingWorkedOn);
                if (!firstToWorkOn) {
                    worker.workingOn = null;
                    worker.doneAt = currentTime;
                    continue;
                }
                let code = charToCode(firstToWorkOn);
                beingWorkedOn[code] = true;
                worker.doneAt = currentTime + 60 + code + 1;
                worker.workingOn = code;
            }
            if (passedSteps >= beingWorkedOn.length) {
                break;
            }
        }
        currentTime++;
    }

    console.log(currentTime - 1);
});

function charToCode(char) {
    return char.charCodeAt(0) - 65;
}

function codeToChar(code) {
    return String.fromCharCode(code + 65);
}

function getFirstAvailableStep(dependencies, passed, beingWorkedOn) {
    for (let i = 0; i < dependencies.length; i++) {
        if (!passed[i] && !beingWorkedOn[i]) {
            let dependency = dependencies[i];
            let canBeAdded = true;
            for (let j = 0; j < dependency.length; j++) {
                if (!passed[dependency[j]]) {
                    canBeAdded = false;
                }
            }
            if (canBeAdded) {
                return codeToChar(i);
            }
        }
    }
}