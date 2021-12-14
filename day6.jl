function read_data()
    return parse.(Int, split(readlines("data/day6.txt")[1], ","))
end

school = read_data()

# part 1
function simulate_fish(fish)
    if fish == 0
        return 6, 8
    else
        return fish -1
    end
end

function simulate_school(school)
    vcat([vcat(simulate_fish(fish)...) for fish in school]...)
end

for i in 1:80
    school = simulate_school(school)
end

# part 2
school = read_data()
data = [sum(school .== i) for i in 0:8]

for day in 1:256
    data = circshift(data, -1)
    data[7] += data[9]
end

sum(data)