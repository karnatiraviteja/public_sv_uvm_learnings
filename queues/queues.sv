/*
****************** Queues ******************
See below for more information
1. https://www.chipverify.com/systemverilog/systemverilog-queue
2. https://vlsiverify.com/system-verilog/systemverilog-queues/
3. https://verificationguide.com/systemverilog/systemverilog-queue/

    o Bounded Queue   : Limited number of entries
    o Unbounded Queue : Unlimited number of entries
*/

`include "uvm_macros.svh"
import uvm_pkg::*;

module queues;
    int bounded_queue [$:9];
    int unbounded_queue [$];

    string companies [$] = {"Google", "Nvidia", "Apple", "Meta"};

    int arr_of_queues [3][$];

    initial begin
        foreach(companies[i]) begin
            `uvm_info("[Queues]", $sformatf("companies[%0d] : %s", i, companies[i]), UVM_LOW)
        end
        `uvm_info("[Queues]", $sformatf("companies = %p", companies), UVM_LOW)
        companies.push_back("IBM");
        `uvm_info("[Queues]", $sformatf("companies = %p", companies), UVM_LOW)
        companies.push_front("Broadcom");
        `uvm_info("[Queues]", $sformatf("companies = %p", companies), UVM_LOW)
        companies.insert(3, "AMD");
        `uvm_info("[Queues]", $sformatf("companies = %p", companies), UVM_LOW)

        companies = {};
        `uvm_info("[Queues]", $sformatf("Deleted queue : companies = %p", companies), UVM_LOW)

        arr_of_queues = '{
            {1,3,5,7},
            {2,4,6,8},
            {100,200,300,400}
        };
        `uvm_info("[Queues]", $sformatf("arr_of_queues = %p", arr_of_queues), UVM_LOW)
        arr_of_queues[0].push_back(9);
        arr_of_queues[1].push_back(10);
        arr_of_queues[2].push_back(500);
        `uvm_info("[Queues]", $sformatf("arr_of_queues = %p", arr_of_queues), UVM_LOW)

        //bounded_queue.size() = 10;
        //foreach(bounded_queue[i]) begin
        //    bounded_queue[i] = 2 ** i;   // This will not work because bounded_queue.size() is 0, so foreach doesn't executes.
        //                                 // Like how Dynamic Array needs new[] to allocate size, queue needs push from back/front.
        //                                 // int bounded_queue [$:9] = {0,0,0,0,0,0,0,0,0,0}; if declared this way in line 16 then it'll work .
        //                                 // Line 49 as well wouldn't work, size can only be altered with push/pop, shouldn't be set directly.
        //end

        for(int i = 0; i < 10; i++) begin
            bounded_queue.push_back(2 ** i); // This and below, both works in case of for loop
            //bounded_queue[i] = 2 ** i;
        end

        `uvm_info("[Queues]", $sformatf("bounded_queue.size() == %0d, bounded_queue = %p", bounded_queue.size(), bounded_queue), UVM_LOW)
        // bounded_queue can have only 10 elements, trying to push a new elements
        bounded_queue.insert(2, 1024);
        bounded_queue.push_front(1024);
        bounded_queue.push_back(1024);
        bounded_queue.delete(5);
        bounded_queue.insert(9, 1024);
        `uvm_info("[Queues]", $sformatf("bounded_queue.size() == %0d, bounded_queue = %p", bounded_queue.size(), bounded_queue), UVM_LOW)
    end

endmodule

/************** OUTPUT **************
# UVM_INFO queues.sv(25) @ 0: reporter [[Queues]] companies[0] : Google
# UVM_INFO queues.sv(25) @ 0: reporter [[Queues]] companies[1] : Nvidia
# UVM_INFO queues.sv(25) @ 0: reporter [[Queues]] companies[2] : Apple
# UVM_INFO queues.sv(25) @ 0: reporter [[Queues]] companies[3] : Meta
# UVM_INFO queues.sv(27) @ 0: reporter [[Queues]] companies = '{"Google", "Nvidia", "Apple", "Meta"}
# UVM_INFO queues.sv(29) @ 0: reporter [[Queues]] companies = '{"Google", "Nvidia", "Apple", "Meta", "IBM"}
# UVM_INFO queues.sv(31) @ 0: reporter [[Queues]] companies = '{"Broadcom", "Google", "Nvidia", "Apple", "Meta", "IBM"}
# UVM_INFO queues.sv(33) @ 0: reporter [[Queues]] companies = '{"Broadcom", "Google", "Nvidia", "AMD", "Apple", "Meta", "IBM"}
# UVM_INFO queues.sv(36) @ 0: reporter [[Queues]] Deleted queue : companies = '{}
# UVM_INFO queues.sv(43) @ 0: reporter [[Queues]] arr_of_queues = '{'{1, 3, 5, 7}, '{2, 4, 6, 8}, '{100, 200, 300, 400}}
# UVM_INFO queues.sv(47) @ 0: reporter [[Queues]] arr_of_queues = '{'{1, 3, 5, 7, 9}, '{2, 4, 6, 8, 10}, '{100, 200, 300, 400, 500}}
# UVM_INFO queues.sv(62) @ 0: reporter [[Queues]] bounded_queue.size() == 10, bounded_queue = '{1, 2, 4, 8, 16, 32, 64, 128, 256, 512}
# ** Warning: queues.sv(64): Queue operation would exceed max. right index of 9.
#    Time: 0 ns  Iteration: 0  Instance: /queues
# ** Warning: queues.sv(65): Queue operation would exceed max. right index of 9.
#    Time: 0 ns  Iteration: 0  Instance: /queues
# ** Warning: queues.sv(66): Queue operation would exceed max. right index of 9.
#    Time: 0 ns  Iteration: 0  Instance: /queues
# UVM_INFO queues.sv(69) @ 0: reporter [[Queues]] bounded_queue.size() == 10, bounded_queue = '{1, 2, 4, 8, 16, 64, 128, 256, 512, 1024}
#  quit
# End time: 22:36:56 on Apr 03,2026, Elapsed time: 0:00:15
# Errors: 0, Warnings: 3
************************************/ 
