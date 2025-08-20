#!/bin/bash

# Stress testing script for competitive programming
# Usage: ./stress.sh [number_of_tests] [compile_flag]
# Default: 100 tests with compilation enabled

# Define ANSI color codes
GREEN='\033[38;2;0;230;0m'
RED='\033[38;2;255;0;0m'
MAGENTA='\033[38;2;190;0;240m'
YELLOW='\033[38;2;210;240;0m'
BLUE='\033[38;2;0;10;250m'
CYAN='\033[38;2;0;160;160m'
BOLD='\033[1m'
UNDERLINE='\033[4m'
RESET='\033[0m'

# Color printing functions
echo_green() {
    echo -e "${GREEN}$*${RESET}"
}

echo_bold_deep_green() {
    echo -e "${GREEN}${BOLD}$*${RESET}"
}

echo_red() {
    echo -e "${RED}$*${RESET}"
}

echo_magenta() {
    echo -e "${MAGENTA}$*${RESET}"
}

echo_bold_underline_deep_magenta() {
    echo -e "${MAGENTA}${BOLD}${UNDERLINE}$*${RESET}"
}

echo_yellow() {
    echo -e "${YELLOW}$*${RESET}"
}

echo_blue() {
    echo -e "${BLUE}$*${RESET}"
}

echo_cyan() {
    echo -e "${CYAN}$*${RESET}"
}

echo_bold_underline_cyan() {
    echo -e "${CYAN}${BOLD}${UNDERLINE}$*${RESET}"
}

echo_red_from_file() {
    while IFS= read -r line; do
        echo -e "${RED}${line}${RESET}"
    done < "$1"
}

echo_magenta_from_file() {
    while IFS= read -r line; do
        echo -e "${MAGENTA}${line}${RESET}"
    done < "$1"
}

# Set default values
num_loop=${1:-100}
do_comp=${2:-1}

# Compilation phase
if [ "$do_comp" -eq 1 ]; then
    echo_yellow "Compiling solution, gen, brute..."
    g++ -std=c++17 gen.cpp -o gen
    g++ -std=c++17 solution.cpp -o solution
    g++ -std=c++17 brute.cpp -o brute
    echo_yellow "Compilation completed!"
    echo
fi

diff_found=""

# Main testing loop
for ((x=1; x<=num_loop; x++)); do
    echo_bold_deep_green "[ TestCase $x: passed! ]"
    
    # Generate input
    ./gen > input.in
    
    # Run solution and brute force
    ./solution < input.in > output.out 2>/dev/null
    ./brute < input.in > output2.out 2>/dev/null
    
    # Compare outputs
    if ! diff -q output.out output2.out > /dev/null 2>&1; then
        diff_found="y"
        break
    fi
done

# Results display
if [ -n "$diff_found" ]; then
    echo
    echo_red "[   Wrong answer:(   ]"
    echo
    echo_bold_underline_cyan "Input:"
    echo
    echo_magenta_from_file "input.in"
    echo
    
    echo_bold_underline_cyan "Your output:"
    echo
    echo_magenta_from_file "output.out"
    echo
    
    echo_bold_underline_cyan "Expected output:"
    echo
    echo_magenta_from_file "output2.out"
    echo
else
    echo
    echo_bold_deep_green "All testcases passed :D"
fi

# Cleanup
rm -f input.in output.out output2.out gen solution brute

exit 0
