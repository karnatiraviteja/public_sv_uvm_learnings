module data_types;

    // ===================================
    // 2 state data types : Default value = 0
    // Signed   : byte
    //            shortint
    //            int
    //            longint
    // Unsigned : bit
    // ===================================
    bit two_state;
    
    // ===================================
    // 4 state data types : Default value = X
    // Signed   : integer
    // ===================================
    logic four_state;

    // ===================================
    // User defined type
    // ===================================
    typedef int my_int;   // Declaration
    my_int a,b;           // Usage of user defined data type

    // ===================================
    // Enumeration
    // ===================================
    enum {red,
          yellow,
          green} traffic_signal;

    initial begin
        $display("two_state  : default value : %0d", two_state);
        $display("four_state : default value : %0d", four_state);
    end
endmodule
