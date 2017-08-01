LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
------------------------------------------------
ENTITY aluseq IS
	PORT(a,b:IN STD_LOGIC_VECTOR(3 DOWNTO 0);
		 sel:IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		 cin,clk:IN STD_LOGIC;
		 y_real:OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
		 cout,sign:OUT STD_LOGIC);
		 
END aluseq;
-------------------------------------------------
ARCHITECTURE flow OF aluseq IS
	Signal arith		:std_Logic_vector(4 downto 0);
	Signal logic		:std_Logic_vector(4 downto 0);
	 SIGNAL y_temp: STD_LOGIC_VECTOR (7 DOWNTO 0);
BEGIN
	process(a,b,sel,clk)
	begin 
-------Arithmetic unit----------------------------
CASE sel IS
 
	--WITH sel(2 DOWNTO 0)SELECT
		when 	"00000" 	=> 	y_real 		<= ("0000" & a);
		when 	"00001" 	=> 	y_real 		<=	("0000" & a)+1;
		when	"00010"	=> 	y_real 		<= ("000" & ('0'&(a)-1)) ;
		when 	"00011" 	=> 	y_real		<=	("0000" & b)  ;
		when 	"00100" 	=> 	y_real  		<=	("0000" & b)+1 ;
		when 	"00101" 	=> 	y_real 		<= ("000" & ('0'&(b)-1));
		when 	"00110" 	=> 	y_real 		<= ("0000" & a)+("0000" & b);
		when 	"00111" 	=> 	y_real		<=	("0000" & a)+("0000" & b)+cin; 
		when  "01000"  =>	 	y_real		<=	("0000" & (NOT a));
		when 	"01001"  =>		y_real 		<= ("0000" & (NOT b)) ;
		when  "01010"  =>    y_real		<=	("0000" & (a AND b)) ;
		when 	"01011"	=>		y_real		<=	("0000" & (a OR  b)) ;
		when 	"01100"	=>		y_real		<=	("0000" & (a NAND b)) ;
		when	"01101"	=>		y_real		<=	("0000" & (a NOR b)) ;
		when 	"01110"	=>		y_real		<=	("0000" & (a XOR b)) ;
		when 	"01111" 	=> 	y_real		<=	("0000" & (a XNOR b)) ;
		when others => 	y_temp <= NULL;
end case;
end process;
----------Mux------------------------------------
--WITH sel(3) SELECT
--		y<=arith WHEN '0',
--			logic WHEN OTHERS;

--WITH sel(3) SELECT
--		cout<=y(4) WHEN '0',
--			'0' WHEN OTHERS;
--y_real<=y(3 DOWNTO 0);

--
--Process(sel,clk)
--	variable temp,temp_a,temp_b,temp_cin:std_Logic_vector(8 downto 0);
--begin
--		If(clk'event AND clk='1') then
--			temp_a:="00000"&a;
--			temp_b:="00000"&b;
--			temp_cin:="00000000"&cin;
--			temp:=(others=>'0');
--			If(sel="0001")     then 
--				temp:=temp_a+1;
--			elsif (sel="0010") then 
--				temp:=temp_a-1;
--			elsif (sel="0100") then 
--				temp:=temp_b+1;
--			elsif (sel="0101") then 
--				temp:=temp_b-1;
--			elsif (sel="0110") then 
--				temp:=temp_a+temp_b;
--			elsif (sel="0111") then 
--				temp:=temp_a+temp_b+temp_cin;
--
--			else 						   
--				temp:=(Others=>'0');
--			end if;
--		end if;
--------------------- Carry & Sign flag -------------
--		If (temp(4)='1') then 
--			cout<='1';
--		else 						 
--			cout<='0';
--		end if;
--		If (temp(8)='1') then 
--			sign<='1';
--		else 						 
--			sign<='0';
--		end if;
--end Process;



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


--y_real<=y_temp;

--y_real<= "000" &arith when sel(4 downto 3)    = "00"    else
--		 "000"&logic when sel(4 downto 3)    = "01"    else
--		 "11111111";

END flow;

