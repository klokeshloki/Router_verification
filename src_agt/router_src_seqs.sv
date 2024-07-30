class router_src_seqs extends uvm_sequence #(write_xtn);
	`uvm_object_utils(router_src_seqs)

router_env_config env_cfg;

extern function new(string name = "router_src_seqs");
endclass

//----------------------------------------------------------------------//

function router_src_seqs::new(string name = "router_src_seqs");
	super.new(name);
endfunction
//------------------------------------------------------------------------//

class router_small_pkt extends router_src_seqs;
	`uvm_object_utils(router_small_pkt)
bit[1:0]addr;

extern function new(string name = "router_small_pkt");
extern task body();
endclass

//----------------------------------------------------------------------------//
function router_small_pkt::new(string name = "router_small_pkt");
	super.new(name);
endfunction
	
task router_small_pkt::body();
	
		begin
			req=write_xtn::type_id::create("req");
			uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit",addr);
			start_item(req);
			assert(req.randomize()with {Header[1:0]==addr;Header[7:2] inside {[1:13]};});
			`uvm_info("router_small_pkt",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
			finish_item(req);
		end
endtask

//-------------------------------------------------------------------------------------------------------------------//

class router_medium_pkt extends router_src_seqs;

	`uvm_object_utils(router_medium_pkt)

bit[1:0] addr;

extern function new(string name = "router_medium_pkt");
extern task body();
endclass

//----------------------------------------------------------------------------------------------------------------//

function router_medium_pkt::new(string name = "router_medium_pkt");
	super.new(name);
endfunction

task router_medium_pkt::body();
		begin
			req=write_xtn::type_id::create("req");
			uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit",addr);
			start_item(req);
			assert(req.randomize()with {Header[1:0]==addr;Header[7:2] inside {[14:30]};});
			`uvm_info("router_small_pkt",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
			finish_item(req);
		end
endtask

//--------------------------------------------------------------------------------------------------------------------//	

class router_large_pkt extends router_src_seqs;

	`uvm_object_utils(router_large_pkt)

bit[1:0] addr;

extern function new(string name = "router_large_pkt");
extern task body();
endclass

//----------------------------------------------------------------------------------------------------------------//

function router_large_pkt::new(string name = "router_large_pkt");
	super.new(name);
endfunction

task router_large_pkt::body();
		begin
			req=write_xtn::type_id::create("req");
			uvm_config_db#(bit[1:0])::get(null,get_full_name(),"bit",addr);
			start_item(req);
			assert(req.randomize()with {Header[1:0]==addr;Header[7:2] inside {[31:63]};});
			`uvm_info("router_small_pkt",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
			finish_item(req);
		end
endtask


//--------------------------------------------------------------------------------------------------------------------//	
