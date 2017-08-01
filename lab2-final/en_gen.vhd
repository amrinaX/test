library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;


entity en_gen is
	port(
			clk,pwr	: in std_logic;
			en			: out std_logic
		);
end en_gen;

architecture behavioural of en_gen is

begin

	process(clk, pwr)	--int_clk = 27MHZ
	
		variable c : integer :=0;
	
	begin
	
		if (clk'event and clk = '1') then
			if (pwr = '1') then
				if (c = 54000) then
					c := 1;
				else
					c := c + 1;
				end if;	
				if (c <= 27000) then
					en <= '0';
				else
					en <= '1';
				end if;
			end if;
		end if;
	
	end process;

end behavioural;