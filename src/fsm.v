module fsm #(
    parameter CLK_FREQ = 1_000_000
)(
    input clock,
    input standby_i,
    input done,
    output reg [31:0] max_time,
    output reg [2:0] L_LIGHT,
    output reg [2:0] R_LIGHT
);

localparam RED=3'b100, YELLOW=3'b010, GREEN=3'b001;
localparam YY=0, RY=1, GR=2, YR=3, RG=4;
localparam RY_TIME=5*CLK_FREQ, GR_TIME=45*CLK_FREQ;
localparam YR_TIME=5*CLK_FREQ, RG_TIME=30*CLK_FREQ;

reg [2:0] current_state, next_state;
reg [15:0] state_name;

always @(*) begin
    case(current_state)
        YY: next_state = standby_i ? YY : RY;
        RY: next_state = done ? GR : RY;
        GR: next_state = done ? YR : GR;
        YR: next_state = done ? RG : YR;
        RG: next_state = done ? RY : RG;
        default: next_state = YY;
    endcase
end

always @(posedge clock)
    current_state <= standby_i ? YY : next_state;

always @(*) begin
    case(current_state)
        RY: max_time=RY_TIME;
        GR: max_time=GR_TIME;
        YR: max_time=YR_TIME;
        RG: max_time=RG_TIME;
        default: max_time=0;
    endcase
end

always @(*) begin
    L_LIGHT=YELLOW;
    R_LIGHT=YELLOW;

    case(current_state)
        RY: begin L_LIGHT=RED;   R_LIGHT=YELLOW; end
        GR: begin L_LIGHT=GREEN; R_LIGHT=RED;    end
        YR: begin L_LIGHT=YELLOW;R_LIGHT=RED;    end
        RG: begin L_LIGHT=RED;   R_LIGHT=GREEN;  end
    endcase
end

always @(*) begin
    case(current_state)
        YY: state_name="YY";
        RY: state_name="RY";
        GR: state_name="GR";
        YR: state_name="YR";
        RG: state_name="RG";
        default: state_name="??";
    endcase
end

endmodule