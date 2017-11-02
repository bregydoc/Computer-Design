library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ProgramCounter is
	port(
		clock: in std_logic;
		address_to_load: in std_logic_vector(31 downto 0);
		current_address: out std_logic_vector(31 downto 0)
		--pc_write: in std_logic
	);
end ProgramCounter;

architecture beh of ProgramCounter is

	signal address: std_logic_vector(31 downto 0):= "00000000000000000000000000000000";

	begin

	process(clock)
		begin
		current_address <= address;
		if clock='1' and clock'event then
			address <= address_to_load;
		end if;
	end process;

end beh;
