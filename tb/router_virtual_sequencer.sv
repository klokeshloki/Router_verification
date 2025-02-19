class router_virtual_sequencer extends uvm_sequencer #(uvm_sequence_item);

	`uvm_component_utils(router_virtual_sequencer)


router_src_sequencer src_seqrh[];
router_dst_sequencer dst_seqrh[];

router_env_config env_cfg;

extern function new (string name = "router_virtual_sequencer", uvm_component parent);
extern function void build_phase(uvm_phase phase);
endclass

//-----------------------------------------------------------------------------------------//


	function router_virtual_sequencer::new(string name = "router_virtual_sequencer", uvm_component parent);
		super.new(name , parent);
	endfunction


	function void router_virtual_sequencer::build_phase(uvm_phase phase);
	
	uvm_config_db#(router_env_config)::get(this,"","router_env_config",env_cfg);

		super.build_phase(phase);
	src_seqrh=new[env_cfg.no_of_src_agents];
	dst_seqrh=new[env_cfg.no_of_dst_agents];
	
	endfunction
	


