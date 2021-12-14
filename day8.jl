using Combinatorics

function parse_line(line)
    input, output = split.(split(line, " | "), " ")
    return input, output
end

data = parse_line.(readlines("data/day8.txt"))

# part 1
is_unique_number(digit) =  length(digit) in [2, 3, 4, 7]

sum(sum([is_unique_number.(line[2]) for line in data]))

# part 2
segments_to_numbers = Dict(
    "abcefg" => "0",
    "cf" => "1",
    "acdeg" => "2",
    "acdfg" => "3",
    "bcdf" => "4",
    "abdfg" => "5",
    "abdefg" => "6",
    "acf" => "7",
    "abcdefg" => "8",
    "abcdfg" => "9"
)

# check if the current digit exists
is_correct_digit(digit, wiring) = join(sort([wiring[char] for char in digit])) in keys(segments_to_numbers)

# check if all digits in the input line are digits under the current wiring
check_wiring(wiring, input_line) = all(is_correct_digit.(input_line, (wiring,)))

# make a wiring from a permutation of a:g and a:g
create_wiring(perm) = Dict(elem => p for (elem, p) in zip(perm, 'a':'g'))

# create all possible wirings
possible_wirings = create_wiring.(permutations('a':'g'))

# check which of all possible wirings is correct for one line of the input
find_correct_wiring(input_line) = possible_wirings[findfirst(check_wiring.(possible_wirings, (input_line,)))]

# get the number of the output line under the current wiring
get_number(wiring, digit) = segments_to_numbers[join(sort([wiring[char] for char in digit]))]

function decode(line)
    input_line, output_line = line

    # get correct wiring from input
    wiring = find_correct_wiring(input_line)

    # get all four numbers from output
    numbers = get_number.((wiring,), output_line)

    # concatenate and turn into integer
    return parse(Int, join(numbers))
end

# sum up all decoded outputs
sum(decode.(data))
    

