`timescale 1ns/1ps
module tb_uart_tx;

	reg clk;
	reg rst;
	reg tx_start;
	reg [7:0] data_in;
	wire tx;
	wire busy;
	
	//實例化 uart_tx
	uart_tx uut(
		.clk(clk),
		.rst(rst),
		.tx_start(tx_start),
		.data_in(data_in),
		.tx(tx),
		.busy(busy)
	);
	
	//產生時鐘100MHz = 10ns週期
	always #5 clk = ~clk;
	
	initial begin
		clk = 0;
		rst = 1;
		tx_start = 0;
		data_in = 8'h00;
		
		#100; //等待重置完成
		rst = 0;
		
		#50;
		data_in = 8'hA5; //要送的資料
		tx_start =1;
		
		#10;  //tx_start保持一個時脈
		tx_start = 0;
		
		//等待busy變為0表示傳送完成
		wait (busy == 0);
		
		#100;
		$finish;
	end
endmodule