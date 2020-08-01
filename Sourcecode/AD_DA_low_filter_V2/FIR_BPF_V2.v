`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: cHAn
// 
// Create Date: 2020/7/31 14:25:19
// Design Name: 
// Module Name: FIR_BPF
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


module FIR_BPF_V2(
    input clk_100MHz,
    input [7:0]ADC_Data,
    output clk_ADC,
    output ADC_En, 
    output clk_DAC,
    output DAC_Din,
    output DAC_Sync
    
    );
    //clk_module
    wire clk_100MHz_system;
    wire locked;
   
    clk_wiz_0 clk_0(
    .locked(locked), //148.5
    .clk_out1(clk_100MHz_system),//100
    .clk_out2(clk_DAC),//20
    .clk_in1(clk_100MHz)
    );

    //ADC driver_module
    Driver_ADC Driver_ADC0(
    .clk_100MHz(clk_100MHz_system), //System clock              
    .Rst(locked),                        //Reset signal, low reset
    .clk_ADC(clk_ADC),              //ADC clock
    .ADC_En(ADC_En)               //ADC enable signal
    );

   //FIR_module
   wire [20:0]data_out;
   wire filter_out_Enable;
          
   Fir_BPF_100khz Fir_BPF_100khz(
   .data_filter_out(data_out),
   .filter_out_Enable(filter_out_Enable),
   .rst_n(locked),
   .clk(clk_ADC),
   .data_in(ADC_Data)
   );

   //DAC driver_module
   wire [7:0] DAC_In; 
   assign DAC_In=data_out[17:10];
        
   Driver_DAC Driver_DAC0(
   .clk_DAC(clk_DAC),
   .DAC_En(filter_out_Enable),
   .DAC_Data(DAC_In),
   //output
   .DAC_Din(DAC_Din),
   .DAC_Sync(DAC_Sync)
   );          
          
endmodule
