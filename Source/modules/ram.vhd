----------------------------------------------------------------------------------
-- Company: 		 GMV
-- Engineer: 		 Fernando Capellan
-- 
-- Create Date:    08:29:09 03/02/2018 
-- Design Name: 
-- Module Name:    ram - rtl 
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
library UNISIM;
use UNISIM.VComponents.all;

entity ram is
    Port ( data 		: inout  t_data;
           address 	: in  	STD_LOGIC_VECTOR(20 DOWNTO 0);
           ce 			: in  	STD_LOGIC;
           rw 			: in  	STD_LOGIC;
			  rd_en 		: in  	STD_LOGIC;
			  wr_en 		: out  	STD_LOGIC;
			  clk 		: in  	STD_LOGIC;
           rst 		: in  	STD_LOGIC
			  );
end ram;

architecture rtl of ram is

	COMPONENT ram_2mib
		PORT (
			clka 	: IN STD_LOGIC;
			rsta 	: IN STD_LOGIC;
			wea 	: IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			addra : IN STD_LOGIC_VECTOR(20 DOWNTO 0);
			dina 	: IN t_data;
			douta : OUT t_data
		);
	END COMPONENT;
	
	signal I 				: t_data;
	signal wr_en_ff_1, wr_en_ff_2		: std_logic := '0'; -- active = '0'
	signal read_port	: std_logic := '0';
	
begin

	wr_en <= wr_en_ff_1;
	read_port <= rd_en and not rw and not ce;
		
	i_ram_2mib : ram_2mib
		PORT MAP (
			clka => clk,
			rsta => rst,
			wea(0) => read_port,
			addra => address,
			dina => data,
			douta => I
	);

	p_impedance : process(wr_en_ff_1, I) is
	begin
		if wr_en_ff_1 = '1' then
			data <= I;
		else
			data <= (others => 'Z');
		end if;
	end process p_impedance;

	p_wr_en : process(clk) is
	begin
		if rising_edge(clk) then
			if ce = '0' and rw = '1' then
				wr_en_ff_2 <= '1';
			else
				wr_en_ff_2 <= '0';
			end if;
			wr_en_ff_1 <= wr_en_ff_2;
		end if;
	end process p_wr_en;
	
end rtl;

