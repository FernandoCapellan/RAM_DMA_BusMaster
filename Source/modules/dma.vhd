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
    Port ( 
			  clk				: in		STD_LOGIC;
			  rst				: in		STD_LOGIC;
			  
			  port_data		: inout	t_data;
           port_addr		: inout	STD_LOGIC_VECTOR(20 DOWNTO 0);
           port_ce		: inout	STD_LOGIC;
			  port_rw		: inout	STD_LOGIC;
			  port_rd_en	: in		STD_LOGIC;
			  port_wr_en	: out		STD_LOGIC;
			  
			  ram_data		: inout	t_data;
           ram_addr		: out		STD_LOGIC_VECTOR(20 DOWNTO 0);
           ram_ce			: out		STD_LOGIC;
			  ram_rw			: out		STD_LOGIC;
			  ram_rd_en		: out		STD_LOGIC;
			  ram_wr_en		: in		STD_LOGIC;
			  
           bus_rq			: out		STD_LOGIC;
           bus_ak			: in		STD_LOGIC;
			  
           reg				: in		STD_LOGIC
			  );
end dma;

architecture rtl of dma is

	component dma_state_machine is
		Port (
			clk					: in std_logic;
			rst					: in std_logic;
			
			port_data			: inout	t_data;
		   port_addr			: inout	STD_LOGIC_VECTOR(20 DOWNTO 0);
		   port_ce				: inout	STD_LOGIC;
		   port_rw				: inout	STD_LOGIC;
		   port_rd_en			: in		STD_LOGIC;
		   port_wr_en			: out		STD_LOGIC;
			
			ram_data				: inout	t_data;
         ram_addr				: out		STD_LOGIC_VECTOR(20 DOWNTO 0);
         ram_ce				: out		STD_LOGIC;
			ram_rw				: out		STD_LOGIC;
			ram_rd_en			: out		STD_LOGIC;
			ram_wr_en			: in		STD_LOGIC;
			
			ctrl					: in		t_data;
         bus_rq				: out		STD_LOGIC;
         bus_ak				: in		STD_LOGIC;	
         reg					: in		STD_LOGIC;		
		   ctrl_stop			: out		STD_LOGIC;
		
		   base_address		: in		STD_LOGIC_VECTOR (20 DOWNTO 0);
		   source_address		: in		STD_LOGIC_VECTOR (20 DOWNTO 0);
		   destin_address		: in		STD_LOGIC_VECTOR (20 DOWNTO 0);
		   transfer_length	: in		STD_LOGIC_VECTOR (20 downto 0)
		);
	end component;

	-- REGISTERS --
	signal registers	: t_registers := (others => (others =>'0'));
	-- Base address RAM --
	signal BASEM		: t_data := (others => '0');
	signal BASEH		: t_data := (others => '0');
	signal BASE			: std_logic_vector(23 downto 0) := (others => '0');
	-- Source address --
	signal SRCL			: t_data := (others => '0');
	signal SRCM			: t_data := (others => '0');
	signal SRCH			: t_data := (others => '0');
	signal SRC			: std_logic_vector(23 downto 0) := (others => '0');
	-- Destunation address --
	signal DSTL			: t_data := (others => '0');
	signal DSTM			: t_data := (others => '0');
	signal DSTH			: t_data := (others => '0');
	signal DST			: std_logic_vector(23 downto 0) := (others => '0');
	-- Transfer length --
	signal LENL			: t_data := (others => '0');
	signal LENH			: t_data := (others => '0');
	signal LENU			: t_data := (others => '0');
	signal LEN			: std_logic_vector(23 downto 0) := (others => '0');
	-- Control register --
	signal CTRL			: t_data := (others => '0');
	
	signal ctrl_stop	: std_logic	:= '0';
		
begin	

	i_dma_state_machine : dma_state_machine

	port map(
			clk					=> clk,
			rst					=> rst,
			
			port_data			=> port_data,
		   port_addr			=> port_addr,
		   port_ce				=> port_ce,
		   port_rw				=> port_rw,
		   port_rd_en			=> port_rd_en,
		   port_wr_en			=> port_wr_en,
			
			ram_data				=> ram_data,
         ram_addr				=> ram_addr,
         ram_ce				=> ram_ce,
			ram_rw				=> ram_rw,
			ram_rd_en			=> ram_rd_en,
			ram_wr_en			=> ram_wr_en,
			
			ctrl					=> CTRL,
         bus_rq				=> bus_rq,
         bus_ak				=> bus_ak,
			reg					=> reg,
		   ctrl_stop			=> ctrl_stop,
		
		   base_address		=> BASE(20 downto 0),
		   source_address		=> SRC(20 downto 0),
		   destin_address		=> DST(20 downto 0),
		   transfer_length	=> LEN(20 downto 0)
		);

	BASEM	<= registers(0);
	BASEH	<= registers(1);
	BASE	<= (c_addr_width - 1 downto 21 => '0') & BASEH & BASEM & (4 downto 0 => '0');
	
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
	
	p_register : process (clk, rst, reg, port_ce, ctrl_stop) is
	begin
		if rising_edge(clk) then
			if rst = '1' then
				registers <= (others => (others =>'0'));	-- If reset, erase registers
				
			elsif ctrl_stop = '1' then
				registers(11)(0) <= '0';						-- Start bit of CTRL register = 0
				
			elsif reg = '0' and port_ce = '0' then			-- If Chip Enable and Registers signals active
				if 0 <= to_integer(unsigned(port_addr(3 downto 0))) and to_integer(unsigned(port_addr(3 downto 0))) <= 11 then	-- Safeguard: If address references a register
					registers(to_integer(unsigned(port_addr(3 downto 0)))) <= port_data;
				end if;
			end if;
		end if;
	end process p_register;

end rtl;

