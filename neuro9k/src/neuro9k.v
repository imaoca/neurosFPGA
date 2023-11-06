module neuro (input rst,input clk,input [3:0]btn,output test1,test2,low,high,[7:0]col,[7:0]row);
  reg [24:0] neuros;
  reg signed[7:0] links[624:0];
  wire [7:0] matrix[7:0];
  reg[4:0] i=0,jj=0;
  reg signed [7:0]sum;
  reg [24:0]count12;

  assign test1 = i;
  assign test2 = btn[0];
  assign matrix[0][4:0] = neuros[4:0];
  assign matrix[1][4:0] = neuros[9:5];
  assign matrix[2][4:0] = neuros[14:10];
  assign matrix[3][4:0] = neuros[19:15];
  assign matrix[4][4:0] = neuros[24:20];
  assign col = matrix[count12[15:13]];
  assign row = ~(1<<count12[15:13]);

  always @(posedge(clk))count12 = count12 + 1;
  integer k,m;
  always @(posedge(clk))begin
	if (rst==0)  begin i = 0;neuros = 25'b0111010011100100001001110;end
	if ((btn[0]==0)&&(i==0))begin
        for (k=0;k<25;k=k+1) begin 
            sum=0;
            for (m=0;m<25;m=m+1) 
                sum = sum + ((neuros[m]==1)?links[(k<<4)+(k<<3)+k+m]:(-links[(k<<4)+(k<<3)+k+m]));
        neuros[k]=(sum>0)?1:0;
        end
		i = 1;
	end
 end
always @(posedge(clk))if (rst==0) begin `include "links.txt" end
endmodule
