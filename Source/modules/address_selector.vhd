----------------------------------------------------------------------------------
-- Company: 		 GMV
-- Engineer: 		 Fernando Capellan
-- 
-- Create Date:    16:22:40 03/01/2018 
-- Design Name: 
-- Module Name:    address_selector - rtl 
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

entity address_selector is
    Port ( address 	: in  	STD_LOGIC_VECTOR (c_addr_width - 1 downto 0); --(20 downto 0);
           reg 		: in  	STD_LOGIC;
           dma_addr 	: out  	STD_LOGIC_VECTOR (3 downto 0);
           ram_addr 	: out  	STD_LOGIC_VECTOR (20 downto 0));
end address_selector;

architecture rtl of address_selector is
	
	signal test1 : STD_LOGIC_VECTOR (3 downto 0);
	signal test2 : STD_LOGIC_VECTOR (20 downto 0);
	
begin
	p_switch : process(reg, address) is
	begin
--		if reg = '1' then
--			dma_addr <= (others => '0');
--			ram_addr <= address(20 downto 0);
--		else
--			dma_addr <= address(3 downto 0);
--			ram_addr <= (others => '0');
--		end if;
		test1 <= address(3 downto 0);
		test2 <= address(20 downto 0);
	end process p_switch;


end rtl;

