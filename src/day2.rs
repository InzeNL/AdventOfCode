use regex::Regex;
use crate::input;

pub fn part1() {
    let lines = input::read_as_list(2);

    let max_red = 12;
    let max_green = 13;
    let max_blue = 14;

    let mut sum = 0;

    let re_game = Regex::new(r"Game (\d+)").unwrap();
    let re_red  = Regex::new(r"(\d+?) red").unwrap();
    let re_green = Regex::new(r"(\d+?) green").unwrap();
    let re_blue = Regex::new(r"(\d+?) blue").unwrap();
    for line in lines {
        let game_split: Vec<&str> = line.split(": ").collect();
        let id = &re_game.captures(game_split[0]).unwrap()[1];
        let pulls = game_split[1].split("; ");

        let mut game_is_possible = true;
        for pull in pulls {
            if game_is_not_possible(&re_red, pull, max_red) {
                game_is_possible = false;
                break;
            }
            if game_is_not_possible(&re_green, pull, max_green) {
                game_is_possible = false;
                break;
            }
            if game_is_not_possible(&re_blue, pull, max_blue) {
                game_is_possible = false;
                break;
            }
        }

        if game_is_possible {
            sum += id.parse::<i32>().unwrap();
        }
    }

    println!("Day 2, Part 1: {}", sum);
}

fn game_is_not_possible(re: &Regex, pull: &str, max: i32) -> bool {
    return re.is_match(pull) && re.captures(pull).unwrap()[1].parse::<i32>().unwrap() > max;
}

pub fn part2() {
    let lines = input::read_as_list(2);

    let mut sum = 0;

    let re_red  = Regex::new(r"(\d+?) red").unwrap();
    let re_green = Regex::new(r"(\d+?) green").unwrap();
    let re_blue = Regex::new(r"(\d+?) blue").unwrap();
    for line in lines {
        let mut min_red = 0;
        let mut min_green = 0;
        let mut min_blue = 0;

        let game_split: Vec<&str> = line.split(": ").collect();
        let pulls = game_split[1].split("; ");

        for pull in pulls {
            min_red = max_of_colour(&re_red, pull, min_red);
            min_green = max_of_colour(&re_green, pull, min_green);
            min_blue = max_of_colour(&re_blue, pull, min_blue);
        }

        sum += min_red * min_green * min_blue;
    }

    println!("Day 2, Part 2: {}", sum);
}

fn max_of_colour(re: &Regex, pull: &str, min: i32) -> i32 {
    if re.is_match(pull) {
        let colour = re.captures(pull).unwrap()[1].parse::<i32>().unwrap();
        if colour > min {
            return colour;
        }
    }
    return min;
}