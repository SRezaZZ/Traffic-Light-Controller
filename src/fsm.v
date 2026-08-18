module fsm (
    input clock,
    input standby_i,
    input done
);

localparam YY = 3'b000;
localparam RY = 3'b001;
localparam GR = 3'b010;
localparam YR = 3'b011;
localparam RG = 3'b100;

reg [2:0] current_state;
reg [2:0] next_state;


// Next State Logic
always @(*) begin
    next_state = current_state;

    case (current_state)

        YY: begin
            if (!standby_i)
                next_state = RY;
        end

        RY: begin
            if (done)
                next_state = GR;
        end

        GR: begin
            if (done)
                next_state = YR;
        end

        YR: begin
            if (done)
                next_state = RG;
        end

        RG: begin
            if (done)
                next_state = RY;
        end

        default: begin
            next_state = YY;
        end

    endcase
end


// State Register
always @(posedge clock) begin
    if (standby_i)
        current_state <= YY;
    else
        current_state <= next_state;
end

endmodule