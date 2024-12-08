# Advent of Code

## Ruby
Ruby is required to run this program

1. Navigate to https://www.ruby-lang.org/en/documentation/installation/
2. Download the installer that's appropriate for your operating system
3. Install it

## Dependencies
To install the dependencies that are required for this project, simply run the follow command in the root directory of the project
```
bundle
```

## Configuration
Before running the application, a configuration needs to be set up. This configuration file needs to be placed in the root folder of the project, with the name `config.json`

An example is given in `config.json.example`, but also shown below.

```
{
    "input_url": "https://adventofcode.com/2024/day/%s/input",
    "session_token": ""
}
```

It is unlikely the `input_url` property needs to be changed, unless the year is changed. This particular project is created for 2024, thus it uses the 2024 url. For other years, simply replace the `2024` with the correct year.

The `session_token` needs to be filled out manually. To obtain the session token, follow the steps below:
1. Navigate to https://adventofcode.com/
2. If not logged in, click "[Log in]" in the menu
3. Log in using your Advent of Code account
4. Open the debug menu for your browser. In most browsers, this is done by pressing `F12`
5. Navigate to your cookies (In Chromium: Application > Cookies > https://adventofcode.com/)
6. Copy the value for `session`
7. Paste the value into the `config.json` for the `session_token` property

## Executing the program
There are different ways to run the program, they are described below.

### Benchmark mode
Benchmark mode is the "default" mode. This will run all available modes for days 1 through 25, both part 1 and part 2, where available.

It will measure the time it takes to run these and display the benchmark results in a table

You can run this mode by using the following command in the root directory of the project
```
ruby .\main.rb
```

### Day mode
Day mode lets you run both parts for a specific day. This will not run a benchmark on it, and simply show the results.

You can run this mode by using the following command in the root directory of the project. Assuming day 1
```
ruby .\main.rb 1
```

### Part mode
Part mode lets you run a specific part for a specific day. This will not run a benchmark on it, and simply show the result.

Day mode lets you run both parts for a specific day. This will not run a benchmark on it, and simply show the results.

You can run this mode by using the following command in the root directory of the project. Assuming day 1, part 2
```
ruby .\main.rb 1 2
```