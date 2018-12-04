const md5 = require('md5');

let input = 'yzbqklnj';

let hashNumber = null;
let i = 1;
while (hashNumber === null) {
    if (createsValidHash(input, i)) {
        hashNumber = i;
    }
    i++;
}

console.log(hashNumber);

function createsValidHash(input, number) {
    let hash = md5(input + number);
    let validHash = true;
    for (let i = 0; i < 5; i++) {
        if (hash.charAt(i) !== '0') {
            validHash = false;
        }
    }
    return validHash;
}