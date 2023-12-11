use crate::input;

pub fn part1() {
    let mut lines = input::read_as_list(11);

    let mut galaxies = vec![];
    let mut empty_columns = vec![];
    let mut empty_rows = vec![];

    // TODO: Expand map

    for y in 0..lines.len() {
        let line = &lines[y];

        let mut empty_row = true;

        for x in 0..line.len() {
            if y == 0 {
                empty_columns.push(true);
            }

            if line.chars().nth(x).unwrap() == '#' {
                empty_row = false;
                empty_columns[x] = false;
            }
        }

        if empty_row {
            empty_rows.push(y);
        }
    }

    let mut parsed_empty_columns = empty_columns.iter().enumerate().filter_map(|(index, element)| {
        return if *element {
            Some(index)
        } else {
            None
        }
    }).collect::<Vec<_>>();
    parsed_empty_columns.reverse();

    for y in 0..lines.len() {
        for x in &parsed_empty_columns {
            lines[y].replace_range(x..&(x+1), "..");
        }
    }

    let mut new_lines = vec![];

    for y in (0..lines.len()).rev() {
        new_lines.push(&lines[y]);
        if empty_rows.contains(&y) {
            new_lines.push(&lines[y]);
        }
    }

    for y in 0..new_lines.len() {
        let line = &new_lines[y];

        for x in 0..line.len() {
            if line.chars().nth(x).unwrap() == '#' {
                galaxies.push((x as i32, y as i32));
            }
        }
    }

    let mut sum = 0;

    for i in 0..galaxies.len() {
        for j in (i + 1)..galaxies.len() {
            sum += (galaxies[i].0 - galaxies[j].0).abs() + (galaxies[i].1 - galaxies[j].1).abs();
        }
    }

    println!("Day 11, Part 1: {}", sum);
}

pub fn part2() {
    let lines = input::read_as_list(11);

    let mut galaxies = vec![];
    let mut empty_columns = vec![];
    let mut empty_rows = vec![];

    // TODO: Expand map

    for y in 0..lines.len() {
        let line = &lines[y];

        let mut empty_row = true;

        for x in 0..line.len() {
            if y == 0 {
                empty_columns.push(true);
            }

            if line.chars().nth(x).unwrap() == '#' {
                empty_row = false;
                empty_columns[x] = false;
            }
        }

        if empty_row {
            empty_rows.push(y as i64);
        }
    }

    let parsed_empty_columns = empty_columns.iter().enumerate().filter_map(|(index, element)| {
        return if *element {
            Some(index as i64)
        } else {
            None
        }
    }).collect::<Vec<_>>();

    for y in 0..lines.len() {
        let line = &lines[y];

        for x in 0..line.len() {
            if line.chars().nth(x).unwrap() == '#' {
                galaxies.push((x as i64, y as i64));
            }
        }
    }

    let mut sum = 0i64;

    let factor = 1000000;

    for i in 0..galaxies.len() {
        for j in (i + 1)..galaxies.len() {
            let distance_x: i64 = (galaxies[i].0 - galaxies[j].0).abs() + parsed_empty_columns.iter().filter(|&&x| (x >= galaxies[i].0 && x <= galaxies[j].0) || x >= galaxies[j].0 && x <= galaxies[i].0).map(|_| factor - 1).sum::<i64>();
            let distance_y: i64 = (galaxies[i].1 - galaxies[j].1).abs() + empty_rows.iter().filter(|&&y| (y >= galaxies[i].1 && y <= galaxies[j].1) || y >= galaxies[j].1 && y <= galaxies[i].1).map(|_| factor - 1).sum::<i64>();

            sum += distance_x + distance_y;
        }
    }

    println!("Day 11, Part 2: {}", sum);
}