------------------------------------------------------
-- Register Memory Block
-- 
-- Contains all the registers.
-- 
-- Memory is kept in rows of 32 bits to represent 32-bit
-- registers.
------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity registers is 
	port (
		clock: in std_logic;
		reg_write: in std_logic;
		R_reg1, R_reg2, W_reg: in std_logic_vector(4 downto 0);
		W_data: in std_logic_vector(31 downto 0);
		R_data1, R_data2: out std_logic_vector(31 downto 0)
	);
end registers;

architecture beh of registers is

    -- 128 byte register memory (32 rows * 4 bytes/row)
    type mem_array is array(0 to 31) of STD_LOGIC_VECTOR (31 downto 0);
    signal reg_mem: mem_array := (
      
        "00000000000000000000000000000000", -- $0
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
		  "00000000000000000000000000000000",
        "00000000000000000000000000000000", --$t0
        "00000000000000000000000000000000", --$t1
        "00000000000000000000000000000000", --$t2
        "00000000000000000000000000000000", --$t3
        "00000000000000000000000000000000", --$t4
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",  
        "00000000000000000000000000000000", 
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000", 
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000",
        "00000000000000000000000000000000", 
        "00000000000000000000000000000000", 
        "00000000000000000000000000000000"
    );

	begin

    R_data1 <= reg_mem(to_integer(unsigned(R_reg1)));
    R_data2 <= reg_mem(to_integer(unsigned(R_reg2)));

    process(clock)
        begin
        if clock='0' and clock'event and reg_write='1' then
            -- write to reg. mem. when the reg_write flag is set and on a falling clock
            reg_mem(to_integer(unsigned(W_Reg))) <= W_data;
        end if;
    end process;

end beh;