library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;        -- for addition & counting
use ieee.numeric_std.all;               -- for type conversions
use ieee.math_real.all;                 -- for the ceiling and log constant calculation functions

entity micro_MIPS is
	port (
		clock : std_logic;
		regDst: in std_logic;
		jump: in std_logic;
		regWrite: in std_logic;
		Memtoreg: in std_logic;
		memwrite: in std_logic;
		memread: in std_logic;
		aluSrc: in std_logic;
		aluCnt: in std_logic_vector(3 downto 0);
		branch: in std_logic;
		regOut: out std_logic_vector(31 downto 0);
		resultadoalu: out std_logic_vector(31 downto 0)
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
	component instruction_memory is
		port (
		read_address: in STD_LOGIC_VECTOR (31 downto 0);
		instruction: out STD_LOGIC_VECTOR (31 downto 0)
		);
	end component instruction_memory;
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
	component memory is
	port (
		address, write_data: in STD_LOGIC_VECTOR (31 downto 0);
		MemWrite, MemRead,clock: in STD_LOGIC;
		read_data: out STD_LOGIC_VECTOR (31 downto 0)
	);
	end component;
	----------------------------------------------------------------------------
	component shifter is
	generic (n1: integer:= 32; n2: integer:= 32; k: integer:= 2);
	port (
		x: in std_logic_vector(n1-1 downto 0);
		y: out std_logic_vector(n2-1 downto 0)
	);
	end component;
	-----------------------------------------------------------------------------
	component ProgramCounter is
	port(
		clock: in std_logic;
		address_to_load: in std_logic_vector(31 downto 0);
		current_address: out std_logic_vector(31 downto 0)
		--pc_write: in std_logic
	);
   end component;
	-----------------------------------------------------------------------------
	component adder2 is
	port (
		x,y: in std_logic_vector(31 downto 0);
		z: out std_logic_vector(31 downto 0)
	);
   end component;
	-----------------------------------------------------------------------------
	component adder is
	port (
		x: in std_logic_vector(31 downto 0);
		y: in std_logic_vector(31 downto 0);
		z: out std_logic_vector(31 downto 0)
	);
   end component;
	------------------------------------------------------------------------------
	
	
	signal instruction_internal: std_logic_vector(31 downto 0);
	alias opcode is instruction_internal(31 downto 26);


	-- For any R type instruction:
	alias rs is instruction_internal(25 downto 21);
	alias rt is instruction_internal(20 downto 16);
	alias rd is instruction_internal(15 downto 11);
	alias shamt is instruction_internal(10 downto 6);
	alias funct is instruction_internal(5 downto 0);

	
	-- For load/store and branch instruction:
	alias address_of_instr is instruction_internal(15 downto 0);
	alias  target is instruction_internal (25 downto 0); 
	signal alu_in1: std_logic_vector(31 downto 0);
	signal alu_in2: std_logic_vector(31 downto 0);
	signal alu_zero: std_logic;
	signal alu_out: std_logic_vector(31 downto 0);
	
	-- Signals for register_memory instance:
	signal reg_read_data_1: std_logic_vector(31 downto 0);
	signal reg_write_data: std_logic_vector(4 downto 0);

	-- Signals for instruction_memory instance:
	signal inst_address: std_logic_vector(3 downto 0);

	-- Signals for sign_extend instance:
	signal sign_y: std_logic_vector(31 downto 0);

	signal reg_to_alu_and_mux: std_logic_vector(31 downto 0);
	signal mux_alu_c: std_logic_vector(31 downto 0);
	--Signal Aluzero and branch
	signal alu_zero_and_branch: std_logic;
	--Signals for Shift_left2
	signal shiftleft2: std_logic_vector(31 downto 0);
	--Signals for PC 
	signal PC_OUT: std_logic_vector(31 downto 0);
	signal PC_IN: std_logic_vector(31 downto 0);
	--Sifnals for ADD1
	signal ADD_OUT1: std_logic_vector(31 downto 0);
	--Signals for shift_left1
	signal shiftleft1: std_logic_vector(27 downto 0);
	--Signals for ADD2
	signal ADD_OUT2: std_logic_vector(31 downto 0);
	--concatenation
	signal jumpto: std_logic_vector (31 downto 0);
	--Signals data memory
	signal aluRes: std_logic_vector (31 downto 0);
	signal data_out_mem: std_logic_vector (31 downto 0);
	signal write_data: std_logic_vector (31 downto 0);
   --OUT MUX BRANCH
	signal out_mux_branch: std_logic_vector (31 downto 0);
	
	
	
	
	
begin
jumpto <= add_out1(31 downto 28)& shiftleft1	;
alu_zero_and_branch <= alu_zero and branch;	
	main_alu: alu 
	port map (
		in_1 => alu_in1,
		in_2 => mux_alu_c,
		alu_control_fuct => aluCnt,
		zero => alu_zero,
		alu_result => aluRes
	);

	reg_memory: registers
	port map (
		clock => clock,
		reg_write => regWrite,
		R_reg1 => rs,
		R_reg2 => rt,		
		W_reg => reg_write_data,
		W_data => write_data,
		R_data1 => alu_in1,
		R_data2 => reg_to_alu_and_mux
	);

	instruction_memry: instruction_memory
	port map (
		read_address => PC_OUT,
		instruction => instruction_internal
	);

	sign_extend_new: sign_extend
	port map (
		x => address_of_instr,
		y => sign_y	
	);

	mux_reg: mux 
	generic map(
		n=>5
	)
	
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
	mux_jump: mux 
	port map (
		a => out_mux_branch,
		b => jumpto,
		sel => jump,
		c => PC_IN
	);
	mux_memory: mux
	port map(
		a => AluRes,
		b => data_out_mem,
		sel => MemtoReg,
		c => write_data
	);
	mux_branch: mux
	port map(
		a => ADD_OUT1,
		b => ADD_OUT2,
		sel =>alu_zero_and_branch,
		c => out_mux_branch
	);

	
	shift26:shifter
	generic map(
		n1=>26,n2=>28,k=>2
	)
	port map(
		x => target,
		y => shiftleft1
	);
	shift32:shifter
	generic map(
		n1=>32,n2=>32,k=>2
	)
	port map(
	   x => sign_y,
		y => shiftleft2
	);
	
	counter:ProgramCounter
	port map(
		clock => clock,
		address_to_load => PC_IN,
		current_address => PC_OUT
	);
	Adderplus4:adder
	port map(
		x => PC_OUT,
		y => "00000000000000000000000000000100",
		z => ADD_OUT1
	);
	Adderloco:adder2
	port map(
		x => ADD_OUT1,
		y => shiftleft2,
		z => ADD_OUT2
	);
	datamemory:memory
	port map(
	   address=>AluRes,
	   write_data=>reg_to_alu_and_mux,
		MemWrite=>MemWrite,
		MemRead=>MemRead,
		clock=>clock,
		read_data=>data_out_mem
		);
		
	resultadoalu <=alures;
	regOut <= reg_to_alu_and_mux;

end micro_MIPS_arc;