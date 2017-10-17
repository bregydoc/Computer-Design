--------------------------------------------------------------------------------
-- 							COMPUTER DESIGN
-- 	Laboratory number: 4
--	Authors: Alexander Ortega & Bregy Malpartida

--	Description of code:
--	This code is a simple implementation of a little async memory used  
--	instruction memory on a MIPS processor
--------------------------------------------------------------------------------



library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;        -- for addition & counting
use ieee.numeric_std.all;               -- for type conversions
use ieee.math_real.all;                 -- for the ceiling and log constant calculation functions


entity instmem is
	port (
		inst_address: in std_logic_vector(3 downto 0);
		instruction: out std_logic_vector(31 downto 0)
	);
end instmem;

architecture instmem_arc of instmem is
	type instrMem is array(0 to 15) of STD_LOGIC_VECTOR (31 downto 0);
	signal memory: instrMem := (
		"00000000001000100001100000100000", -- add $3, $1, $2
		"00000000110001000100000000100010", -- sub $8, $6, $4
		"00000001000000110110000000100100", -- and $12, $3, $8
		"10001101100001110000000000000001", -- lw $7, 1($12)
		"00000000010000010001100000100000", -- add $3, $1, $2
		"00000001000011001000000000100010", -- sub $8, $6, $4
		"00000001000000110110000000100100", -- and $12, $3, $8
		"00000000010000010001100000100000", -- add $3, $1, $2
		"00000001000011001000000000100010", -- sub $8, $6, $4
		"00000001000000110110000000100100", -- and $12, $3, $8
		"00000000010000010001100000100000", -- add $3, $1, $2
		"00000001000000000000000000100010", -- sub $8, $6, $4
		"00000001000000110110000000100100", -- and $12, $3, $8
		"00000001000000110110000000100100", -- and $12, $3, $8
		"11111000010000010001100000100000", -- add $3, $1, $2
		"11111000010000010001100000100000" -- add $3, $1, $2

	);

begin
	
  	process (inst_address)
		begin
		  instruction <= memory(to_integer(unsigned(inst_address)));
	end process;
end instmem_arc;
