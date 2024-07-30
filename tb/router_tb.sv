class router_env extends uvm_env;

  `uvm_component_utils(router_env)
  
  router_src_top src_top;
  router_dst_top dst_top;


 router_virtual_sequencer v_sequencer;

 router_scoreboard sb;

  router_env_config env_cfg;
  
extern function new(string name = "router_env" , uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass


//------------------------------------------------------------------------------------//

  function router_env::new(string name = "router_env", uvm_component parent);
    super.new(name,parent);
  endfunction
  
  function void router_env::build_phase(uvm_phase phase);
   
super.build_phase(phase);

   if(!uvm_config_db#(router_env_config)::get(this,"","router_env_config",env_cfg))
	`uvm_fatal("ENV","fail")
    
    if(env_cfg.has_src_agent)
    begin  
  
    src_top=router_src_top::type_id::create("src_top",this);
    
    end
    
    if(env_cfg.has_dst_agent)
    begin
    
    dst_top=router_dst_top::type_id::create("dst_top",this);
    
    end
    
    
    
   if(env_cfg.has_virtual_sequencer)
      
        v_sequencer=router_virtual_sequencer::type_id::create("v_sequencer",this);
        
      if(env_cfg.has_scoreboard)
        
        sb=router_scoreboard::type_id::create("sb",this);
  
  endfunction
    
    
  function void router_env::connect_phase(uvm_phase phase);
    super.connect_phase(phase);

	if(env_cfg.has_virtual_sequencer)
	begin
		if(env_cfg.has_src_agent)
			foreach(src_top.src_agent[i])
				v_sequencer.src_seqrh[i]=src_top.src_agent[i].src_seqrh;
		
		if(env_cfg.has_dst_agent)
			foreach(dst_top.dst_agent[i])
				v_sequencer.dst_seqrh[i]=dst_top.dst_agent[i].dst_seqrh;
	end	


	if(env_cfg.has_scoreboard)
	begin
		foreach(src_top.src_agent[i])
			src_top.src_agent[i].src_monh.monitor_port.connect(sb.src_fifo[i].analysis_export);
		foreach(dst_top.dst_agent[i])
			dst_top.dst_agent[i].dst_monh.monitor_port.connect(sb.dst_fifo[i].analysis_export);
	end
   endfunction  
