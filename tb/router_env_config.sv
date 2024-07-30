class router_env_config extends uvm_object;

    `uvm_object_utils(router_env_config)
	

// data members

//bit has_functional_coverage = 0;
//bit has_src_agent_functional_coverage = 0;
bit has_scoreboard = 1;

bit has_src_agent = 1;
bit has_dst_agent = 1;

bit has_virtual_sequencer = 1;

	router_src_agent_config r_src_agent_cfg[];
	router_dst_agent_config r_dst_agent_cfg[];

int no_of_src_agents=1;
int no_of_dst_agents=3;

 //bit[1:0]addr=$urandom_range(0,2);
	
extern function new(string name = "router_env_config");
endclass

//-------------------------------------------------------------------//
	function router_env_config::new(string name = "router_env_config");
		super.new(name);
	endfunction


	

