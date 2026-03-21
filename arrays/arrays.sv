/*
****************** Arrays ******************
See below for more information
1. https://forkjoin.in/practice_questions_systemverilog/000_arrays/systemverilog_arrays.html
2. https://www.chipverify.com/systemverilog/systemverilog-arrays
3. https://vlsiverify.com/system-verilog/arrays/
4. https://verificationguide.com/systemverilog/systemverilog-arrays/

    o Static Arrays 
        o Fixed Size Arrays
        o Single Dimensional Arrays & Multi Dimensional Arrays
        o Packed and Unpacked Arrays
    o Dynamic Arrays
    o Associative Arrays
*/

`include "uvm_macros.svh"
import uvm_pkg::*;

module arrays;
    // Fixed Size Array : Array size if fixed through out the simulation
    int arr_single_d [5] = '{5{11}};
    int arr_multi_d  [4][2] = '{'{1, 2}, '{5, 6}, '{9, 10}, '{13, 14}};

    // Packed and Unpacked arrays
    bit [2:0] [3:0] packed_arr = {4'b1010, 4'b1100, 4'b1111};
    int unpacked_arr [2:0] [3:0] = '{'{16, 17, 18, 19}, '{20, 21, 22, 23}, '{24, 25, 26, 27}};

    // Dynamic Array
    int dyn_arr[];

    // Associative Array
    bit [7:0] asso_arr[int];

    initial begin
        // Print the size and default values of fixed size array
        `uvm_info("arrays", 
                  $sformatf("Size of arr_single_d array : %0d", $size(arr_single_d)),   // .size() is not supported for static (fixed-size) arrays
                  UVM_LOW)
        `uvm_info("arrays", 
                  $sformatf("Default arr_single_d values : %0p", arr_single_d), 
                  UVM_LOW)
        `uvm_info("arrays", 
                  $sformatf("Size of arr_multi_d array : %0d", $size(arr_multi_d)),     // .size() is not supported for static (fixed-size) arrays
                  UVM_LOW)
        `uvm_info("arrays", 
                  $sformatf("Default arr_multi_d values : %0p", arr_multi_d), 
                  UVM_LOW)

        // Updating the array values
        foreach(arr_single_d[i]) begin
            arr_single_d[i] = i * 5;
        end
        `uvm_info("arrays", 
                  $sformatf("Updated arr_single_d values : %0p", arr_single_d), 
                  UVM_LOW)
        foreach(arr_multi_d[j,k]) begin
            arr_multi_d[j][k] = j + k;
        end
        `uvm_info("arrays", 
                  $sformatf("Updated arr_multi_d values : %0p", arr_multi_d), 
                  UVM_LOW)

        // Print the size and default values of packed and unpacked arrays
        `uvm_info("arrays", 
                  $sformatf("Size of packed_arr array : %0d", $size(packed_arr)),       // .size() is not supported for static (fixed-size) arrays
                  UVM_LOW)
        `uvm_info("arrays", 
                  $sformatf("Default packed_arr values : %0p", packed_arr), 
                  UVM_LOW)
        `uvm_info("arrays", 
                  $sformatf("Size of unpacked_arr array : %0d", $size(unpacked_arr)),   // .size() is not supported for static (fixed-size) arrays
                  UVM_LOW)
        `uvm_info("arrays", 
                  $sformatf("Default unpacked_arr values : %0p", unpacked_arr), 
                  UVM_LOW)

        // Print the size and default values of dynamic array
        `uvm_info("arrays", 
                  $sformatf("Size of dyn_arr array : %0d", dyn_arr.size()), 
                  UVM_LOW)
        dyn_arr = new[10];
        `uvm_info("arrays", 
                  $sformatf("Updated size of dyn_arr array : %0d", dyn_arr.size()), 
                  UVM_LOW)
        `uvm_info("arrays", 
                  $sformatf("Default dyn_arr values : %0p", dyn_arr), 
                  UVM_LOW)
        foreach(dyn_arr[i]) begin
            dyn_arr[i] = i * 2;
        end
        `uvm_info("arrays", 
                  $sformatf("Updated dyn_arr values : %0p", dyn_arr), 
                  UVM_LOW)
        dyn_arr = new[40](dyn_arr); // This retains the previous 10 elements and adds 30 new elements
        `uvm_info("arrays", 
                  $sformatf("New size of dyn_arr array : %0d", dyn_arr.size()), 
                  UVM_LOW)
        `uvm_info("arrays", 
                  $sformatf("New dyn_arr values : %0p", dyn_arr), 
                  UVM_LOW)
        foreach(dyn_arr[i]) begin
            if(i inside {[0:9]}) continue;
            dyn_arr[i] = i * 5;
        end
        `uvm_info("arrays", 
                  $sformatf("Updated dyn_arr values with retention : %0p", dyn_arr), 
                  UVM_LOW)

        // Deleting the array
        dyn_arr.delete();
        `uvm_info("arrays", 
                  $sformatf("Size after deleting the dyn_arr array : %0d", dyn_arr.size()), 
                  UVM_LOW)

        // Print the size and default values of associative array
        `uvm_info("arrays", 
                  $sformatf("Size of asso_arr array : %0d", asso_arr.size()), 
                  UVM_LOW)
        asso_arr[10] = 16;
        asso_arr[23] = 36;
        `uvm_info("arrays", 
                  $sformatf("New size of asso_arr array : %0d", asso_arr.size()), 
                  UVM_LOW)
        foreach(asso_arr[i]) begin
            `uvm_info("arrays", 
                      $sformatf("Updated asso_arr[%0d] value : %0d", i, asso_arr[i]), 
                      UVM_LOW)
        end
        `uvm_info("arrays", 
                  $sformatf("Keys and values of asso_arr : %0p", asso_arr), 
                  UVM_LOW)
        if(asso_arr.exists(10)) begin
            `uvm_info("arrays", 
                      $sformatf("Associate Array key 10 exists"), 
                      UVM_LOW)
        end
    end

