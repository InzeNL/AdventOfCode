mod day1;
mod input;
mod day2;
mod day3;

fn main() {
    use std::time::Instant;
    let now = Instant::now();

    day1::part1();
    day1::part2();
    day2::part1();
    day2::part2();
    day3::part1();
    day3::part2();

    let elapsed = now.elapsed();
    println!("Total run time: {:?}", elapsed);
}