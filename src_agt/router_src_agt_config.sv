class router_src_agent_config extends uvm_object;

	`uvm_object_utils(router_src_agent_config)
	
// Declare the virtual interface handle for router_if as "vif"

virtual router_src_if vif;

uvm_active_passive_enum is_active = UVM_ACTIVE;


static int mon_rcvd_xtn_cnt=0;

static int drv_rcvd_xtn_cnt=0;


function new(string name = "router_src_agent_config");
	super.new(name);
endfunction

endclass
	

