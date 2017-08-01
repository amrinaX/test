library ieee;
use ieee.std_logic_1164.all;


entity state_ascii is
	port(
			clk,pwr,bl						            	  : in std_logic;
			lcm_rs,lcm_on,lcm_blon			              : out std_logic;
			Buffer_c0,Buffer_c1,Buffer_C2,sign_buff_c   : in std_logic_vector(7 downto 0);
			Buffer_s0,Buffer_s1,Buffer_s2,sign_buff_s   : in std_logic_vector(7 downto 0);
			op_buff_c1,op_buff_c2,op_buff_c3,op_buff_c4 : in std_logic_vector(7 downto 0);
			op_buff_s1,op_buff_s2,op_buff_s3,op_buff_s4 : in std_logic_vector(7 downto 0);
			lcm_data						               	  : out std_logic_vector(7 downto 0)
		);
end state_ascii;

architecture behavioural of state_ascii is
	type state_type is (
							ini_ln_fn,ini_lcd_off,ini_lcd_clr,ini_lcd_on,ini_lcd_2ndline,
							entry_mode_set,
							ini_lcd_1stline,
							
							sign_c0,
							res_buffer_c0,res_buffer_c1,res_buffer_c2,
							op_state_c0,op_state_c1,op_state_c2,op_state_c3,
							
							sign_s0,
							res_buffer_s0,res_buffer_s1,res_buffer_s2,
							op_state_s0,op_state_s1,op_state_s2,op_state_s3,
							
							return_home
						);
	signal cur_state, next_state: state_type;

