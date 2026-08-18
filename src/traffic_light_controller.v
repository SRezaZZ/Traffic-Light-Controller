module traffic_light_controller #(
    parameter CLK_FREQ=1_000_000
)(
    input clock,
    input standby_i,
    output [2:0] L_LIGHT,
    output [2:0] R_LIGHT
);

wire done;
wire [31:0] max_time;

fsm #(.CLK_FREQ(CLK_FREQ)) fsm_inst(
    .clock(clock),
    .standby_i(standby_i),
    .done(done),
    .max_time(max_time),
    .L_LIGHT(L_LIGHT),
    .R_LIGHT(R_LIGHT)
);

timer timer_inst(
    .clock(clock),
    .max_time(max_time),
    .done(done)
);

endmodule