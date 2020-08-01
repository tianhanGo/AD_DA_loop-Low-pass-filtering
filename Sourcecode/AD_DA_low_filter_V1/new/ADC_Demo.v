`timescale 1ns / 1ps


//This is an example program for an ADC that displays the waveform read by the ADC pin through the display.
module ADC_Demo(
    input clk_100MHz,
    
    input [7:0]ADC_Data,
    
    output clk_ADC,
    output ADC_En,
    

    output clk_DAC,
    output DAC_Din,
    output DAC_Sync
    
    );
    
    wire clk_100MHz_system;
//    wire clk_system;

  /*===================================================
  分频器
  =====================================================*/  
    clk_wiz_0 clk_10(
    //.clk_out1(clk_system),  //148.5MHZ
    .clk_out2(clk_100MHz_system),//100
    .clk_out3(clk_DAC),    // 20mhz
    .clk_in1(clk_100MHz)
    
 );
    
  /*===============================
  ADC
  =============================*/   
  wire [23:0]data_out;
  wire [7:0] DAC_In;
  assign DAC_In=data_out[17:10];
     
   wire data_out_valid; 
   wire data_out_ready; 
   wire [17:0]Period;
    //ADC Driver
    Driver_ADC Driver_ADC0(
        .clk_100MHz(clk_100MHz_system), //System clock              
//        .clk_system(clk_system),        //Clock reading signal  148.5mhz
        .Rst(1'b1),                        //Reset signal, low reset
        .ADC_Data(DAC_In),            //ADC sampling data

// output
        .clk_ADC(clk_ADC),              //ADC clock
        .ADC_En(ADC_En),                //ADC enable signal
        .Period(Period)
        );
 
 ila_0 ila0 (
	.clk(clk_100MHz_system), // input wire clk


	.probe0(Period) // input wire [17:0] probe0
);
 
        
  /*===============================
  滤波器
  =============================*/   


    fir_compiler_0 fir_compiler_0 (
  .aclk(clk_ADC),                              // input wire aclk
  .s_axis_data_tvalid(1'b1),  // input wire s_axis_data_tvalid
  .s_axis_data_tready(data_out_ready),  // output wire s_axis_data_tready
  .s_axis_data_tdata(ADC_Data),    // input wire [7 : 0] s_axis_data_tdata
  .m_axis_data_tvalid(data_out_valid),  // output wire m_axis_data_tvalid
  .m_axis_data_tdata(data_out)    // output wire [23 : 0] m_axis_data_tdata
);

   //DAC driver instantiation
   Driver_DAC Driver_DAC0(
//        .clk_100MHz(clk_100MHz_system),
        .clk_DAC(clk_DAC), //20mhz
        .DAC_En(data_out_valid),
//        .Wave_Mode(2'b11),
//        .Phase(180),
        .DAC_Data(DAC_In), //送入数据

         //   output 
        .DAC_Din(DAC_Din),
        .DAC_Sync(DAC_Sync)
   );          
        
        
endmodule
