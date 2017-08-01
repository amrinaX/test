----------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
----------------------------------------------
ENTITY aluc IS
	PORT (a: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		b: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		sel: IN STD_LOGIC_VECTOR (4 DOWNTO 0);
		y_real: OUT STD_LOGIC_VECTOR (7 DOWNTO 0);
		cin,clk: IN STD_LOGIC;
		cout,sign: OUT STD_LOGIC);
END aluc;
----------------------------------------------
ARCHITECTURE dataflow OF aluc IS
	 SIGNAL y: STD_LOGIC_VECTOR (4 DOWNTO 0);
BEGIN
----- Logic unit: ---------------------------------------------
	y <= '0' & ( NOT a) WHEN sel="0000" ELSE
		'0' & (NOT b) WHEN sel="0001" ELSE
		'0' & (a AND b) WHEN sel="0010" ELSE
		'0' & (a OR b) WHEN sel="0011" ELSE
		'0' & (a NAND b) WHEN sel="0100" ELSE
		'0' & (a NOR b) WHEN sel="0101" ELSE
		'0' & (a XOR b) WHEN sel="0110" ELSE
		'0' & (NOT (a XOR b)) WHEN sel="0111" ELSE
----- Arithmetic unit: -----------
		('0' & a) WHEN sel="1000" ELSE
		('0' & b) WHEN sel="1001" ELSE
		('0' & a) + 1 WHEN sel="1010" ELSE
		('0' & b) + 1 WHEN sel="1011" ELSE
		('0' & a) - 1 WHEN sel="1100" ELSE
		('0' & b) - 1 WHEN sel="1101" ELSE
		('0' & a) + ('0' & b) WHEN sel="1110" ELSE
		('0' & a) + ('0' & b) + cin;
Process (sel,clk)
	variable temp, temp_a, temp_b, temp_cin: STD_LOGIC_VECTOR (8 DOWNTO 0);
begin
	if (clk'event AND clk='1') then
		temp_a := "00000" & a;
		temp_b := "00000" & b;
		temp_cin := "00000000" & cin;
		temp := (others => '0');
		if (sel = "1010") then
			temp := temp_a + 1;
		elsif (sel = "1011") then
			temp := temp_b + 1;
		elsif (sel = "1100") then
			temp := temp_a - 1;
		elsif (sel = "1101") then
			temp := temp_b - 1;
		elsif (sel = "1110") then
			temp := temp_a + temp_b;
		elsif (sel = "1111") then
			temp := temp_a + temp_b + temp_cin;
		else
			temp := (Others => '0');
		end if;
	end if;
------- cout and sign: --------------
	if (temp(4) = '1') then
	cout <= '1';
	else
		cout <= '0';
	end if;
	if (temp(8) = '1') then
		sign <= '1';
	else
		sign <= '0';
	end if;
end Process;
----- mux -------------------
y_real <= 	"000" & y WHEN sel(4 DOWNTO 3) = "01" ELSE
				"000" & y WHEN sel(4 DOWNTO 3) = "00" ELSE
				"11111111";
END dataflow;
----------------------------------------------