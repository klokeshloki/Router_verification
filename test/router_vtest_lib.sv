class router_base_test extends uvm_test;

	`uvm_component_utils(router_base_test)

// Handels

	router_env r_env;
	router_env_config env_cfg;

	router_src_agent_config r_src_cfg[];
	router_dst_agent_config r_dst_cfg[];


//local variables

	bit has_v_seqr=1;
  bit has_sb=1;
  bit has_src_agent=1;
  bit has_dst_agent=1;

  int no_of_src_agents=1;
  int no_of_dst_agents=3;
  
  

extern function new(string name ="router_base_test", uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern function void config_router();
extern function void end_of_elaboration_phase(uvm_phase phase);

endclass


//-----------------------------------------------------------------------------//

  function router_base_test::new(string name = "router_base_test", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  
  function void router_base_test::config_router();
    
	if(has_src_agent)
	begin    
    	r_src_cfg=new[no_of_src_agents];

	foreach(r_src_cfg[i])
	begin
		r_src_cfg[i]=router_src_agent_config::type_id::create($sformatf("r_src_cfg[%0d]",i));
		uvm_config_db#(virtual router_src_if)::get(this,"",$sformatf("vif_%0d",i),r_src_cfg[i].vif);

		r_src_cfg[i].is_active=UVM_ACTIVE;

		env_cfg.r_src_agent_cfg[i]=r_src_cfg[i];
	end
	end

	if(has_dst_agent)
	begin
		r_dst_cfg=new[no_of_dst_agents];

	foreach(r_dst_cfg[i])
	begin
		r_dst_cfg[i]=router_dst_agent_config::type_id::create($sformatf("r_dst_cfg[%0d]",i));
		uvm_config_db#(virtual router_dst_if)::get(this,"",$sformatf("vif_%0d",i),r_dst_cfg[i].vif);
		
		r_dst_cfg[i].is_active=UVM_ACTIVE;

		env_cfg.r_dst_agent_cfg[i]=r_dst_cfg[i];
	end
	end
	
      env_cfg.has_virtual_sequencer=has_v_seqr;
      env_cfg.has_scoreboard=has_sb;
      env_cfg.has_src_agent=has_src_agent;
      env_cfg.has_dst_agent=has_dst_agent;
      env_cfg.no_of_src_agents=no_of_src_agents;
      env_cfg.no_of_dst_agents=no_of_dst_agents;
      
  endfunction

	function void router_base_test::build_phase(uvm_phase phase);
		
	env_cfg=router_env_config::type_id::create("env_cfg");

	if(has_src_agent)
		env_cfg.r_src_agent_cfg=new[no_of_src_agents];
     
	if(has_dst_agent)
		env_cfg.r_dst_agent_cfg=new[no_of_dst_agents];

   	 config_router();
	uvm_config_db#(router_env_config)::set(this,"*","router_env_config",env_cfg);

	super.build_phase(phase);

	r_env=router_env::type_id::create("r_env",this);
	
	
	endfunction

	function void router_base_test::end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
	
	uvm_top.print_topology;
	endfunction



//------------------------------------------------------------------------------------//
class router_small_pkt_test extends router_base_test;
	`uvm_component_utils(router_small_pkt_test)


v_seqs_1 small_pkt;
bit [1:0] addr;
//=$urandom_range(0,2);


