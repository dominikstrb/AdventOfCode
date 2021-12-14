using Statistics

data = parse.(Int64, hcat(split.(readlines("data/day3.txt"), "")...))'

compute_most_common(d) = Int.(round.(mean(d, dims=1), RoundNearestTiesAway))[1,:] # round ties up
compute_least_common(d) = Int.(round.(1 .- mean(d, dims=1)))[1,:]
# part 1
most_common = compute_most_common(data)
least_common = compute_least_common(data)

Int.(round.(mean(data, dims=1)))[1,:]

bin_array_to_int(arr) = parse(Int, string(string.(arr)...); base=2)

gamma_rate = bin_array_to_int(most_common)
epsilon_rate = bin_array_to_int(least_common)

gamma_rate * epsilon_rate

# part 2
oxygen = copy(data)
most_common = compute_most_common(oxygen)
i = 1
while size(oxygen, 1) > 1
    oxygen = oxygen[oxygen[:,i] .== most_common[i],:]
    most_common = compute_most_common(oxygen)
    i += 1
end


c02 = copy(data)
least_common = compute_least_common(c02)
i = 1
while size(c02, 1) > 1
    c02 = c02[c02[:,i] .== least_common[i],:]
    least_common = compute_least_common(c02)
    i += 1
end

bin_array_to_int(c02[1,:]) * bin_array_to_int(oxygen[1,:])
