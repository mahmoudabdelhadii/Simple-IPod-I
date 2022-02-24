`timescale 1ns/1ps
`define Do 32'd95602

module tb_clock_divider;
 // Inputs
 reg clock_in;
 reg reset;
 reg [31:0] DIVISOR;
 // Outputs
 wire clock_out;
 // Instantiate the Unit Under Test (UUT)
 // Test the clock divider in Verilog
 Clock_divider uut (
  .clock_in(clock_in), 
  .reset(reset),
.DIVISOR(DIVISOR),
  .clock_out(clock_out)
 );
 initial begin
  // Initialize Inputs
  clock_in = 1'b0;
  reset = 1'b0;
DIVISOR = 32'd2;
  //DIVISOR = `Do;
  // create input clock 50MHz
        forever begin
         #10   clock_in = ~clock_in;  
        end
 end
endmodule     

module tb_led_fsm;
reg clock_1Hz;
wire [7:0] LEDR;

led_fsm uut2 (
    .clock_1Hz(clock_1Hz),
    .LEDR(LEDR)
    );
    initial begin
  // Initialize Inputs
  clock_1Hz = 1'b0;
 // reset = 1'b0;
  //DIVISOR = `Do;
  // create input clock 50MHz
        forever begin
         #100   clock_1Hz = ~clock_1Hz;  
        end
end
endmodule 

module tb_DIV; 

reg [3:0]SW;
wire [31:0]div;
wire [31:0] lcd_ch;

DIV uut3 (
  .SW(SW),
  .div(div),
  .lcd_ch(lcd_ch)
);

initial begin
#10 SW[3:0] = 4'b0;
  #10 SW[0] = 1'b1; 
  #10 SW[1] = 1'b1; 
  #10 SW[2] = 1'b1; 
  #10 SW[3] = 1'b1; 
  #10 SW[3] = 1'b0; 
  #10 SW[2] = 1'b0; 
  #10 SW[2] = 1'b1; 
  #10 SW[3] = 1'b0; 
end
endmodule 

module tb_asyncsig;

    reg clk;
    reg async_sig;
    wire out_sync_sig;

    asyncsig u1 (.clk(clk),
    .async_sig(async_sig),
    .out_sync_sig(out_sync_sig));


    initial begin 

      clk =1'b0;
      async_sig = 1'b1;
      #1000 async_sig =1'b0;
     // #10000 async_sig =1'b1;


      forever begin
         #100   clk = ~clk;  
         #150 async_sig = ~async_sig;
        end

    end
endmodule
