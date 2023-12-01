use regex::Regex;
use crate::input;

pub fn part1() {
    let lines = input::read_as_list(1);

    let mut sum = 0;

    let re = Regex::new(r"(\d)").unwrap();
    for line in lines {
        let first_line = line.chars().collect::<String>();
        let last_line = line.chars().rev().collect::<String>();
        let Some(first_caps) = re.captures(&*first_line) else { return };
        let Some(second_caps) = re.captures(&*last_line) else { return };
        let digits = first_caps[1].to_owned() + &second_caps[1];
        let actual_digits = digits.parse::<i32>().unwrap();
        sum += actual_digits;
    }

    println!("Day 1, Part 1: {}", sum);
}

pub fn part2() {
    let lines = input::read_as_list(1);

    let mut sum = 0;

    let re = Regex::new(r"^.*?(\d|one|two|three|four|five|six|seven|eight|nine).*$").unwrap();
    let second_re = Regex::new(r".*(\d|one|two|three|four|five|six|seven|eight|nine).*?$").unwrap();
    for line in lines {
        let first_line = line.chars().collect::<String>();
        let Some(first_caps) = re.captures(&*first_line) else { println!("Hey"); return };
        let Some(second_caps) = second_re.captures(&*first_line) else { println!("Hi"); return };
        let digits = first_caps[1].to_owned() + &second_caps[1];
        let real_digits = digits
            .replace("one", "1")
            .replace("two", "2")
            .replace("three", "3")
            .replace("four", "4")
            .replace("five", "5")
            .replace("six", "6")
            .replace("seven", "7")
            .replace("eight", "8")
            .replace("nine", "9");
        let actual_digits = real_digits.parse::<i32>().unwrap();
        sum += actual_digits;
    }

    println!("Day 1, Part 2: {}", sum);
}