endmodule

/************** OUTPUT **************
# UVM_INFO arrays.sv(37) @ 0: reporter [arrays] Size of arr_single_d array : 5
# UVM_INFO arrays.sv(40) @ 0: reporter [arrays] Default arr_single_d values : 11 11 11 11 11
# UVM_INFO arrays.sv(43) @ 0: reporter [arrays] Size of arr_multi_d array : 4
# UVM_INFO arrays.sv(46) @ 0: reporter [arrays] Default arr_multi_d values : {1 2} {5 6} {9 10} {13 14}
# UVM_INFO arrays.sv(54) @ 0: reporter [arrays] Updated arr_single_d values : 0 5 10 15 20
# UVM_INFO arrays.sv(60) @ 0: reporter [arrays] Updated arr_multi_d values : {0 1} {1 2} {2 3} {3 4}
# UVM_INFO arrays.sv(65) @ 0: reporter [arrays] Size of packed_arr array : 3
# UVM_INFO arrays.sv(68) @ 0: reporter [arrays] Default packed_arr values : 10 12 15
# UVM_INFO arrays.sv(71) @ 0: reporter [arrays] Size of unpacked_arr array : 3
# UVM_INFO arrays.sv(74) @ 0: reporter [arrays] Default unpacked_arr values : {16 17 18 19} {20 21 22 23} {24 25 26 27}
# UVM_INFO arrays.sv(79) @ 0: reporter [arrays] Size of dyn_arr array : 0
# UVM_INFO arrays.sv(83) @ 0: reporter [arrays] Updated size of dyn_arr array : 10
# UVM_INFO arrays.sv(86) @ 0: reporter [arrays] Default dyn_arr values : 0 0 0 0 0 0 0 0 0 0
# UVM_INFO arrays.sv(92) @ 0: reporter [arrays] Updated dyn_arr values : 0 2 4 6 8 10 12 14 16 18
# UVM_INFO arrays.sv(96) @ 0: reporter [arrays] New size of dyn_arr array : 40
# UVM_INFO arrays.sv(99) @ 0: reporter [arrays] New dyn_arr values : 0 2 4 6 8 10 12 14 16 18 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
# UVM_INFO arrays.sv(106) @ 0: reporter [arrays] Updated dyn_arr values with retention : 0 2 4 6 8 10 12 14 16 18 50 55 60 65 70 75 80 85 90 95 100 105 110 115 120 125 130 135 140 145 150 155 160 165 170 175 180 185 190 195
# UVM_INFO arrays.sv(112) @ 0: reporter [arrays] Size after deleting the dyn_arr array : 0
# UVM_INFO arrays.sv(117) @ 0: reporter [arrays] Size of asso_arr array : 0
# UVM_INFO arrays.sv(122) @ 0: reporter [arrays] New size of asso_arr array : 2
# UVM_INFO arrays.sv(126) @ 0: reporter [arrays] Updated asso_arr[10] value : 16
# UVM_INFO arrays.sv(126) @ 0: reporter [arrays] Updated asso_arr[23] value : 36
# UVM_INFO arrays.sv(130) @ 0: reporter [arrays] Keys and values of asso_arr : {10:16} {23:36}
# UVM_INFO arrays.sv(134) @ 0: reporter [arrays] Associate Array key 10 exists
#  quit
# End time: 23:34:09 on Mar 21,2026, Elapsed time: 0:00:15
# Errors: 0, Warnings: 0
************************************/ 
