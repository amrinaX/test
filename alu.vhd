LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
------------------------------------------------
ENTITY alu IS
	PORT(a,b:IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 sel:IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 cin,clk:IN STD_LOGIC;
		 y_real:OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 cout,sign:OUT STD_LOGIC);
		 
END alu;
-------------------------------------------------
ARCHITECTURE flow OF alu IS
	Signal arith		:std_Logic_vector(4 downto 0);
	Signal logic		:std_Logic_vector(4 downto 0);
	 SIGNAL y: STD_LOGIC_VECTOR (4 DOWNTO 0);
BEGIN
-------Arithmetic unit----------------------------
	WITH sel(2 DOWNTO 0)SELECT
		arith<= ('0' & a) WHEN "000",
				('0' & a)+1 WHEN "001",
				('0' & a)-1 WHEN "010",
				('0' & b)   WHEN "011",
			('0' & b)+1 WHEN "100",
			('0' & b)-1	WHEN "101",
			('0' & a)+('0' & b) WHEN "110",
			('0' & a)+('0' & b)+cin WHEN OTHERS;
---------Logic unit--------------------------------
WITH sel(2 DOWNTO 0) SELECT
	logic<= 		('0' & NOT a) WHEN "000",
					('0' & NOT b) WHEN "001",
			('0' & (a AND b))  WHEN "010",
			('0' & (a OR b) )  WHEN "011",
			('0' & (a NAND b))WHEN "100",
			('0' & (a NOR b))  WHEN "101",
			('0' & (a XOR b))  WHEN "110",
			('0' & (a XNOR b)) WHEN OTHERS;
----------Mux------------------------------------
--WITH sel(3) SELECT
--		y<=arith WHEN '0',
--			logic WHEN OTHERS;

--WITH sel(3) SELECT
--		cout<=y(4) WHEN '0',
--			'0' WHEN OTHERS;
--y_real<=y(3 DOWNTO 0);


Process(sel,clk)
	variable temp,temp_a,temp_b,temp_cin:std_Logic_vector(8 downto 0);
begin
		If(clk'event AND clk='1') then
			temp_a:="00000"&a;
			temp_b:="00000"&b;
			temp_cin:="00000000"&cin;
			temp:=(others=>'0');
			If(sel="0001")     then 
				temp:=temp_a+1;
			elsif (sel="0010") then 
				temp:=temp_a-1;
			elsif (sel="0100") then 
				temp:=temp_b+1;
			elsif (sel="0101") then 
				temp:=temp_b-1;
			elsif (sel="0110") then 
				temp:=temp_a+temp_b;
			elsif (sel="0111") then 
				temp:=temp_a+temp_b+temp_cin;

			else 						   
				temp:=(Others=>'0');
			end if;
		end if;
------------------- Carry & Sign flag -------------
		If (temp(4)='1') then 
			cout<='1';
		else 						 
			cout<='0';
		end if;
		If (temp(8)='1') then 
			sign<='1';
		else 						 
			sign<='0';
		end if;
end Process;

y_real<= "000" &arith when sel(4 downto 3)    = "00"    else
		 "000"&logic when sel(4 downto 3)    = "01"    else
		 "11111111";

END flow;

