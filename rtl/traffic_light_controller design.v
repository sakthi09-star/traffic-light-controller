module traffic_light_controller(
    input clk,
    input reset,

    output reg NS_R, NS_Y, NS_G,
    output reg EW_R, EW_Y, EW_G
);

    // ----------------------------
    // State encoding
    // ----------------------------
    reg [1:0] state, next_state;

    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

    // ----------------------------
    // Counter
    // ----------------------------
    reg [3:0] counter;

    parameter GREEN_TIME  = 4'd10;
    parameter YELLOW_TIME = 4'd3;

    // ----------------------------
    // Next output signals (combinational)
    // ----------------------------
    reg NS_R_n, NS_Y_n, NS_G_n;
    reg EW_R_n, EW_Y_n, EW_G_n;

    // =========================================================
    // 1. STATE REGISTER + COUNTER (SYNCHRONOUS)
    // =========================================================
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
            counter <= 0;
        end else begin
            state <= next_state;

            if (state == next_state)
                counter <= counter + 1;
            else
                counter <= 0;
        end
    end

    // =========================================================
    // 2. NEXT STATE LOGIC (COMBINATIONAL)
    // =========================================================
    always @(*) begin
        case (state)

            S0: next_state = (counter >= GREEN_TIME)  ? S1 : S0;
            S1: next_state = (counter >= YELLOW_TIME) ? S2 : S1;
            S2: next_state = (counter >= GREEN_TIME)  ? S3 : S2;
            S3: next_state = (counter >= YELLOW_TIME) ? S0 : S3;

            default: next_state = S0;

        endcase
    end

    // =========================================================
    // 3. NEXT OUTPUT LOGIC (COMBINATIONAL)
    // =========================================================
    always @(*) begin

        // default OFF
        NS_R_n = 0; NS_Y_n = 0; NS_G_n = 0;
        EW_R_n = 0; EW_Y_n = 0; EW_G_n = 0;

        case (state)

            S0: begin
                NS_G_n = 1;
                EW_R_n = 1;
            end

            S1: begin
                NS_Y_n = 1;
                EW_R_n = 1;
            end

            S2: begin
                NS_R_n = 1;
                EW_G_n = 1;
            end

            S3: begin
                NS_R_n = 1;
                EW_Y_n = 1;
            end

        endcase
    end

    // =========================================================
    // 4. OUTPUT REGISTERS (SYNCHRONOUS - FPGA STYLE)
    // =========================================================
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            NS_R <= 0; NS_Y <= 0; NS_G <= 0;
            EW_R <= 0; EW_Y <= 0; EW_G <= 0;
        end else begin
            NS_R <= NS_R_n;
            NS_Y <= NS_Y_n;
            NS_G <= NS_G_n;

            EW_R <= EW_R_n;
            EW_Y <= EW_Y_n;
            EW_G <= EW_G_n;
        end
    end

endmodule
