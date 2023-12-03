use regex::Regex;
use crate::input;

pub fn part1() {
    let lines = input::read_as_list(3);

    let mut sum = 0;

    let lines_len = lines.len();
    let re_part = Regex::new(r"(\d+)").unwrap();
    let re_symbol = Regex::new(r"[^\d.]").unwrap();
    for i in 0..lines_len {
        let line = &lines[i];
        let part_number_options: Vec<_> = re_part.captures_iter(line).collect();
        for j in 0..part_number_options.len() {
            let part_number_option = &part_number_options[j].get(1).unwrap();
            let range = part_number_option.range();
            let mut start = range.start;
            if start > 0 {
                start -= 1;
            }
            let mut end = range.end;
            if end < line.len() - 1 {
                end += 1;
            }

            let mut is_part_number = false;
            if i > 0 {
                let previous_line = &lines[i - 1][start..end];
                if re_symbol.is_match(previous_line) {
                    is_part_number = true;
                }
            }

            if !is_part_number {
                let current_line = &line[start..end];
                if re_symbol.is_match(current_line) {
                    is_part_number = true;
                }
            }

            if i < lines_len - 1 && !is_part_number {
                let next_line = &lines[i + 1][start..end];
                if re_symbol.is_match(next_line) {
                    is_part_number = true;
                }
            }

            if is_part_number {
                sum += part_number_option.as_str().parse::<i32>().unwrap();
            }
        }
    }

    println!("Day 3, Part 1: {}", sum);
}

pub fn part2() {
    let lines = input::read_as_list(3);

    let mut sum = 0;

    let lines_len = lines.len();
    let re_part = Regex::new(r"(\d+)").unwrap();
    let re_gear = Regex::new(r"(\*)").unwrap();
    for i in 0..lines_len {
        let line = &lines[i];

        let gears: Vec<_> = re_gear.captures_iter(line).collect();
        for gear in gears {
            let found = gear.get(1).unwrap();
            let mut parts: Vec<i32> = vec![];
            let gear_position = found.start();

            if i > 0 {
                let previous_line = &lines[i - 1];
                let part_number_matches: Vec<_> = re_part.captures_iter(previous_line).collect();
                for j in 0..part_number_matches.len() {
                    let part = &part_number_matches[j].get(1).unwrap();
                    let range = part.range();
                    for k in range.start..range.end {
                        if k >= gear_position - 1 && k <= gear_position + 1 {
                            parts.push(part.as_str().parse::<i32>().unwrap());
                            break;
                        }
                    }
                }
            }

            if parts.len() <= 2 {
                let part_number_matches: Vec<_> = re_part.captures_iter(line).collect();
                for j in 0..part_number_matches.len() {
                    let part = &part_number_matches[j].get(1).unwrap();
                    let range = part.range();
                    if range.end == gear_position {
                        parts.push(part.as_str().parse::<i32>().unwrap());
                    }
                    else if range.start == gear_position + 1 {
                        parts.push(part.as_str().parse::<i32>().unwrap());
                    }
                }
            }

            if i < lines_len - 1 && parts.len() <= 2 {
                let next_line = &lines[i + 1];
                let part_number_matches: Vec<_> = re_part.captures_iter(next_line).collect();
                for j in 0..part_number_matches.len() {
                    let part = &part_number_matches[j].get(1).unwrap();
                    let range = part.range();
                    for k in range.start..range.end {
                        if k >= gear_position - 1 && k <= gear_position + 1 {
                            parts.push(part.as_str().parse::<i32>().unwrap());
                            break;
                        }
                    }
                }
            }

            if parts.len() == 2 {
                sum += parts[0] * parts[1];
            }
        }
    }


    println!("Day 3, Part 2: {}", sum);
}