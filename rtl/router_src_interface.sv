

interface router_src_if(input bit clock);
	logic [7:0]data_in;
	logic  pkt_vld;
	logic reset;
	logic error;
	logic busy;


	clocking src_drv_cb @(posedge clock);
		default input #1 output #1;
		output data_in;
		output pkt_vld;
		output reset;
		input error;
		input busy;
	endclocking

	clocking src_mon_cb @(posedge clock);
		default input #1 output #1;
		input data_in;
		input pkt_vld;
		input reset;
		input error;
		input busy;
	endclocking

	modport SRC_DRV_MP (clocking src_drv_cb);
	
	modport SRC_MON_MP (clocking src_mon_cb);
	
endinterface
