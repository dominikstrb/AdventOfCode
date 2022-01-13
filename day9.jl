using Images, ImageSegmentation

x = parse.(Int, hcat(split.(readlines("data/day9.txt"), "")...))

# part 1
idx = findlocalminima(x, window=(3,3))
sum(x[idx] .+ 1)

# part 2
x[x .== 9] .= 0
label_components(x)

minima = zeros(Int, size(x))
minima[idx] .= 1

d = distance_transform(feature_transform(Gray.(x / 255) .< (9 / 255)))

markers = label_components(d.==0)
res = watershed(d, markers, mask=x .!= 9)

using DataStructures

counts = counter(markers)
sort(collect(counts), by=x->x[2])

labels_map(res)

counts = segment_pixel_count(res)

sort(collect(counted), by=x->x[2])