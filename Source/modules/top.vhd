----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:07:32 03/05/2018 
-- Design Name: 
-- Module Name:    top - rtl 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
library common;
use common.constants.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port ( data 		: inout  t_data;
           address 	: inout  t_addr;
           bus_rq 	: out  	STD_LOGIC;
           bus_ak 	: in  	STD_LOGIC;
           rw 			: inout  STD_LOGIC;
           reg 		: in  	STD_LOGIC;
           ce 			: inout  STD_LOGIC;
			  wr_en 		: in  	STD_LOGIC;
			  rd_en 		: out  	STD_LOGIC;
           clk 		: in  	STD_LOGIC;
           rst 		: in  	STD_LOGIC);
end top;

architecture rtl of top is

component dma
    Port ( data		: in		t_data;
           port_addr	: inout	t_addr;
           reg			: in		STD_LOGIC;
           port_ce	: inout	STD_LOGIC;
			  port_rw	: inout	STD_LOGIC;
           bus_rq		: out		STD_LOGIC;
           bus_ak		: in		STD_LOGIC;	
			  ram_rw		: out		STD_LOGIC;		  
           ram_ce		: out		STD_LOGIC;
           ram_addr	: out		t_addr;			  
			  clk			: in		STD_LOGIC;
			  rst			: in		STD_LOGIC
			  );
end component;

component ram
    Port ( data 		: inout  t_data;
           address 	: in  	t_addr;		--STD_LOGIC_VECTOR (20 downto 0)
           ce 			: in  	STD_LOGIC;
           rw 			: in  	STD_LOGIC;
			  rd_en 		: in  	STD_LOGIC;
			  wr_en 		: out  	STD_LOGIC;
			  clk 		: in  	STD_LOGIC;
           rst 		: in  	STD_LOGIC
			  );
end component;

	-- Communication from DMA to RAM
	signal ram_rw : std_logic; 
	signal ram_ce : std_logic; 
	signal ram_addr : t_addr; 

begin
	
	i_dma : dma
	port map (
		data			=> data,
		port_addr	=> address,
		reg			=> reg,
		port_ce		=> ce,
		port_rw		=> rw,
		bus_rq		=> bus_rq,
		bus_ak		=> bus_ak,
		ram_rw		=> ram_rw,
		ram_ce		=> ram_ce,
		ram_addr		=> ram_addr,
		clk			=> clk,
		rst			=> rst
	);

	i_ram : ram
	port map (
		data 		=> data,
		address	=> ram_addr,
		ce			=> ram_ce,
		rw			=> ram_rw,
		rd_en		=> wr_en,
		wr_en		=> rd_en,
		clk		=> clk,
		rst		=> rst
	);
	
end rtl;

