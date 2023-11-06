//C4ExecFaster
/*
module cpu(input rst,input clk,input [3:0]btn,
    output [7:0]col, output [7:0]row,
    output [5:0]leds,
    output low,high);
*/


// module neuro( clk,reset,seg,dig,key1,outClk,test1,test2,col,row);
module neuro (input rst,input clk,input [3:0]btn,
    output [7:0]col, output [7:0]row,
    output [5:0]leds,
    output low,high,
    output test1,
    output test2);


 reg [24:0] neuros,D,J,C,M;
 reg signed[7:0] links[624:0];
 
 wire [7:0] matrix[7:0];
 reg[4:0] i,jj;
 reg signed [9:0]sum;
 reg [24:0]count12;

//  reg [7:0]segreg;
//  reg [3:0]digreg;

//  reg [31:0]data32;
//  output test1;
//  output test2; 

  assign test1 = i;
  assign test2 = btn[0];
//  assign test2 = jj;
//  assign outClk = clk;
 

    assign matrix[0][4:0] = neuros[4:0];
    assign matrix[1][4:0] = neuros[9:5];
    assign matrix[2][4:0] = neuros[14:10];
    assign matrix[3][4:0] = neuros[19:15];
    assign matrix[4][4:0] = neuros[24:20];

    assign col = matrix[count12[15:13]];

    assign row[0]=(count12[15:13]==0?0:1);
    assign row[1]=(count12[15:13]==1?0:1);
    assign row[2]=(count12[15:13]==2?0:1);
    assign row[3]=(count12[15:13]==3?0:1);
    assign row[4]=(count12[15:13]==4?0:1);
    assign row[5]=(count12[15:13]==5?0:1);
    assign row[6]=(count12[15:13]==6?0:1);
    assign row[7]=(count12[15:13]==7?0:1);

 initial begin
	i = 0;
	jj = 0;
 end
 
 always @(posedge(clk))count12 = count12 + 1;
 
 always @(posedge(clk))begin
	if (rst==0)  begin
		i = 0;
//		neuros = 25'b0111000011100101001001110;
        neuros = 25'b0111010011100100001001110;
		end
	if ((btn[0]==0)&&(i==0))begin
//		i = 1;
//        sum = 0;
		`include "makeExec.txt"
		i = 1;
	end
 end

always @(posedge(clk))begin
	if ((rst==0)&&(jj == 0))begin
		jj = 5'b11111;
		`include "links.txt"
		jj = 0;
	end
 end

endmodule