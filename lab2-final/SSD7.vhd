Library ieee;
USE ieee.std_logic_1164.all;

ENTITY SSD7 is
PORT(
clk:IN std_logic;
data1,data2:IN std_logic_vector(3 downto 0);
digit1,digit2:OUT std_logic_vector(7 downto 0)
);
End SSD7;
Architecture counter of SSD7 is
Begin

-------------------BCD to SSD conversion---------------
process(clk)
begin
	CASE data2 IS
		WHEN "0000"=>digit2<="11000000";
		WHEN "0001"=>digit2<="11111001";
		WHEN "0010"=>digit2<="10100100";
		WHEn "0011"=>digit2<="10110000";
		WHEN "0100"=>digit2<="10011001";
		WHEN "0101"=>digit2<="10010010";
		WHEN "0110"=>digit2<="10000010";
		WHEN "0111"=>digit2<="11111000";
		WHEN "1000"=>digit2<="10000000";
		WHEN "1001"=>digit2<="10010000";
		WHEN "1111"=>digit2<="10111111";
		WHEN OTHERS=>NULL;
		end case;
	CASE data1 IS
		WHEN "0000"=>digit1<="11000000";
		WHEN "0001"=>digit1<="11111001";
		WHEN "0010"=>digit1<="10100100";
		WHEn "0011"=>digit1<="10110000";
		WHEN "0100"=>digit1<="10011001";
		WHEN "0101"=>digit1<="10010010";
		WHEN "0110"=>digit1<="10000010";
		WHEN "0111"=>digit1<="11111000";
		WHEN "1000"=>digit1<="10000000";
		WHEN "1001"=>digit1<="10010000";
		WHEN "1111"=>digit2<="10111111";
		WHEN OTHERS=>NULL;
		end case;
end Process;
End counter ;