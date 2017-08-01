LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;
------------------------------------------------
ENTITY bcd IS
	PORT(y_real					:IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			
		  cin,sign	:IN STD_LOGIC;
		  x_real		:IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		  z_real		:IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		  opcode		:In std_LOGIC_VECTOR(4 downto 0);
		  d0,d1,d2	:OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		  );
END bcd;
-------------------------------------------------
ARCHITECTURE flow OF bcd IS
SIGNAL temp : STD_LOGIC_VECTOR(11 DOWNTO 0);

BEGIN
	PROCESS(y_real)
	variable temp_ans:std_Logic_vector(7 downto 0);
	BEGIN
--------------------Check Mult and Divi ---------------------------

		IF (opcode="10000") then
			temp_ans:=x_real;
		ElsIF (opcode="11000") then
			temp_ans:="0000"&z_real;
		ELSE
			temp_ans:=y_real;
		END IF;


--------------------negative number ------------------------
		IF (sign='1' AND cin='1')	THEN	
			temp<= "0000" &( ("00011111" - y_real) +1 );	
		ElsIF (sign= '1' AND cin='0') THEN
			temp<="111111111111";
			

																							
------------------------ non-negative number ------------------------
		ELSIF (temp_ans > 249 AND sign = '0') THEN
			temp<= "0000" & temp_ans + 342;
		ELSIF (temp_ans > 239 AND sign = '0') THEN	-- > 239 
			temp<= "0000" & temp_ans + 336;				-- + 150H
		ELSIF (temp_ans > 229 AND sign = '0') THEN		-- > 229 
			temp<= "0000" & temp_ans + 330;				-- + 14AH
		ELSIF (temp_ans > 219 AND sign = '0') THEN		-- > 219 
			temp<= "0000" & temp_ans + 324;				-- + 144H
		ELSIF (temp_ans > 209 AND sign = '0') THEN		-- > 209 
			temp<= "0000" & temp_ans + 318;				-- + 13EH
		ELSIF (temp_ans > 199 AND sign = '0') THEN		-- > 199 
			temp<= "0000" & temp_ans + 312;				-- + 138H
		ELSIF (temp_ans > 189 AND sign = '0') THEN		-- > 189 
			temp<= "0000" & temp_ans + 210;				-- +  D2H
		ELSIF (temp_ans > 179 AND sign = '0') THEN		-- > 179 
			temp<= "0000" & temp_ans + 204;				-- +  CCH
		ELSIF (temp_ans > 169 AND sign = '0') THEN		-- > 169 
			temp<= "0000" & temp_ans + 198;				-- +  C6H
		ELSIF (temp_ans > 159 AND sign = '0') THEN		-- > 159 
			temp<= "0000" & temp_ans + 192;				-- +  C0H
		ELSIF (temp_ans > 149 AND sign = '0') THEN		-- > 149	
			temp<= "0000" & temp_ans + 186;				-- +  BAH
		ELSIF (temp_ans > 139 AND sign = '0') THEN		-- > 139 
			temp<= "0000" & temp_ans + 180;				-- +  B4H
		ELSIF (temp_ans > "10000001" AND sign = '0') THEN		-- > 129 
			temp<= "0000" & temp_ans + 174;				-- +  AEH	
		ELSIF (temp_ans > "01110111" AND sign = '0') THEN		-- > 119 
			temp<= "0000" & temp_ans + 168;				-- +  A8H	
		ELSIF (temp_ans > "01101101" AND sign = '0') THEN		-- > 109  
			temp<= "0000" & temp_ans + 162;				-- +  A2H	
		ELSIF (temp_ans > "01100011" AND sign = '0') THEN		-- > 99 
			temp<= "0000" & temp_ans + 156;				-- +  9CH	
		ELSIF (temp_ans > "01011001" AND sign = '0') THEN		-- > 89 
			temp<= "0000" & temp_ans + "00110110";				-- + 54	
		ELSIF (temp_ans > "01001111" AND sign = '0') THEN		-- > 79 
			temp<= "0000" & temp_ans + "00110000";	      	-- + 48	
		ELSIF (temp_ans > "01000101" AND sign = '0') THEN		-- > 69 
			temp<= "0000" & temp_ans + "00101010";				-- + 42	
		ELSIF (temp_ans > "00111011" AND sign = '0') THEN		-- > 59 
			temp<= "0000" & temp_ans + "00100100";				-- + 36	
		ELSIF (temp_ans > "00110001" AND sign = '0') THEN		-- > 49 
			temp<= "0000" & temp_ans + "00011110";				-- + 30	
		ELSIF (temp_ans > "00100111" AND sign = '0') THEN		-- > 39 
			temp<= "0000" & temp_ans + "00011000";				-- + 24	
		ELSIF (temp_ans > "00011101" AND sign = '0') THEN		-- > 29 
			temp<= "0000" & temp_ans + "00010010";				-- + 18	
		ELSIF (temp_ans > "00010011" AND sign = '0') THEN		-- > 19
			temp<= "0000" & temp_ans + "00001100";				-- + 12
		ELSIF (temp_ans > "00001001" AND sign = '0') THEN		-- > 9
			temp<= "0000" & temp_ans + "00000110";				-- + 6
		ELSE
			temp<="0000"& temp_ans;
		END IF;
d2<=temp(11 downto 8);
d1<=temp(7 DOWNTO 4);
d0<=temp(3 DOWNTO 0);

END PROCESS;
END flow;
