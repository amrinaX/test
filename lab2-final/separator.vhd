LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

entity separator is
port ( z	: IN std_logic_vector (12 downto 0);
		a,b: OUT std_logic_vector(3 downto 0);
		sel: OUT std_logic_vector(4 downto 0));
		
end separator;

architecture sini OF separator IS
signal temp:std_logic_vector (12 downto 0);
begin
	process(z)
	begin
	a <= z(3 downto 0);
	b <= z(7 downto 4);
	sel <=z(12 downto 8);
	temp<=z;
end process;
end sini;