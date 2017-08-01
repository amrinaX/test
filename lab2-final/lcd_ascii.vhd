library ieee;
use ieee.std_logic_1164.all;

--To display correctlly, we must keep the waiting time between the first
--character and the last one in the non noticable senstivety eye range
--for moving objects.
--It has nothing to do with the overall frequency of the displayed text.
--Where once we write a character it's displayed forever
--(unless we wrote it over with another word!).

--In the case of improper timing, we need to generate the LCD_en,r/W
--signals inside the state_machine; so the en_signal will
--dynamically change to fit each instructon. And the waiting time
--between instructions will be controlled by reading the Busy_flag bit
--of the LCD. Each state in the FSM will be formulated to end up with
--reading the Busy_flag (after writing). That redaing will trigger
--the moving from one write state to another in the FSM.
--The proposed solution needs refinement.

entity lcd_ascii is
	port(
			pwr,bl										   : in std_logic;
			Digit_c1,Digit_c2,Digit_c3,sign_c,opcode_c1,opcode_c2,opcode_c3,opcode_c4: in std_logic_vector(7 downto 0);
			
			Digit_s1,Digit_s2,Digit_s3,sign_s,opcode_s1,opcode_s2,opcode_s3,opcode_s4: in std_logic_vector(7 downto 0);
			
			clk										      : in std_logic;
			lcd_en,lcd_rs,lcd_rw,lcd_on,lcd_blon	: out std_logic;
			lcd_data											: out std_logic_vector(7 downto 0)
		);
end lcd_ascii;

architecture behavioural of lcd_ascii is

	signal en_sig : std_logic;
	
	component en_gen
		port(
				clk,pwr	: in std_logic;
				en			: out std_logic
			);
	end component;
	
	component state_ascii
		port(
				clk,pwr,bl 												: in std_logic;
				lcm_rs,lcm_on,lcm_blon								: out std_logic;
				Buffer_c0,Buffer_c1,Buffer_C2,sign_buff_c   	: in std_logic_vector(7 downto 0);
				Buffer_s0,Buffer_s1,Buffer_s2,sign_buff_s   	: in std_logic_vector(7 downto 0);
				op_buff_c1,op_buff_c2,op_buff_c3,op_buff_c4	: in std_logic_vector(7 downto 0);
				op_buff_s1,op_buff_s2,op_buff_s3,op_buff_s4	: in std_logic_vector(7 downto 0);
				lcm_data													: out std_logic_vector(7 downto 0)
			);
	end component;

begin

	lcd_rw <= '0';
	lcd_en <= en_sig;
	lcd_en_gen	: en_gen port map( clk=>clk, pwr=>pwr, en=>en_sig );
	lcd_cnt		: state_ascii port map( clk=>en_sig, pwr=>pwr, bl=>bl, 
															  lcm_rs=>lcd_rs, lcm_data=>lcd_data, lcm_on=>lcd_on, lcm_blon=>lcd_blon, 
															  Buffer_c0=>Digit_c1, Buffer_c1=>Digit_c2 ,buffer_c2=>Digit_c3, sign_buff_c=>sign_c,
															  op_buff_c1=>opcode_c1,op_buff_c2=>opcode_c2,op_buff_c3=>opcode_c3,op_buff_c4=>opcode_c4,
															  Buffer_s0=>Digit_s1, Buffer_s1=>Digit_s2 ,buffer_s2=>Digit_s3, sign_buff_s=>sign_s,
															  op_buff_s1=>opcode_s1,op_buff_s2=>opcode_s2,op_buff_s3=>opcode_s3,op_buff_s4=>opcode_s4
															 );

end behavioural;
