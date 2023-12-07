use std::cmp::Ordering;
use crate::input;

pub fn part1() {
    let lines = input::read_as_list(7);

    let mut sum = 0;

    let mut mapped_lines: Vec<_> = lines.iter().map(|line| {
        let split_line = line.split(" ").collect::<Vec<_>>();
        return (split_line[0], split_line[1].parse::<i32>().unwrap(), get_score_for_hand(split_line[0]));
    }).collect();

    mapped_lines.sort_by(|a,b| compare_one_to_two(a,b, false));

    for i in 0..mapped_lines.len() {
        sum += &mapped_lines[i].1 * (i + 1) as i32;
    }

    println!("Day 7, Part 1: {}", sum);
}

pub fn part2() {
    let lines = input::read_as_list(7);

    let mut sum = 0;

    let mut mapped_lines: Vec<_> = lines.iter().map(|line| {
        let split_line = line.split(" ").collect::<Vec<_>>();
        return (split_line[0], split_line[1].parse::<i32>().unwrap(), get_score_for_hand_with_joker(split_line[0]));
    }).collect();

    mapped_lines.sort_by(|a,b| compare_one_to_two(a,b,true));

    for i in 0..mapped_lines.len() {
        sum += &mapped_lines[i].1 * (i + 1) as i32;
    }

    println!("Day 7, Part 2: {}", sum);
}

fn compare_one_to_two(one: &(&str, i32, i32), two: &(&str, i32, i32), with_joker: bool) -> Ordering {
    if one.2 < two.2 {
        return Ordering::Less;
    }

    if one.2 > two.2 {
        return Ordering::Greater;
    }

    for i in 00..one.0.len() {
        let letter_one = get_number_for_letter(one.0.chars().nth(i).unwrap(), with_joker);
        let letter_two = get_number_for_letter(two.0.chars().nth(i).unwrap(), with_joker);
        if letter_one < letter_two {
            return Ordering::Less;
        }
        if letter_one > letter_two {
            return Ordering::Greater;
        }
    }

    return Ordering::Equal;
}

fn get_score_for_hand(hand: &str) -> i32 {
    let mut scores = [0,0,0,0,0,0,0,0,0,0,0,0,0];

    for char in hand.chars() {
        scores[get_number_for_letter(char, false)] += 1;
    }

    scores.sort();
    scores.reverse();

    if scores[0] == 5 {
        return 7;
    }

    if scores[0] == 4 {
        return 6;
    }

    if scores[0] == 3 {
        if scores[1] == 2 {
            return 5;
        }
        return 4;
    }

    if scores[0] == 2 {
        if scores[1] == 2 {
            return 3;
        }
        return 2;
    }

    return 1;
}

fn get_score_for_hand_with_joker(hand: &str) -> i32 {
    let mut scores = [0,0,0,0,0,0,0,0,0,0,0,0,0];

    let mut jokers = 0;

    for char in hand.chars() {
        if char == 'J' {
            jokers += 1;
        }
        else {
            scores[get_number_for_letter(char, true)] += 1;
        }
    }

    scores.sort();
    scores.reverse();

    if scores[0] + jokers >= 5 {
        return 7;
    }

    if scores[0] + jokers >= 4 {
        return 6;
    }

    if scores[0] + jokers >= 3 {
        if scores[1] == 2 {
            return 5;
        }
        return 4;
    }

    if scores[0] + jokers >= 2 {
        if scores[1] == 2 {
            return 3;
        }
        return 2;
    }

    return 1;
}

fn get_number_for_letter(letter: char, with_joker: bool) -> usize {
    return if with_joker {
        get_number_for_letter_with_joker(letter)
    } else {
        get_number_for_letter_without_joker(letter)
    };
}

fn get_number_for_letter_without_joker(letter: char) -> usize {
    if letter == 'A' {
        return 12;
    }
    if letter == 'K' {
        return 11;
    }
    if letter == 'Q' {
        return 10;
    }
    if letter == 'J' {
        return 9;
    }
    if letter == 'T' {
        return 8;
    }
    let parsed_char = letter.to_digit(10).unwrap() as usize;
    return parsed_char - 2;
}

fn get_number_for_letter_with_joker(letter: char) -> usize {
    if letter == 'A' {
        return 12;
    }
    if letter == 'K' {
        return 11;
    }
    if letter == 'Q' {
        return 10;
    }
    if letter == 'J' {
        return 0;
    }
    if letter == 'T' {
        return 9;
    }
    let parsed_char = letter.to_digit(10).unwrap() as usize;
    return parsed_char - 1;
}