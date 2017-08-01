LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
------------------------------------------------
ENTITY bcd_4 IS
	PORT(y_real		:IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		  sign,cin	:IN STD_LOGIC;
		  d0,d1		:OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		  );
END bcd_4;
-------------------------------------------------
ARCHITECTURE flow OF bcd_4 IS
SIGNAL temp : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN
	PROCESS(y_real)
	BEGIN
------------------------ negative number ------------------------
		IF  sign = '1' 							 			THEN		
			temp<= "0000" &( (NOT y_real) + 1);					
--		ELSIF (sign = '1' AND (NOT y_real)>"")			THEN		-- >29
--			temp<= "0000" &( (NOT y_real) + 1);					
--		ELSIF (sign = '1' AND (NOT y_real)>"") 		THEN		-- >19
--			temp<= "0000" &( (NOT y_real) + 1);					
--		ELSIF (sign = '1' AND (NOT y_real)>"")			THEN		-- >9
--			temp<= "0000" &( (NOT y_real) + 1);																							
------------------------ non-negative number ------------------------	
		ELSIF (y_real > "00011101" AND sign = '0') THEN		-- > 29 
			temp<= "0000" & y_real + "00010010";					-- + 18	
		ELSIF (y_real > "00010011" AND sign = '0') THEN		-- > 19
			temp<= "0000" & y_real + "00001100";					-- + 12
		ELSIF (y_real > "00001001" AND sign = '0') THEN		-- > 9
			temp<= "0000" & y_real + "00000110";					-- + 6
		ELSE
			temp<="0000"& y_real;
		END IF;
d1<=temp(7 DOWNTO 4);
d0<=temp(3 DOWNTO 0);

END PROCESS;
END flow;
