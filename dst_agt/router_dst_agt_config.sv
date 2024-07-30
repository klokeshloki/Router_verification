class router_dst_agent_config extends uvm_object;

	`uvm_object_utils(router_dst_agent_config)



// Declare the virtual interface handle for router_if as "vif"
virtual router_dst_if vif;


uvm_active_passive_enum is_active = UVM_ACTIVE;


// Declare the mon_rcvd_xtn_cnt as static int and initialize it to zero  
static int mon_rcvd_xtn_cnt = 0;

// Declare the drv_data_sent_cnt as static int and initialize it to zero 
static int drv_rcvd_xtn_cnt = 0;

//methods

extern function new(string name = "router_dst_agent_config");

endclass

	function router_dst_agent_config::new(string name = "router_dst_agent_config");
		super.new(name);
	endfunction





