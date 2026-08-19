module timer (
    input clock,
    input reset_i,
    input [31:0] max_time,
    output reg done
);

reg [31:0] counter;

always @(posedge clock) begin
    if (reset_i) begin
        counter <= 0;
        done <= 0;
    end
    else if (max_time == 0) begin
        counter <= 0;
        done <= 0;
    end
    else if (counter >= max_time - 1) begin
        counter <= 0;
        done <= 1;
    end
    else begin
        counter <= counter + 1;
        done <= 0;
    end
end

endmodule