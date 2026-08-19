module fsm #(
    parameter CLK_FREQ = 1_000_000
)(
    input clock,
    input reset_i,
    input standby_i,
    input done,
    output reg [31:0] max_time,
    output reg [2:0] L_LIGHT,
    output reg [2:0] R_LIGHT
);

localparam RED    = 3'b100;
localparam YELLOW = 3'b010;
localparam GREEN  = 3'b001;

localparam YY = 3'd0;
localparam RY = 3'd1;
localparam GR = 3'd2;
localparam YR = 3'd3;
localparam RG = 3'd4;

localparam RY_TIME = 5  * CLK_FREQ;
localparam GR_TIME = 45 * CLK_FREQ;
localparam YR_TIME = 5  * CLK_FREQ;
localparam RG_TIME = 30 * CLK_FREQ;

reg [2:0] current_state;
reg [2:0] next_state;

always @(*) begin
    case (current_state)
        YY: next_state = standby_i ? YY : RY;
        RY: next_state = done ? GR : RY;
        GR: next_state = done ? YR : GR;
        YR: next_state = done ? RG : YR;
        RG: next_state = done ? RY : RG;
        default: next_state = YY;
    endcase
end

always @(posedge clock) begin
    if (reset_i)
        current_state <= YY;
    else
        current_state <= next_state;
end

always @(*) begin
    case (current_state)
        RY:     max_time = RY_TIME;
        GR:     max_time = GR_TIME;
        YR:     max_time = YR_TIME;
        RG:     max_time = RG_TIME;
        default: max_time = 0;
    endcase
end

always @(*) begin
    L_LIGHT = YELLOW;
    R_LIGHT = YELLOW;

    case (current_state)
        RY: begin
            L_LIGHT = RED;
            R_LIGHT = YELLOW;
        end

        GR: begin
            L_LIGHT = GREEN;
            R_LIGHT = RED;
        end

        YR: begin
            L_LIGHT = YELLOW;
            R_LIGHT = RED;
        end

        RG: begin
            L_LIGHT = RED;
            R_LIGHT = GREEN;
        end
    endcase
end

endmodule