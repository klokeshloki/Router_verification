class read_xtn extends uvm_sequence_item;

	`uvm_object_utils(read_xtn)

bit[7:0]Header;
bit[7:0]pl[];
bit[7:0]parity;
rand bit[4:0] no_of_cycles;

extern function new (string name = "read_xtn");
extern function void do_print(uvm_printer printer);
endclass
//--------------------------------------------------------------------------//
	function read_xtn::new(string name = "read_xtn");
		super.new(name);
	endfunction

	function void read_xtn::do_print(uvm_printer printer);
		super.do_print(printer);
	
	printer.print_field("Header",this.Header,8,UVM_DEC);
	foreach(pl[i])
	printer.print_field($sformatf("payload[%0d]",i),this.pl[i],8,UVM_DEC);
	printer.print_field("parity",this.parity,8,UVM_DEC);
	printer.print_field("no_of_cycles",this.no_of_cycles,5,UVM_DEC);
	
	endfunction

