`timescale 1ns / 1ps

module Driver_ADC(
    input clk_100MHz,       //Clock

    input Rst,              //Reset signal, low reset
    input[7:0]ADC_Data,     //ADC sampling data

    
    output[17:0]Period,     //frequency
    output clk_ADC,         //ADC clock
    output ADC_En          //ADC enable signal

    );

    assign ADC_En=~Rst;  //Rst=1,en=0; ad采集一直有效
    //Frequency division produces ADC clock
    Clk_Division Clk_Division_ADC(
              .clk_100MHz(clk_100MHz),  // input wire clk_100MHz
              .clk_mode(31'd100),             // input wire [30 : 0] clk_mode
              .clk_out(clk_ADC)        // output wire clk_out
            );

    //Frequency calculation
    Freq_Cal Freq_Cal0(
        .clk_100MHz(clk_100MHz),
        .Rst(Rst),
        .ADC_Data(ADC_Data),
        .F_Gate(123),
        .Period(Period)
   );

endmodule
