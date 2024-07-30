class router_src_driver extends uvm_driver #(write_xtn);

	`uvm_component_utils(router_src_driver)

virtual router_src_if.SRC_DRV_MP vif;

router_src_agent_config src_agent_cfg;

extern function new (string name = "router_src_driver", uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
extern task run_phase(uvm_phase phase);
extern task drive_to_dut(write_xtn xtn);
extern function void report_phase(uvm_phase phase);
endclass
//------------------------------------------------------------------------------//

function router_src_driver::new( string name = "router_src_driver", uvm_component parent);
	super.new(name,parent);
endfunction

function void router_src_driver::build_phase(uvm_phase phase);
	super.build_phase(phase);
	uvm_config_db#(router_src_agent_config)::get(this,"","router_src_agent_config",src_agent_cfg);

endfunction

function void router_src_driver::connect_phase(uvm_phase phase);
	vif=src_agent_cfg.vif;
endfunction


task router_src_driver::run_phase(uvm_phase phase);
		@(vif.src_drv_cb);
		vif.src_drv_cb.reset<=1'b0;
		@(vif.src_drv_cb);
		vif.src_drv_cb.reset<=1'b1;
		forever
			begin
				seq_item_port.get_next_item(req);
				drive_to_dut(req);
				seq_item_port.item_done();
			end
endtask
	
task router_src_driver::drive_to_dut(write_xtn xtn);
		//`uvm_info("router_src_driver",$sformatf("printing from driver \n %s", xtn.sprint()),UVM_LOW)
	$display("drv start");

		@(vif.src_drv_cb);
		while(vif.src_drv_cb.busy!==0)
			@(vif.src_drv_cb);
		vif.src_drv_cb.pkt_vld<=1'b1;
		vif.src_drv_cb.data_in<=xtn.Header;
		@(vif.src_drv_cb);
		foreach(xtn.pl[i])
			begin
				while(vif.src_drv_cb.busy!==0)
					@(vif.src_drv_cb);
				vif.src_drv_cb.data_in<=xtn.pl[i];
				@(vif.src_drv_cb);
			end
		while(vif.src_drv_cb.busy!==0)
			@(vif.src_drv_cb);
		vif.src_drv_cb.pkt_vld<=1'b0;
		vif.src_drv_cb.data_in<=xtn.parity;
	
		repeat(2)
		@(vif.src_drv_cb);
		xtn.error =vif.src_drv_cb.error;
		`uvm_info("router_src_driver",$sformatf("printing from driver \n %s", xtn.sprint()),UVM_LOW)

		src_agent_cfg.drv_rcvd_xtn_cnt++;
endtask

function void router_src_driver::report_phase(uvm_phase phase);
		`uvm_info(get_type_name(),$sformatf("report : router_src_driver sent %0d transactions",src_agent_cfg.drv_rcvd_xtn_cnt),UVM_LOW)
endfunction
