--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:01:25 03/10/2018
-- Design Name:   
-- Module Name:   C:/Users/FECP/Documents/Fernando/VHDL/RAM_DMA_BusMaster/Source/tb/tb_dma_fsm_testing.vhd
-- Project Name:  RAM_DMA_BusMaster
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: dma_state_machine
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
 
ENTITY tb_dma_fsm_testing IS
END tb_dma_fsm_testing;
 
ARCHITECTURE behavior OF tb_dma_fsm_testing IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT dma_state_machine
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         port_data : INOUT  std_logic_vector(7 downto 0);
         port_addr : INOUT  std_logic_vector(20 downto 0);
         port_ce : INOUT  std_logic;
         port_rw : INOUT  std_logic;
         port_rd_en : IN  std_logic;
         port_wr_en : OUT  std_logic;
         ram_data : INOUT  std_logic_vector(7 downto 0);
         ram_addr : OUT  std_logic_vector(20 downto 0);
         ram_ce : OUT  std_logic;
         ram_rw : OUT  std_logic;
         ram_rd_en : OUT  std_logic;
         ram_wr_en : IN  std_logic;
         ctrl : IN  std_logic_vector(7 downto 0);
         bus_rq : OUT  std_logic;
         bus_ak : IN  std_logic;
         ctrl_stop : OUT  std_logic;
         base_address : IN  std_logic_vector(20 downto 0);
         source_address : IN  std_logic_vector(20 downto 0);
         destin_address : IN  std_logic_vector(20 downto 0);
         transfer_length : IN  std_logic_vector(20 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal port_rd_en : std_logic := '0';
   signal ram_wr_en : std_logic := '0';
   signal ctrl : std_logic_vector(7 downto 0) := (others => '0');
   signal bus_ak : std_logic := '0';
   signal base_address : std_logic_vector(20 downto 0) := (others => '0');
   signal source_address : std_logic_vector(20 downto 0) := (others => '0');
   signal destin_address : std_logic_vector(20 downto 0) := (others => '0');
   signal transfer_length : std_logic_vector(20 downto 0) := (others => '0');

	--BiDirs
   signal port_data : std_logic_vector(7 downto 0);
   signal port_addr : std_logic_vector(20 downto 0);
   signal port_ce : std_logic;
   signal port_rw : std_logic;
   signal ram_data : std_logic_vector(7 downto 0);

 	--Outputs
   signal port_wr_en : std_logic;
   signal ram_addr : std_logic_vector(20 downto 0);
   signal ram_ce : std_logic;
   signal ram_rw : std_logic;
   signal ram_rd_en : std_logic;
   signal bus_rq : std_logic;
   signal ctrl_stop : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
	
	
	signal LEN			: std_logic_vector(20 downto 0) := (others => '0');
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: dma_state_machine PORT MAP (
          clk => clk,
          rst => rst,
          port_data => port_data,
          port_addr => port_addr,
          port_ce => port_ce,
          port_rw => port_rw,
          port_rd_en => port_rd_en,
          port_wr_en => port_wr_en,
          ram_data => ram_data,
          ram_addr => ram_addr,
          ram_ce => ram_ce,
          ram_rw => ram_rw,
          ram_rd_en => ram_rd_en,
          ram_wr_en => ram_wr_en,
          ctrl => ctrl,
          bus_rq => bus_rq,
          bus_ak => bus_ak,
          ctrl_stop => ctrl_stop,
          base_address => base_address,
          source_address => source_address,
          destin_address => destin_address,
          transfer_length => transfer_length
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
		
		port_data <= (others => 'Z');
		port_addr <= (others => 'Z');
		port_ce <= 'Z';
		port_rw <= 'Z';
		bus_ak <= '1';
		ram_data <= (others => 'Z');
		
		wait until rst = '0';
	
      wait for clk_period*10;
		-- slave waiting for input
		
		-- writing as slave
		port_data <= "01010101";
		port_addr <= "000000000000000000000";
		port_ce <= '0';
		port_rw <= '0';
		port_rd_en <= '1';
      wait for clk_period;
		
		port_data <= (others => 'Z');
		port_addr <= (others => 'Z');
		port_ce <= '1';
		port_rd_en <= '0';
      wait for clk_period;
		
		port_data <= "00001111";
		port_addr <= "000000000000000000001";
		port_ce <= '0';
		port_rw <= '0';
		port_rd_en <= '1';
      wait for clk_period;		
		
		port_data <= (others => 'Z');
		port_addr <= (others => 'Z');
		port_ce <= '1';
		port_rd_en <= '0';
		
      wait for clk_period*10;
		-- slave waiting for input
		
		-- reading as slave
		port_addr <= "000000000000000000001";
		port_ce <= '0';
		port_rw <= '1';
      wait for clk_period;
		
		port_addr <= (others => 'Z');	
		port_ce <= '1';
		ram_data <= "00001111";
		ram_wr_en <= '1';
      wait for clk_period;	

		port_addr <= "000000000000000000000";
		port_ce <= '0';
		port_rw <= '1';
		ram_data <= (others => 'Z');
		ram_wr_en <= '0';
      wait for clk_period;
		
		port_addr <= (others => 'Z');	
		port_ce <= 'Z';
		ram_data <= "01010101";
		ram_wr_en <= '1';
      wait for clk_period;	
		
		ram_data <= (others => 'Z');
		ram_wr_en <= '0';
		--slave waiting for input
		
		wait for clk_period * 3;	
		
		-- Master mode
		-- Write on RAM
		base_address		<= "000000000000000000000";	-- Base address for local RAM mapping	= 0;
		source_address		<= "000000000000000000010";	-- First address from port 				= 2;
		destin_address		<= "000000000000000000100";	-- First address for RAM 					= 4;
		transfer_length	<= "000000000000000000111";	-- Data to be transmitted					= 7;
		
		LEN 					<= "000000000000000000111";
      wait for clk_period;
		ctrl					<= "11011001"; 						-- SRC autoinc: -1; DST autoinc: -1; Mode: Read from port; Start: Enabled;
		
		wait until bus_rq = '0' and ctrl_stop = '1';
		
		-- START_ST
		wait for clk_period;
		ctrl(0) 				<= '0';	
		
		-- AK_WAIT_ST
		wait for (clk_period * 1) - clk_period;
		bus_ak				<= '0';
		
		-- TRANSFER_ST
      wait for clk_period;
		bus_ak				<= '1';
		
		
		for I in 0 to to_integer(unsigned(LEN)) loop
		
			--	PORT_READ_ST
			wait for clk_period;
			
			--	RAM_WRITE_ST
			wait for clk_period;
			port_data <= std_logic_vector(to_unsigned(I * 2, c_data_width));
			port_rd_en <= '1';
			
			--	RAM_WRITE_FINISH_ST
			wait for clk_period;
			port_rd_en <= '0';
			
			--	INDEX_ST
			wait for clk_period;
			
		end loop;
		
		port_data <= (others => 'Z');
		port_ce <= 'Z';
		port_rw <= 'Z';
		-- INIT_ST
		wait for clk_period * 3;
		
		-- Master mode
		-- Read from RAM
		base_address		<= "111111111111111111110";	-- Base address for local RAM mapping	= address in which writing ended = x'1FFFFE = -2;
		source_address		<= "000000000000000000000";	-- First address from port 				= 0;
		destin_address		<= "111111111111111111100";	-- First address for RAM 					= address in which reading ended = x'1FFFFC = -4;
		transfer_length	<= "000000000000000000111";	-- Data to be transmitted					= 7;
		
		LEN 					<= "000000000000000000111";
      wait for clk_period;
		ctrl					<= "00100111"; 					-- SRC autoinc: 1; DST autoinc: 1; Mode: Read from RAM; Start: Enabled;
		
		wait until bus_rq = '0' and ctrl_stop = '1';
		
		-- START_ST
		wait for clk_period;
		ctrl(0) 				<= '0';	
		
		-- AK_WAIT_ST
		wait for (clk_period * 1) - clk_period;
		bus_ak				<= '0';
		
		-- TRANSFER_ST
      wait for clk_period;
		bus_ak				<= '1';
		
		
		for I in 0 to to_integer(unsigned(LEN)) loop
		
			--	RAM_READ_ST
			wait for clk_period;
			
			--	PORT_WRITE_ST
			wait for clk_period;
			ram_data <= std_logic_vector(to_unsigned(I * 10, c_data_width));
			ram_wr_en <= '1';
			
			--	PORT_WRITE_FINISH_ST
			wait for clk_period;
			ram_wr_en <= '0';
			
			--	INDEX_ST
			wait for clk_period;
			
		end loop;
      
      wait;
   end process;

END;
