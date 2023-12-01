use std::fs;

pub fn read_as_list(day: i32) -> Vec<String> {
    let mut lines = Vec::new();

    for line in read_as_string(day).lines() {
        lines.push(line.to_string());
    }

    lines
}

pub fn read_as_string(day: i32) -> String {
    fs::read_to_string(get_input_file_from_day(day)).unwrap()
}

fn get_input_file_from_day(day: i32) -> String {
    format!("input/{}.txt", day)
}