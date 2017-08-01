LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
------------------------------------------------
ENTITY bcd_ascii IS
	PORT(data1,data2,data3		                              :IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		  sign					                               	:IN STD_LOGIC;
		  opcode						                              :In std_LOGIC_VECTOR(4 downto 0);
		  d0,d1,d2,sout,opcode1,opcode2,opcode3,opcode4			:OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		  );
END bcd_ascii;
-------------------------------------------------
ARCHITECTURE flow OF bcd_ascii IS
begin
d0<=	 X"30" WHEN data1 ="0000" ELSE
		 X"31" WHEN data1 ="0001" ELSE
		 X"32" WHEN data1 ="0010" ELSE
		 X"33" WHEN data1 ="0011" ELSE
		 X"34" WHEN data1 ="0100" ELSE
		 X"35" WHEN data1 ="0101" ELSE
		 X"36" WHEN data1 ="0110" ELSE
		 X"37" WHEN data1 ="0111" ELSE
		 X"38" WHEN data1 ="1000" ELSE
		 X"39" WHEN data1 ="1001" ELSE
		 X"45";

d1<=	 X"30" WHEN data2 ="0000" ELSE
		 X"31" WHEN data2 ="0001" ELSE
		 X"32" WHEN data2 ="0010" ELSE
		 X"33" WHEN data2 ="0011" ELSE
		 X"34" WHEN data2 ="0100" ELSE
		 X"35" WHEN data2 ="0101" ELSE
		 X"36" WHEN data2 ="0110" ELSE
		 X"37" WHEN data2 ="0111" ELSE
		 X"38" WHEN data2 ="1000" ELSE
		 X"39" WHEN data2 ="1001" ELSE
		 X"45";

d2<=	 X"30" WHEN data3 ="0000" ELSE
		 X"31" WHEN data3 ="0001" ELSE
		 X"32" WHEN data3 ="0010" ELSE
		 X"33" WHEN data3 ="0011" ELSE
		 X"34" WHEN data3 ="0100" ELSE
		 X"35" WHEN data3 ="0101" ELSE
		 X"36" WHEN data3 ="0110" ELSE
		 X"37" WHEN data3 ="0111" ELSE
		 X"38" WHEN data3 ="1000" ELSE
		 X"39" WHEN data3 ="1001" ELSE
		 X"45";
			 
sout<= X"2D" WHEN sign ='1' ELSE
		 X"20";
		 
opcode1<= X"20" WHEN opcode ="00000" ELSE
			 X"49" WHEN opcode ="00001" ELSE
			 X"44" WHEN opcode ="00010" ELSE
			 X"20" WHEN opcode ="00011" ELSE
			 X"49" WHEN opcode ="00100" ELSE
		  	 X"44" WHEN opcode ="00101" ELSE
			 X"20" WHEN opcode ="00110" ELSE
			 X"41" WHEN opcode ="00111" ELSE
			 X"6E" WHEN opcode ="01000" ELSE
			 X"6E" WHEN opcode ="01001" ELSE
			 X"20" WHEN opcode ="01010" ELSE
			 X"20" WHEN opcode ="01011" ELSE
			 X"6E" WHEN opcode ="01100" ELSE
			 X"20" WHEN opcode ="01101" ELSE
			 X"20" WHEN opcode ="01110" ELSE
			 X"78" WHEN opcode ="01111" ELSE
			 X"20" WHEN opcode ="10000" ELSE
			 X"20" WHEN opcode ="11000" ELSE
			 X"20";

opcode2<= X"20" WHEN opcode ="00000" ELSE
			 X"6E" WHEN opcode ="00001" ELSE
			 X"65" WHEN opcode ="00010" ELSE
			 X"20" WHEN opcode ="00011" ELSE
			 X"6E" WHEN opcode ="00100" ELSE
		  	 X"65" WHEN opcode ="00101" ELSE
			 X"41" WHEN opcode ="00110" ELSE
			 X"42" WHEN opcode ="00111" ELSE
			 X"6F" WHEN opcode ="01000" ELSE
			 X"6F" WHEN opcode ="01001" ELSE
			 X"41" WHEN opcode ="01010" ELSE
			 X"41" WHEN opcode ="01011" ELSE
			 X"61" WHEN opcode ="01100" ELSE
			 X"6E" WHEN opcode ="01101" ELSE
			 X"78" WHEN opcode ="01110" ELSE
			 X"6E" WHEN opcode ="01111" ELSE
			 X"41" WHEN opcode ="10000" ELSE
			 X"42" WHEN opcode ="11000" ELSE
			 X"20";

opcode3<= X"20" WHEN opcode ="00000" ELSE
			 X"64" WHEN opcode ="00001" ELSE
			 X"63" WHEN opcode ="00010" ELSE
			 X"20" WHEN opcode ="00011" ELSE
			 X"64" WHEN opcode ="00100" ELSE
		  	 X"63" WHEN opcode ="00101" ELSE
			 X"2B" WHEN opcode ="00110" ELSE
			 X"63" WHEN opcode ="00111" ELSE
			 X"74" WHEN opcode ="01000" ELSE
			 X"74" WHEN opcode ="01001" ELSE
			 X"26" WHEN opcode ="01010" ELSE
			 X"2F" WHEN opcode ="01011" ELSE
			 X"6E" WHEN opcode ="01100" ELSE
			 X"6F" WHEN opcode ="01101" ELSE
			 X"6F" WHEN opcode ="01110" ELSE
			 X"6F" WHEN opcode ="01111" ELSE
			 X"2A" WHEN opcode ="10000" ELSE
			 X"25" WHEN opcode ="11000" ELSE
			 X"20";

opcode4<= X"41" WHEN opcode ="00000" ELSE
			 X"41" WHEN opcode ="00001" ELSE
			 X"41" WHEN opcode ="00010" ELSE
			 X"42" WHEN opcode ="00011" ELSE
			 X"42" WHEN opcode ="00100" ELSE
		  	 X"42" WHEN opcode ="00101" ELSE
			 X"42" WHEN opcode ="00110" ELSE
			 X"79" WHEN opcode ="00111" ELSE
			 X"41" WHEN opcode ="01000" ELSE
			 X"42" WHEN opcode ="01001" ELSE
			 X"42" WHEN opcode ="01010" ELSE
			 X"42" WHEN opcode ="01011" ELSE
			 X"64" WHEN opcode ="01100" ELSE
			 X"72" WHEN opcode ="01101" ELSE
			 X"72" WHEN opcode ="01110" ELSE
			 X"72" WHEN opcode ="01111" ELSE
			 X"42" WHEN opcode ="10000" ELSE
			 X"42" WHEN opcode ="11000" ELSE
			 X"20";
			
END flow;
