class router_dst_driver extends uvm_driver #(read_xtn);

	`uvm_component_utils(router_dst_driver)

virtual router_dst_if.DST_DRV_MP vif;

router_dst_agent_config dst_agent_cfg;



extern function new (string name = "router_dst_driver", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task driving_to_dut(read_xtn xtn);
extern function void report_phase(uvm_phase phase);
endclass
//------------------------------------------------------------------------------//

	function router_dst_driver::new( string name = "router_dst_driver", uvm_component parent);
		super.new(name,parent);
	endfunction

	function void router_dst_driver::build_phase(uvm_phase phase);
		super.build_phase(phase);
	uvm_config_db#(router_dst_agent_config)::get(this,"","router_dst_agent_config",dst_agent_cfg);

	endfunction

	function void router_dst_driver::connect_phase(uvm_phase phase);
		vif=dst_agent_cfg.vif;
	endfunction

  task router_dst_driver::run_phase(uvm_phase phase);
    
    forever
      begin
        seq_item_port.get_next_item(req);
        driving_to_dut(req);
        seq_item_port.item_done();
      end
      
  endtask
  
  task router_dst_driver::driving_to_dut(read_xtn xtn);
    
      @(vif.dst_drv_cb);
      while(vif.dst_drv_cb.vld_out!==1)
        @(vif.dst_drv_cb);
      repeat(xtn.no_of_cycles)
        @(vif.dst_drv_cb);
      vif.dst_drv_cb.rd_enb<=1'b1;
      while(vif.dst_drv_cb.vld_out!==0)
        @(vif.dst_drv_cb);
      vif.dst_drv_cb.rd_enb<=1'b0;
      	`uvm_info("router_dst_driver",$sformatf("printing from driver \n %s", xtn.sprint()),UVM_LOW)
	repeat(2)
	@(vif.dst_drv_cb);
       
       dst_agent_cfg.drv_rcvd_xtn_cnt++;
  endtask
  
  function void router_dst_driver::report_phase(uvm_phase phase);
		`uvm_info(get_type_name(),$sformatf("report : router_dst_driver sent %0d transactions",dst_agent_cfg.drv_rcvd_xtn_cnt),UVM_LOW)
	endfunction
