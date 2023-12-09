use crate::input;

pub fn part1() {
    let lines = input::read_as_list(9);

    let mut sum = 0;

    for line in lines {
        sum += calculate_next(translate_to_prediction_model(get_list_of_numbers(&line)));
    }

    println!("Day 9, Part 1: {}", sum);
}

pub fn part2() {
    let lines = input::read_as_list(9);

    let mut sum = 0;

    for line in lines {
        sum += calculate_previous(translate_to_prediction_model(get_list_of_numbers(&line)));
    }

    println!("Day 9, Part 2: {}", sum);
}

fn get_list_of_numbers(list: &str) -> Vec<i32> {
    return list.split(" ").map(|x| x.trim()).filter(|x| !x.is_empty()).map(|x| x.parse::<i32>().unwrap()).collect();
}

fn calculate_next(prediction_model: Vec<Vec<i32>>) -> i32 {
    let mut next = 0i32;

    for i in (0..prediction_model.len()).rev() {
        next += prediction_model[i].last().unwrap();
    }

    return next;
}

fn calculate_previous(prediction_model: Vec<Vec<i32>>) -> i32 {
    let mut previous = 0i32;

    for i in (0..prediction_model.len()).rev() {
        previous = prediction_model[i].first().unwrap() - previous;
    }

    return previous;
}

fn translate_to_prediction_model(numbers: Vec<i32>) -> Vec<Vec<i32>> {
    let mut rows = vec![numbers];

    let mut current_row = rows.last().unwrap();
    while !row_is_all_zeroes(current_row) {
        let mut new_row = vec![];

        for i in 0..current_row.len() - 1 {
            new_row.push(current_row[i + 1] - current_row[i]);
        }

        rows.push(new_row);

        current_row = rows.last().unwrap();
    }

    return rows;
}

fn row_is_all_zeroes(numbers: &Vec<i32>) -> bool {
    for number in numbers {
        if number != &0i32 {
            return false;
        }
    }
    return true;
}