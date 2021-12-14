lines = readlines("data/day4.txt")

# get the first line (contains draws)
draws = parse.(Int, split(lines[1], ","))

# get all lines containing boards
board_lines =  split.(lines[3:end], " ", keepempty=false)

# create array of boards - this is so ugly
boards = cat([parse.(Int, hcat(board_lines[i:i+4]...)) for i in 1:6:size(board_lines, 1)]..., dims=3)

# function for checking which of the boards are winners
check_winner(m) = any(sum(m, dims=1) .== 5, dims=2) .| any(sum(m, dims=2) .==5, dims=1)

# initialize array for winner checks and stuff
marks = zeros(Int, size(boards))
winner = nothing
winning_draw = nothing
for draw in draws # iterate draws
    marks += boards .== draw # add current draw locations to marks array
    winner = findfirst(check_winner(marks)) # get first winner
    if !isnothing(winner) # is there a winner yet?
        # save final draw and winning index
        winning_draw = draw
        winner = winner[3] # get index
        break
    end
end

final_score(boards, winner, winning_draw) = sum(boards[:,:,winner][marks[:,:,winner] .== 0]) * winning_draw

# result for first task
# sum of all numbers of the winning board, which are not yet marked
# multiplied by the winning draw
final_score(boards, winner, winning_draw)

# second task
marks = zeros(Int, size(boards))
winners = zeros(Int, (1, 1, size(boards, 3)))
winning_draw = nothing
for draw in draws # iterate draws
    marks += boards .== draw # add current draw locations to marks array
    new_winners = check_winner(marks) # get list of winners
    if sum(new_winners) == 100 # have all boards won yet?
        # save final draw and winning index
        winning_draw = draw
        winner = findfirst(BitArray(new_winners - winners)) # get new winner
        winner = winner[3] # get index
        break
    end
    winners = new_winners # udpate winners
end

final_score(boards, winner, winning_draw)
