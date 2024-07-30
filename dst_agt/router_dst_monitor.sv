class router_dst_monitor extends uvm_monitor;

	`uvm_component_utils(router_dst_monitor)

virtual router_dst_if.DST_MON_MP vif;

router_dst_agent_config dst_agent_cfg;

read_xtn xtn;

uvm_analysis_port#(read_xtn) monitor_port;

extern function new (string name = "router_dst_monitor" , uvm_component parent);
extern function void build_phase (uvm_phase  phase );
extern function void connect_phase (uvm_phase phase); 
extern task run_phase(uvm_phase phase);
extern task collect_data(read_xtn xtn);
extern function void report_phase(uvm_phase phase);
endclass

//----------------------------------------------------------------------------//


	function router_dst_monitor::new(string name = "router_dst_monitor", uvm_component parent);
		super.new(name ,parent);
		monitor_port =new("monitor_port",this);
	endfunction

	function void router_dst_monitor::build_phase(uvm_phase phase);
		super.build_phase(phase);
	uvm_config_db#(router_dst_agent_config)::get(this,"","router_dst_agent_config",dst_agent_cfg);
	endfunction

	function void router_dst_monitor::connect_phase(uvm_phase phase);
		vif=dst_agent_cfg.vif;
	endfunction

  task router_dst_monitor::run_phase(uvm_phase phase);
	forever
		collect_data(xtn);
  endtask

	task router_dst_monitor::collect_data(read_xtn xtn);
    xtn=read_xtn::type_id::create("xtn");
  
    @(vif.dst_mon_cb);
    while(vif.dst_mon_cb.rd_enb!==1)
      @(vif.dst_mon_cb);
	@(vif.dst_mon_cb);


    xtn.Header=vif.dst_mon_cb.data_out;
    xtn.pl=new[xtn.Header[7:2]];
	@(vif.dst_mon_cb);
    foreach(xtn.pl[i])
      begin
		while(vif.dst_mon_cb.rd_enb!==1)
		@(vif.dst_mon_cb);

        xtn.pl[i]=vif.dst_mon_cb.data_out;
        @(vif.dst_mon_cb);
      end
	while(vif.dst_mon_cb.rd_enb!==1)
	@(vif.dst_mon_cb);
    xtn.parity=vif.dst_mon_cb.data_out;
    
   //repeat(2)
    //@(vif.dst_mon_cb);

    `uvm_info("router_dst_monitor",$sformatf("printing from monitor \n %s",xtn.sprint()),UVM_LOW)
    monitor_port.write(xtn);
    
    dst_agent_cfg.mon_rcvd_xtn_cnt++;
  endtask
  
  	function void router_dst_monitor::report_phase(uvm_phase phase);
		`uvm_info(get_type_name(),$sformatf("report : monitor_dst collected %0d transactions",dst_agent_cfg.mon_rcvd_xtn_cnt),UVM_LOW)
	endfunction
