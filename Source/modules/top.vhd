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
			  rd_en 		: in  	STD_LOGIC;
			  wr_en 		: out  	STD_LOGIC;
           clk 		: in  	STD_LOGIC;
           rst 		: in  	STD_LOGIC);
end top;

architecture rtl of top is

component dma
    Port ( 
			  clk					: in		STD_LOGIC;
			  rst					: in		STD_LOGIC;
			  
			  port_data			: inout	t_data;
           port_addr			: inout	STD_LOGIC_VECTOR(20 DOWNTO 0);
           port_ce			: inout	STD_LOGIC;
			  port_rw			: inout	STD_LOGIC;
			  port_rd_en		: in		STD_LOGIC;
			  port_wr_en		: out		STD_LOGIC;
			  
			
			  ram_data_out		: in		t_data;
			  ram_data_in		: out		t_data;
           ram_addr			: out		STD_LOGIC_VECTOR(20 DOWNTO 0);
           ram_ce				: out		STD_LOGIC;
			  ram_rw				: out		STD_LOGIC;
			  ram_rd_en			: out		STD_LOGIC;
			  ram_wr_en			: in		STD_LOGIC;
			  
           bus_rq				: out		STD_LOGIC;
           bus_ak				: in		STD_LOGIC;
			  
           reg					: in		STD_LOGIC
			  );
end component;

component ram
    Port ( data_in	: in  	t_data;
			  data_out	: out  	t_data;
           address 	: in  	STD_LOGIC_VECTOR(20 DOWNTO 0);
           ce 			: in  	STD_LOGIC;
           rw 			: in  	STD_LOGIC;
			  rd_en 		: in  	STD_LOGIC;
			  wr_en 		: out  	STD_LOGIC;
			  clk 		: in  	STD_LOGIC;
           rst 		: in  	STD_LOGIC
			  );
end component;

	-- Communication from DMA to RAM
	signal ram_data_in 	: t_data;
	signal ram_data_out 	: t_data;
	signal ram_addr 		: std_logic_vector(20 DOWNTO 0); 
	signal ram_ce 			: std_logic; 
	signal ram_rw 			: std_logic; 
	signal ram_rd_en		: std_logic; 
	signal ram_wr_en		: std_logic; 

begin
	
	i_dma : dma
	port map( 
				clk				=> clk,
				rst				=> rst,
		  
				port_data		=> data,
				port_addr		=> address(20 downto 0),
				port_ce			=> ce,
				port_rw			=> rw,
				port_rd_en		=> rd_en,
				port_wr_en		=> wr_en,		  
				
				ram_data_out	=> ram_data_out,
				ram_data_in		=> ram_data_in,
				ram_addr			=> ram_addr,
				ram_ce			=> ram_ce,
				ram_rw			=> ram_rw,
				ram_rd_en		=> ram_rd_en,
				ram_wr_en		=> ram_wr_en,
		  
				bus_rq			=> bus_rq,
				bus_ak			=> bus_ak,
		  
				reg				=> reg
	);

	i_ram : ram
	port map (
		data_in 	=> ram_data_in,
		data_out	=> ram_data_out,
		address	=> ram_addr,
		ce			=> ram_ce,
		rw			=> ram_rw,
		rd_en		=> ram_rd_en,
		wr_en		=> ram_wr_en,
		clk		=> clk,
		rst		=> rst
	);
	
	

--	p_impedance : process(ram_wr_en, ram_data_out) is
--	begin
--		if ram_wr_en = '1' then
--			ram_data_in <= ram_data_out;
--		else
--			ram_data_in <= (others => 'Z');
--		end if;
--	end process p_impedance;
	
end rtl;

