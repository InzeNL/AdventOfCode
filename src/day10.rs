use iron_shapes::multi_polygon::WindingNumber;
use iron_shapes::point::Point;
use iron_shapes::polygon::{SimplePolygon};
use rayon::iter::ParallelIterator;
use rayon::iter::IntoParallelIterator;
use crate::input;

pub fn part1() {
    let lines = input::read_as_list(10);

    let mut start_x = 0;
    let mut start_y = 0;

    let mut map = vec![];

    for i in 0..lines.len() {
        let line = &lines[i];

        let mut map_row = vec![];
        for _ in 0..line.len() {
            map_row.push(-1);
        }

        map.push(map_row);

        let animal = line.find('S');
        if animal.is_some() {
            start_x = animal.unwrap();
            start_y = i;

            map[start_y][start_x] = 0;
        }
    }

    let mut first_direction = 'X';
    if start_y > 0 && ['|', 'F', '7'].contains(&lines[start_y - 1].chars().nth(start_x).unwrap()) {
        first_direction = 'N';
    }
    else if start_x < lines[0].len() - 1 && ['J', '-', '7'].contains(&lines[start_y].chars().nth(start_x + 1).unwrap()) {
        first_direction = 'E';
    }
    else if start_y < lines.len() - 1 && ['L', '|', 'J'].contains(&lines[start_y + 1].chars().nth(start_x).unwrap()) {
        first_direction = 'S';
    }
    else if start_x > 0 && ['L', 'F', '-'].contains(&lines[start_y].chars().nth(start_x - 1).unwrap()) {
        first_direction = 'W';
    }

    let mut looped_around = false;

    let mut current_x = start_x;
    let mut current_y = start_y;
    let mut current_distance = 0;
    let mut current_direction = first_direction;
    while !looped_around {
        current_distance += 1;

        if current_direction == 'N' {
            current_y -= 1;
        }
        else if current_direction == 'E' {
            current_x += 1;
        }
        else if current_direction == 'S' {
            current_y += 1;
        }
        else if current_direction == 'W' {
            current_x -= 1;
        }

        if map[current_y][current_x] != -1 {
            looped_around = true;
        }
        else {
            let pipe = lines[current_y].chars().nth(current_x).unwrap();

            if current_direction == 'N' {
                if pipe == '|' {
                    current_direction = 'N';
                }
                else if pipe == 'F' {
                    current_direction = 'E';
                }
                else if pipe == '7' {
                    current_direction = 'W';
                }
            }
            else if current_direction == 'E' {
                if pipe == 'J' {
                    current_direction = 'N';
                }
                else if pipe == '-' {
                    current_direction = 'E';
                }
                else if pipe == '7' {
                    current_direction = 'S';
                }
            }
            else if current_direction == 'S' {
                if pipe == 'L' {
                    current_direction = 'E';
                }
                else if pipe == '|' {
                    current_direction = 'S';
                }
                else if pipe == 'J' {
                    current_direction = 'W';
                }
            }
            else if current_direction == 'W' {
                if pipe == 'L' {
                    current_direction = 'N';
                }
                else if pipe == 'F' {
                    current_direction = 'S';
                }
                else if pipe == '-' {
                    current_direction = 'W';
                }
            }
        }
    }

    let furthest_distance = current_distance / 2;

    println!("Day 10, Part 1: {}", furthest_distance);
}

pub fn part2() {
    let lines = input::read_as_list(10);

    let mut start_x = 0;
    let mut start_y = 0;

    let mut map = vec![];

    for i in 0..lines.len() {
        let line = &lines[i];

        let mut map_row = vec![];
        for _ in 0..line.len() {
            map_row.push(-1);
        }

        map.push(map_row);

        let animal = line.find('S');
        if animal.is_some() {
            start_x = animal.unwrap();
            start_y = i;

            map[start_y][start_x] = 0;
        }
    }

    let mut first_direction = 'X';
    if start_y > 0 && ['|', 'F', '7'].contains(&lines[start_y - 1].chars().nth(start_x).unwrap()) {
        first_direction = 'N';
    }
    else if start_x < lines[0].len() - 1 && ['J', '-', '7'].contains(&lines[start_y].chars().nth(start_x + 1).unwrap()) {
        first_direction = 'E';
    }
    else if start_y < lines.len() - 1 && ['L', '|', 'J'].contains(&lines[start_y + 1].chars().nth(start_x).unwrap()) {
        first_direction = 'S';
    }
    else if start_x > 0 && ['L', 'F', '-'].contains(&lines[start_y].chars().nth(start_x - 1).unwrap()) {
        first_direction = 'W';
    }

    let mut looped_around = false;

    let mut points: Vec<Point<i32>> = vec![];

    let mut current_x = start_x;
    let mut current_y = start_y;
    let mut current_direction = first_direction;
    while !looped_around {
        map[current_y][current_x] = 0;
        points.push(Point::new(current_x as i32, current_y as i32));

        if current_direction == 'N' {
            current_y -= 1;
        }
        else if current_direction == 'E' {
            current_x += 1;
        }
        else if current_direction == 'S' {
            current_y += 1;
        }
        else if current_direction == 'W' {
            current_x -= 1;
        }

        if map[current_y][current_x] != -1 {
            looped_around = true;
        }
        else {
            let pipe = lines[current_y].chars().nth(current_x).unwrap();

            if current_direction == 'N' {
                if pipe == '|' {
                    current_direction = 'N';
                }
                else if pipe == 'F' {
                    current_direction = 'E';
                }
                else if pipe == '7' {
                    current_direction = 'W';
                }
            }
            else if current_direction == 'E' {
                if pipe == 'J' {
                    current_direction = 'N';
                }
                else if pipe == '-' {
                    current_direction = 'E';
                }
                else if pipe == '7' {
                    current_direction = 'S';
                }
            }
            else if current_direction == 'S' {
                if pipe == 'L' {
                    current_direction = 'E';
                }
                else if pipe == '|' {
                    current_direction = 'S';
                }
                else if pipe == 'J' {
                    current_direction = 'W';
                }
            }
            else if current_direction == 'W' {
                if pipe == 'L' {
                    current_direction = 'N';
                }
                else if pipe == 'F' {
                    current_direction = 'S';
                }
                else if pipe == '-' {
                    current_direction = 'W';
                }
            }
        }
    }

    let polygon = SimplePolygon::from(points);

    let area = (0..lines.len()).into_par_iter().map(|y| {
        return (0..lines[y].len()).into_par_iter().map(|x| {
            if map[y][x] == -1 {
                if polygon.contains_point(Point::new(x as i32, y as i32)) {
                    return 1;
                }
            }
            return 0;
        }).sum::<i32>();
    }).sum::<i32>();

    println!("Day 10, Part 2: {}", area);
}