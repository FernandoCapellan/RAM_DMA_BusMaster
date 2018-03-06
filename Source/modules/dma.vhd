----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:52:42 03/04/2018 
-- Design Name: 
-- Module Name:    dma - rtl 
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

entity dma is
    Port ( data		: in	t_data;
           address	: inout	STD_LOGIC_VECTOR (20 downto 0);
           reg			: in		STD_LOGIC;
           ce			: inout	STD_LOGIC;
			  rw			: inout	STD_LOGIC;
           bus_rq		: out		STD_LOGIC;
           bus_ak		: in		STD_LOGIC;	
			  ram_rw		: out		STD_LOGIC;		  
           ram_ce		: out		STD_LOGIC;
           ram_addr	: out		STD_LOGIC
			  );
end dma;

architecture rtl of dma is

	-- REGISTERS --
	signal registers	: t_registers := (others => (others =>'0'));
	-- Base address RAM --
	signal BASEM		: t_data := (others => 0);
	signal BASEH		: t_data := (others => 0);
	-- Source address --
	signal SRCL			: t_data := (others => 0);
	signal SRCM			: t_data := (others => 0);
	signal SRCH			: t_data := (others => 0);
	-- Destunation address --
	signal DSTL			: t_data := (others => 0);
	signal DSTM			: t_data := (others => 0);
	signal DSTH			: t_data := (others => 0);
	-- Transfer length --
	signal LENL			: t_data := (others => 0);
	signal LENH			: t_data := (others => 0);
	signal LENU			: t_data := (others => 0);
	-- Control register --
	signal CTRL			: t_data := (others => 0);
	
	signal mode			: std_logic := '0'; -- 0 = slave, 1 = master
	
begin	
	BASEM	<= registers(0);
	BASEH	<= registers(1);
	SRCL	<= registers(2);
	SRCM	<= registers(3);
	SRCH	<= registers(4);
	DSTL	<= registers(5);
	DSTM	<= registers(6);
	DSTH	<= registers(7);
	LENL	<= registers(8);
	LENH	<= registers(9);
	LENU	<= registers(10);
	CTRL	<= registers(11);
	
	p_reset : process (clk, rst) is
	begin
		if rising_edge(clk) then
			if rst = '1' then
				registers <= (others => (others =>'0'));
				mode <= '0';
			end if;
		end if;
	end process p_reset;
	
	p_impedance : process(role) is
	begin
		if mode = '0' then	-- If slave, inout ports act as inputs and have to be set to high impedance
			address <= (others => 'Z');
			ce <= 'Z';
			rw <= 'Z';
		end if;
	end process p_impedance;

	p_register : process (reg, ce) is
	begin
		if reg = '0' and ce = '0' then	-- If Chip Enable and Registers
			if 0 <= unsigned(address(3 downto 0)) and unsigned(address(3 downto 0)) <= 11 then	-- Safeguard: If address references a register
				registers(unsigned(address(3 downto 0))) <= data;
			end if;
		end if;
	end process p_register;
	
	
	p_transmission : process (CTRL) is
	begin
		
	
	end process p_transmission;

end rtl;

