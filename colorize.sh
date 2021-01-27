#!/bin/bash

SCRIPT=$( basename "$0" )
VERSION="1.0.0"

COLOR_OFF='\x1b[0m'

BLACK_ON='\x1b[0;30m'
RED_ON='\x1b[0;31m'
GREEN_ON='\x1b[0;32m'
YELLOW_ON='\x1b[0;33m'
BLUE_ON='\x1b[0;34m' 
PURPLE_ON='\x1b[0;35m'
CYAN_ON='\x1b[0;36m' 
WHITE_ON='\x1b[0;37m'

HIGH_INTENSITY_BLACK_ON='\x1b[0;90m'
HIGH_INTENSITY_RED_ON='\x1b[0;91m'
HIGH_INTENSITY_GREEN_ON='\x1b[0;92m'
HIGH_INTENSITY_YELLOW_ON='\x1b[0;93m'
HIGH_INTENSITY_BLUE_ON='\x1b[0;94m'
HIGH_INTENSITY_PURPLE_ON='\x1b[0;95m'
HIGH_INTENSITY_CYAN_ON='\x1b[0;96m'
HIGH_INTENSITY_WHITE_ON='\x1b[0;97m'

BOLD_BLACK_ON='\x1b[1;30m'
BOLD_RED_ON='\x1b[1;31m' 
BOLD_GREEN_ON='\x1b[1;32m'
BOLD_YELLOW_ON='\x1b[1;33m'
BOLD_BLUE_ON='\x1b[1;34m'
BOLD_PURPLE_ON='\x1b[1;35m'
BOLD_CYAN_ON='\x1b[1;36m'
BOLD_WHITE_ON='\x1b[1;37m'

BOLD_HIGH_INTENSITY_BLACK_ON='\x1b[1;90m'
BOLD_HIGH_INTENSITY_RED_ON='\x1b[1;91m'
BOLD_HIGH_INTENSITY_GREEN_ON='\x1b[1;92m'
BOLD_HIGH_INTENSITY_YELLOW_ON='\x1b[1;93m'
BOLD_HIGH_INTENSITY_BLUE_ON='\x1b[1;94m'
BOLD_HIGH_INTENSITY_PURPLE_ON='\x1b[1;95m'
BOLD_HIGH_INTENSITY_CYAN_ON='\x1b[1;96m'
BOLD_HIGH_INTENSITY_WHITE_ON='\x1b[1;97m'

function colorize() {
  COLORIZE_EXPRESSION=${COLORIZE_EXPRESSION:-"s#ERROR#$RED_ON&$COLOR_OFF#I;
                                              s#WARN\(ING\)\?#$YELLOW_ON&$COLOR_OFF#I;
                                              s#DEBUG#$PURPLE_ON&$COLOR_OFF#I;
                                              s#INFO#$HIGH_INTENSITY_BLUE_ON&$COLOR_OFF#I;"}
  sed -u "$COLORIZE_EXPRESSION" $1
}

#
# Message to display for usage and help.
#
function usage
{
  local txt=(
"Utility $SCRIPT for colorize logs."
"Usage: $SCRIPT [options] <command> [arguments]"
""
"Command:"
"  colorize.sh file.log"
"  tail -f file.log | colorize.sh"
"  colorize.sh --colors"
""
"Options:"
"  --colors       Print colors."
"  --help, -h     Print help."
"  --version, -v  Print version.")

  printf "%s\n" "${txt[@]}"
}

#
# Message to display when bad usage.
#
function badUsage
{
    local message="$1"
    local txt=(
"For an overview of the command, execute:"
"$SCRIPT --help"
    )

    [[ $message ]] && printf "$message\n"

    printf "%s\n" "${txt[@]}"
}

#
# Message to display for version.
#
function version
{
    local txt=(
"$SCRIPT version $VERSION"
    )

    printf "%s\n" "${txt[@]}"
}

function showColors() {
  for X in 1 2 3 4 5 6 7 8 9; do
    for Y in 1 2 3 4 5 6 7 8 9; do
      COLOR_ON="\x1b[""$X$Y""m"
      CODE="\\\x1b["$X$Y"m"
      echo -e -n "$COLOR_ON"$CODE"$COLOR_OFF\t"
    done
    echo
  done
}

#
# Process options
#
while (( $# ))
do
  case "$1" in
    --help | -h)
      usage
      exit 0
    ;;
    --version | -v)
      version
      exit 0
    ;;
    --colors)
      showColors
      exit 0
    ;;
    *)
      if [ -f "$1" ] ; then
        colorize "$1"
        exit 1
      else
        badUsage "Option/command not recognized."
        exit 1
      fi
    ;;
  esac
done

colorize
