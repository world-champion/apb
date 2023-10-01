
class apb_base_seq extends uvm_sequence #(apb_item);
  
  // Required macro for sequences automation
  `uvm_object_utils(apb_base_seq)

  // Constructor
  function new(string name="apb_base_seq");
    super.new(name);
  endfunction

  task pre_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.raise_objection(this, get_type_name());
      `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
    end
  endtask : pre_body

  task post_body();
    uvm_phase phase;
    `ifdef UVM_VERSION_1_2
      // in UVM1.2, get starting phase from method
      phase = get_starting_phase();
    `else
      phase = starting_phase;
    `endif
    if (phase != null) begin
      phase.drop_objection(this, get_type_name());
      `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
    end
  endtask : post_body

endclass :apb_base_seq
class rnd_in_itr_seq extends apb_base_seq;
 `uvm_object_utils(rnd_in_itr_seq)
 
 function new(string name="rnd_in_itr_seq");
 super.new(name);
 endfunction: new
  int iti = 5;

 // No. of iterations

 task body();
 `uvm_info(get_type_name(), $sformatf("Executing rnd_in_itr_seq sequence with %d iterations",iti), UVM_LOW)

    repeat(iti) begin
        `uvm_do(req)
    //`uvm_info ("Response Fields", $sformatf("Req = %h", req), UVM_LOW)
 end
 endtask: body

//  apb_seq_item req;
 
// task body();
//     req = apb_seq_item::type_id::create("req", this);
//     repeat(iti)
//         `uvm_do(req)

//     // begin
//     // start_item(req);
//     // assert (!req.randomize() with {addr inside {[32`h1000_0000:32`h1000_001C]};}) begin
//     // `uvm_error("Body", "Randomization Error");
//     // end 
//     // finish_item(req);
//     `uvm_info ("Response Fields", $sformatf("Read Data = %h", req.rdata), UVM_LOW)
// //  end
//  endtask: body
 
endclass: rnd_in_itr_seq