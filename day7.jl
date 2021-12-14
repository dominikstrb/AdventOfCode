using Statistics

crab_pos = parse.(Int, split(readline("data/day7.txt"), ","))

# part 1
sum(abs.(crab_pos .- median(crab_pos)))

# part 2
cost(diff) = sum(1:diff)

res = sum(cost.(abs.(crab_pos .- Int(floor(mean(crab_pos))))))