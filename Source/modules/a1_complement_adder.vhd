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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

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

	signal addition : STD_LOGIC_VECTOR (g_bus_width downto 0); -- 1 bit wider than operands

begin
	
	addition <= std_logic_vector(unsigned('0' & address) + unsigned('0' & step));
	result <= std_logic_vector(unsigned(addition(g_bus_width - 1 downto 0)) + unsigned(addition(g_bus_width downto g_bus_width)));

end rtl;

