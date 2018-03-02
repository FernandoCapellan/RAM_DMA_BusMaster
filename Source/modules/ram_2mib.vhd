----------------------------------------------------------------------------------
-- Company: 		 GMV
-- Engineer: 		 Fernando Capellan
-- 
-- Create Date:    08:29:09 03/02/2018 
-- Design Name: 
-- Module Name:    ram_2mib - rtl 
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

entity ram_2mib is
    Port ( data 		: inout  t_data;
           address 	: in  	STD_LOGIC_VECTOR (20 downto 0);
           rw 			: in  	STD_LOGIC;
           clk 		: in  	STD_LOGIC;
           rst 		: in  	STD_LOGIC);
end ram_2mib;

architecture rtl of ram_2mib is

	signal ram : t_ram := (others => (others => '0'));
	
begin
	p_ram : process(clk) is
	begin
		if rising_edge(clk) then	-- Synchronous
			if rst = '1' then			-- Reset: wipe RAM
				ram <= (others => (others => '0'));
			else
				if rw = '0' then				-- Write mode
					ram(to_integer(unsigned(address))) <= data;
					data <= (others => 'Z');
				else								-- Read mode
					data <= ram(to_integer(unsigned(address)));			
				end if;
			end if;
		end if;
	end process p_ram;
	
end rtl;

