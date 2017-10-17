--------------------------------------------------------------------------------
-- 							COMPUTER DESIGN
-- 	Laboratory number: 4
--	Authors: Alexander Ortega & Bregy Malpartida

--	Description of code:
-- 	This component takes in 2 inputs, performs one of 5 
-- 	operations between them (add, subtract, and, or, 
-- 	set-on-less-than), and returns the result.
--
-- 	Also returns a zero flag that is true if the 2 inputs
-- 	are equal and false otherwise.
--------------------------------------------------------------------------------


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY mipstest IS
END mipstest;
 
ARCHITECTURE behavior OF mipstest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT micro_MIPS
    PORT(
         clock : IN  std_logic;
         address : IN  std_logic_vector(3 downto 0);
         regDst : IN  std_logic;
         wrData : IN  std_logic_vector(31 downto 0);
         regWrite : IN  std_logic;
         aluSrc : IN  std_logic;
         aluCnt : IN  std_logic_vector(3 downto 0);
         Z : OUT  std_logic;
         aluRes : OUT  std_logic_vector(31 downto 0);
         regOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clock : std_logic := '0';
   signal address : std_logic_vector(3 downto 0) := (others => '0');
   signal regDst : std_logic := '0';
   signal wrData : std_logic_vector(31 downto 0) := (others => '0');
   signal regWrite : std_logic := '0';
   signal aluSrc : std_logic := '0';
   signal aluCnt : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal Z : std_logic;
   signal aluRes : std_logic_vector(31 downto 0);
   signal regOut : std_logic_vector(31 downto 0);

   -- Clock period definitions
   constant clock_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: micro_MIPS PORT MAP (
          clock => clock,
          address => address,
          regDst => regDst,
          wrData => wrData,
          regWrite => regWrite,
          aluSrc => aluSrc,
          aluCnt => aluCnt,
          Z => Z,
          aluRes => aluRes,
          regOut => regOut
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
		address <= "0000"; Regdst <= '1'; regWrite <='0'; alusrc <='0' ; alucnt <="0010";
		wait for 100 ns;
		address <= "0000"; Regdst <= '1'; regWrite <='1'; alusrc <='0' ; alucnt <="0010"; wrData<="00000000000000000000000000000011";
      wait for 100 ns;
		address <= "0001"; Regdst <= '1'; regWrite <='0'; alusrc <='0' ; alucnt <="0110";
		wait for 100 ns;
		address <= "0001"; Regdst <= '1'; regWrite <='1'; alusrc <='0' ; alucnt <="0110"; wrData<="00000000000000000000000000000010";
		wait for 100 ns;
		address <= "0010"; Regdst <= '1'; regWrite <='0'; alusrc <='0' ; alucnt <="0000";
		wait for 100 ns;
		address <= "0010"; Regdst <= '1'; regWrite <='1'; alusrc <='0' ; alucnt <="0000"; wrData<="00000000000000000000000000000010";
		wait for 100 ns;
		address <= "0011"; Regdst <= '0'; regWrite <='0'; alusrc <='1' ; alucnt <="0010";
		wait for 100 ns;
		address <= "0011"; Regdst <= '0'; regWrite <='1'; alusrc <='1' ; alucnt <="0010"; wrData<="00000000000000000000000000000110";

      wait for clock_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;