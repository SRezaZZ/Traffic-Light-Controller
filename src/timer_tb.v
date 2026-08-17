module timer_tb;

reg clock;
reg standby_i;
reg [25:0] max_time;
wire done;

timer uut (
    .clock(clock),
    .standby_i(standby_i),
    .max_time(max_time),
    .done(done)
);

initial begin
    clock = 0;
    standby_i = 1;
    max_time = 5;

    #20;
    standby_i = 0;

    #100;
    $finish;
end

always #5 clock = ~clock;

endmodule