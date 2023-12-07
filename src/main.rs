mod input;
mod day1;
mod day2;
mod day3;
mod day4;

mod day6;
mod day7;

fn main() {
    use std::time::Instant;
    let now = Instant::now();

    day1::part1();
    day1::part2();
    day2::part1();
    day2::part2();
    day3::part1();
    day3::part2();
    day4::part1();
    day4::part2();


    day6::part1();
    day6::part2();
    day7::part1();
    day7::part2();

    let elapsed = now.elapsed();
    println!("Total run time: {:?}", elapsed);
}