begin
	process(cur_state)
	
	begin
	
		case cur_state is
			when ini_ln_fn =>
				next_state <= ini_lcd_off;

			when ini_lcd_off =>
				next_state <= ini_lcd_clr;

			when ini_lcd_clr =>
				next_state <= ini_lcd_on;

			when ini_lcd_on =>
				next_state <= entry_mode_set;
				
			when entry_mode_set =>
				next_state <= ini_lcd_1stline;
				
			when ini_lcd_1stline=>
				next_state <= sign_c0;
				
			when sign_c0 =>
				next_state<= res_buffer_c2;
				
			when res_buffer_c2 =>
				next_state <= res_buffer_c1;
				
			when res_buffer_c1 =>
			   next_state <= res_buffer_c0;
			
			when res_buffer_c0=>
				next_state <= op_state_c0;
			
			when op_state_c0=>
				next_state <= op_state_c1;
			
			when op_state_c1=>
				next_state <= op_state_c2;
				
			when op_state_c2=>
				next_state <= op_state_c3;
				
			when op_state_c3 =>
				next_state <= ini_lcd_2ndline;
			
			when ini_lcd_2ndline=>
				next_state <= sign_s0;
				
			when sign_s0 =>
				next_state <= res_buffer_s2;
				
			when res_buffer_s2=>
				next_state <= res_buffer_s1;
				
			when res_buffer_s1=>
				next_state <= res_buffer_s0;
				
			when res_buffer_s0 =>
				next_state <= op_state_s0;
				
			when op_state_s0 =>
				next_state <= op_state_s1;
				
			when op_state_s1 =>
				next_state <= op_state_s2;
			
			when op_state_s2 =>
				next_state <= op_state_s3;
				
			when op_state_s3 =>
			   next_state <= ini_lcd_1stline;
				
			when others =>
				next_state <= return_home;

		end case;
		
	end process;

	Process(clk, pwr)
	begin
		if (pwr = '0') then
			cur_state <= ini_ln_fn;
		elsif (clk'event and clk = '1') then
			if (pwr = '1') then
				cur_state <= next_state;
			end if;
		end if;
		
	end process;
	
	process(cur_state)
	begin
	
		case cur_state is
		
			when ini_ln_fn =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
				lcm_rs <= '0';
				lcm_on <= '1';
				lcm_data <= X"38";

			when ini_lcd_off =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
				lcm_rs <= '0';
				lcm_on <= '1';
				lcm_data <= X"08";

			when ini_lcd_clr =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
				lcm_rs <= '0';
				lcm_on <= '1';
				lcm_data <= X"01";

			when ini_lcd_on =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
				lcm_rs <= '0';
				lcm_on <= '1';
				lcm_data <= X"0C";

			when entry_mode_set =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
				lcm_rs <= '0';
				lcm_on <= '1';
				lcm_data <= X"06";
				
			when ini_lcd_2ndline =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
				lcm_rs <= '0';
				lcm_on <= '1';
				lcm_data <= X"C0";
				
			when res_buffer_c0 =>
				if (bl = '1') then
					lcm_blon <= '1';
			else
				lcm_blon <= '0';
			end if;
					lcm_rs <='1';
					lcm_on <='1';
					lcm_data <= buffer_c0;			-------------------------- digit1
					
			when res_buffer_c1 =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
					lcm_rs <='1';
					lcm_on <='1';
					lcm_data <= buffer_c1;		------------------------------ digit2
					
			when res_buffer_c2 =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
					lcm_rs <='1';
					lcm_on <='1';
					lcm_data <= buffer_c2;   ---------------------------------digit3
				
			when sign_c0 =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
					lcm_rs <='1';
					lcm_on <='1';
					lcm_data <= sign_buff_c;-----------------------------------sign
					
			when op_state_c0 =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
					lcm_rs <='1';
					lcm_on <='1';
					lcm_data <= op_buff_c1;-----------------------------------opcode0
					
			when op_state_c1 =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
					lcm_rs <='1';
					lcm_on <='1';
					lcm_data <= op_buff_c2;-----------------------------------opcode1
					
			when op_state_c2 =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
					lcm_rs <='1';
					lcm_on <='1';
					lcm_data <= op_buff_c3;-----------------------------------opcode2
					
			when op_state_c3 =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
					lcm_rs <='1';
					lcm_on <='1';
					lcm_data <= op_buff_c4;-----------------------------------opcode3
					
				when res_buffer_s0 =>
				if (bl = '1') then
					lcm_blon <= '1';
			else
				lcm_blon <= '0';
			end if;
					lcm_rs <='1';
					lcm_on <='1';
					lcm_data <= buffer_s0;			-------------------------- digit1
					
			when res_buffer_s1 =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
					lcm_rs <='1';
					lcm_on <='1';
					lcm_data <= buffer_s1;		------------------------------ digit2
					
			when res_buffer_s2 =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
					lcm_rs <='1';
					lcm_on <='1';
					lcm_data <= buffer_s2;   ---------------------------------digit3
				
			when sign_s0 =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
					lcm_rs <='1';
					lcm_on <='1';
					lcm_data <= sign_buff_s;-----------------------------------sign
					
			when op_state_s0 =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
					lcm_rs <='1';
					lcm_on <='1';
					lcm_data <= op_buff_s1;-----------------------------------opcode0
					
			when op_state_s1 =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
					lcm_rs <='1';
					lcm_on <='1';
					lcm_data <= op_buff_s2;-----------------------------------opcode1
					
			when op_state_s2 =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
					lcm_rs <='1';
					lcm_on <='1';
					lcm_data <= op_buff_s3;-----------------------------------opcode2
					
			when op_state_s3 =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
					lcm_rs <='1';
					lcm_on <='1';
					lcm_data <= op_buff_s4;-----------------------------------opcode3
					
			when ini_lcd_1stline=>
				if (bl ='1') then
					lcm_blon <= '1';
					else
					lcm_blon <= '0';
				end if;
				
				lcm_rs <='0';
				lcm_on<='1';
				lcm_data <= X"80";

			when others =>
				if (bl = '1') then
					lcm_blon <= '1';
				else
					lcm_blon <= '0';
				end if;
				lcm_rs <= '0';
				lcm_on <= '1';
				lcm_data <= X"02";

		end case;
	
	end process;

end behavioural;