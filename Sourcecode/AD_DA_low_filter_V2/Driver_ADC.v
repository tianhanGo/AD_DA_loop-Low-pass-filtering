`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/18 13:37:41
// Design Name: 
// Module Name: Driver_ADC
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Driver_ADC(
    input clk_100MHz,       //Clock
    input Rst,              //Reset signal, low reset
    output clk_ADC,         //ADC clock
    output ADC_En         //ADC enable signal
    );
    reg[15:0]Addr_Read_Real=0;
    assign ADC_En=~Rst; //low_enable
    Clk_Division Clk_Division_ADC(
    .rst_n(Rst),
    .clk_100MHz(clk_100MHz),  
    .clk_mode(31'd100),           
    .clk_out(clk_ADC)        
    );
endmodule
