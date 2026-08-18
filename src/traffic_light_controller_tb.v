`timescale 1ns/1ps

module traffic_light_controller_tb;

reg clock, standby_i;
wire [2:0] L_LIGHT, R_LIGHT;

initial begin
    clock=0;
    forever #5 clock=~clock;
end

traffic_light_controller #(.CLK_FREQ(1)) dut(
    .clock(clock),
    .standby_i(standby_i),
    .L_LIGHT(L_LIGHT),
    .R_LIGHT(R_LIGHT)
);

initial begin
    standby_i=1;
    #20 standby_i=0;

    #50;
    #450;
    #50;
    #300;

    #50;
    #450;
    #50;
    #300;

    standby_i=1;
    #20 $finish;
end

endmodule