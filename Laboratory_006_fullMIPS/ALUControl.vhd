----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:31:15 09/29/2017 
-- Design Name: 
-- Module Name:    ALUControl - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity alucontrol is
	port (
		FuncCode: in std_logic_vector(5 downto 0);
		ALUOp: in std_logic_vector(1 downto 0);
		ALUCtl: out std_logic_vector(3 downto 0)
	);
end alucontrol;

architecture behavioral of alucontrol is
	signal and_op: std_logic_vector(3 downto 0):= "0000";
	signal or_op: std_logic_vector(3 downto 0):= "0001";
	signal add: std_logic_vector(3 downto 0):= "0010";
	
	signal subtract: std_logic_vector(3 downto 0):= "0110";
	signal set_on_less_than: std_logic_vector(3 downto 0):= "0111";

	begin

	ALUCtl <= add when(ALUOp="00" or (ALUOp="10" and FuncCode="100000")) else
						subtract when(ALUOp="01" or (ALUOp="10" and FuncCode="100010")) else
						
						and_op when(ALUOp="10" and FuncCode="100100") else
						or_op when(ALUOp="10" and FuncCode="100101") else
						set_on_less_than when(ALUOp="10" and FuncCode="101010") else
						"0000";
						

end behavioral;
