// Commented out lines were erased.
// Noise during training was removed. 
// Rewrote the LED matrix column process to one line.
module neuro (input rst,input clk,Abtn,Bbtn,input [3:0]btn,output test1,test2,low,high,[7:0]col,[7:0]row);
  reg signed [7:0]sum;
  reg [24:0]counter,neuros;
  reg signed[3:0] links[624:0];
  assign col =  (counter[15:13]==0)*neuros[4:0]+(counter[15:13]==1)*neuros[9:5]+(counter[15:13]==2)*neuros[14:10]+(counter[15:13]==3)*neuros[19:15]+(counter[15:13]==4)*neuros[24:20];
  assign row = ~(1<<counter[15:13]);
  wire [24:0]D=25'b0111010010100101001001111;
  wire [24:0]C=25'b0011101001010000100011111;
  wire [24:0]J=25'b1111000001000010000111110;
  wire [24:0]M=25'b1000110001101011101110001;
  wire [24:0]noise=counter;
  always @(posedge(clk))counter = counter + 1;

  integer k,m;
  always @(posedge(clk))begin
	if (rst==0)  neuros = (Abtn==0)? counter : 25'b0111010011100100001001110; 
	if (btn[0]==0)if (counter[22]==0) begin
        for (k=0;k<25;k=k+1) begin 
            sum=0;
            for (m=0;m<25;m=m+1) 
                sum = sum + ((neuros[m]==1)?links[(k<<4)+(k<<3)+k+m]:(-links[(k<<4)+(k<<3)+k+m]));
        neuros[k]=(sum>0)?1:0;
        end
	end
 end

 always @(posedge(counter[19]))if (rst==0) 
        for (k=0;k<25;k=k+1)
          for(m=0;m<25;m=m+1)
            links[k*25+m]<=((D[k]==D[m])?1:-1)+((J[k]==J[m])?1:-1)+((C[k]==C[m])?1:-1)+((M[k]==M[m])?1:-1); 
//          links[k*25+m]<=((D[k]==D[m])?1:-1)+((J[k]==J[m])?1:-1)+((C[k]==C[m])?1:-1)+((M[k]==M[m])?1:-1)+((noise[k]==noise[m])?1:-1); 
endmodule
