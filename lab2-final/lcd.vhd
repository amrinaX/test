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

entity lcd is
	port(
			pwr,bl,clk,sign								: in std_logic;
			Digit3,Digit2,Digit1							: in std_logic_vector(3 downto 0);
			lcd_en,lcd_rs,lcd_rw,lcd_on,lcd_blon	: out std_logic;
			lcd_data											: out std_logic_vector(7 downto 0)
		);
end lcd;

architecture behavioural of lcd is

	signal en_sig : std_logic;
	
	component en_gen
		port(
				clk,pwr	: in std_logic;
				en			: out std_logic
			);
	end component;
	
	component state_machine
		port(
				clk,pwr,bl,sign_buff 	: in std_logic;
				lcm_rs,lcm_on,lcm_blon	: out std_logic;
				Buffer0,Buffer1,Buffer2	: in std_logic_vector(3 downto 0);
				lcm_data						: out std_logic_vector(7 downto 0)
			);
	end component;

begin

	lcd_rw <= '0';
	lcd_en <= en_sig;
	lcd_en_gen	: en_gen port map( clk=>clk, pwr=>pwr, en=>en_sig );
	lcd_cnt		: state_machine port map( clk=>en_sig, pwr=>pwr, bl=>bl, lcm_rs=>lcd_rs, lcm_data=>lcd_data, lcm_on=>lcd_on, lcm_blon=>lcd_blon, Buffer0=>Digit1, Buffer1=>Digit2 ,buffer2=>Digit3, sign_buff=>sign );

end behavioural;