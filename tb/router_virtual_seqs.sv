class router_virtual_seqs extends uvm_sequence #(uvm_sequence_item);

	`uvm_object_utils(router_virtual_seqs)
//----------physiscal sequencer-----------//
router_src_sequencer src_seqrh[];
router_dst_sequencer dst_seqrh[];
//-virtual sequencer----//
router_virtual_sequencer v_seqrh;



router_env_config env_cfg;

extern function new (string name = "router_virtual_seqs");
extern task body();
endclass


//-----------------------------------------------------------//

	function router_virtual_seqs::new(string name = "router_virtual_seqs");
		super.new(name );
	endfunction


	task router_virtual_seqs::body();

	uvm_config_db#(router_env_config)::get(null,get_full_name(),"router_env_config",env_cfg);
		
	src_seqrh=new[env_cfg.no_of_src_agents];
	dst_seqrh=new[env_cfg.no_of_dst_agents];

	
	assert($cast(v_seqrh,m_sequencer))
		else begin
		`uvm_error(" body", "error in v_sequencer $cast failed");
		end



	foreach(src_seqrh[i])
		src_seqrh[i]=v_seqrh.src_seqrh[i];

	foreach(dst_seqrh[i])
		dst_seqrh[i]=v_seqrh.dst_seqrh[i];


	endtask


//------------------------------------------------------------------------------------------------------------//

class v_seqs_1 extends router_virtual_seqs;

	`uvm_object_utils(v_seqs_1)

router_small_pkt small_seqs;
dst_seq_1  dst_seqs;



bit[1:0] addr;

extern function new(string name = "v_seqs_1");
extern task body();
endclass

//----------------------------------------------------------------------------------------------------------//

	function v_seqs_1::new(string name = "v_seqs_1");
		super.new(name);
	endfunction


	task v_seqs_1::body();
		super.body();
	
	uvm_config_db#(bit[1:0])::get(null,get_full_name,"bit",addr);	
	
	small_seqs=router_small_pkt::type_id::create("small_seqs");
	dst_seqs=dst_seq_1::type_id::create("dst_seqs");
fork
	if(env_cfg.has_src_agent)
		begin
			//for(int i=0;i<env_cfg.no_of_src_agents;i++)
			small_seqs.start(src_seqrh[0]);
		end


	if(env_cfg.has_dst_agent)
		begin
			if(addr==0)
  	 		dst_seqs.start(dst_seqrh[0]);
			else if(addr==1)
			dst_seqs.start(dst_seqrh[1]);
			else if(addr==2)
			dst_seqs.start(dst_seqrh[2]);
		end
join
	endtask

//-----------------------------------------------------------------------------------//

class v_seqs_2 extends router_virtual_seqs;

	`uvm_object_utils(v_seqs_2)

router_medium_pkt medium_seqs;
dst_seq_1  dst_seqs;



bit[1:0] addr;

extern function new(string name = "v_seqs_2");
extern task body();
endclass

//----------------------------------------------------------------------------------------------------------//

	function v_seqs_2::new(string name = "v_seqs_2");
		super.new(name);
	endfunction


	task v_seqs_2::body();
		super.body();
	
	uvm_config_db#(bit[1:0])::get(null,get_full_name,"bit",addr);	
	
	medium_seqs=router_medium_pkt::type_id::create("medium_seqs");
	dst_seqs=dst_seq_1::type_id::create("dst_seqs");
fork
	if(env_cfg.has_src_agent)
		begin
			//for(int i=0;i<env_cfg.no_of_src_agents;i++)
			medium_seqs.start(src_seqrh[0]);
		end


	if(env_cfg.has_dst_agent)
		begin
			if(addr==0)
  	 		dst_seqs.start(dst_seqrh[0]);
			else if(addr==1)
			dst_seqs.start(dst_seqrh[1]);
			else if(addr==2)
			dst_seqs.start(dst_seqrh[2]);
		end
join
	endtask
//--------------------------------------------------------------------------------------------//


class v_seqs_3 extends router_virtual_seqs;

	`uvm_object_utils(v_seqs_3)

router_large_pkt large_seqs;
dst_seq_1  dst_seqs;



bit[1:0] addr;

extern function new(string name = "v_seqs_3");
extern task body();
endclass

//----------------------------------------------------------------------------------------------------------//

	function v_seqs_3::new(string name = "v_seqs_3");
		super.new(name);
	endfunction


	task v_seqs_3::body();
		super.body();
	
	uvm_config_db#(bit[1:0])::get(null,get_full_name,"bit",addr);	
	
	large_seqs=router_large_pkt::type_id::create("large_seqs");
	dst_seqs=dst_seq_1::type_id::create("dst_seqs");
fork
	if(env_cfg.has_src_agent)
		begin
			//for(int i=0;i<env_cfg.no_of_src_agents;i++)
			large_seqs.start(src_seqrh[0]);
		end


	if(env_cfg.has_dst_agent)
		begin
			if(addr==0)
  	 		dst_seqs.start(dst_seqrh[0]);
			else if(addr==1)
			dst_seqs.start(dst_seqrh[1]);
			else if(addr==2)
			dst_seqs.start(dst_seqrh[2]);
		end
join
	endtask
//--------------------------------------------------------------------------------------------//

class v_seqs_4 extends router_virtual_seqs;

	`uvm_object_utils(v_seqs_4)

router_medium_pkt medium_seqs;
dst_seq_2  dst_seqs;



bit[1:0] addr;

extern function new(string name = "v_seqs_4");
extern task body();
endclass

//----------------------------------------------------------------------------------------------------------//

	function v_seqs_4::new(string name = "v_seqs_4");
		super.new(name);
	endfunction


	task v_seqs_4::body();
		super.body();
	
	uvm_config_db#(bit[1:0])::get(null,get_full_name,"bit",addr);	
	
	medium_seqs=router_medium_pkt::type_id::create("medium_seqs");
	dst_seqs=dst_seq_2::type_id::create("dst_seqs");
fork
	if(env_cfg.has_src_agent)
		begin
			//for(int i=0;i<env_cfg.no_of_src_agents;i++)
			medium_seqs.start(src_seqrh[0]);
		end


	if(env_cfg.has_dst_agent)
		begin
			if(addr==0)
  	 		dst_seqs.start(dst_seqrh[0]);
			else if(addr==1)
			dst_seqs.start(dst_seqrh[1]);
			else if(addr==2)
			dst_seqs.start(dst_seqrh[2]);
		end
join
	endtask
//--------------------------------------------------------------------------------------------//

















