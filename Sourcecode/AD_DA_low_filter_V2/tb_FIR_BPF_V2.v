
module tb_FIR_BPF_V2(

    );
    reg clk_100MHz;
    reg [7:0]ADC_Data;
    wire clk_ADC;
    wire ADC_En;    
    wire clk_DAC;
    wire DAC_Din;
    wire DAC_Sync; 

    FIR_BPF_V2 FIR_BPF_V2(
    .clk_100MHz(clk_100MHz),
    .ADC_Data(ADC_Data),    
    .clk_ADC(clk_ADC),
    .ADC_En(ADC_En),    
    .clk_DAC(clk_DAC),
    .DAC_Din(DAC_Din),
    .DAC_Sync(DAC_Sync)        
    );
    
    reg[12:0] n=0;
    reg[7:0] n_500k=0;;
    reg[7:0] memory[0:4095]; 
    always #10 clk_100MHz=~clk_100MHz;
      initial 
      begin
       clk_100MHz=0;
       ADC_Data<=0;
       $readmemh("D:/xilinx/Vivado_Project/2020_SummerCamp/Final_test/mix2_mem.txt",memory); //读取file1.txt中的数字到memory
    //    for(n=0;n<=4095;n=n+1) //把八个存储单元的数字都读取出来，若存的数不到八个单元输出x态，程序结果中会看到
    //      $display("%b",memory);        
      end
 
//  always @(posedge clk_100MHz)
//   begin
//     if(ADC_En)
//       ADC_Data<= 0;    
//     else 
//       begin
//        if(n_500k==99)
//         begin
//           n_500k<=0;
//           if(n==4095)
//             n<=0;
//            else 
//             n<=n+1'd1;     
//         end
//        else
//           n_500k<=n_500k+1'd1;
//         ADC_Data<= memory[n]; 
//       end 
//   end
 
 always @(posedge clk_ADC)
  begin
    if(ADC_En)
      ADC_Data<= 0;    
    else 
      begin
        if(n==4095)
         n<=0;
        else 
         n<=n+1'd1;     
        ADC_Data<= memory[n]; 
      end 
  end
endmodule