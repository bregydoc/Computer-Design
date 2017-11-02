--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   20:47:51 10/30/2017
-- Design Name:   
-- Module Name:   C:/Users/Alexander/Desktop/Ciclo V/Lab_4D1s3/test2323.vhd
-- Project Name:  Lab_4D1s3
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
 
ENTITY test2323 IS
END test2323;
 
ARCHITECTURE behavior OF test2323 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT micro_MIPS
    PORT(
         clock : IN  std_logic;
         regDst : IN  std_logic;
         jump : IN  std_logic;
         regWrite : IN  std_logic;
         Memtoreg : IN  std_logic;
         memwrite : IN  std_logic;
         memread : IN  std_logic;
         aluSrc : IN  std_logic;
         aluCnt : IN  std_logic_vector(3 downto 0);
         branch : IN  std_logic;
         regOut : OUT  std_logic_vector(31 downto 0);
         resultadoalu : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal regDst : std_logic := '0';
   signal jump : std_logic := '0';
   signal regWrite : std_logic := '0';
   signal Memtoreg : std_logic := '0';
   signal memwrite : std_logic := '0';
   signal memread : std_logic := '0';
   signal aluSrc : std_logic := '0';
   signal aluCnt : std_logic_vector(3 downto 0) := (others => '0');
   signal branch : std_logic := '0';

 	--Outputs
   signal regOut : std_logic_vector(31 downto 0);
   signal resultadoalu : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: micro_MIPS PORT MAP (
          clock => clock,
          regDst => regDst,
          jump => jump,
          regWrite => regWrite,
          Memtoreg => Memtoreg,
          memwrite => memwrite,
          memread => memread,
          aluSrc => aluSrc,
          aluCnt => aluCnt,
          branch => branch,
          regOut => regOut,
          resultadoalu => resultadoalu
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
      regDst<='1'; jump<='0' ; regWrite<='1'; Memtoreg<='0'; memwrite<='0'; memread<='0'; aluSrc<='0';  aluCnt<="0010";  branch<='0';
      wait for clock_period;
      regDst<='1'; jump<='0' ; regWrite<='1'; Memtoreg<='0';memwrite<='0' ;memread<='0' ;aluSrc<='0';  aluCnt<="0110"  ;branch<='0';
      wait for clock_period;
      regDst<='1'; jump<='0' ; regWrite<='1'; Memtoreg<='0'; memwrite<='0' ;memread<='0' ;aluSrc<='0'  ;aluCnt<="0000"  ;branch<='0';
      wait for clock_period;
      regDst<='0'; jump<='0' ; regWrite<='1'; Memtoreg<='1'; memwrite<='0'; memread<='1' ;aluSrc<='1' ; aluCnt<="0010" ; branch<='0';
      wait for clock_period;



      wait;
   end process;

END;
