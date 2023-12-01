use std::fs;
use regex::Regex;

fn main() {
    day1part1();
    day1part2();
}

fn day1part1() {
    let mut lines = Vec::new();

    for line in fs::read_to_string("input/1.txt").unwrap().lines() {
        lines.push(line.to_string());
    }

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

fn day1part2() {
    let mut lines = Vec::new();

    for line in fs::read_to_string("input/1.txt").unwrap().lines() {
        lines.push(line.to_string());
    }

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