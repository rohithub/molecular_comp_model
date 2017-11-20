function time_seconds = current_time
    curr_time = clock;
    time_seconds = curr_time(5)*60 + curr_time(6);
end