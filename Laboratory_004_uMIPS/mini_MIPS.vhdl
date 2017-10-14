library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;        -- for addition & counting
use ieee.numeric_std.all;               -- for type conversions
use ieee.math_real.all;                 -- for the ceiling and log constant calculation functions



entity mini_MIPS is
  port (
	address: in std_logic_vector(3 downto 0);
	regDst: in std_logic;
	wrData: in std_logic;
	regWrite: in std_logic;
	aluSrc: in std_logic;
	aluCnt: in std_logic;

	Z: out std_logic;
	aluRes: out std_logic_vector(31 downto 0);
	regOut: out std_logic_vector(31 downto 0)
  
  );


end entity ; -- mini_MIPS

architecture arch of mini_MIPS is

	component alu is
		port (
			in_1, in_2: std_logic_vector(31 downto 0);
			alu_control_fuct: in std_logic_vector(3 downto 0);
			zero: out std_logic;
			alu_result: out std_logic_vector(31 downto 0)
		);
	end component alu;
	component instructions_memory is
		port (
			address: in std_logic_vector(3 downto 0);
			data: out std_logic_vector(31 downto 0)
		);
	end component instructions_memory;

	signal instruction: std_logic_vector(31 downto 0);
	alias opcode is instruction(31 downto 26);


	-- For any R type instruction:
	alias rs is instruction(25 to 21);
	alias rt is instruction(20 to 16);
	alias rd is instruction(15 to 11);
	alias shamt is instruction(10 to 6);
	alias funct is instruction(5 to 0);

	-- For load/store and branch instruction:
	alias address is instruction(15:0);

	-- Signals for alu instance:
	signal alu_fuct: std_logic_vector(3 downto 0) := "0000";
	signal alu_in1: std_logic_vector(31 downto 0);
	signal alu_in2: std_logic_vector(31 downto 0);
	signal alu_zero: std_logic;
	signal alu_out: std_logic_vector(31 downto 0);

	--util signals 
	signal type_op: integer range 0 to 2 := 0; 
	--signal alu_op_of_instruction: std
begin
	main_alu: alu 
	port map (
		in_1 => alu_in1,
		in_2 => alu_in2,
		alu_control_fuct => alu_fuct,
		zero => alu_zero,
		alu_result => alu_out
	);

	use_opcode : process(opcode)
	begin
		case (opcode) is
			when x"00" => opcode <= 0;
			when others => opcode <= 2;
		end case;
	end process ; -- use_opcode

	main_process : process(rs, rt, rd, shamt, funct, address)
	begin
		if (type_op = 0) then -- R type instructions
			
		else -- load, store and brach type

		end if;

		
	end process ; -- main_process

	alu_code_calculator : process(type_op, funct)
	begin
		if (type_op = 0) then -- The instruction is R type
			case (funct) is
				when x"20" => alu_fuct <= "0010";
				when x"22" => alu_fuct <= "0110";
				when x"24" => alu_fuct <= "0000";
					
				when others =>
					null;
			end case;
		end if;
	end process ; -- alu_code_calculator


end architecture ; -- arch