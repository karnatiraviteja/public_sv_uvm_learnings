// Data types in SV
// 1. Two state data types  (default value : 0)
//     1.1 Signed
//         * byte         -  8  bit
//         * shortint     -  16 bit
//         * int          -  32 bit
//         * longint      -  64 bit
//     1.2 Unsigned
//         * bit          -  User defined size
// 2. Four state data types (default value : X)
//     2.1 Signed
//         * integer      -  32 bit
//     2.2 Unsigned
//         * logic        -  User defined size
//         * reg          -  User defined size
//         * time         -  64 bit
//

module data_types;
    byte     byte_type_var    ;
    shortint shortint_type_var;
    int      int_type_var     ;
    longint  longint_type_var ;

    bit      bit_type_var     ;

    integer  integer_type_var ;

    logic    logic_type_var   ;
    reg      reg_type_var     ;
    time     time_type_var    ;

    // User defined types
    typedef logic [31:0] addr_t;
    addr_t   awaddr  ,  araddr ;

    // Enumeration
    typedef enum logic [1:0] {
        ON,
        OFF,
        PG
    } power_state_e; // int type; ON = 0; OFF = 1; PG = 2;
    
    power_state_e power_state;
    event ev;

    initial begin
        $display("============= DEFAULT VALUES =============");
        $display("Default value of byte                  : %0d"  , byte_type_var         );   // Default value of byte                  : 0 
        $display("Default value of shortint              : %0d"  , shortint_type_var     );   // Default value of shortint              : 0 
        $display("Default value of int                   : %0d"  , int_type_var          );   // Default value of int                   : 0 
        $display("Default value of longint               : %0d"  , longint_type_var      );   // Default value of longint               : 0 
        $display("Default value of bit                   : %0d"  , bit_type_var          );   // Default value of bit                   : 0 
        $display("Default value of integer               : %0d"  , integer_type_var      );   // Default value of integer               : x 
        $display("Default value of logic                 : %0d"  , logic_type_var        );   // Default value of logic                 : x 
        $display("Default value of reg                   : %0d"  , reg_type_var          );   // Default value of reg                   : x 
        $display("Default value of time                  : %0d"  , time_type_var         );   // Default value of time                  : x 
        $display("Default value of typedef logic awaddr  : %0d"  , awaddr                );   // Default value of typedef logic awaddr  : x 
        $display("Default value of typedef logic araddr  : %0d"  , araddr                );   // Default value of typedef logic araddr  : x 
        $display("Default value of typedef enum          : %0d"  , power_state           );   // Default value of typedef enum          : x 
        $display("Default value of typedef enum          : %0s"  , power_state.name()    );   // Default value of typedef enum          :
        $display("==========================================");
        #1ns;
        $display("Triggered event after @ %0tns", $time);
        -> ev;
    end

    logic signed [7:0] s_data;
    bit   signed [7:0] s_bit;

    // Packed arrays
    bit   [31:0] addr_2_state;
    logic [63:0] data_4_state;

    // Unpacked arrays
    int   mem[0:255];
    logic data_q [$];

    // Dynamic array
    int dyn_arr[];

    initial begin
        $display("Waiting for event ev @ %0tns", $time);
        @ev;
        $display("Received event @ %0tns", $time);
    end
endmodule

/************ OUTPUT ************
# ============= DEFAULT VALUES =============
# Default value of byte                  : 0
# Default value of shortint              : 0
# Default value of int                   : 0
# Default value of longint               : 0
# Default value of bit                   : 0
# Default value of integer               : x
# Default value of logic                 : x
# Default value of reg                   : x
# Default value of time                  : x
# Default value of typedef logic awaddr  : x
# Default value of typedef logic araddr  : x
# Default value of typedef enum          : x
# Default value of typedef enum          :
# ==========================================
# Waiting for event ev @ 0ns
# Triggered event after @ 1ns
# Received event @ 1ns
#  quit
# End time: 10:40:10 on Mar 22,2026, Elapsed time: 0:00:03
# Errors: 0, Warnings: 0
*********************************/
