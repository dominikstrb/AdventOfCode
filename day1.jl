using DSP

data = parse.(Int, readlines("data/day1.txt"))

# result for part 1
sum(diff(data) .> 0)

# result for part 2
sum(diff(conv(data, [1, 1, 1])[3:end]) .> 0)
