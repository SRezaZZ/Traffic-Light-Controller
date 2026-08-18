module fsm_tb;

reg clock;
reg standby_i;
reg done;

fsm uut (
    .clock(clock),
    .standby_i(standby_i),
    .done(done)
);


// Clock Generator
initial begin
    clock = 0;
    forever #5 clock = ~clock;
end


// Test Stimulus
initial begin
    standby_i = 1;
    done = 0;

    // Standby: YY
    #20;
    standby_i = 0;

    // RY -> GR
    #10;
    done = 1;
    #10;
    done = 0;

    // GR -> YR
    #10;
    done = 1;
    #10;
    done = 0;

    // YR -> RG
    #10;
    done = 1;
    #10;
    done = 0;

    // RG -> RY
    #10;
    done = 1;
    #10;
    done = 0;

    #20;
    $finish;
end

endmodule