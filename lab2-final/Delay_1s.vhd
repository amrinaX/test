library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

Entity Delay_1s IS
Port(
	Clock27Mhz 	  					: IN std_logic;
	data_out1,data_out2			: OUT std_logic_vector(12 downto 0);
	Address_out : out std_logic_vector(5 downto 0);
	wr: OUT std_logic
--	addr_A,addr_B : OUT std_logic_vector(4 downto 0);
--	addr_Op_con,addr_Op_seq  : OUT std_logic_vector(4 downto 0)
	
	);
end Delay_1s;

Architecture flow of Delay_1s IS
signal A,B 		:std_logic_vector	(3 downto 0);
signal OPC,OPS :std_logic_vector (4 downto 0);

begin
	Process(clock27Mhz)
		variable counter,delay,temp_a,temp_opcode_con,temp_opcode_seq : integer:=0;
		variable temp_b :integer:=0;

		begin
		if(clock27Mhz'EVENT AND clock27Mhz='1') then
		
				if(delay< 27000001) then
					delay:=delay+1;
					else
					delay:=1;
					counter:=counter+1;
					
				end if; 	
								
		
						
				if(counter=2)then 		--2sec delay
					counter:=0;
					if(temp_a<16)then 	--add_a punya
						temp_a:=temp_a+1;
					else
						temp_a:=0;
					end if;
			
					if(temp_b<16)then 		--add_b punya
						temp_b:=temp_b+1;
					else
						temp_b:=0;				--sebab depa share same ram so sambung
					end if;
				
					if(temp_opcode_con<16)then
						temp_opcode_con:=temp_opcode_con+1;
					elsif	(temp_opcode_con=16) then
						temp_opcode_con:=24;
					else
						temp_opcode_con:=0;
					end if;							-----habis
				
					if(temp_opcode_seq<16)then
						temp_opcode_seq:=temp_opcode_seq+1;
					elsif (temp_opcode_seq=16) then
						temp_opcode_seq:=24;
					else 
							temp_opcode_seq:=0;
					end if;							
				end if; 	
		

A<=conv_std_logic_vector(temp_a,4);
B<=conv_std_logic_vector(temp_b,4);
OPC<=conv_std_logic_vector(temp_opcode_con,5);
OPS<=conv_std_logic_vector(temp_opcode_seq,5);
		
if (delay=100) then	
data_out1<= OPC & B & A;
data_out2<= OPS & B & A;
wr<='1';
Address_out<="000000";
else 
wr<='0';
Address_out<="000000";
end if;


end if;


--addr_A<=conv_std_logic_vector(temp_a,5);		
--addr_B<=conv_std_logic_vector(temp_b,5);
--addr_Op_con<=conv_std_logic_vector(temp_opcode_con,5);
--addr_Op_seq<=conv_std_logic_vector(temp_opcode_seq,5);	
		
			
end Process;
end flow;
			
				
			