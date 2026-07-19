
`timescale 1ns / 1ps



module apb_master (

    // Global signals

    input wire pclk, presetn,

    

    // User interface

    input wire start_write, start_read,

    input wire [31:0] addr_in, data_in,

    output reg master_busy,

    

    // APB Bridge Interface

    output reg [31:0] paddr,

    output reg pwrite,

    output reg penable, psel,

    output reg [31:0] pwdata,

    input wire [31:0] prdata,

    input wire pready, pslverr

);



    // FSM States Parameters

    parameter IDLE   = 2'b00;

    parameter SETUP  = 2'b01;

    parameter ACCESS = 2'b10;



    reg [1:0] current_state, next_state;



    // Sequential State Register

    always @(posedge pclk or negedge presetn) begin

        if (!presetn) begin

            current_state <= IDLE;

        end else begin

            current_state <= next_state;

        end

    end



    // Combinational Next State Logic

    always @(*) begin

        case (current_state)

            IDLE: begin

                if (start_write || start_read)

                    next_state = SETUP;

                else

                    next_state = IDLE;

            end

            SETUP: begin

                next_state = ACCESS;

            end

            ACCESS: begin

                if (pready) begin

                    if (start_write || start_read)

                        next_state = SETUP;

                    else

                        next_state = IDLE;

                end else begin

                    next_state = ACCESS;

                end

            end

            default: next_state = IDLE;

        endcase

    end



    // Sequential Output Logic

    always @(posedge pclk or negedge presetn) begin

        if (!presetn) begin

            paddr       <= 32'h0;

            pwrite      <= 1'b0;

            psel        <= 1'b0;

            penable     <= 1'b0;

            pwdata      <= 32'h0;

            master_busy <= 1'b0;

        end else begin

            case (current_state)

                IDLE: begin

                    penable     <= 1'b0;

                    psel        <= 1'b0;

                    master_busy <= 1'b0;

                end

                SETUP: begin

                    master_busy <= 1'b1;

                    paddr       <= addr_in;

                    psel        <= 1'b1;

                    penable     <= 1'b0;

                    if (start_write) begin

                        pwrite <= 1'b1;

                        pwdata <= data_in;

                    end else if (start_read) begin

                        pwrite <= 1'b0;

                    end

                end

                ACCESS: begin

                    penable <= 1'b1;

                end

            endcase

        end

    end



endmodule

