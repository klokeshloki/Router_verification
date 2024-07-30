class router_src_monitor extends uvm_monitor;

	`uvm_component_utils(router_src_monitor)

virtual router_src_if.SRC_MON_MP vif;

router_src_agent_config src_agent_cfg;
write_xtn xtn;

uvm_analysis_port#(write_xtn) monitor_port;

extern function new (string name = "router_src_monitor" , uvm_component parent);
extern function void build_phase (uvm_phase  phase );
extern function void connect_phase (uvm_phase phase); 
extern task run_phase(uvm_phase phase);
extern task collect_data();
extern function void report_phase(uvm_phase phase);
endclass

//----------------------------------------------------------------------------//


function router_src_monitor::new(string name = "router_src_monitor", uvm_component parent);
	super.new(name ,parent);
		monitor_port =new("monitor_port",this);
endfunction

function void router_src_monitor::build_phase(uvm_phase phase);
	super.build_phase(phase);
	uvm_config_db#(router_src_agent_config)::get(this,"","router_src_agent_config",src_agent_cfg);
endfunction

function void router_src_monitor::connect_phase(uvm_phase phase);
		vif=src_agent_cfg.vif;
endfunction

task router_src_monitor::run_phase(uvm_phase phase);
		forever
			 collect_data();
endtask

task router_src_monitor::collect_data();
	$display("mon start");
		xtn=write_xtn::type_id::create("xtn");
	
		@(vif.src_mon_cb);
		while(vif.src_mon_cb.pkt_vld!==1)
		@(vif.src_mon_cb);
		while(vif.src_mon_cb.busy===1)
		@(vif.src_mon_cb);
		xtn.Header=vif.src_mon_cb.data_in;
		@(vif.src_mon_cb);
		xtn.pl=new[xtn.Header[7:2]];

		foreach(xtn.pl[i])
			begin
				while(vif.src_mon_cb.busy===1)
				@(vif.src_mon_cb);
				xtn.pl[i]=vif.src_mon_cb.data_in;
				@(vif.src_mon_cb);
			end
		while(vif.src_mon_cb.busy===1)
		@(vif.src_mon_cb);
		xtn.parity=vif.src_mon_cb.data_in;
		
		repeat(2)
		@(vif.src_mon_cb);
		xtn.error=vif.src_mon_cb.error;
		`uvm_info("router_src_monitor",$sformatf("printing from monitor \n %s",xtn.sprint()),UVM_LOW)
		monitor_port.write(xtn);
		
		src_agent_cfg.mon_rcvd_xtn_cnt++;
endtask

function void router_src_monitor::report_phase(uvm_phase phase);
		`uvm_info(get_type_name(),$sformatf("report : monitor_src collected %0d transactions",src_agent_cfg.mon_rcvd_xtn_cnt),UVM_LOW)
endfunction
