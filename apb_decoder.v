
`timescale 1ns / 1ps



module apb_decoder (

    input wire [31:0] paddr,

    input wire psel_master,

    output reg psel_slave0,

    output reg psel_slave1

);



    always @(*) begin

        psel_slave0 = 1'b0;

        psel_slave1 = 1'b0;

        

        if (psel_master) begin

       

            if (paddr[31:16] == 16'h0000) begin

                psel_slave0 = 1'b1;

            end else if (paddr[31:16] == 16'h0001) begin

                psel_slave1 = 1'b1;

            end

        end

    end



endmodule

