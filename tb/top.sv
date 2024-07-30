module top;


import router_test_pkg::*;
import uvm_pkg::*;

bit clock;
always 
#5 clock=!clock;


	router_src_if in0(clock);
	router_dst_if in1(clock);
	router_dst_if in2(clock);
	router_dst_if in3(clock);


	router_top DUV(.clock(clock),.resetn(in0.reset),.pkt_valid(in0.pkt_vld),.err(in0.error),.busy(in0.busy),.data_in(in0.data_in),
			.data_out_0(in1.data_out),.data_out_1(in2.data_out),.data_out_2(in3.data_out),
			.read_enb_0(in1.rd_enb),.read_enb_1(in2.rd_enb),.read_enb_2(in3.rd_enb),
			.vld_out_0(in1.vld_out),.vld_out_1(in2.vld_out),.vld_out_2(in3.vld_out));

initial
	begin
			$fsdbDumpvars(top,0);

			uvm_config_db#(virtual router_src_if)::set(null,"*","vif_0",in0);
			uvm_config_db#(virtual router_dst_if)::set(null,"*","vif_0",in1);
			uvm_config_db#(virtual router_dst_if)::set(null,"*","vif_1",in2);
			uvm_config_db#(virtual router_dst_if)::set(null,"*","vif_2",in3);

			run_test();
	end
endmodule

