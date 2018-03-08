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
           port_addr	: inout	t_addr;
           reg			: in		STD_LOGIC;
           port_ce	: inout	STD_LOGIC;
			  port_rw	: inout	STD_LOGIC;
           bus_rq		: out		STD_LOGIC;
           bus_ak		: in		STD_LOGIC;	
			  ram_rw		: out		STD_LOGIC;		  
           ram_ce		: out		STD_LOGIC;
           ram_addr	: out		t_addr;			  
			  clk			: in		STD_LOGIC;
			  rst			: in		STD_LOGIC
			  );
end dma;

architecture rtl of dma is

	component dma_state_machine is
		Port ( clk					: in STD_LOGIC;
				 rst					: in STD_LOGIC;
				 ctrl					: in	t_data;
				 bus_ak				: in	STD_LOGIC;
				 base_address		: in	t_addr;
				 source_address	: in	t_addr;
				 destin_address	: in	t_addr;
				 transfer_length	: in	STD_LOGIC_VECTOR (23 downto 0);
				 bus_rq				: out	STD_LOGIC;
				 ram_addr			: out	t_addr;
				 port_addr			: out	t_addr;
				 ram_rw				: out	STD_LOGIC;
				 port_rw				: out	STD_LOGIC;
				 ram_ce				: out	STD_LOGIC;
				 port_ce				: out	STD_LOGIC;
				 ctrl_stop			: out	STD_LOGIC);
	end component;

	-- REGISTERS --
	signal registers	: t_registers := (others => (others =>'0'));
	-- Base address RAM --
	signal BASEM		: t_data;
	signal BASEH		: t_data;
	signal BASE			: std_logic_vector(23 downto 0);
	-- Source address --
	signal SRCL			: t_data;
	signal SRCM			: t_data;
	signal SRCH			: t_data;
	signal SRC			: std_logic_vector(23 downto 0);
	-- Destunation address --
	signal DSTL			: t_data;
	signal DSTM			: t_data;
	signal DSTH			: t_data;
	signal DST			: std_logic_vector(23 downto 0);
	-- Transfer length --
	signal LENL			: t_data;
	signal LENH			: t_data;
	signal LENU			: t_data;
	signal LEN			: std_logic_vector(23 downto 0);
	-- Control register --
	signal CTRL			: t_data;
	
	signal ctrl_stop	: std_logic	:= '0';
		
begin	

	i_dma_state_machine : dma_state_machine
	port map (
		clk					=> clk,
		rst					=> rst,
		ctrl					=> CTRL,
		bus_ak				=> bus_ak,
		base_address		=> BASE,
		source_address		=> SRC,
		destin_address		=> DST,
		transfer_length	=> LEN,
		bus_rq				=> bus_rq,
		ram_addr				=> ram_addr,
		port_addr			=> port_addr,
		ram_rw				=> ram_rw,
		port_rw				=> port_rw,
		ram_ce				=> ram_ce,
		port_ce				=> port_ce,
		ctrl_stop			=> ctrl_stop
	);

	BASEM	<= registers(0);
	BASEH	<= registers(1);
	BASE	<= BASEH & BASEM & (7 downto 0 => '0');
	
	SRCL	<= registers(2);
	SRCM	<= registers(3);
	SRCH	<= registers(4);
	SRC	<= SRCH & SRCM & SRCL;
	
	DSTL	<= registers(5);
	DSTM	<= registers(6);
	DSTH	<= registers(7);
	DST	<= DSTH & DSTM & DSTL;
	
	LENL	<= registers(8);
	LENH	<= registers(9);
	LENU	<= registers(10);
	LEN	<= LENU & LENH & LENL;
	
	CTRL	<= registers(11);
	
	p_register : process (clk, rst, reg, port_ce,ctrl_stop) is
	begin
		if rising_edge(clk) then
			if rst = '1' then
				registers <= (others => (others =>'0'));	-- If reset, erase registers
				
			elsif ctrl_stop = '1' then
				registers(11)(0) <= '0';						-- Start bit of CTRL register = 0
				
			elsif reg = '0' and port_ce = '0' then			-- If Chip Enable and Registers signals active
				if 0 <= to_integer(unsigned(port_addr(3 downto 0))) and to_integer(unsigned(port_addr(3 downto 0))) <= 11 then	-- Safeguard: If address references a register
					registers(to_integer(unsigned(port_addr(3 downto 0)))) <= data;
				end if;
			end if;
		end if;
	end process p_register;

end rtl;

