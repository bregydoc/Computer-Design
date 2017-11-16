library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity memory is
	port (
		address, write_data: in STD_LOGIC_VECTOR (31 downto 0);
		MemWrite, MemRead,clock: in STD_LOGIC;
		read_data: out STD_LOGIC_VECTOR (31 downto 0)
	);
end memory;


architecture behavioral of memory is	  

type mem_array is array(0 to 63) of STD_LOGIC_VECTOR (31 downto 0);

signal data_mem: mem_array := (
    X"00000000", -- initialize data memory
    X"00000001", -- mem 1
    X"00000002",
    X"00000004",
    X"00000004",
    X"00000005",
    X"00000006",
    X"00000007",
    X"00000008",
    X"00000009", 
    X"0000000A", -- mem 10 
    X"0000000B", 
    X"0000000C",
    X"0000000D",
    X"0000000E",
    X"0000000F",
    X"00000010",
    X"00000011",
    X"00000012",
    X"00000013",  
    X"00000014", -- mem 20
    X"00000015",
    X"00000016",
    X"00000017",
    X"00000018", 
    X"00000019",
    X"0000001A",
    X"0000001B",
    X"0000001C",
    X"0000001D", 
    X"0000001E", -- mem 30
    X"0000001F",
	 X"00000000", -- initialize data memory
    X"00000001", -- mem 1
    X"00000002",
    X"00000004",
    X"00000004",
    X"00000005",
    X"00000006",
    X"00000007",
    X"00000008",
    X"00000009", 
    X"0000000A", -- mem 10 
    X"0000000B", 
    X"0000000C",
    X"0000000D",
    X"0000000E",
    X"0000000F",
    X"00000010",
    X"00000011",
    X"00000012",
    X"00000013",  
    X"00000014", -- mem 20
    X"00000015",
    X"00000016",
    X"00000017",
    X"00000018", 
    X"00000019",
    X"0000001A",
    X"0000001B",
    X"0000001C",
    X"0000001D", 
    X"0000001E", -- mem 30
    X"0000001F"
	 );

begin
read_data <= data_mem(conv_integer(address(5 downto 0))) when MemRead = '1' else X"00000000";

mem_process: process(address, write_data,clock)
begin
	if clock = '0' and clock'event then
		if (MemWrite = '1') then

			data_mem(conv_integer(address(5 downto 0))) <= write_data;
		end if;
	end if;
end process mem_process;

end behavioral;
