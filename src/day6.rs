use regex::Regex;
use crate::input;

pub fn part1() {
    let lines = input::read_as_list(6);

    let mut product = 1;

    let re_text = Regex::new(r"[a-zA-Z:]").unwrap();
    let first_line = get_list_of_numbers(&re_text.replace_all(&lines[0], "").to_string());
    let second_line = get_list_of_numbers(&re_text.replace_all(&lines[1], "").to_string());

    for i in 0..first_line.len() {
        let time = first_line[i];
        let distance_to_beat = second_line[i];

        let mut first_time_beat = 0;
        let mut last_time_beat= 0;

        for j in 0..time {
            let distance = calculate_distance(time, j);
            if distance > distance_to_beat {
                first_time_beat = j;
                break;
            }
        }

        for k in (0..time).rev() {
            let distance = calculate_distance(time, k);
            if distance > distance_to_beat {
                last_time_beat = k;
                break;
            }
        }

        product *= last_time_beat - first_time_beat + 1;
    }

    println!("Day 6, Part 1: {}", product);
}

fn get_list_of_numbers(list: &str) -> Vec<i32> {
    return list.split(" ").map(|x| x.trim()).filter(|x| !x.is_empty()).map(|x| x.parse::<i32>().unwrap()).collect();
}

fn calculate_distance(total_time: i32, button_time: i32) -> i32 {
    return (total_time - button_time) * button_time;
}

fn calculate_big_distance(total_time: i64, button_time: i64) -> i64 {
    return (total_time - button_time) * button_time;
}

pub fn part2() {
    let lines = input::read_as_list(6);

    let mut product = 1;

    let re_text = Regex::new(r"[a-zA-Z:\s]").unwrap();
    let time = &re_text.replace_all(&lines[0], "").to_string().parse::<i64>().unwrap();
    let distance_to_beat = &re_text.replace_all(&lines[1], "").to_string().parse::<i64>().unwrap();

    let mut first_time_beat = 0;
    let mut last_time_beat= 0;

    for j in 0..*time {
        let distance = &calculate_big_distance(*time, j);
        if distance > distance_to_beat {
            first_time_beat = j;
            break;
        }
    }

    for k in (0..*time).rev() {
        let distance = &calculate_big_distance(*time, k);
        if distance > distance_to_beat {
            last_time_beat = k;
            break;
        }
    }

    product = last_time_beat - first_time_beat + 1;

    println!("Day 6, Part 2: {}", product);
}