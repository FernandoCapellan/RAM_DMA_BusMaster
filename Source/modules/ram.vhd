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
           rw 			: in  	STD_LOGIC;
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
	
	signal O, I : t_data;
	signal write_enable : std_logic;
	
begin

	write_enable <= not rw;
		
	i_ram_2mib : ram_2mib
		PORT MAP (
			clka => clk,
			rsta => rst,
			wea(0) => write_enable,
			addra => address,
			dina => data,
			douta => I
	);

	p_impedance : process(rw, I) is
	begin
		if rw = '0' then
			data <= (others => 'Z');
		else
			data <= I;
		end if;
	end process p_impedance;
	
end rtl;

