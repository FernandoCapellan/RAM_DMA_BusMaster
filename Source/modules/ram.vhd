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
	
component IOBUF is
	generic(
		CAPACITANCE			: string		:= "DONT_CARE";
      DRIVE					: integer	:= 12;
      IBUF_DELAY_VALUE	: string 	:= "0";
      IBUF_LOW_PWR		: boolean	:=  TRUE;
      IFD_DELAY_VALUE	: string		:= "AUTO";
      IOSTANDARD			: string		:= "DEFAULT";
      SLEW					: string		:= "SLOW"
	);
	port(
		O  : out   std_logic;
		IO : inout std_logic;
		I  : in    std_logic;
		T  : in    std_logic
	);
	end component;
	
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
			dina => O,
			douta => I
	);

	iobuf_gen : for x in 0 to c_data_width - 1 generate
		i_iobuf : iobuf
			port map (
				O 	=> O(x),
				IO 	=> data(x),
				I 	=> I(x),
				T => rw
			);		
	end generate iobuf_gen;

--	p_ram : process(clk) is
--	begin
--		if rising_edge(clk) then	-- Synchronous
--			if rst = '1' then			-- Reset: wipe RAM
--				ram <= (others => (others => '0'));
--			else
--				if rw = '0' then				-- Write mode
--					ram(to_integer(unsigned(address))) <= data;
--					data <= (others => 'Z');
--				else								-- Read mode
--					data <= ram(to_integer(unsigned(address)));			
--				end if;
--			end if;
--		end if;
--	end process p_ram;
	
end rtl;

