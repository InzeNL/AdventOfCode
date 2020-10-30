const fs = require('fs');

fs.readFile('./inputs/d6.txt', 'utf8', function (err, data) {
    if (err) {
        console.log('An error occurred while trying to read the input: ' + err);
        return;
    }

    const regex = /^(.*?) (\d*?),(\d*).*?(\d*?),(\d*)$/gm;

    let lights = [];

    let rowOfLights = [];
    for (let i = 0; i <= 999; i++) {
        rowOfLights.push(0);
    }

    for (let i = 0; i <= 999; i++) {
        lights.push([...rowOfLights]);
    }

    let match;

    while ((match = regex.exec(data)) !== null) {
        if (match.index === regex.lastIndex) {
            regex.lastIndex++;
        }

        for (let x = parseInt(match[2]); x <= parseInt(match[4]); x++) {
            for (let y = parseInt(match[3]); y <= parseInt(match[5]); y++) {
                switch (match[1]) {
                    case 'turn on':
                        lights[x][y]++;
                        break;
                    case 'turn off':
                        if (lights[x][y] > 0) {
                            lights[x][y]--;
                        }
                        break;
                    case 'toggle':
                        lights[x][y] += 2;
                        break;
                }
            }
        }
    }

    let totalBrightness = 0;
    for (let x = 0; x <= 999; x++) {
        for (let y = 0; y <= 999; y++) {
            totalBrightness += lights[x][y];
        }
    }

    console.log(totalBrightness);
});