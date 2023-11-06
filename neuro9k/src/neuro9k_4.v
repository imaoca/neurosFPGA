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


 reg [24:0] neuros;
 reg [24:0] D,J,C,M;
 reg signed[7:0] links[624:0];
 
  wire [7:0] matrix[7:0];
  reg[4:0] i,jj;
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
 
integer k;
 always @(posedge(clk))begin
	if (rst==0)  begin i = 0;neuros = 25'b0111010011100100001001110;end
	if ((btn[0]==0)&&(i==0))begin
    for (k=0;k<25;k=k+1) 
      neuros[k]=
        ((neuros[0]==1)?links[k*25+0]:(-links[k*25+0]))+
        ((neuros[1]==1)?links[k*25+1]:(-links[k*25+1]))+
        ((neuros[2]==1)?links[k*25+2]:(-links[k*25+2]))+
        ((neuros[3]==1)?links[k*25+3]:(-links[k*25+3]))+
        ((neuros[4]==1)?links[k*25+4]:(-links[k*25+4]))+
        ((neuros[5]==1)?links[k*25+5]:(-links[k*25+5]))+
        ((neuros[6]==1)?links[k*25+6]:(-links[k*25+6]))+
        ((neuros[7]==1)?links[k*25+7]:(-links[k*25+7]))+
        ((neuros[8]==1)?links[k*25+8]:(-links[k*25+8]))+
        ((neuros[9]==1)?links[k*25+9]:(-links[k*25+9]))+
        ((neuros[10]==1)?links[k*25+10]:(-links[k*25+10]))+
        ((neuros[11]==1)?links[k*25+11]:(-links[k*25+11]))+
        ((neuros[12]==1)?links[k*25+12]:(-links[k*25+12]))+
        ((neuros[13]==1)?links[k*25+13]:(-links[k*25+13]))+
        ((neuros[14]==1)?links[k*25+14]:(-links[k*25+14]))+
        ((neuros[15]==1)?links[k*25+15]:(-links[k*25+15]))+
        ((neuros[16]==1)?links[k*25+16]:(-links[k*25+16]))+
        ((neuros[17]==1)?links[k*25+17]:(-links[k*25+17]))+
        ((neuros[18]==1)?links[k*25+18]:(-links[k*25+18]))+
        ((neuros[19]==1)?links[k*25+19]:(-links[k*25+19]))+
        ((neuros[20]==1)?links[k*25+20]:(-links[k*25+20]))+
        ((neuros[21]==1)?links[k*25+21]:(-links[k*25+21]))+
        ((neuros[22]==1)?links[k*25+22]:(-links[k*25+22]))+
        ((neuros[23]==1)?links[k*25+23]:(-links[k*25+23]))+
        ((neuros[24]==1)?links[k*25+24]:(-links[k*25+24]))>0?1:0;

		i = 1;
	end
 end

/*
integer k,m;
 always @(posedge(clk))begin
	if (rst==0)  begin i = 0;neuros = 25'b0111010011100100001001110;end
	if ((btn[0]==0)&&(i==0))begin
//		`include "makeExec.txt"
    for (k=0;k<25;k=k+1) begin 
        sum=0;
        for (m=0;m<25;m=m+1) 
            sum = sum + ((neuros[m]==1)?links[k*25+m]:(-links[k*25+m]));
        neuros[k]=(sum>0)?1:0;
        end
        i = 1;
	end
 end
*/
always @(posedge(clk))begin
	if ((rst==0)&&(jj == 0))begin
		jj = 5'b11111;
		`include "links.txt"
		jj = 0;
	end
 end

endmodule