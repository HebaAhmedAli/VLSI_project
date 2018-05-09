LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

ENTITY Accelerator IS
GENERIC ( n : integer := 8);
PORT( Clk,Rst ,Start,Size,R_F_Ack, R_I_Ack,Write_ack,instr : in std_logic;
	 alu1,alu2,alu3,alu4,alu5,
	alu6,alu7,alu8,alu9,alu10,
	alu11,alu12,alu13,alu14,
	alu15,alu16,alu17,alu18,
	alu19,alu20,alu21,alu22,
	alu23,alu24,alu25 : in std_logic_vector(n-1 DOWNTO 0);  

	cache_w_in : out std_logic_vector(7 downto 0);
	R_I_acc,R_F_acc,Write_acc,en_W_cache : out std_logic
	);
END Accelerator;

ARCHITECTURE my_Accelerator OF Accelerator IS
component my_DFF IS
     PORT( clk,rst,en,d: IN std_logic;   q : OUT std_logic);
END component;

component my_DFF_rise IS
     PORT( clk,rst,en,d: IN std_logic;   q : OUT std_logic);
END component;


signal en_S,enP, R_F_ack_reg_out,R_F_Ack_buff : std_logic;
signal counter : std_logic_vector(2 downto 0);

BEGIN

R_F_ack_reg : my_DFF  PORT map (Clk,Rst,R_F_Ack, R_F_Ack, R_F_ack_reg_out);
R_F_ack_buff_reg : my_DFF_rise  PORT map (Clk,Rst,R_F_ack_reg_out, R_F_ack_reg_out, R_F_Ack_buff);


en_S<=R_F_Ack or R_F_Ack_buff;

en_P<= R_I_Ack or (counter != "000"); 




end my_Accelerator;