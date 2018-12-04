const fs = require('fs');

fs.readFile('./inputs/d4.txt', 'utf8', function (err, data) {
    if (err) {
        console.log('An error occurred while trying to read the input: ' + err);
        return;
    }

    let input = data.split(/\r?\n/g);

    let objects = [];

    for (let i = 0; i < input.length; i++) {
        let item = input[i];
        if (item.length >= 2) {
            let date = item.split('] ')[0].substring(1).split('-');
            let action = item.split('] ')[1];

            let year = parseInt(date[0]);
            let month = parseInt(date[1]);
            let day = parseInt(date[2].split(' ')[0]);
            let time = date[2].split(' ')[1];

            year += (1970 - 1518);

            let dateString = year + '-' + month + '-' + day + ' ' + time;

            let dateFormat = new Date(dateString);

            objects.push({
                date: dateFormat,
                action: action
            });
        }
    }

    objects.sort(function (a, b) {
        return a.date.getTime() - b.date.getTime();
    });

    let lastGuard = null;

    let timesAsleep = {};
    let sleepTimes = {};

    for (let i = 0; i < objects.length; i++) {
        let object = objects[i];
        let action = object.action;

        if (action.split(' ')[0] === 'Guard') {
            lastGuard = action.split(' ')[1].substring(1);
            if (!sleepTimes[lastGuard]) {
                timesAsleep[lastGuard] = 0;
                sleepTimes[lastGuard] = [];
                for (let i = 0; i < 60; i++) {
                    sleepTimes[lastGuard][i] = 0;
                }
            }
        } else if (action.split(' ')[0] === 'wakes') {
            let prevObject = objects[i - 1];

            let minutes = Math.round((object.date - prevObject.date) / 60000);
            let startMinutes = prevObject.date.getMinutes();

            for (let i = startMinutes; i < startMinutes + minutes; i++) {
                timesAsleep[lastGuard]++;
                sleepTimes[lastGuard][i]++;
            }
        }
    }

    let mostAsleepGuard = 0;
    let mostAsleepGuardId = null;
    let maxSleepTime = 0;
    let maxSleepMoment = 0;

    for (let guard in timesAsleep) {
        if (!timesAsleep.hasOwnProperty(guard)) {
            continue;
        }
        let sleepTimesGuard = sleepTimes[guard];

        for (let i = 0; i < sleepTimesGuard.length; i++) {
            if (sleepTimesGuard[i] > maxSleepTime) {
                mostAsleepGuard = sleepTimesGuard[i];
                mostAsleepGuardId = guard;
                maxSleepTime = sleepTimesGuard[i];
                maxSleepMoment = i;
            }
        }
    }

    console.log(mostAsleepGuardId * maxSleepMoment);
});