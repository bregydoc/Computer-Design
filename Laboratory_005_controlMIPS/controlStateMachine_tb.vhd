library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

-----------------------------------------------------------

entity controlStateMachine_tb is

end entity controlStateMachine_tb;

-----------------------------------------------------------

architecture testbench of controlStateMachine_tb is

	-- Testbench signals
    signal clk      : std_logic;
    signal reset    : std_logic;
    signal opcode   : std_logic_vector(5 downto 0);
    signal PCWrite  : std_logic;
    signal RegDst   : std_logic;
    signal Jump     : std_logic;
    signal Branch   : std_logic;
    signal MemRead  : std_logic;
    signal MemtoReg : std_logic;
    signal ALUOp    : std_logic_vector(1 downto 0);
    signal MemWrite : std_logic;
    signal ALUSrc   : std_logic;
    signal RegWrite : std_logic;

	constant C_CLK_PERIOD = real := 10.0e-9; -- NS

begin
	-----------------------------------------------------------
	-- Clocks and Reset
	-----------------------------------------------------------
	CLK_GEN : process
	begin
		clk <= '1';
		wait for C_CLK_PERIOD / 2.0 * (1 SEC);
		clk <= '0';
		wait for C_CLK_PERIOD / 2.0 * (1 SEC);
	end process CLK_GEN;
        
	RESET_GEN : process
	begin
		reset <= '1',
		         '0' after 20.0*C_CLK_PERIOD * (1 SEC);
		wait;
	end process RESET_GEN;
    
	-----------------------------------------------------------
	-- Testbench Stimulus
	-----------------------------------------------------------
 	stim_proc : process (reset, clock)
 	begin
 	  	if not (reset = '1') then
 	    	opcode <= "001000";
 	    	wait for 20 ns;
			opcode <= "000010";
			wait for 20 ns;
			opcode <= "001000";
			wait for 20 ns;
			opcode <= "000000";
			wait for 20 ns;
			opcode <= "000000";
			wait for 20 ns;
			opcode <= "101011";
			wait for 20 ns;
			opcode <= "100011";
			wait for 20 ns;
			opcode <= "000010";
			wait for 20 ns;
			opcode <= "000100";
 			wait;
	 	end if;
 	end process stim_proc;
	-----------------------------------------------------------
	-- Entity Under Test
	-----------------------------------------------------------
    DUT : entity work.controlStateMachine
        port map (
            clk      => clk,
            reset    => reset,
            opcode   => opcode,
            PCWrite  => PCWrite,
            RegDst   => RegDst,
            Jump     => Jump,
            Branch   => Branch,
            MemRead  => MemRead,
            MemtoReg => MemtoReg,
            ALUOp    => ALUOp,
            MemWrite => MemWrite,
            ALUSrc   => ALUSrc,
            RegWrite => RegWrite
        );

end architecture testbench;