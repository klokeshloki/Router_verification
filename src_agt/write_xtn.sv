class write_xtn extends uvm_sequence_item;

	`uvm_object_utils(write_xtn)

rand bit[7:0]Header;
rand bit[7:0]pl[];
     bit[7:0]parity;
     bit error;
//constraints
constraint c_addr{Header[1:0]!=2'b11;}
constraint c_pl_size{pl.size==Header[7:2];}
constraint c3{Header[7:2]!=0;}

extern function new (string name = "write_xtn");
extern function void post_randomize();
extern function void do_print(uvm_printer printer);
endclass

function write_xtn::new(string name = "write_xtn");
	super.new(name);
endfunction

function void write_xtn::post_randomize();
			parity=Header^8'b0;
		foreach(pl[i])
			parity=parity^pl[i];
endfunction

function void write_xtn::do_print(uvm_printer printer);
	super.do_print(printer);

	printer.print_field("Header",this.Header,8,UVM_DEC);
	foreach(pl[i])
	printer.print_field($sformatf("payload[%0d]",i),this.pl[i],8,UVM_DEC);
	printer.print_field("parity",this.parity,8,UVM_DEC);
	printer.print_field("error",this.error,1,UVM_DEC);
	
endfunction	

class error_xtn extends write_xtn;
	`uvm_object_utils(error_xtn)

function new(string name="error_xtn");
	super.new(name);
endfunction

function void post_randomize();
	parity=$random;
endfunction

endclass

