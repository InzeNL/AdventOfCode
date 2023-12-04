use crate::input;

pub fn part1() {
    let lines = input::read_as_list(4);

    let mut sum = 0;

    for line in lines {
        let card_split: Vec<&str> = line.split(": ").collect();
        let number_split: Vec<&str> = card_split[1].split(" | ").collect();
        let winning_numbers: Vec<i32> = get_list_of_numbers(number_split[0]);
        let numbers_on_card: Vec<i32> = get_list_of_numbers(number_split[1]);

        let score = count_matching_numbers(winning_numbers, numbers_on_card) as u32;
        if score > 0 {
            sum += 2_i32.pow(score - 1);
        }
    }

    println!("Day 3, Part 1: {}", sum);
}

fn get_list_of_numbers(list: &str) -> Vec<i32> {
    return list.split(" ").map(|x| x.trim()).filter(|x| !x.is_empty()).map(|x| x.parse::<i32>().unwrap()).collect();
}

fn count_matching_numbers(winning_numbers: Vec<i32>, numbers_on_card: Vec<i32>) -> usize {
    let mut actual_winning_numbers = 0;
    for winning_number in winning_numbers {
        if numbers_on_card.contains(&winning_number) {
            actual_winning_numbers += 1;
        }
    }
    return actual_winning_numbers;
}

pub fn part2() {
    let lines = input::read_as_list(4);
    let mut copies: Vec<i32> = vec![];
    for _ in &lines {
        copies.push(1);
    }

    let mut sum = 0;

    for i in 0..lines.len() {
        let line = &lines[i];
        let card_split: Vec<&str> = line.split(": ").collect();
        let number_split: Vec<&str> = card_split[1].split(" | ").collect();
        let winning_numbers: Vec<i32> = get_list_of_numbers(number_split[0]);
        let numbers_on_card: Vec<i32> = get_list_of_numbers(number_split[1]);

        let score = count_matching_numbers(winning_numbers, numbers_on_card);

        for j in i + 1..i + 1 + score {
            copies[j] += copies[i];
        }
        sum += copies[i];
    }

    println!("Day 3, Part 2: {}", sum);
}