/*
****************** Functions and Tasks ******************
*/

`include "uvm_macros.svh"
import uvm_pkg::*;

module functions_and_tasks;

    bit comp_res;

    function bit compare_reg(input int wr, rd);
        if(rd == wr) begin
            `uvm_info("[functions_and_tasks]", $sformatf("PASS : wr = 32'h%0h, rd = 32'h%0h", wr, rd), UVM_LOW)
            return 0;
        end
        else begin
            `uvm_info("[functions_and_tasks]", $sformatf("FAIL : wr = 32'h%0h, rd = 32'h%0h", wr, rd), UVM_LOW)
            return 1;
        end
    endfunction

    initial begin
        `uvm_info("[functions_and_tasks]", $sformatf("Executing random case"), UVM_LOW)
        repeat(5) begin
            comp_res = compare_reg($urandom_range(12,14), $urandom_range(12,14));
        end
    end

endmodule
