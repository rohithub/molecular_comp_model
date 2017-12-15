function time_seconds = current_time
    %Simulates the B and R clock jumps
    curr_time = clock;
    time_seconds = curr_time(5)*60 + curr_time(6);
end