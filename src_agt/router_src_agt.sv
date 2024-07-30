class router_src_agent extends uvm_agent;

	`uvm_component_utils(router_src_agent)

router_src_driver src_drvh;
router_src_sequencer src_seqrh;
router_src_monitor src_monh;
router_env_config env_cfg;
router_src_agent_config src_agent_cfg;

extern function new(string name = "router_src_agent",uvm_component parent);
extern function void build_phase (uvm_phase phase);
extern function void connect_phase (uvm_phase phase);
endclass
//-----------------------------------------------------------------------------------------------//
function router_src_agent::new(string name = "router_src_agent", uvm_component parent );
	super.new(name,parent);
endfunction

function void router_src_agent::build_phase(uvm_phase phase);
	super.build_phase(phase);
	
	if(!uvm_config_db#(router_src_agent_config)::get(this,"","router_src_agent_config",src_agent_cfg))
	`uvm_fatal(get_type_name(),"check the strings") 

	src_monh=router_src_monitor::type_id::create("src_monh",this);

	if (src_agent_cfg.is_active==UVM_ACTIVE)
		begin
			src_seqrh=router_src_sequencer::type_id::create("src_seqrh",this);
			src_drvh=router_src_driver::type_id::create("src_drvh",this);
		end
endfunction


function void router_src_agent::connect_phase(uvm_phase phase);
		if(src_agent_cfg.is_active==UVM_ACTIVE)
		begin
		src_drvh.seq_item_port.connect(src_seqrh.seq_item_export);
  		end
endfunction


