class router_dst_top extends uvm_env;

	`uvm_component_utils(router_dst_top)

router_dst_agent dst_agent[];
router_env_config env_cfg;
router_dst_agent_config dst_agent_cfg[];

	function new(string name = "router_dst_top", uvm_component parent);
		super.new(name,parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
			
	uvm_config_db#(router_env_config)::get(this,"","router_env_config",env_cfg);

	dst_agent=new[env_cfg.no_of_dst_agents];
	//dst_agent_cfg=new[env_cfg.no_of_dst_agents];
	foreach(dst_agent[i])
	begin
		//dst_agent_cfg[i]=env_cfg.r_dst_agent_cfg[i];

	dst_agent[i]=router_dst_agent::type_id::create($sformatf("dst_agent[%0d]",i),this);
	
	uvm_config_db#(router_dst_agent_config)::set(this,$sformatf("dst_agent[%0d]*",i),"router_dst_agent_config",env_cfg.r_dst_agent_cfg[i]);
	end
	super.build_phase(phase);

	endfunction

endclass
