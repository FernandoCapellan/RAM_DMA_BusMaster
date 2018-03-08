----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:47:27 03/06/2018 
-- Design Name: 
-- Module Name:    a1_complement_adder - rtl 
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

entity a1_complement_adder is
	Generic (
		g_bus_width : positive := 24
	);
	Port (
		address	: in  STD_LOGIC_VECTOR (g_bus_width - 1 downto 0);
		step		: in  STD_LOGIC_VECTOR (g_bus_width - 1 downto 0);
		result	: out STD_LOGIC_VECTOR (g_bus_width - 1 downto 0)
	);
end a1_complement_adder;

architecture rtl of a1_complement_adder is
	
	function a1_conv(step: STD_LOGIC_VECTOR (g_bus_width - 1 downto 0)) 
            return integer is  
		variable int_step : integer := 0;
	begin 
		int_step := to_integer(signed(step));
		if int_step < 0 then
			int_step := int_step + 1;
		end if;
		return int_step;
	end function;

begin
	
	result <= std_logic_vector( to_signed(to_integer(unsigned(address)) + a1_conv(step), g_bus_width));
	
end rtl;

