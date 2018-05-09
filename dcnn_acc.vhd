LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity dcnn_acc is 
	Generic (m : integer :=8);
port ( clk,rst,start,inst,size,stride: in std_logic;
	RAM_DataIn: in std_logic_vector(39 downto 0);
        done,RAM_En,RAM_RW:out std_logic;
        RAM_Address: out std_logic_vector(19 downto 0);
	RAM_DataOut: out std_logic_vector(7 downto 0));
end dcnn_acc;

architecture dcnn_acc_a of dcnn_acc is 

component img_address is 

port (Clk,Rst,read_wind_acc,ack_F,ack_Img,stride,size : in std_logic;
upc_out : std_logic_vector (19 downto 0);

upc_Img_address : out std_logic_vector( 19 downto 0)

);

end component;

component dma IS 
GENERIC ( n : integer := 8); 
		PORT (	Clk,hardRst,readIAcc,readFAcc ,
		            size:IN std_logic;	
		            inputpixel1,inputpixel2,inputpixel3,inputpixel4,inputpixel5: IN std_logic_vector(n-1 DOWNTO 0);
		            imgAdd,lastWrAdd  : in std_logic_vector(19 DOWNTO 0);
		            ramAddrBus	   : OUT std_logic_vector(19 DOWNTO 0);
			    outputpixel1,outputpixel2,outputpixel3,outputpixel4,outputpixel5 : OUT std_logic_vector(n-1 DOWNTO 0); 
			    FAck,IAck: OUT std_logic);       
END component;

component for_write is
generic ( n : integer := 8);  

PORT( Clk,Rst,write_acc,start,size,read_ors,read_ack: in std_logic;
 data_from_cache: in std_logic_vector( n-1 downto 0);
 ram_write_en , write_ack,write_Reg :  out std_logic;
 ram_write_address: out std_logic_vector( 19 downto 0)

);


end component;

component bet_cache_dma IS 
GENERIC ( n : integer := 8); 
		PORT (clk,rst,size,Ors_F : IN std_logic;
		    r0,r1,r2,r3,r4: IN std_logic_vector(n-1 DOWNTO 0);
                    counter_delayed_dma:  IN std_logic_vector(2 DOWNTO 0);
  		   alu1,alu2,alu3,alu4,alu5,alu6,alu7,alu8,alu9,alu10,alu11,alu12,alu13,alu14,alu15,alu16,alu17,alu18,alu19,alu20
,alu21,alu22,alu23,alu24,alu25 : OUT std_logic_vector(n-1 DOWNTO 0));    
END component;

component pre_read_and_done is 

port (Clk,Rst,read_Img_bgd_bgd,write_reg,write_ack: in std_logic;
    last_start_address : in std_logic_vector(19 downto 0);
counter_delayed: in std_logic_vector(2 downto 0);


Read_I_acc,done: out std_logic);

end component;

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

cache:bet_cache_dma port map();
	
end dcnn_acc_a;
