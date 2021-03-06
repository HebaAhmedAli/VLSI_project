LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity dcnn_acc is 
	Generic (n : integer :=8);
port ( clk,rst,start,inst,size,stride: in std_logic;
	RAM_DataIn: in std_logic_vector(39 downto 0);
        done,RAM_En,RAM_RW:out std_logic;
        RAM_Address: out std_logic_vector(19 downto 0);
	RAM_DataOut: out std_logic_vector(7 downto 0));
end dcnn_acc;

architecture dcnn_acc_a of dcnn_acc is 

component dma_all is 
	Generic (n: integer :=8);
port ( clk,rst,start,size,stride,readIAcc,readFAcc,write_acc : in std_logic;
	RAM_DataIn: in std_logic_vector(39 downto 0);
        data_from_cache: in std_logic_vector( n-1 downto 0);
        done,RAM_En,RAM_RW,FAck,IAck,write_ack:out std_logic;
        RAM_Address: out std_logic_vector(19 downto 0);
	RAM_DataOut: out std_logic_vector(7 downto 0);
       outputpixel1,outputpixel2,outputpixel3,outputpixel4,outputpixel5 : OUT std_logic_vector(n-1 DOWNTO 0);
       counter_delayed:OUT std_logic_vector(2 DOWNTO 0));
end component;

component bet_cache_dma IS 
GENERIC ( n : integer := 8); 
		PORT (clk,rst,size,Ors_F : IN std_logic;
		    r0,r1,r2,r3,r4: IN std_logic_vector(n-1 DOWNTO 0);
                    counter_delayed_dma:  IN std_logic_vector(2 DOWNTO 0);
  		   alu1,alu2,alu3,alu4,alu5,alu6,alu7,alu8,alu9,alu10,alu11,alu12,alu13,alu14,alu15,alu16,alu17,alu18,alu19,alu20
,alu21,alu22,alu23,alu24,alu25 : OUT std_logic_vector(n-1 DOWNTO 0));    
END component;


component Accelerator IS
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
END component;


begin 


end dcnn_acc_a;
