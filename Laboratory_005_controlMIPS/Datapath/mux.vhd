
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux is 
	generic (n: natural:= 1); -- number of bits in the choices
	port (
		a,b: in std_logic_vector(n-1 downto 0);
		sel: in std_logic;
		c: out std_logic_vector(n-1 downto 0)
	);
end mux;

architecture beh of mux is
	begin
	c <= a when (sel='0') else b;
end beh;
