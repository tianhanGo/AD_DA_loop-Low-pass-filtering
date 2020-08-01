`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/10/12 16:18:03
// Design Name: 
// Module Name: Driver_DAC
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


module Driver_DAC(
//    input clk_100MHz,
    input clk_DAC,
    input DAC_En,
//    input [1:0]Wave_Mode,
//    input [8:0]Phase,
    
    input [7:0] DAC_Data,
    output reg DAC_Din,
    output reg DAC_Sync
    );

//    reg [7:0]DAC_Data=0;
//     assign DAC_Data=data;
    //DAC cycle state machine count
    reg [4:0] DAC_Cnt = 5'd0;

    //DAC state machine task execution
    always@(posedge clk_DAC)
        begin
            if(DAC_Cnt == 19)
                DAC_Cnt <= 5'd0;
            else
                DAC_Cnt <= DAC_Cnt + 5'd1;
            case(DAC_Cnt)
                5'd0: DAC_Din <= 1'b0;
                5'd1: DAC_Din <= DAC_Data[7];
                5'd2: DAC_Din <= DAC_Data[6];
                5'd3: DAC_Din <= DAC_Data[5];
                5'd4: DAC_Din <= DAC_Data[4];
                5'd5: DAC_Din <= DAC_Data[3];
                5'd6: DAC_Din <= DAC_Data[2];
                5'd7: DAC_Din <= DAC_Data[1];
                5'd8: DAC_Din <= DAC_Data[0];
                5'd9: DAC_Din <= 1'b0;
                5'd10: DAC_Din <= 1'b0;
                5'd11: DAC_Din <= 1'b0;
                5'd12: DAC_Din <= 1'b0;
                5'd13: DAC_Din <= 1'b0;
                5'd14: DAC_Din <= 1'b0;
                5'd15: DAC_Din <= 1'b0;
                5'd16: begin
                        DAC_Din <= 1'b0;
                        DAC_Sync <= 1'b1;
                       end
                5'd17: DAC_Din <= 1'b0;      
                5'd18: DAC_Din <= 1'b0;    
               
                5'd19: begin 
                        DAC_Din <= 1'b0;
                        DAC_Sync <= 1'b0;
                       end
            endcase    
        end
       
//    //DAC state machine task execution
//    always@(posedge clk_DAC)
//        begin
//            if(DAC_Cnt == 19)
//                DAC_Cnt <= 5'd0;
//            else
//                DAC_Cnt <= DAC_Cnt + 5'd1;
//            case(DAC_Cnt)
//                5'd0: DAC_Din <= 1'b0;
//                5'd1: DAC_Din <= DAC_Data[7];
//                5'd2: DAC_Din <= DAC_Data[6];
//                5'd3: DAC_Din <= DAC_Data[5];
//                5'd4: DAC_Din <= DAC_Data[4];
//                5'd5: DAC_Din <= DAC_Data[3];
//                5'd6: DAC_Din <= DAC_Data[2];
//                5'd7: DAC_Din <= DAC_Data[1];
//                5'd8: DAC_Din <= DAC_Data[0];
//                5'd9: DAC_Din <= 1'b0;
//                5'd10: DAC_Din <= 1'b0;
//                5'd11: DAC_Din <= 1'b0;
//                5'd12: DAC_Din <= 1'b0;
//                5'd13: DAC_Din <= 1'b0;
//                5'd14: DAC_Din <= 1'b0;
//                5'd15: begin
//                        DAC_Din <= 1'b0;
//                        DAC_Sync <= 1'b1;
//                       end
//                5'd16: DAC_Din <= 1'b0;
//                5'd17: DAC_Din <= 1'b0;
//                5'd18: DAC_Din <= 1'b0;       
                       
                       
//                5'd19: begin 
//                        DAC_Din <= 1'b0;
//                        DAC_Sync <= 1'b0;
//                       end
//            endcase    
//        end

endmodule
