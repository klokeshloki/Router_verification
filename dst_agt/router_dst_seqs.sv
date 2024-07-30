class router_dst_seqs extends uvm_sequence #(read_xtn);
	`uvm_object_utils(router_dst_seqs)



extern function new(string name = "router_dst_seqs");
endclass

//----------------------------------------------------------------------//

	function router_dst_seqs::new(string name = "router_dst_seqs");
		super.new(name);
	endfunction
//------------------------------------------------------------------------//

class dst_seq_1 extends router_dst_seqs;
	`uvm_object_utils(dst_seq_1)

extern function new(string name = "dst_seq_1");
extern task body();
endclass

//----------------------------------------------------------------------------//
	function dst_seq_1::new(string name = "dst_seq_1");
		super.new(name);
	endfunction
	
	task dst_seq_1::body();

		begin
			req=read_xtn::type_id::create("req");
			start_item(req);
			assert(req.randomize()with {no_of_cycles inside{[1:25]};});
			`uvm_info("router_seq_1",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
			finish_item(req);
		end
	endtask
//-----------------------------------------------------------------------------------------------------------------//

class dst_seq_2 extends router_dst_seqs;
	`uvm_object_utils(dst_seq_2)

extern function new(string name = "dst_seq_1");
extern task body();
endclass

//----------------------------------------------------------------------------//
	function dst_seq_2::new(string name = "dst_seq_1");
		super.new(name);
	endfunction
	
	task dst_seq_2::body();

		begin
			req=read_xtn::type_id::create("req");
			start_item(req);
			assert(req.randomize()with {no_of_cycles==31;});
			`uvm_info("router_seq_1",$sformatf("printing from sequence \n %s", req.sprint()),UVM_LOW)
			finish_item(req);
		end
	endtask
//-----------------------------------------------------------------------------------------------------------------//
