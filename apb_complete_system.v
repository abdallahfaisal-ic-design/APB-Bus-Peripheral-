
`timescale 1ns / 1ps



module apb_complete_system (

    input wire pclk, presetn,

    input wire start_write, start_read,

    input wire [31:0] addr_in, data_in,

    output wire master_busy,

    output wire [31:0] bus_prdata

);



    //(Interconnect Wires)

    wire [31:0] bus_paddr;

    wire bus_pwrite;

    wire bus_penable;

    wire bus_psel_master;

    wire [31:0] bus_pwdata;

    

    //  Slaves (Decoder Selects)

    wire psel_slave0;

    wire psel_slave1;

    

 

    wire [31:0] prdata_s0, prdata_s1;

    wire pready_s0, pready_s1;

    wire pslverr_s0, pslverr_s1;

    

    wire bus_pready;

    wire bus_pslverr;



    
    apb_master u_apb_master (

        .pclk(pclk), .presetn(presetn),

        .start_write(start_write), .start_read(start_read),

        .addr_in(addr_in), .data_in(data_in), .master_busy(master_busy),

        .paddr(bus_paddr), .pwrite(bus_pwrite), .penable(bus_penable),

        .psel(bus_psel_master), .pwdata(bus_pwdata),

        .prdata(bus_prdata), .pready(bus_pready), .pslverr(bus_pslverr)

    );



   

    apb_decoder u_apb_decoder (

        .paddr(bus_paddr),

        .psel_master(bus_psel_master),

        .psel_slave0(psel_slave0),

        .psel_slave1(psel_slave1)

    );




    apb_slave u_apb_slave1 (

        .pclk(pclk), .presetn(presetn),

        .paddr(bus_paddr),

        .psel(psel_slave0), .penable(bus_penable), .pwrite(bus_pwrite),

        .pwdata(bus_pwdata), .prdata(prdata_s0),

        .pready(pready_s0), .pslverr(pslverr_s0)

    );



    
    apb_slave u_apb_slave2 (

        .pclk(pclk), .presetn(presetn),

        .paddr(bus_paddr),

        .psel(psel_slave1), .penable(bus_penable), .pwrite(bus_pwrite),

        .pwdata(bus_pwdata), .prdata(prdata_s1),

        .pready(pready_s1), .pslverr(pslverr_s1)

    );



   

    assign bus_prdata  = (psel_slave0) ? prdata_s0  : (psel_slave1) ? prdata_s1  : 32'h0;

    assign bus_pready  = (psel_slave0) ? pready_s0  : (psel_slave1) ? pready_s1  : 1'b1;

    assign bus_pslverr = (psel_slave0) ? pslverr_s0 : (psel_slave1) ? pslverr_s1 : 1'b0;



endmodule

