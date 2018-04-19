module main( clock // 50 MHz
			 ,sw0
			 ,sw1
			 ,sw2
			 ,sw3			 
			 ,key_0
			 ,key_1
			 ,led
			 ,PS2_CLK
			 ,PS2_DAT
			 ,VGA_VSYNC
			 ,VGA_HSYNC
			 ,VGA_RED
			 ,VGA_GREEN
			 ,VGA_BLUE
          ,test_point );

			input clock;

			input sw0;
			input sw1;			
			input sw2;
			input sw3;	

			input key_0; // not used yet
			input key_1;
			
			input PS2_CLK;
			input PS2_DAT;

			output [7:0] led;			

			output       VGA_VSYNC;
			output       VGA_HSYNC;
			output [4:0] VGA_RED;
			output [4:0] VGA_GREEN;
			output [4:0] VGA_BLUE;			
			output test_point;

wire [2:0]  clk_div; 
wire [7:0]  char_count;
wire [11:0] line_count;

wire pre_visible;
wire [3:0]key;

wire [7:0]goals;

wire video_r;
wire video_g;
wire video_b;

assign VGA_RED[0] = video_r;
assign VGA_RED[1] = video_r;
assign VGA_RED[2] = video_r;
assign VGA_RED[3] = video_r;
assign VGA_RED[4] = video_r;

assign VGA_GREEN[0] = video_g;
assign VGA_GREEN[1] = video_g;
assign VGA_GREEN[2] = video_g;
assign VGA_GREEN[3] = video_g;
assign VGA_GREEN[4] = video_g;

assign VGA_BLUE[0] = video_b;
assign VGA_BLUE[1] = video_b;
assign VGA_BLUE[2] = video_b;
assign VGA_BLUE[3] = video_b;
assign VGA_BLUE[4] = video_b;

assign key[3]     = key_1;
assign test_point = clk_div[2];
assign led0       = sw0;

lpm_counter1 lpm_counter1_inst(
     .clock (clock)
    ,.q     (clk_div)
    );

ps2 ps2_inst(
     .PS2_DAT_in (PS2_DAT)
    ,.PS2_CLK_in (PS2_CLK)
    ,.clock      (clock)
    ,.led_out    (led)
    ,.down       (key[0])
    ,.up         (key[1])
    );

hvsync hvsync_inst(
     .reset       (1'h0)
    ,.char_clock  (clk_div[2])
    ,.char_count  (char_count)
    ,.line_count  (line_count)    
    ,.hsync       (VGA_HSYNC)
    ,.vsync       (VGA_VSYNC)
    ,.pre_visible (pre_visible)	
     );

game game_inst(
     .char_clock  (clk_div[2])
    ,.vsync       (VGA_VSYNC)
    ,.key         (key)
    ,.char_count  (char_count)
    ,.line_count  (line_count) 
    ,.pre_visible (pre_visible)
    ,.video       ()
    ,.video_r     (video_r)
    ,.video_g     (video_g)
    ,.video_b     (video_b)
    ,.goals       (goals)
     );

endmodule

