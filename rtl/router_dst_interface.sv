

interface router_dst_if (input bit clock);

	logic [7:0]data_out;
	logic rd_enb;
	logic vld_out;
	

	clocking dst_drv_cb @(posedge clock);
		default input #1 output #1;
		output rd_enb;
		input vld_out;
	endclocking
	
	clocking dst_mon_cb @(posedge clock);
		default input #1 output #1;
		input data_out;
		input rd_enb;

	endclocking


	modport DST_DRV_MP (clocking dst_drv_cb);
	
	modport DST_MON_MP (clocking dst_mon_cb);

endinterface
