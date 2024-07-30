class router_dst_agent extends uvm_agent;

	`uvm_component_utils(router_dst_agent)


router_dst_driver dst_drvh;
router_dst_sequencer dst_seqrh;
router_dst_monitor dst_monh;
router_env_config env_cfg;
router_dst_agent_config dst_agent_cfg;

extern function new (string name = "router_dst_agent", uvm_component parent );
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass

	function router_dst_agent::new(string name = "router_dst_agent", uvm_component parent);
		super.new(name ,parent);
	endfunction

	 function void router_dst_agent::build_phase(uvm_phase phase);
		super.build_phase(phase);
	if(!uvm_config_db#(router_dst_agent_config)::get(this,"","router_dst_agent_config",dst_agent_cfg))
		`uvm_fatal(get_type_name(),"check the string")
	
	dst_monh=router_dst_monitor::type_id::create("dst_monh",this);

	if(dst_agent_cfg.is_active==UVM_ACTIVE)
	begin
		dst_seqrh=router_dst_sequencer::type_id::create("dst_seqrh",this);
		dst_drvh=router_dst_driver::type_id::create("dst_drvh",this);
	end
	endfunction

	function void router_dst_agent::connect_phase(uvm_phase phase);
		if(dst_agent_cfg.is_active==UVM_ACTIVE)
		begin
		dst_drvh.seq_item_port.connect(dst_seqrh.seq_item_export);
		end
	endfunction
