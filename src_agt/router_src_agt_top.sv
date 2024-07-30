class router_src_top extends uvm_env;

	`uvm_component_utils(router_src_top)

router_src_agent src_agent[];
router_env_config env_cfg;
router_src_agent_config src_agent_cfg[];

function new(string name = "router_src_top",uvm_component parent );
	super.new(name,parent);
endfunction
	
virtual function void build_phase (uvm_phase phase);
	super.build_phase(phase);
	if(!uvm_config_db#(router_env_config)::get(this,"","router_env_config",env_cfg))
	`uvm_fatal(get_type_name(),"check the strings")

	src_agent=new[env_cfg.no_of_src_agents];
	foreach(src_agent[i])
		begin
		src_agent[i]=router_src_agent::type_id::create($sformatf("src_agent[%0d]",i),this);
		uvm_config_db#(router_src_agent_config)::set(this,$sformatf("src_agent[%0d]*",i),"router_src_agent_config",env_cfg.r_src_agent_cfg[i]);
		end
endfunction

endclass



