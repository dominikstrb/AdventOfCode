using DataFrames

# read data and create data frame
data = [split(ln, " ") for ln in readlines("data/day2.txt")]
df = DataFrame(direction=[a[1] for a in data], amount=[parse(Int64, a[2]) for a in data])

# pivot data frame
df.id = 1:size(df, 1)
udf = unstack(df, :id, :direction, :amount)
udf = coalesce.(udf, 0) # replace other values by zero

# compute horizontal and depth position
udf.horizontal = cumsum(udf.forward)
udf.depth = cumsum(udf.down) - cumsum(udf.up)

# result for first part
udf.depth .* udf.horizontal

# compute aim
udf.aim = cumsum(udf.down) - cumsum(udf.up)
udf.horizontal = cumsum(udf.forward)
udf.depth = cumsum(udf.aim .* udf.forward)

# result for second part
udf.depth .* udf.horizontal
