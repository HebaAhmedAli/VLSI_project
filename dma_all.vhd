LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity dma_all is 
	Generic (n : integer :=8);
port ( clk,rst,start,size,stride,readIAcc,readFAcc,write_acc : in std_logic;
	RAM_DataIn: in std_logic_vector(39 downto 0);
        data_from_cache: in std_logic_vector( n-1 downto 0);
        done,RAM_En,RAM_RW,FAck,IAck,write_ack:out std_logic;
        RAM_Address: out std_logic_vector(19 downto 0);
	RAM_DataOut: out std_logic_vector(7 downto 0);
       outputpixel1,outputpixel2,outputpixel3,outputpixel4,outputpixel5 : OUT std_logic_vector(n-1 DOWNTO 0);
       counter_delayed:OUT std_logic_vector(2 DOWNTO 0));
end dma_all;

architecture dma_all_a of dma_all is 

component img_address is 

port (Clk,Rst,read_wind_acc,ack_F,ack_Img,stride,size : in std_logic;
upc_out : in std_logic_vector (19 downto 0);

upc_Img_address : out std_logic_vector( 19 downto 0)

);

end component;

component dma IS 
GENERIC ( n : integer := 8); 
		PORT (	Clk,hardRst,readIAcc,readFAcc ,
		            size:IN std_logic;	
		            inputpixel1,inputpixel2,inputpixel3,inputpixel4,inputpixel5: IN std_logic_vector(n-1 DOWNTO 0);
		            imgAdd,lastWrAdd  : in std_logic_vector(19 DOWNTO 0);
		            ramAddrBus  : OUT std_logic_vector(19 DOWNTO 0);
			    outputpixel1,outputpixel2,outputpixel3,outputpixel4,outputpixel5 : OUT std_logic_vector(n-1 DOWNTO 0); 
			    FAck,IAck,readORs_out: OUT std_logic;
                            counter_delayed:OUT std_logic_vector(2 DOWNTO 0));       
END component;

component for_write is
generic ( n : integer := 8);  

PORT( Clk,Rst,write_acc,start,size,read_ors,read_ack: in std_logic;
 data_from_cache: in std_logic_vector( n-1 downto 0);
 ram_write_en , write_ack,write_Reg :  out std_logic;
 ram_write_address: out std_logic_vector( 19 downto 0)

);

end component;

component pre_read_and_done is 

port (Clk,Rst,read_Img_bgd_bgd,write_reg,write_ack: in std_logic;
    last_start_address : in std_logic_vector(19 downto 0);
counter_delayed: in std_logic_vector(2 downto 0);

Read_I_acc,done: out std_logic);

end component;

signal R_I_acc_from_pre_read,FAck_sig,IAck_sig,readORs_out_sig : std_logic;
signal ramAddrBus_sig,upc_Img_address_sig:std_logic_vector(19 downto 0);
begin 

img_addresss:img_address port map(Clk => clk,Rst => rst,read_wind_acc =>R_I_acc_from_pre_read,
ack_F => FAck_sig,ack_Img => IAck_sig,stride => stride,size => size,
upc_out => ramAddrBus_sig,upc_Img_address => upc_Img_address_sig
 );

end dma_all_a;
