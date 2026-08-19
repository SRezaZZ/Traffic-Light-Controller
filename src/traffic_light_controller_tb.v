`timescale 1ns/1ps

module traffic_light_controller_tb;

reg clock;
reg reset_i;
reg standby_i;

wire [2:0] L_LIGHT;
wire [2:0] R_LIGHT;

localparam RED    = 3'b100;
localparam YELLOW = 3'b010;
localparam GREEN  = 3'b001;

initial begin
    clock = 0;
    forever #5 clock = ~clock;
end

traffic_light_controller #(.CLK_FREQ(1)) dut (
    .clock(clock),
    .reset_i(reset_i),
    .standby_i(standby_i),
    .L_LIGHT(L_LIGHT),
    .R_LIGHT(R_LIGHT)
);

task check_lights;
    input [2:0] expected_l;
    input [2:0] expected_r;

    begin
        if (L_LIGHT !== expected_l || R_LIGHT !== expected_r) begin
            $display("FAIL: L=%b R=%b | Expected L=%b R=%b",
                     L_LIGHT, R_LIGHT, expected_l, expected_r);
        end
        else begin
            $display("PASS: L=%b R=%b",
                     L_LIGHT, R_LIGHT);
        end
    end
endtask

initial begin
    reset_i = 1;
    standby_i = 1;

    #20;
    check_lights(YELLOW, YELLOW);

    reset_i = 0;
    standby_i = 0;

    #50;
    check_lights(RED, YELLOW);

    #450;
    check_lights(GREEN, RED);

    #50;
    check_lights(YELLOW, RED);

    #300;
    check_lights(RED, GREEN);

    #50;
    check_lights(RED, YELLOW);

    #450;
    check_lights(GREEN, RED);

    #50;
    check_lights(YELLOW, RED);

    #300;
    check_lights(RED, GREEN);

    standby_i = 1;

    #20;
    check_lights(YELLOW, YELLOW);

    $display("TESTBENCH FINISHED");
    $finish;
end

endmodule