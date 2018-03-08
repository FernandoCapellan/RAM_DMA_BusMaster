--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:05:05 03/08/2018
-- Design Name:   
-- Module Name:   C:/Users/FECP/Documents/Fernando/VHDL/RAM_DMA_BusMaster/Source/tb/tb_dma.vhd
-- Project Name:  RAM_DMA_BusMaster
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: dma
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
use ieee.numeric_std.all;
library common;
use common.constants.all;
 
ENTITY tb_dma IS
END tb_dma;
 
ARCHITECTURE behavior OF tb_dma IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT dma
    PORT(
         data 			: IN		t_data;
         port_addr	: INOUT	t_addr;
         reg			: IN		std_logic;
         port_ce		: INOUT	std_logic;
         port_rw		: INOUT	std_logic;
         bus_rq		: OUT		std_logic;
         bus_ak		: IN		std_logic;
         ram_rw		: OUT		std_logic;
         ram_ce		: OUT		std_logic;
         ram_addr		: OUT		t_addr;
         clk			: IN		std_logic;
         rst			: IN		std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal data				: t_data 	:= (others => '0');
   signal reg				: std_logic	:= '0';
   signal bus_ak			: std_logic	:= '0';
   signal clk				: std_logic	:= '0';
   signal rst				: std_logic	:= '0';

	--BiDirs
   signal port_addr		: t_addr;
   signal port_ce			: std_logic;
   signal port_rw			: std_logic;

 	--Outputs
   signal bus_rq			: std_logic;
   signal ram_rw			: std_logic;
   signal ram_ce			: std_logic;
   signal ram_addr		: t_addr;

   -- Clock period definitions
   constant clk_period	: time		:= 10 ns;
	
	-- Transmission length
	signal LENL			: t_data := (others => '0');
	signal LENH			: t_data := (others => '0');
	signal LENU			: t_data := (others => '0');
	signal LEN			: std_logic_vector(23 downto 0) := (others => '0');
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: dma PORT MAP (
          data 		=> data,
          port_addr	=> port_addr,
          reg			=> reg,
          port_ce		=> port_ce,
          port_rw		=> port_rw,
          bus_rq		=> bus_rq,
          bus_ak		=> bus_ak,
          ram_rw		=> ram_rw,
          ram_ce		=> ram_ce,
          ram_addr	=> ram_addr,
          clk			=> clk,
          rst			=> rst
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 
	p_rst : process
   begin
     rst <= '1';
     wait for 45 ns;
     rst <= '0';
     wait;
   end process p_rst;
	

   -- Stimulus process
   stim_proc: process
   begin		
		data 			<= (others => '0');
		port_addr	<= (others => '0');
		reg 			<= '1';
		port_ce		<= '1';
		port_rw		<= '1';
		bus_ak		<= '1';
		
      wait until rst='0';
		
		reg <= '0';
		port_ce <= '0';
		port_addr <= (c_addr_width - 1 downto 4 => '0') & "0000";		-- BASEM
		data <= (others => '0');
		wait for clk_period;
		
		reg <= '0';
		port_ce <= '0';
		port_addr <= (c_addr_width - 1 downto 4 => '0') & "0001";		-- BASEH
		data <= (others => '0');
		wait for clk_period;
		
		reg <= '0';
		port_ce <= '0';
		port_addr <= (c_addr_width - 1 downto 4 => '0') & "0010";		-- SRCL
		data <= "00000010";
		wait for clk_period;
		
		reg <= '0';
		port_ce <= '0';
		port_addr <= (c_addr_width - 1 downto 4 => '0') & "0011";		-- SRCM
		data <= (others => '0');
		wait for clk_period;
		
		reg <= '0';
		port_ce <= '0';
		port_addr <= (c_addr_width - 1 downto 4 => '0') & "0100";		-- SRCH
		data <= (others => '0');
		wait for clk_period;
		
		reg <= '0';
		port_ce <= '0';
		port_addr <= (c_addr_width - 1 downto 4 => '0') & "0101";		-- DSTL
		data <= "00000100";
		wait for clk_period;
		
		reg <= '0';
		port_ce <= '0';
		port_addr <= (c_addr_width - 1 downto 4 => '0') & "0110";		-- DSTM
		data <= (others => '0');
		wait for clk_period;
		
		reg <= '0';
		port_ce <= '0';
		port_addr <= (c_addr_width - 1 downto 4 => '0') & "0111";		-- DSTH
		data <= (others => '0');
		wait for clk_period;
		
		reg <= '0';
		port_ce <= '0';
		port_addr <= (c_addr_width - 1 downto 4 => '0') & "1000";		-- LENL
		data <= "00000111";
		wait for clk_period;
		LENL <= data;
		
		reg <= '0';
		port_ce <= '0';
		port_addr <= (c_addr_width - 1 downto 4 => '0') & "1001";		-- LENH
		data <= (others => '0');
		wait for clk_period;
		LENH <= data;
		
		reg <= '0';
		port_ce <= '0';
		port_addr <= (c_addr_width - 1 downto 4 => '0') & "1010";		-- LENU
		data <= (others => '0');
		wait for clk_period;
		LENU <= data;
		reg <= '1';
		wait for clk_period;
		LEN <= LENU & LENH & LENL;
		
		reg <= '0';
		port_ce <= '0';
		port_addr <= (c_addr_width - 1 downto 4 => '0') & "1011";		-- CTRL
		data <= "11011001";
		wait for clk_period;								--	START_ST		
		reg <= '1';
		
		wait until bus_rq = '0';					--	AK_WAIT_ST
		wait for clk_period;
		bus_ak				<= '0';
			
		wait for clk_period;							--	TRANSFER_ST
		bus_ak				<= '1';
		port_addr			<= (others => 'Z');
		port_ce				<= 'Z';
		
		for I in 0 to to_integer(unsigned(LEN)) loop
		
			wait for clk_period;							--	PORT_READ_ST
				
			wait for clk_period;							--	RAM_WRITE_ST
			
			wait for clk_period;							--	INDEX_ST
			
		end loop;
		
		-- WRITE ON RAM FINISH
		
		
      wait;
   end process;

END;
