--------------------------------------------------------------------------------
-- 							COMPUTER DESIGN
-- 	Laboratory number: 4
--	Authors: Alexander Ortega & Bregy Malpartida

--	Description of code:
--	Have a useful of R type instructions on a MIPS processor without control
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;        -- for addition & counting
use ieee.numeric_std.all;               -- for type conversions
use ieee.math_real.all;                 -- for the ceiling and log constant calculation functions

entity micro_MIPS is
	port (
		clock : std_logic;

		address: in std_logic_vector(3 downto 0);
		regDst: in std_logic;
		wrData: in std_logic_vector(31 downto 0);
		regWrite: in std_logic;
		aluSrc: in std_logic;
		aluCnt: in std_logic_vector(3 downto 0);

		Z: out std_logic;
		aluRes: out std_logic_vector(31 downto 0);
		regOut: out std_logic_vector(31 downto 0)
	);
end micro_MIPS;

architecture micro_MIPS_arc of micro_MIPS is
	-----------------------------------------------------------------------------
	component mux
		generic (
			n: integer := 32
		);
		port (
			a, b: in std_logic_vector(n-1 downto 0);
			sel: in std_logic;
			c: out std_logic_vector(n-1 downto 0)
			
		);
	end component;
	-----------------------------------------------------------------------------
	component alu is
		port (
			in_1, in_2: std_logic_vector(31 downto 0);
			alu_control_fuct: in std_logic_vector(3 downto 0);
			zero: out std_logic;
			alu_result: out std_logic_vector(31 downto 0)
		);
	end component alu;
	----------------------------------------------------------------------------
	component instmem is
		port (
			inst_address: in std_logic_vector(3 downto 0);
			instruction: out std_logic_vector(31 downto 0)
		);
	end component instmem;
	----------------------------------------------------------------------------
	component registers is
		port (
			clock: in std_logic;
			reg_write: in std_logic;
			R_reg1, R_reg2, W_reg: in std_logic_vector(4 downto 0);
			W_data: in std_logic_vector(31 downto 0);
			R_data1, R_data2: out std_logic_vector(31 downto 0)
		);
	end component registers;
	----------------------------------------------------------------------------
	component sign_extend is
		port (
			x: in std_logic_vector(15 downto 0);
			y: out std_logic_vector(31 downto 0)
		);
	end component sign_extend;
	----------------------------------------------------------------------------

	signal instruction_internal: std_logic_vector(31 downto 0);
	alias opcode is instruction_internal(31 downto 26);


	-- For any R type instruction:
	alias rs is instruction_internal(25 to 21);
	alias rt is instruction_internal(20 to 16);
	alias rd is instruction_internal(15 to 11);
	alias shamt is instruction_internal(10 to 6);
	alias funct is instruction_internal(5 to 0);
	
	-- For load/store and branch instruction:
	alias address_of_instr is instruction_internal(15 to 0);

	-- Signals for alu instance:
	signal alu_fuct: std_logic_vector(3 downto 0) := "0000";
	signal alu_in1: std_logic_vector(31 downto 0);
	signal alu_in2: std_logic_vector(31 downto 0);
	signal alu_zero: std_logic;
	signal alu_out: std_logic_vector(31 downto 0);
	
	-- Signals for register_memory instance:
	signal reg_read_data_1: std_logic_vector(31 downto 0);
	signal reg_write_data: std_logic_vector(31 downto 0);

	-- Signals for instruction_memory instance:
	signal inst_address: std_logic_vector(3 downto 0);

	-- Signals for sign_extend instance:
	signal sign_y: std_logic_vector(31 downto 0);

	signal reg_to_alu_and_mux: std_logic_vector(31 downto 0);
	signal mux_alu_c: std_logic_vector(31 downto 0);
begin
	

	main_alu: alu 
	port map (
		in_1 => alu_in1,
		in_2 => mux_alu_c,
		alu_control_fuct => aluCnt,
		zero => Z,
		alu_result => aluRes
	);

	reg_memory: registers
	port map (
		clock => clock,
		reg_write => regWrite,
		R_reg1 => rs,
		R_reg2 => rt,		
		W_reg => reg_write_data,
		W_data => wrData,
		R_data1 => alu_in1,
		R_data2 => reg_to_alu_and_mux
	);

	instruction_memory: instmem
	port map (
		inst_address => address,
		instruction => instruction_internal
	);

	sign_extend_new: sign_extend
	port map (
		x => address_of_instr,
		y => sign_y	
	);

	mux_reg: mux 
	port map (
		a => rt,
		b => rd,
		sel => regDst,
		c => reg_write_data
	);

	mux_alu: mux 
	port map (
		a => reg_to_alu_and_mux,
		b => sign_y,
		sel => aluSrc,
		c => mux_alu_c
	);
	-- reg_read_reg_1 <= rs;
	-- reg_read_reg_2 <= rt;
	regOut <= reg_to_alu_and_mux;

end micro_MIPS_arc;
