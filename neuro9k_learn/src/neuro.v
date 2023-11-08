// Added Abtn to switch between random and fixed input characters.
module neuro (input rst,input clk,Abtn,input [3:0]btn,output test1,test2,low,high,[7:0]col,[7:0]row);
  reg [24:0] neuros;
  wire [7:0] matrix[7:0];
  reg[4:0] i=0,jj=0;
  reg signed [7:0]sum;
  reg [24:0]count12;
  reg [24:0] D,J,C,M,noise;
  reg signed[3:0] links[624:0];
//  reg [24:0]learn[2:0];

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
	if (rst==0)  neuros = (Abtn==1)? count12 : 25'b0111010011100100001001110; 
	if (btn[0]==0)if (count12[22]==0) begin
        for (k=0;k<25;k=k+1) begin 
            sum=0;
            for (m=0;m<25;m=m+1) 
                sum = sum + ((neuros[m]==1)?links[(k<<4)+(k<<3)+k+m]:(-links[(k<<4)+(k<<3)+k+m]));
        neuros[k]=(sum>0)?1:0;
        end
	end
 end

/*
  always @(posedge(clk))begin
	if (rst==0)  neuros = (Abtn==1)? neuros = count12:25'b0111010011100100001001110; 
	if (btn[0]==0)if (count12[22]==0) begin
        for (k=0;k<25;k=k+1) begin 
            sum=0;
            for (m=0;m<25;m=m+1) 
                sum = sum + ((neuros[m]==1)?links[(k<<4)+(k<<3)+k+m]:(-links[(k<<4)+(k<<3)+k+m]));
        neuros[k]=(sum>0)?1:0;
        end
	end
 end
*/
/*
  always @(posedge(clk))begin
	if (rst==0)  neuros = count12;
	if ((btn[0]==0)&(count12[22]==0))begin
        for (k=0;k<25;k=k+1) begin 
            sum=0;
            for (m=0;m<25;m=m+1) 
                sum = sum + ((neuros[m]==1)?links[(k<<4)+(k<<3)+k+m]:(-links[(k<<4)+(k<<3)+k+m]));
        neuros[k]=(sum>0)?1:0;
        end
	end
 end
*/

/*
  always @(posedge(count12[22]))begin
	if (rst==0)  begin neuros = 25'b0111010011100100001001110;end
	if ((btn[0]==0))begin
        for (k=0;k<25;k=k+1) begin 
            sum=0;
            for (m=0;m<25;m=m+1) 
                sum = sum + ((neuros[m]==1)?links[(k<<4)+(k<<3)+k+m]:(-links[(k<<4)+(k<<3)+k+m]));
        neuros[k]=(sum>0)?1:0;
        end
	end
 end
*/

/*
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
*/
/*
 always @(posedge(clk))if (rst==0) begin 
        learn[0]     = 25'b0111010010100101001001111;
        learn[1]     = 25'b0011101001010000100011111;
        learn[2]     = 25'b1111000001000010000111110;
        learn[3]     = 25'b1000110001101011101110001;
        learn[4]     = count12; 
        for (k=0;k<25;k=k+1)
          for(m=0;m<25;m=m+1)
            links[k*25+m]=
            ((learn[0][k]==learn[0][m])?1:-1)+
            ((learn[1][k]==learn[1][m])?1:-1)+
            ((learn[2][k]==learn[2][m])?1:-1)+
            ((learn[3][k]==learn[3][m])?1:-1)+
            ((learn[4][k]==learn[4][m])?1:-1);
	end
*/
 always @(posedge(clk))if (rst==0) begin 
        D     = 25'b0111010010100101001001111;
        C     = 25'b0011101001010000100011111;
        J     = 25'b1111000001000010000111110;
        M     = 25'b1000110001101011101110001;
        noise = count12; 
        for (k=0;k<25;k=k+1)
          for(m=0;m<25;m=m+1)
            links[k*25+m]=
//            ((D[k]==D[m])?1:-1)+((J[k]==J[m])?1:-1)+((C[k]==C[m])?1:-1)+((M[k]==M[m])?1:-1);
            ((D[k]==D[m])?1:-1)+((J[k]==J[m])?1:-1)+((C[k]==C[m])?1:-1)+((M[k]==M[m])?1:-1)+((noise[k]==noise[m])?1:-1); 
	end

/*
 always @(posedge(clk))if (rst==0) begin 
        D     = 25'b0111010010100101001001111;
        C     = 25'b0011101001010000100011111;
        J     = 25'b1111000001000010000111110;
        M     = 25'b1000110001101011101110001;
        noise = count12; 
        for (k=0;k<25;k=k+1)
          for(m=0;m<25;m=m+1)
            links[k*25+m]=
            ((D[k]==D[m])?1:-1)+
            ((J[k]==J[m])?1:-1)+
            ((C[k]==C[m])?1:-1)+
            ((M[k]==M[m])?1:-1)+
            ((noise[k]==noise[m])?1:-1);
	end
*/
/*
 always @(posedge(clk))if (rst==0) begin 
	learn[0]  = 25'b0111010010100101001001111;
	learn[1]  = 25'b0011101001010000100011111; 
	learn[2]  = 25'b1111000001000010000111110;
	learn[3]  = 25'b1000110001101011101110001;
    for (k=0;k<25;k=k+1)
          for(m=0;m<25;m=m+1)
               links[k*25+m]=((learn[0][k]==learn[0][m])?1:-1)+((learn[1][k]==learn[1][m])?1:-1)+((learn[2][k]==learn[2][m])?1:-1)+((learn[3][k]==learn[3][m])?1:-1);
end
*/
// always @(posedge(clk))if (rst==0) begin `include "links.txt" end
endmodule
