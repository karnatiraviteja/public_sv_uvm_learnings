/*
****************** Static and Automatic Methods ******************

--------------------|--------------------------------------|
Context             |   Default Lifetime
--------------------|--------------------------------------|
module / interface  |   Static
class (UVM)         |   Automatic
`program` block     |   Automatic
`package` functions |   Static (unless declared automatic)
module task/function|	Static
class task/function |	Automatic
--------------------|--------------------------------------|
1. https://verificationacademy.com/forums/t/what-is-the-exact-difference-between-static-tasks-functions-and-automatic-tasks-functions-please-explain-with-a-clear-example/31014

    o task/function in module is always static at the default. task/function in class is always automatic at default.
*/ 

`include "uvm_macros.svh"
import uvm_pkg::*;

class static_automatic_c;
    task add_m(int e, int f);                             // This method is by default automatic in nature.
        #2;
        `uvm_info("static_automatic", $sformatf("Value of e : %0d, f : %0d, sum : %0d", e, f, e+f), UVM_LOW)
    endtask
endclass

module static_automatic;

    task add(int a, int b);                               // This method is by default static in nature. Only one shared storage.
        #2;
        `uvm_info("static_automatic", $sformatf("Value of a : %0d, b : %0d, sum : %0d", a, b, a+b), UVM_LOW)
    endtask
    
    task automatic add_automatic(int c, int d);           // Explicitly declaring this method as automatic. Each call gets separate storage.
        #2;
        `uvm_info("static_automatic", $sformatf("Value of c : %0d, d : %0d, sum : %0d", c, d, c+d), UVM_LOW)
    endtask

    static_automatic_c m_sa_h = new();

    initial begin
        fork
            begin
                add(3,4);
            end
            begin
                #1;
                add(5,6);
            end
        join

        fork
            begin
                add_automatic(3,4);
            end
            begin
                #1;
                add_automatic(5,6);
            end
        join

        fork
            begin
                m_sa_h.add_m(3,4);
            end
            begin
                #1;
                m_sa_h.add_m(5,6);
            end
        join
    end

endmodule

/************** OUTPUT **************
# UVM_INFO static_automatic.sv(33) @ 2: reporter [static_automatic] Value of a : 5, b : 6, sum : 11
# UVM_INFO static_automatic.sv(33) @ 3: reporter [static_automatic] Value of a : 5, b : 6, sum : 11
# UVM_INFO static_automatic.sv(38) @ 5: reporter [static_automatic] Value of c : 3, d : 4, sum : 7
# UVM_INFO static_automatic.sv(38) @ 6: reporter [static_automatic] Value of c : 5, d : 6, sum : 11
# UVM_INFO static_automatic.sv(25) @ 8: reporter [static_automatic] Value of e : 3, f : 4, sum : 7
# UVM_INFO static_automatic.sv(25) @ 9: reporter [static_automatic] Value of e : 5, f : 6, sum : 11
#  quit
# End time: 15:41:07 on Apr 04,2026, Elapsed time: 0:00:17
# Errors: 0, Warnings: 0
************************************/ 
