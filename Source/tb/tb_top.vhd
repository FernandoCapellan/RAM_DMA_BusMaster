--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:32:50 03/08/2018
-- Design Name:   
-- Module Name:   C:/Users/FECP/Documents/Fernando/VHDL/RAM_DMA_BusMaster/Source/tb/tb_top.vhd
-- Project Name:  RAM_DMA_BusMaster
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top
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
 
ENTITY tb_top IS
END tb_top;
 
ARCHITECTURE behavior OF tb_top IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top
    PORT(
         data		: INOUT	t_data;
         address	: INOUT	t_addr;
         bus_rq	: OUT		std_logic;
         bus_ak	: IN		std_logic;
         rw			: INOUT	std_logic;
         reg		: IN		std_logic;
         ce			: INOUT	std_logic;
         wr_en		: IN		std_logic;
         rd_en		: OUT		std_logic;
         clk		: IN		std_logic;
         rst		: IN		std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal bus_ak	: std_logic := '0';
   signal reg		: std_logic := '0';
   signal wr_en	: std_logic := '0';
   signal clk		: std_logic := '0';
   signal rst		: std_logic := '0';

	--BiDirs
   signal data		: t_data;
   signal address	: t_addr;
   signal rw		: std_logic;
   signal ce		: std_logic;

 	--Outputs
   signal bus_rq	: std_logic;
   signal rd_en	: std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	
	-- Transmission length
	signal LENL			: t_data := (others => '0');
	signal LENH			: t_data := (others => '0');
	signal LENU			: t_data := (others => '0');
	signal LEN			: std_logic_vector(23 downto 0) := (others => '0');
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top PORT MAP (
          data		=> data,
          address	=> address,
          bus_rq	=> bus_rq,
          bus_ak	=> bus_ak,
          rw 		=> rw,
          reg		=> reg,
          ce		=> ce,
          wr_en	=> wr_en,
          rd_en	=> rd_en,
          clk		=> clk,
          rst		=> rst
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
--		 data		=> data,
--		 address	=> address,
--		 bus_rq	=> bus_rq,
--		 bus_ak	=> bus_ak,
--		 rw 		=> rw,
--		 reg		=> reg,
--		 ce		=> ce,
--		 wr_en	=> wr_en,
--		 rd_en	=> rd_en,
--		 clk		=> clk,
--		 rst		=> rst

		bus_ak	<= '1';
		reg		<= '1';
		wr_en		<= '0';
	
		data		<= "00000000";
		address	<= (others => '0');
		rw			<= '1';
		ce			<= '1';
		wait until rst = '0';
		wait for clk_period;
		
		
		
		-- WRITE ON RAM START
		
		-- Base address for local RAM mapping	= 0;
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "0000";		-- BASEM
		data <= (others => '0');
		wait for clk_period;
		
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "0001";		-- BASEH
		data <= (others => '0');
		wait for clk_period;
		
		-- First address from port = 2;
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "0010";		-- SRCL
		data <= "00000010";
		wait for clk_period;
		
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "0011";		-- SRCM
		data <= (others => '0');
		wait for clk_period;
		
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "0100";		-- SRCH
		data <= (others => '0');
		wait for clk_period;
		
		-- First address for RAM = 4;
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "0101";		-- DSTL
		data <= "00000100";
		wait for clk_period;
		
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "0110";		-- DSTM
		data <= (others => '0');
		wait for clk_period;
		
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "0111";		-- DSTH
		data <= (others => '0');
		wait for clk_period;
		
		-- Data to be transmitted = 7;
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "1000";		-- LENL
		data <= "00000111";
		wait for clk_period;
		LENL <= data;
		
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "1001";		-- LENH
		data <= (others => '0');
		wait for clk_period;
		LENH <= data;
		
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "1010";		-- LENU
		data <= (others => '0');
		wait for clk_period;
		LENU <= data;
		reg <= '1';
		wait for clk_period;
		LEN <= LENU & LENH & LENL;
		
		-- SRC autoinc: -1; DST autoinc: -1; Mode: Read from port; Start: Enabled;
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "1011";		-- CTRL
		data <= "11011001";
		wait for clk_period;							--	START_ST		
		reg <= '1';
		
		wait until bus_rq = '0';					--	AK_WAIT_ST
		wait for clk_period;
		bus_ak			<= '0';
			
		wait for clk_period;							--	TRANSFER_ST
		bus_ak			<= '1';
		address			<= (others => 'Z');
		ce					<= 'Z';
		ce <= '0';
		
		for I in 0 to to_integer(unsigned(LEN)) loop
			wait for clk_period;							--	PORT_READ_ST
			data <= std_logic_vector(to_unsigned(I, c_data_width));	-- data arrives at port from other memory
			rw <= '0';
				
			wait for clk_period;							--	RAM_WRITE_ST
			data <= (others => 'Z');
			rw <= '1';
			
			wait for clk_period;							--	INDEX_ST
			
		end loop;
		
		-- WRITE ON RAM FINISH
		wait for clk_period * 10;
		
		
		
		-- READ FROM RAM START
		
		-- Base address for local RAM mapping = 0
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "0000";		-- BASEM
		data <= (others => '0');
		wait for clk_period;
		
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "0001";		-- BASEH
		data <= (others => '0');
		wait for clk_period;
		
		-- First address from RAM: address in which writing ended = x'FFFFFE = -2;
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "0010";		-- SRCL
		data <= "11111110";
		wait for clk_period;
		
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "0011";		-- SRCM
		data <= "11111111";
		wait for clk_period;
		
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "0100";		-- SRCH
		data <= "11111111";
		wait for clk_period;
		
		-- First address for port : address in which reading ended = x'FFFFFC = -4;
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "0101";		-- DSTL
		data <= "11111100";
		wait for clk_period;
		
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "0110";		-- DSTM
		data <= "11111111";
		wait for clk_period;
		
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "0111";		-- DSTH
		data <= "11111111";
		wait for clk_period;
		
		-- Data to be transmitted = 7;
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "1000";		-- LENL
		data <= "00000111";
		wait for clk_period;
		LENL <= data;
		
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "1001";		-- LENH
		data <= (others => '0');
		wait for clk_period;
		LENH <= data;
		
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "1010";		-- LENU
		data <= (others => '0');
		wait for clk_period;
		LENU <= data;
		reg <= '1';
		wait for clk_period;
		LEN <= LENU & LENH & LENL;
		
		-- SRC autoinc: 1; DST autoinc: 1; Mode: Read from RAM; Start: Enabled;
		reg <= '0';
		ce <= '0';
		address <= (c_addr_width - 1 downto 4 => '0') & "1011";		-- CTRL
		data <= "00100111";
		wait for clk_period;							--	START_ST		
		reg <= '1';
		data <= (others => 'Z');
		wait until bus_rq = '0';					--	AK_WAIT_ST
		wait for clk_period;
		bus_ak				<= '0';
			
		wait for clk_period;							--	TRANSFER_ST
		bus_ak				<= '1';
		address			<= (others => 'Z');
		ce				<= 'Z';
		
		for I in 0 to to_integer(unsigned(LEN)) loop
		
			wait for clk_period;							--	PORT_READ_ST
				
			wait for clk_period;							--	RAM_WRITE_ST
			
			wait for clk_period;							--	INDEX_ST
			
		end loop;
				
		-- READ FROM RAM FINISH
		
		wait for clk_period * 10;
		
		
		
		
		
		
		
		-- Test writing on module as slave:
--		data		<= "00001111";
--		address	<= (others => '0');
--		rw			<= '0';
--		ce			<= '0';
--      wait for clk_period;
--		ce			<= '1';
--      wait for clk_period*5;
		
		-- Test reading on module as slave:		
--		data		<= "00000000";
--		address	<= (others => '0');
--		rw			<= '1';
--		ce			<= '0';
--      wait for clk_period;
--		ce			<= '1';
--      wait for clk_period*5;

      -- insert stimulus here 

      wait;
   end process;

END;
