# colorize
A simple script that color highlights your log files.

The default keywords highlighed (case insensitive) are: INFO, DEBUG, WARN, WARNING and ERROR.

## Usage
```bash
./colorize.sh --help
```
```
./colorize.sh --help
Utility colorize.sh for colorize logs.
Usage: colorize.sh [options] <command> [arguments]

Command:
  colorize.sh file.log
  tail -f file.log | colorize.sh
  colorize.sh --colors

Options:
  --colors       Print colors.
  --help, -h     Print help.
  --version, -v  Print version.
```

## Example
```bash
echo -e "this is an INFO log\nthis is an info log\n"\
"this is a DEBUG log\nthis is a debug log\n"\
"this is a WARN log\nthis is a warn log\n"\
"this is a WARNING log\nthis is a warning log\n"\
"this is a ERROR log\nthis is a error log"\
| ./colorize.sh
```

## Customization
Set COLORIZE_EXPRESSION variable with your custom expression.
```bash
COLOR_OFF='\x1b[0m'
RED_ON='\x1b[0;31m'
BLUE_ON='\x1b[0;34m' 
export COLORIZE_EXPRESSION="s#ciao#$RED_ON&$COLOR_OFF#;
                     s#mamma#$BLUE_ON&$COLOR_OFF#;"
echo "ciao mamma" | ./colorize.sh
```
