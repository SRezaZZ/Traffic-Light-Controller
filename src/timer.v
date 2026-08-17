module timer (
    input clock,
    input standby_i,
    input [25:0] max_time,
    output reg done
);

reg [25:0] counter = 0;

always @(posedge clock) begin
    if (standby_i) begin
        counter <= 0;
        done <= 0;
    end
    else if (counter == max_time - 1) begin
        counter <= 0;
        done <= 1;
    end
    else begin
        counter <= counter + 1;
        done <= 0;
    end
end

endmodule