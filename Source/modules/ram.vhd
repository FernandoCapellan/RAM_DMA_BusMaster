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
           address 	: in  	STD_LOGIC_VECTOR (20 downto 0);
           ce 			: in  	STD_LOGIC;
           rw 			: in  	STD_LOGIC;
			  rd_en 		: out  	STD_LOGIC;
			  clk 		: in  	STD_LOGIC;
           rst 		: in  	STD_LOGIC);
end ram;

architecture rtl of ram is

	COMPONENT ram_2mib
		PORT (
			clka : IN STD_LOGIC;
			rsta : IN STD_LOGIC;
			wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
			addra : IN STD_LOGIC_VECTOR(20 DOWNTO 0);
			dina : IN t_data;
			douta : OUT t_data
		);
	END COMPONENT;
	
	signal I : t_data;
	signal write_enable : std_logic;
	signal rd_en_ff : std_logic := '0';
	
begin

	write_enable <= not ce and not rw;
		
	i_ram_2mib : ram_2mib
		PORT MAP (
			clka => clk,
			rsta => rst,
			wea(0) => write_enable,
			addra => address,
			dina => data,
			douta => I
	);

	p_impedance : process(ce, rw, I) is
	begin
		if ce = '0' and rw = '1' then
			data <= I;
		else
			data <= (others => 'Z');
		end if;
	end process p_impedance;

	p_rd_en : process(clk) is
	begin
		if rising_edge(clk) then
			if ce = '0' and rw = '1' then
				rd_en_ff <= '1';
			else
				rd_en_ff <= '0';
			end if;
			rd_en <= rd_en_ff;
		end if;
	end process p_rd_en;
	
end rtl;

