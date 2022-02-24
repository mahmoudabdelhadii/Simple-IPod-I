
module led_fsm ( input logic clock_1Hz,output logic [7:0] LEDR);
reg [3:0] ledstate;
reg [3:0] nextstate;


reg[3:0] led1 =4'b0000;
reg [3:0] led2 =4'b0001;
reg [3:0] led3 =4'b0010;
reg[3:0] led4 =4'b0011;
reg [3:0] led5 =4'b0100;
reg [3:0] led6 =4'b0101;
reg [3:0] led7 =4'b0110;
reg [3:0] led8 =4'b0111;
//parameter [3:0] led9 4'b1000

always_ff@(posedge clock_1Hz)    //LED lights   [9:0]      LEDR 
begin
ledstate <= nextstate;
end

always_comb //combinational
begin
  LEDR[7:0] = 8'b0;
case (ledstate)
    led1: begin
      nextstate = led2;
      LEDR[0] = 1'b1;
      LEDR[7] =1'b0;
	LEDR[1] =1'b0;	
    end
    led2: begin
      nextstate = led3;
      LEDR[1] = 1'b1;
      LEDR[0] =1'b0;
    end
    led3: begin 
    nextstate = led4;
    LEDR[2] = 1'b1;
    LEDR[1] =1'b0;
    end
    led4: begin
    nextstate = led5;
    LEDR[3] = 1'b1;
    LEDR[2] =1'b0;
    end
    led5: begin
    nextstate = led6;
    LEDR[4] = 1'b1;
    LEDR[3] =1'b0;
    end

    led6: begin
    nextstate = led7;
    LEDR[5] = 1'b1;
    LEDR[4] =1'b0;
    end
    led7: begin
    nextstate = led8;
    LEDR[6] = 1'b1;
    LEDR[5] =1'b0;
    end
    led8: begin
    nextstate = 4'b1000;
    LEDR[7] = 1'b1;
    LEDR[6] =1'b0;
    end
    4'b1000: begin
      nextstate = 4'b1001;
      LEDR[6] = 1'b1;
      LEDR[7]=1'b0;
end
    4'b1001: begin 
	nextstate = 4'b1010;
    LEDR[5] = 1'b1;
      LEDR[6]=1'b0;
end
    4'b1010: begin 
	nextstate = 4'b1011;
    LEDR[4] = 1'b1;
      LEDR[5]=1'b0;
end
    4'b1011: begin 
	nextstate = 4'b1100;
    LEDR[3] = 1'b1;
      LEDR[4]=1'b0;
end
    4'b1100: begin
	nextstate = 4'b1101;
    LEDR[2] = 1'b1;
      LEDR[3]=1'b0;
end
    4'b1101:begin
 nextstate = led1;
    LEDR[1] = 1'b1;
      LEDR[2]=1'b0;
end
    4'b1110: nextstate = led1;
    4'b1111: nextstate = led1;
      default: nextstate = led1;
endcase
end

endmodule
//=======================================================
//  CLock Divider
//=======================================================
module Clock_divider(
    input logic clock_in,
    input logic reset,
    input logic [31:0] DIVISOR, 
    output logic clock_out
    );
//parameter DIVISOR = 32'd95602;
reg[31:0] counter=32'd0;
//parameter DIVISOR = 28'd2;
// The frequency of the output clk_out
//  = The frequency of the input clk_in divided by DIVISOR
// For example: Fclk_in = 50Mhz
always_ff @(posedge clock_in)
begin
 counter <= counter + 32'd1;
 if (reset)begin
     counter<= 32'd0;
     clock_out<= 1'b0;
 end
 
 else if(counter>=(DIVISOR-1))
 counter <= 32'd0;
 
clock_out <= (counter<DIVISOR/2)?1'b1:1'b0;

end
endmodule
//=======================================================
//  clock divider divisor select
//=======================================================

module DIV (input logic [3:0]SW, 
				output logic [31:0]div,
				output logic [31:0] lcd_ch
				);
				
//Character definitions

//numbers

`define character_2 8'h32

//Uppercase Letters
`define character_A 8'h41


`define character_D 8'h44

`define character_F 8'h46



`define character_L 8'h4C
`define character_M 8'h4D

`define character_O 8'h4F


`define character_R 8'h52
`define character_S 8'h53


//Lowercase Letters
`define character_lowercase_a 8'h61



`define character_lowercase_e 8'h65

`define character_lowercase_i 8'h69

`define character_lowercase_o 8'h6F


//Other Characters
       
`define character_space 8'h20          //' ' 
`define Do 32'd95602
`define Re 32'd85179
`define Mi 32'd75873
`define Fa 32'd71633
`define So 32'd63857
`define La 32'd56818
`define Si 32'd50659
`define Do2 32'd47801    

//wire [31:0] lcd_char;
//assign lcd_ch = lcd_char; 

always_comb
begin
  case (SW[3:0])
    4'b0000: begin 
				div = 32'd1;
				lcd_ch = 32'b0;
				end
    4'b0001: begin 
			div = `Do;
			lcd_ch = {`character_D , `character_lowercase_o , `character_space , 8'h00};
			end
    4'b0010: begin div = 32'd1;
				lcd_ch = 32'b0;
				end
    4'b0011: begin
				div = `Re;
				{lcd_ch} = {`character_R,`character_lowercase_e, `character_space,`character_space} ;
				end
    4'b0100: begin div = 32'd1;
	 lcd_ch = 32'b0;
	 end
    4'b0101: begin 
				div = `Mi;
				lcd_ch = {`character_M,`character_lowercase_i, `character_space,`character_space};
				end
    4'b0110: begin 
				div = 32'd1;
				lcd_ch = 32'b0;
				end
    4'b0111: begin 
				div = `Fa;
				lcd_ch = {`character_F,`character_lowercase_a, `character_space,`character_space};
				end
    4'b1000: begin 
			div = 32'd1;
			lcd_ch = 32'b0;
			end
    4'b1001: begin 
				div = `So;
				lcd_ch = {`character_S,`character_lowercase_o, `character_space,`character_space};
				end 
    4'b0110: begin 
				div = 32'd1;
				lcd_ch = 32'b0;
				end
    4'b0111: begin
					div = 32'd1;
					lcd_ch = 32'b0;
					end
    4'b1000: begin 
				div = 32'd1;
				lcd_ch = 32'b0;
				end
    4'b1001: begin 
					div = 32'd1;
					lcd_ch = 32'b0;
					end
    4'b1010: begin 
				div = 32'd1;
				lcd_ch = 32'b0;
				end
    4'b1011: begin 
				div = `La;
				lcd_ch = {`character_L,`character_lowercase_a, `character_space,`character_space};
				end
    4'b1100: begin div = 32'd1;
	 lcd_ch = 32'b0;
	 end
    4'b1101: begin 
				div = `Si;
				lcd_ch = {`character_S,`character_lowercase_i, `character_space,`character_space};
				end
    4'b1110: begin div = 32'd1;
	 lcd_ch = 32'b0;
	 end
    4'b1111: begin 
				div = `Do2;
				lcd_ch = {`character_D,`character_lowercase_o, `character_2, `character_space};
				end
      default: begin div = 32'd1;
							lcd_ch = 32'b0;
									end
  endcase
end
endmodule