class router_scoreboard extends uvm_scoreboard;

	`uvm_component_utils(router_scoreboard)

write_xtn w_xtn;
read_xtn r_xtn;

uvm_tlm_analysis_fifo #(write_xtn) src_fifo[];
uvm_tlm_analysis_fifo #(read_xtn) dst_fifo[];

router_env_config env_cfg;

//write_xtn src_cov_data;
//read_xtn dst_cov_data;

covergroup router_src;
option.per_instance=1;

SRC_ADDR : coverpoint w_xtn.Header[1:0]		{bins a = {2'b00};
						 bins b = {2'b01};
						 bins c = {2'b10};}


SRC_PL_SIZE : coverpoint w_xtn.Header[7:2] 	{bins small_pkt = {[1:13]};
						 bins medium_pkt = {[14:30]};
						 bins large_pkt = {[31:63]};}
SRC_CROSS : cross SRC_ADDR,SRC_PL_SIZE;

endgroup

covergroup router_dst;
option.per_instance=1;

DST_ADDR : coverpoint r_xtn.Header[1:0] 	{bins e = {2'b00};
						 bins f = {2'b01};
						 bins g = {2'b10};}


DST_PL_SIZE : coverpoint r_xtn.Header[7:2] 	{bins small_pkt = {[1:13]};
						 bins medium_pkt = {[14:30]};
						 bins large_pkt = {[31:63]};}
DST_CROSS : cross DST_ADDR,DST_PL_SIZE;

endgroup



	

extern function new(string name = "router_scoreboard", uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern task run_phase (uvm_phase phase);
extern task user_compare(write_xtn w_xtn,read_xtn r_xtn);
endclass

//----------------------------------------------------------------------------//

function router_scoreboard::new(string name = "router_scoreboard", uvm_component parent);
	super.new(name,parent);
	router_src=new();
	router_dst=new();
endfunction

function void router_scoreboard::build_phase(uvm_phase phase);
	super.build_phase(phase);

	uvm_config_db#(router_env_config)::get(this,"","router_env_config",env_cfg);

	src_fifo=new[env_cfg.no_of_src_agents];
	dst_fifo=new[env_cfg.no_of_dst_agents];

	foreach(src_fifo[i])
		src_fifo[i]=new($sformatf("src_fifo[%0d]",i),this);
	foreach(dst_fifo[i])
		dst_fifo[i]=new($sformatf("dst_fifo[%0d]",i),this);
	
endfunction

task router_scoreboard::run_phase(uvm_phase phase);
	forever
		begin
		fork
			begin
					src_fifo[0].get(w_xtn);
			end
			begin
				fork
					dst_fifo[0].get(r_xtn);
					dst_fifo[1].get(r_xtn);
					dst_fifo[2].get(r_xtn);
				join_any;
				disable fork;
			end
		join
		user_compare(w_xtn,r_xtn);
		router_src.sample();
		router_dst.sample();
		end
endtask

task router_scoreboard::user_compare(write_xtn w_xtn,read_xtn r_xtn);
		`uvm_info("router_scoreboard",$sformatf("printing from scoreboard:w_xtn \n %s",w_xtn.sprint()),UVM_LOW)
		
		`uvm_info("router_scoreboard",$sformatf("printing from scoreboard:r_xtn \n %s",r_xtn.sprint()),UVM_LOW)
		
		if(w_xtn.Header == r_xtn.Header)
		begin
			`uvm_info("Header","Header matched",UVM_LOW)

		if(w_xtn.pl == r_xtn.pl)
		begin
			`uvm_info("pl","pl matched",UVM_LOW)

		if(w_xtn.parity == r_xtn.parity)
			`uvm_info("parity","parity matched",UVM_LOW)

		else
			`uvm_error("parity","parity mismatched")
		end

		else 
			`uvm_error("pl","pl mismatched")
		end
		else 
			`uvm_error("Header","Header mismatched")
		
endtask