extern function new (string name = "router_small_pkt_test",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

//-----------------------------------------------------------------------------//

	function router_small_pkt_test::new(string name = "router_small_pkt_test",uvm_component parent);
		super.new(name,parent);
	endfunction
	

	function void router_small_pkt_test::build_phase(uvm_phase phase);
		super.build_phase(phase);
	//	addr=$urandom_range(0,2);

	//uvm_config_db#(bit[1:0])::set(this,"*","bit",addr);

	endfunction

	task router_small_pkt_test::run_phase(uvm_phase phase);
	
	//raise objection
    phase.raise_objection(this);

		
repeat(10)
begin
 
	addr=$urandom_range(0,2);

	uvm_config_db#(bit[1:0])::set(this,"*","bit",addr);

	small_pkt=v_seqs_1::type_id::create("small_pkt");

	small_pkt.start(r_env.v_sequencer);


end
    
#2000;
	//drop objection
    phase.drop_objection(this);
	endtask   
//---------------------------------------------------------------------------------------//

class router_medium_pkt_test extends router_base_test;
	`uvm_component_utils(router_medium_pkt_test)


v_seqs_2 medium_pkt;
bit [1:0] addr;
//=$urandom_range(0,2);


extern function new (string name = "router_medium_pkt_test",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

//-----------------------------------------------------------------------------//

	function router_medium_pkt_test::new(string name = "router_medium_pkt_test",uvm_component parent);
		super.new(name,parent);
	endfunction
	

	function void router_medium_pkt_test::build_phase(uvm_phase phase);
		super.build_phase(phase);
	//	addr=$urandom_range(0,2);

	//uvm_config_db#(bit[1:0])::set(this,"*","bit",addr);

	endfunction

	task router_medium_pkt_test::run_phase(uvm_phase phase);
	
	//raise objection
    phase.raise_objection(this);

		
repeat(10)
begin
 
	addr=$urandom_range(0,2);

	uvm_config_db#(bit[1:0])::set(this,"*","bit",addr);

	medium_pkt=v_seqs_2::type_id::create("medium_pkt");

	medium_pkt.start(r_env.v_sequencer);


end
    
#2000;
	//drop objection
    phase.drop_objection(this);
	endtask   
//---------------------------------------------------------------------------------------//


class router_large_pkt_test extends router_base_test;
	`uvm_component_utils(router_large_pkt_test)


v_seqs_3 large_pkt;
bit [1:0] addr;
//=$urandom_range(0,2);


extern function new (string name = "router_large_pkt_test",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

//-----------------------------------------------------------------------------//

	function router_large_pkt_test::new(string name = "router_large_pkt_test",uvm_component parent);
		super.new(name,parent);
	endfunction
	

	function void router_large_pkt_test::build_phase(uvm_phase phase);
		super.build_phase(phase);
	//	addr=$urandom_range(0,2);

	//uvm_config_db#(bit[1:0])::set(this,"*","bit",addr);

	endfunction

	task router_large_pkt_test::run_phase(uvm_phase phase);
	
	//raise objection
    phase.raise_objection(this);

		
repeat(10)
begin
 
	addr=$urandom_range(0,2);

	uvm_config_db#(bit[1:0])::set(this,"*","bit",addr);

	large_pkt=v_seqs_3::type_id::create("large_pkt");

	large_pkt.start(r_env.v_sequencer);


end
    
#2000;
	//drop objection
    phase.drop_objection(this);
	endtask   
//---------------------------------------------------------------------------------------//


class router_error_pkt_test extends router_base_test;
	`uvm_component_utils(router_error_pkt_test)


v_seqs_4 error_pkt;
bit [1:0] addr;
//=$urandom_range(0,2);


extern function new (string name = "router_error_pkt_test",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
endclass

//-----------------------------------------------------------------------------//

	function router_error_pkt_test::new(string name = "router_error_pkt_test",uvm_component parent);
		super.new(name,parent);
	endfunction
	

	function void router_error_pkt_test::build_phase(uvm_phase phase);
		super.build_phase(phase);
	//	addr=$urandom_range(0,2);

	//uvm_config_db#(bit[1:0])::set(this,"*","bit",addr);

	endfunction

	task router_error_pkt_test::run_phase(uvm_phase phase);
	
	//raise objection
    phase.raise_objection(this);

		
repeat(10)
begin
 
	addr=$urandom_range(0,2);

	uvm_config_db#(bit[1:0])::set(this,"*","bit",addr);

	error_pkt=v_seqs_4::type_id::create("error_pkt");

	error_pkt.start(r_env.v_sequencer);


end
    
#2000;
	//drop objection
    phase.drop_objection(this);
	endtask   
//---------------------------------------------------------------------------------------//

