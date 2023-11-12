// noise is not mixed in during learning.
// Comment out lines were deleted.
 module neuro (input rst,input clk,Abtn,Bbtn,input [3:0]btn,output test1,test2,low,high,[7:0]col,[7:0]row);
  reg signed [7:0]sum[24:0];
  reg [24:0]counter,neuros;
  reg signed[3:0] links[624:0];
  assign row = ~(1<<counter[15:13]);
  wire [24:0]D=25'b0111010010100101001001111;
  wire [24:0]C=25'b0011101001010000100011111;
  wire [24:0]J=25'b1111000001000010000111110;
  wire [24:0]M=25'b1000110001101011101110001;
  wire [24:0]noise=counter;

  assign col=(counter[15:13]==0)*neuros[4:0]+(counter[15:13]==1)*neuros[9:5]+(counter[15:13]==2)*neuros[14:10]+(counter[15:13]==3)*neuros[19:15]+(counter[15:13]==4)*neuros[24:20];
  assign row = ~(1<<counter[15:13]);

  always @(posedge(clk))counter = counter + 1;

  integer k,m;
  always @(posedge(clk))begin
	if (rst==0)  neuros<= (Abtn==0)? counter : 25'b0111010011100100001001110; 
	if (btn[0]==0)if (counter[22]==0) begin
           for (k=0;k<25;k=k+1) begin 
              sum[k]<=((neuros[0]==1)?links[25*k+0]:(-links[25*k+0]))+    
                      ((neuros[1]==1)?links[25*k+1]:(-links[25*k+1]))+
                      ((neuros[2]==1)?links[25*k+2]:(-links[25*k+2]))+
                      ((neuros[3]==1)?links[25*k+3]:(-links[25*k+3]))+
                      ((neuros[4]==1)?links[25*k+4]:(-links[25*k+4]))+
                      ((neuros[5]==1)?links[25*k+5]:(-links[25*k+5]))+
                      ((neuros[6]==1)?links[25*k+6]:(-links[25*k+6]))+
                      ((neuros[7]==1)?links[25*k+7]:(-links[25*k+7]))+
                      ((neuros[8]==1)?links[25*k+8]:(-links[25*k+8]))+
                      ((neuros[9]==1)?links[25*k+9]:(-links[25*k+9]))+
                      ((neuros[10]==1)?links[25*k+10]:(-links[25*k+10]))+
                      ((neuros[11]==1)?links[25*k+11]:(-links[25*k+11]))+
                      ((neuros[12]==1)?links[25*k+12]:(-links[25*k+12]))+
                      ((neuros[13]==1)?links[25*k+13]:(-links[25*k+13]))+
                      ((neuros[14]==1)?links[25*k+14]:(-links[25*k+14]))+
                      ((neuros[15]==1)?links[25*k+15]:(-links[25*k+15]))+
                      ((neuros[16]==1)?links[25*k+16]:(-links[25*k+16]))+
                      ((neuros[17]==1)?links[25*k+17]:(-links[25*k+17]))+
                      ((neuros[18]==1)?links[25*k+18]:(-links[25*k+18]))+
                      ((neuros[19]==1)?links[25*k+19]:(-links[25*k+19]))+
                      ((neuros[20]==1)?links[25*k+20]:(-links[25*k+20]))+
                      ((neuros[21]==1)?links[25*k+21]:(-links[25*k+21]))+
                      ((neuros[22]==1)?links[25*k+22]:(-links[25*k+22]))+
                      ((neuros[23]==1)?links[25*k+23]:(-links[25*k+23]))+
                      ((neuros[24]==1)?links[25*k+24]:(-links[25*k+24]));
           end
           for (k=0;k<25;k=k+1) neuros[k]<=(sum[k]>0)?1:0; 
	end
 end

 always @(posedge(counter[19]))if (rst==0) 
        for (k=0;k<25;k=k+1)
          for(m=0;m<25;m=m+1)
            links[k*25+m]<=((D[k]==D[m])?1:-1)+((J[k]==J[m])?1:-1)+((C[k]==C[m])?1:-1)+((M[k]==M[m])?1:-1); 
//            links[k*25+m]<=((D[k]==D[m])?1:-1)+((J[k]==J[m])?1:-1)+((C[k]==C[m])?1:-1)+((M[k]==M[m])?1:-1)+((noise[k]==noise[m])?1:-1); 
endmodule
