--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:01:34 03/10/2018
-- Design Name:   
-- Module Name:   C:/Users/FECP/Documents/Fernando/VHDL/RAM_DMA_BusMaster/Source/tb/tb_dma_test.vhd
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_dma_test IS
END tb_dma_test;
 
ARCHITECTURE behavior OF tb_dma_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT dma
    PORT(
         clk 				: IN  	std_logic;
         rst 				: IN  	std_logic;
			
         port_data 		: INOUT  t_data;
         port_addr 		: INOUT  std_logic_vector(20 DOWNTO 0);
         port_ce 			: INOUT  std_logic;
         port_rw 			: INOUT  std_logic;
         port_rd_en 		: IN  	std_logic;
         port_wr_en 		: OUT  	std_logic;
			
         ram_data_out 	: IN  	t_data;
         ram_data_in		: OUT  	t_data;
         ram_addr 		: OUT  	std_logic_vector(20 DOWNTO 0);
         ram_ce 			: OUT  	std_logic;
         ram_rw 			: OUT  	std_logic;
         ram_rd_en 		: OUT  	std_logic;
         ram_wr_en 		: IN  	std_logic;
			
         bus_rq 			: OUT  	std_logic;
         bus_ak 			: IN  	std_logic;
			
         reg 				: IN  	std_logic			
        );
    END COMPONENT;
    

   --Inputs
   signal clk 				: std_logic := '0';
   signal rst 				: std_logic := '0';
   signal port_rd_en 	: std_logic := '0';
	signal ram_data_out 	: t_data := (others => '0');
   signal ram_wr_en 		: std_logic := '0';
   signal bus_ak 			: std_logic := '0';
   signal reg 				: std_logic := '0';

	--BiDirs
   signal port_data 		: t_data;
   signal port_addr 		: std_logic_vector(20 downto 0);
   signal port_ce 		: std_logic;
   signal port_rw 		: std_logic;
   --signal ram_data 	: std_logic_vector(7 downto 0);

 	--Outputs
   signal port_wr_en 	: std_logic;
	signal ram_data_in 	: t_data;
   signal ram_addr 		: std_logic_vector(20 downto 0);
   signal ram_ce 			: std_logic;
   signal ram_rw 			: std_logic;
   signal ram_rd_en 		: std_logic;
   signal bus_rq 			: std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	-- Transmission length
	signal LENL			: t_data := (others => '0');
	signal LENH			: t_data := (others => '0');
	signal LENU			: t_data := (others => '0');
	signal LEN			: std_logic_vector(23 downto 0) := (others => '0');
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: dma PORT MAP (
          clk 				=> clk,
          rst 				=> rst,
			 
          port_data 		=> port_data,
          port_addr 		=> port_addr,
          port_ce 		=> port_ce,
          port_rw 		=> port_rw,
          port_rd_en 	=> port_rd_en,
          port_wr_en 	=> port_wr_en,
			 
          ram_data_out	=> ram_data_out,
          ram_data_in 	=> ram_data_in,
          ram_addr 		=> ram_addr,
          ram_ce 			=> ram_ce,
          ram_rw 			=> ram_rw,
          ram_rd_en 		=> ram_rd_en,
          ram_wr_en 		=> ram_wr_en,
			 
          bus_rq 			=> bus_rq,
          bus_ak 			=> bus_ak,
			 
          reg => reg
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '1';
		wait for clk_period/2;
		clk <= '0';
		wait for clk_period/2;
   end process;

	p_rst : process
   begin
     rst <= '1';
     wait for 40 ns;
     rst <= '0';
     wait;
   end process p_rst;

   -- Stimulus process
   stim_proc: process
   begin
	
		port_data 	<= (others => 'Z');
		port_addr	<= (others => 'Z');
		port_ce		<= 'Z';
		port_rw		<= 'Z';		
		port_rd_en 	<= '0';
		
		--ram_data_in	<= (others => '0');
		ram_wr_en 	<= '0';
		
		bus_ak		<= '1';
		
		reg 			<= '1';
		
      wait until rst='0';
      wait for clk_period;
		
		-- slave waiting for input
		
		-- writing as slave
		port_data 			<= "01010101";
		port_addr 			<= "000000000000000000000";
		port_ce 				<= '0';
		port_rw 				<= '0';
		port_rd_en 			<= '1';
      wait for clk_period;
		
--		port_data 			<= (others => 'Z');
--		port_addr 			<= (others => 'Z');
--		port_ce 				<= '1';
--		port_rd_en 			<= '0';
--      wait for clk_period;
		
		port_data 			<= "00001111";
		port_addr 			<= "000000000000000000001";
		port_ce 				<= '0';
		port_rw 				<= '0';
		port_rd_en 			<= '1';
      wait for clk_period;		
		
		port_data 			<= (others => 'Z');
		port_addr 			<= (others => 'Z');
		port_ce 				<= '1';
		port_rd_en 			<= '0';
		
      wait for clk_period*10;
		-- slave waiting for input
		
		-- reading as slave
		port_addr 			<= "000000000000000000001";
		port_ce 				<= '0';
		port_rw 				<= '1';
      wait for clk_period;
		
		port_addr 			<= (others => 'Z');	
		port_ce 				<= '1';
		ram_data_out		<= "00001111";
		ram_wr_en 			<= '1';
      wait for clk_period;	

		port_addr 			<= "000000000000000000000";
		port_ce 				<= '0';
		port_rw 				<= '1';
		ram_data_out		<= (others => '0');
		ram_wr_en 			<= '0';
      wait for clk_period;
		
		port_addr 			<= (others => 'Z');	
		port_ce 				<= 'Z';
		port_rw 				<= 'Z';
		ram_data_out		<= "01010101";
		ram_wr_en 			<= '1';
      wait for clk_period;	
		
		ram_data_out		<= (others => '0');
		ram_wr_en 			<= '0';
		--slave waiting for input
		
		wait for clk_period * 3;
		
		-- WRITE ON RAM START
		
		-- Base address for local RAM mapping	= 0;
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "0000";		-- BASEM
		port_data 			<= (others => '0');
		wait for clk_period;
		
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "0001";		-- BASEH
		port_data 			<= (others => '0');
		wait for clk_period;
		
		-- First address from port = 2;
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "0010";		-- SRCL
		port_data 			<= "00000010";
		wait for clk_period;
		
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "0011";		-- SRCM
		port_data 			<= (others => '0');
		wait for clk_period;
		
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "0100";		-- SRCH
		port_data 			<= (others => '0');
		wait for clk_period;
		
		-- First address for RAM = 4;
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "0101";		-- DSTL
		port_data 			<= "00000100";
		wait for clk_period;
		
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "0110";		-- DSTM
		port_data 			<= (others => '0');
		wait for clk_period;
		
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "0111";		-- DSTH
		port_data 			<= (others => '0');
		wait for clk_period;
		
		-- Data to be transmitted = 7;
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "1000";		-- LENL
		port_data 			<= "00000111";
		wait for clk_period;
		LENL 					<= port_data;
		
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "1001";		-- LENH
		port_data 			<= (others => '0');
		wait for clk_period;
		LENH 					<= port_data;
		
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "1010";		-- LENU
		port_data 			<= (others => '0');
		wait for clk_period;
		LENU 					<= port_data;
		reg 					<= '1';
		wait for clk_period;
		LEN 					<= LENU & LENH & LENL;
		
		-- SRC autoinc: -1; DST autoinc: -1; Mode: Read from port; Start: Enabled;
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "1011";		-- CTRL
		port_data 			<= "11011001";
		
		--	START_ST
		wait for clk_period;
		port_data 			<= (others => 'Z');
		reg 					<= '1';
		port_ce 				<= '1';
		
		--	AK_WAIT_ST
		wait until bus_rq = '0';
		wait for clk_period;
		bus_ak				<= '0';
		LEN 					<= std_logic_vector(unsigned(LEN) - 1);
			
		--	TRANSFER_ST
		wait for clk_period;
		bus_ak				<= '1';
		port_addr			<= (others => 'Z');
		port_ce				<= 'Z';
		
		for I in 0 to to_integer(unsigned(LEN)) loop
		
			--	PORT_READ_ST
			wait for clk_period;
				
			--	RAM_WRITE_ST
			wait for clk_period;
			port_data 		<= std_logic_vector(to_unsigned(I * 2, c_data_width));
			port_rd_en 		<= '1';
			
			--	RAM_WRITE_FINISH_ST
			--wait for clk_period;	
			
			--	INDEX_ST
			wait for clk_period;					
			port_data 		<= (others => 'Z');
			port_rd_en 		<= '1';
			
		end loop;
		
		-- WRITE ON RAM FINISH
		wait for clk_period * 10;
		
		
		-- READ FROM RAM START
		
		-- Base address for local RAM mapping = 0
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "0000";		-- BASEM
		port_data 			<= (others => '0');
		wait for clk_period;
		
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "0001";		-- BASEH
		port_data 			<= (others => '0');
		wait for clk_period;
		
		-- First address from RAM: address in which writing ended = x'FFFFFE = -2;
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "0010";		-- SRCL
		port_data 			<= "11111110";
		wait for clk_period;
		
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "0011";		-- SRCM
		port_data 			<= "11111111";
		wait for clk_period;
		
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "0100";		-- SRCH
		port_data 			<= "11111111";
		wait for clk_period;
		
		-- First address for port : address in which reading ended = x'FFFFFC = -4;
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "0101";		-- DSTL
		port_data 			<= "11111100";
		wait for clk_period;
		
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "0110";		-- DSTM
		port_data 			<= "11111111";
		wait for clk_period;
		
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "0111";		-- DSTH
		port_data 			<= "11111111";
		wait for clk_period;
		
		-- Data to be transmitted = 7;
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "1000";		-- LENL
		port_data 			<= "00000111";
		wait for clk_period;
		LENL 					<= port_data;
		
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "1001";		-- LENH
		port_data 			<= (others => '0');
		wait for clk_period;
		LENH 					<= port_data;
		
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "1010";		-- LENU
		port_data 			<= (others => '0');
		wait for clk_period;
		LENU 					<= port_data;
		reg 					<= '1';
		wait for clk_period;
		LEN 					<= LENU & LENH & LENL;
		
		-- SRC autoinc: 1; DST autoinc: 1; Mode: Read from RAM; Start: Enabled;
		reg 					<= '0';
		port_ce 				<= '0';
		port_addr 			<= (20 downto 4 => '0') & "1011";		-- CTRL
		port_data 			<= "00100111";
		
		--	START_ST
		wait for clk_period;		
		port_data 			<= (others => 'Z');
		port_ce 				<= '1';
		reg 					<= '1';
		
		--	AK_WAIT_ST
		wait until bus_rq = '0';
		wait for clk_period;
		bus_ak				<= '0';
		LEN 					<= std_logic_vector(unsigned(LEN) - 1);
			
		--	TRANSFER_ST
		wait for clk_period;
		port_addr			<= (others => 'Z');
		port_ce				<= 'Z';
		bus_ak				<= '1';
		
		for I in 0 to to_integer(unsigned(LEN)) loop

			--	RAM_READ_ST
			wait for clk_period;
			
			-- RAM_READ__FINISH_ST
			wait for clk_period;
			ram_wr_en 		<= '1';
			wait for 0.1 ns;
			ram_data_out	<= std_logic_vector(to_unsigned(I * 2, c_data_width));
			
			--	PORT_WRITE_ST
			wait for clk_period;
			ram_data_out	<= (others => 'Z');
			ram_wr_en 		<= '0';
			
			--	INDEX_ST
			wait for clk_period;
			
		end loop;
				
		-- READ FROM RAM FINISH

      wait;
   end process;

END;
