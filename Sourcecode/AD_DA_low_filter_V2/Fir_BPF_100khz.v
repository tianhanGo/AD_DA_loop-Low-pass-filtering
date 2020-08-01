module Fir_BPF_100khz(
    input clk,
    input rst_n,
    input [7:0]data_in,
    output reg filter_out_Enable,
    output reg [20:0]data_filter_out
 );

 parameter coff_0=8'hf3;
 parameter coff_1=8'hf7;
 parameter coff_2=8'hf8;
 parameter coff_3=8'hfc;
 parameter coff_4=8'h06;
 parameter coff_5=8'h14;
 parameter coff_6=8'h27;
 parameter coff_7=8'h3c;
 parameter coff_8=8'h53;
 parameter coff_9=8'h67;
 parameter coff_10=8'h76;
 parameter coff_11=8'h7e;
 
 //buffer_module
 reg [7:0] data_buffer [0:23];
 reg [4:0] i1=0;
 reg [4:0] j=0;
 reg [4:0] i=0;
 reg buffer_enable=0;
 always@(posedge clk or negedge rst_n)
  begin
      if(!rst_n)
        begin
             data_buffer[0]<=0; data_buffer[1]<=0; data_buffer[2]<=0; data_buffer[3]<=0; data_buffer[4]<=0; data_buffer[5]<=0;
             data_buffer[6]<=0; data_buffer[7]<=0; data_buffer[8]<=0; data_buffer[9]<=0; data_buffer[10]<=0;data_buffer[11]<=0;
             data_buffer[12]<=0;data_buffer[13]<=0;data_buffer[14]<=0;data_buffer[15]<=0;data_buffer[16]<=0;data_buffer[17]<=0;
             data_buffer[18]<=0;data_buffer[19]<=0;data_buffer[20]<=0;data_buffer[21]<=0;data_buffer[22]<=0;data_buffer[23]<=0;
             i<=0;
             buffer_enable<=1'd0;
        end
      else 
        begin
            if(i==5'd24)
              buffer_enable<=1'd1;
            else 
             begin
                i <=i+1'd1 ;
                buffer_enable<=1'd0;
             end
            
            for (j=0;j<=22;j=j+1)
             data_buffer[j+1]<=data_buffer[j];
             data_buffer[0]<=data_in;
        end
  end

 //addr_accumulate_module
 reg  [8:0] Add_Reg[0:11];
 always @(posedge clk or negedge buffer_enable)
	   if (!buffer_enable)
		begin 
			for (i1=0; i1<=11; i1=i1+1)
				Add_Reg[i1]=9'd0;
		end
	   else
		begin
			for (i1=0; i1<=11; i1=i1+1)   
			   //Add_Reg[i1]={data_buffer[i1][7],data_buffer[i1]}+{data_buffer[23-i1][7],data_buffer[23-i1]}; //sign
               Add_Reg[i1]={1'd0,data_buffer[i1]}+{1'd0,data_buffer[23-i1]};  //unsign
		end

 //multiple_module
 wire  [16:0] Mul_Out[0:11];   

 mult_gen_0	mult_gen_0 (
 	.CLK (clk),
 	.A (coff_0),
 	.B (Add_Reg[0]),
 	.P (Mul_Out[0]));			
 mult_gen_0	mult_gen_1 (
 	.CLK (clk),
 	.A (coff_1),
 	.B (Add_Reg[1]),
 	.P (Mul_Out[1]));		
 mult_gen_0	mult_gen_2 (
 	.CLK (clk),
 	.A (coff_2),
 	.B (Add_Reg[2]),
 	.P (Mul_Out[2]));		
 mult_gen_0	mult_gen_3 (
 	.CLK (clk),
 	.A (coff_3),
 	.B (Add_Reg[3]),
 	.P (Mul_Out[3]));		
 mult_gen_0	mult_gen_4 (
 	.CLK (clk),
 	.A (coff_4),
 	.B (Add_Reg[4]),
 	.P (Mul_Out[4]));		
 mult_gen_0	mult_gen_5 (
 	.CLK (clk),
 	.A (coff_5),
 	.B (Add_Reg[5]),
 	.P (Mul_Out[5]));		
 mult_gen_0	mult_gen_6 (
 	.CLK (clk),
 	.A (coff_6),
 	.B (Add_Reg[6]),
 	.P (Mul_Out[6]));				
 mult_gen_0	mult_gen_7 (
 	.CLK (clk),
 	.A (coff_7),
 	.B (Add_Reg[7]),
 	.P (Mul_Out[7]));
 mult_gen_0	mult_gen_8 (
 	.CLK (clk),
 	.A (coff_8),
 	.B (Add_Reg[8]),
 	.P (Mul_Out[8]));		
 mult_gen_0	mult_gen_9 (
 	.CLK (clk),
 	.A (coff_9),
 	.B (Add_Reg[9]),
 	.P (Mul_Out[9]));		
 mult_gen_0	mult_gen_10 (
 	.CLK (clk),
 	.A (coff_10),
 	.B (Add_Reg[10]),
 	.P (Mul_Out[10]));		
 mult_gen_0	mult_gen_11 (
 	.CLK (clk),
 	.A (coff_11),
 	.B (Add_Reg[11]),
 	.P (Mul_Out[11]));				

 //data_accumulate_module
 reg [20:0] sum[0:8];
 reg [2:0] k;
 always @(posedge clk or negedge buffer_enable)
 	if (!buffer_enable)
 		begin 
 		 data_filter_out <= 19'd0;
         filter_out_Enable<=1'd0;
 		 k<=0;
 		 sum[0] <= 0;sum[1] <= 0; sum[2] <= 0; sum[3] <= 0;      
         sum[4] <= 0;sum[5] <= 0; sum[6] <= 0; sum[7] <= 0;sum[8] <= 0;      
 		end
 	else
 		begin
           if(k==3'd5)
              filter_out_Enable<=1'd1;
           else 
             begin
              k <=k+1'd1 ;
              filter_out_Enable<=1'd0;
             end
 		   sum[0] <={4'd0,Mul_Out[0]} +{4'd0,Mul_Out[1]};  
           sum[1] <={4'd0,Mul_Out[2]} +{4'd0,Mul_Out[3]};  
           sum[2] <={4'd0,Mul_Out[4]} +{4'd0,Mul_Out[5]};  
           sum[3] <={4'd0,Mul_Out[6]} +{4'd0,Mul_Out[7]};  
           sum[4] <={4'd0,Mul_Out[8]} +{4'd0,Mul_Out[9]};  
           sum[5] <={4'd0,Mul_Out[10]}+{4'd0,Mul_Out[11]};

           sum[6] <=sum[0]+sum[1];
           sum[7] <=sum[2]+sum[3];
           sum[8] <=sum[4]+sum[5];
           data_filter_out<=sum[6]+sum[7]+sum[8];
 		end

endmodule