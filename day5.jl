lines = [split.(v, ",") for v in split.(readlines("data/day5.txt"), " -> ")]

data = cat([hcat(line...) for line in lines]..., dims=3)
data = permutedims(data, (3, 1, 2))
data = parse.(Int, data) .+ 1


x_max = maximum(data[:,1,:])
y_max = maximum(data[:,2,:])


# part 1
horizontal = data[:,1,1] .- data[:,1,2] .== 0
vertical = data[:,2,1] .- data[:,2,2] .== 0

hv_data = data[horizontal .| vertical,:,:]

arr = zeros(Int, x_max, y_max)
for i in 1:size(hv_data,1)
    line = hv_data[i,:,:]
    x1 = minimum(line[1,:])
    x2 = maximum(line[1,:])
    y1 = minimum(line[2,:])
    y2 = maximum(line[2,:])

    arr[x1:x2, y1:y2] .+= 1
end

# solution part 1
sum(arr .>= 2)

# part 2
arr = zeros(Int, x_max, y_max)
for i in 1:size(data,1)
    line = data[i,:,:]

    

    # solution from part 1
    if horizontal[i] | vertical[i]
        # get start and end point 
        # (for horizontal and vertical lines one of the dimensions stays the same)
        x1 = minimum(line[1,:])
        x2 = maximum(line[1,:])
        y1 = minimum(line[2,:])
        y2 = maximum(line[2,:])

        # we can simply take a slice of the array and add 1
        arr[x1:x2, y1:y2] .+= 1
    # diagonal lines
    else 
        # get start and end point
        start_pt = line[:,1]
        end_pt = line[:,2]

        # get length and direction of line
        vec = end_pt - start_pt
        length = abs(vec[1])
        direction = sign.(vec)
        
        # for each element go along the diagonal line and add 1
        for i in 0:length
            arr[start_pt[1] + direction[1] * i, start_pt[2] + direction[2] * i] += 1
        end
    end
    
end

sum(arr .>= 2)
