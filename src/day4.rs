use crate::input;

pub fn part1() {
    let lines = input::read_as_list(4);

    let mut sum = 0;

    for line in lines {
        let card_split: Vec<&str> = line.split(": ").collect();
        let number_split: Vec<&str> = card_split[1].split(" | ").collect();
        let winning_numbers: Vec<i32> = number_split[0].split(" ").map(|x| x.trim()).filter(|x| !x.is_empty()).map(|x| x.parse::<i32>().unwrap()).collect();
        let numbers_on_card: Vec<i32> = number_split[1].split(" ").map(|x| x.trim()).filter(|x| !x.is_empty()).map(|x| x.parse::<i32>().unwrap()).collect();

        let mut score = 0;
        for winning_number in winning_numbers {
            if numbers_on_card.contains(&winning_number) {
                if score == 0 {
                    score = 1;
                }
                else {
                    score *= 2;
                }
            }
        }
        sum += score;
    }

    println!("Day 3, Part 1: {}", sum);
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
        let winning_numbers: Vec<i32> = number_split[0].split(" ").map(|x| x.trim()).filter(|x| !x.is_empty()).map(|x| x.parse::<i32>().unwrap()).collect();
        let numbers_on_card: Vec<i32> = number_split[1].split(" ").map(|x| x.trim()).filter(|x| !x.is_empty()).map(|x| x.parse::<i32>().unwrap()).collect();

        let mut score = 0;
        for winning_number in winning_numbers {
            if numbers_on_card.contains(&winning_number) {
                score += 1;
            }
        }

        for j in i + 1..i + 1 + score {
            copies[j] += copies[i];
        }
        sum += copies[i];
    }

    println!("Day 3, Part 2: {}", sum);
}