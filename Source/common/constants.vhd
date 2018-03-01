--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;

package constants is

constant c_data_width 	: natural := 8;
constant c_addr_width 	: natural := 24;
constant c_mib 			: natural := 1024 * 1024;


subtype t_data is std_logic_vector(c_data_width-1 downto 0);
subtype t_addr is std_logic_vector(c_addr_width-1 downto 0);

type t_ram is array (0 to 2 * c_mib - 1) of t_data;

end constants;



package body constants is
 
end constants;
