
`timescale 1ns / 1ps



module apb_slave (

    input wire pclk, presetn,

    input wire [31:0] paddr,

    input wire psel, penable, pwrite,

    input wire [31:0] pwdata,

    output reg [31:0] prdata,

    output reg pready, pslverr

);



    // Internal Registers 

    reg [31:0] reg0, reg1, reg2, reg3;



    // Write Logic (Sequential)

    always @(posedge pclk or negedge presetn) begin

        if (!presetn) begin

            reg0    <= 32'h0;

            reg1    <= 32'h0;

            reg2    <= 32'h0;

            reg3    <= 32'h0;

            pready  <= 1'b1;

            pslverr <= 1'b0;

        end else begin

            if (psel && penable && pwrite) begin

                case (paddr[3:2])

                    2'b00: reg0 <= pwdata;

                    2'b01: reg1 <= pwdata;

                    2'b10: reg2 <= pwdata;

                    2'b11: reg3 <= pwdata;

                endcase

            end

        end

    end



    // Read Logic (Combinational)

    always @(*) begin

        if (psel && !pwrite) begin

            case (paddr[3:2])

                2'b00: prdata = reg0;

                2'b01: prdata = reg1;

                2'b10: prdata = reg2;

                2'b11: prdata = reg3;

                default: prdata = 32'h0;

            endcase

        end else begin

            prdata = 32'h0;

        end

    end



endmodule

