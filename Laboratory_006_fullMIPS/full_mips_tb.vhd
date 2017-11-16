--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   19:54:46 11/10/2017
-- Design Name:   
-- Module Name:   C:/Users/Alexander/Desktop/Ciclo V/LAB6_D1SE/full_mips_tb.vhd
-- Project Name:  LAB6_D1SE
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: micro_MIPS
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY full_mips_tb IS
END full_mips_tb;
 
ARCHITECTURE behavior OF full_mips_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT micro_MIPS
    PORT(
         clock : IN  std_logic;
         alu_res1 : OUT  std_logic_vector(31 downto 0);
         to_write_data : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';

 	--Outputs
   signal alu_res1 : std_logic_vector(31 downto 0);
   signal to_write_data : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: micro_MIPS PORT MAP (
          clock => clock,
          alu_res1 => alu_res1,
          to_write_data => to_write_data
        );

   -- Clock process definitions
   clock_process :process
   begin
		clock <= '0';
		wait for clock_period/2;
		clock <= '1';
		wait for clock_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.	

      wait for clock_period*100;

      -- insert stimulus here 

      wait;
   end process;

END;
