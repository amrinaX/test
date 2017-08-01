Library ieee;
USE ieee.std_logic_1164.all;

ENTITY dispSel is
PORT(
	clk								 :IN std_logic;
	data								 :IN std_logic_vector(4 downto 0);
	digit1,digit2,digit3,digit4 :OUT std_logic_vector(7 downto 0)
	
);
End dispSel ;
Architecture counter of dispSel  is
Begin

-------------------BCD to SSD conversion---------------
process(clk)
begin
	if(data(4)='0')then
	CASE data(0) IS
		WHEN '0'=>digit1<="11000000";
		WHEN '1'=>digit1<="11111001";
		WHEN OTHERS=>NULL;
		end case;
	CASE data(1) IS
		WHEN '0'=>digit2<="11000000";
		WHEN '1'=>digit2<="11111001";
		WHEN OTHERS=>NULL;
		end case;
	CASE data(2) IS
		WHEN '0'=>digit3<="11000000";
		WHEN '1'=>digit3<="11111001";
		WHEN OTHERS=>NULL;
		end case;
	CASE data(3) IS
		WHEN '0'=>digit4<="11000000";
		WHEN '1'=>digit4<="11111001";
		WHEN OTHERS=>NULL;
		end case;
	else
		digit1<=X"FF";
		digit2<=X"FF";
		CASE data(3) IS
		WHEN '0'=>digit3<="11000000";
		WHEN '1'=>digit3<="11111001";
		WHEN OTHERS=>NULL;
		end case;
		CASE data(4) IS
		WHEN '0'=>digit4<="11000000";
		WHEN '1'=>digit4<="11111001";
		WHEN OTHERS=>NULL;
		end case;
	end if;
end Process;
End counter ;