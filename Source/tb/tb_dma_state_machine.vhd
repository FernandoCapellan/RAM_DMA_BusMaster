--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:51:07 03/07/2018
-- Design Name:   
-- Module Name:   C:/Users/FECP/Documents/Fernando/VHDL/RAM_DMA_BusMaster/Source/tb/tb_dma_state_machine.vhd
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
 
ENTITY tb_dma_state_machine IS
END tb_dma_state_machine;
 
ARCHITECTURE behavior OF tb_dma_state_machine IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT dma_state_machine
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         ctrl : IN  std_logic_vector(7 downto 0);
         bus_ak : IN  std_logic;
         base_address : IN  std_logic_vector(23 downto 0);
         source_address : IN  std_logic_vector(23 downto 0);
         destin_address : IN  std_logic_vector(23 downto 0);
         transfer_length : IN  std_logic_vector(23 downto 0);
         bus_rq : OUT  std_logic;
         ram_addr : OUT  std_logic_vector(23 downto 0);
         port_addr : OUT  std_logic_vector(23 downto 0);
         ram_rw : OUT  std_logic;
         port_rw : OUT  std_logic;
         ram_ce : OUT  std_logic;
         port_ce : OUT  std_logic;
         ctrl_stop : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal ctrl : std_logic_vector(7 downto 0) := (others => '0');
   signal bus_ak : std_logic := '0';
   signal base_address : std_logic_vector(23 downto 0) := (others => '0');
   signal source_address : std_logic_vector(23 downto 0) := (others => '0');
   signal destin_address : std_logic_vector(23 downto 0) := (others => '0');
   signal transfer_length : std_logic_vector(23 downto 0) := (others => '0');

 	--Outputs
   signal bus_rq : std_logic;
   signal ram_addr : std_logic_vector(23 downto 0);
   signal port_addr : std_logic_vector(23 downto 0);
   signal ram_rw : std_logic;
   signal port_rw : std_logic;
   signal ram_ce : std_logic;
   signal port_ce : std_logic;
   signal ctrl_stop : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: dma_state_machine PORT MAP (
          clk => clk,
          rst => rst,
          ctrl => ctrl,
          bus_ak => bus_ak,
          base_address => base_address,
          source_address => source_address,
          destin_address => destin_address,
          transfer_length => transfer_length,
          bus_rq => bus_rq,
          ram_addr => ram_addr,
          port_addr => port_addr,
          ram_rw => ram_rw,
          port_rw => port_rw,
          ram_ce => ram_ce,
          port_ce => port_ce,
          ctrl_stop => ctrl_stop
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
     wait for 250 ns;
     rst <= '0';
     wait;
   end process p_rst;
	

   -- Stimulus process
   stim_proc: process
   begin		
	
		-- Write on RAM
		bus_ak				<= '1';
		base_address		<= "000000000000000000000000";	-- Base address for local RAM mapping	= 0;
		source_address		<= "000000000000000000000010";	-- First address from port 				= 2;
		destin_address		<= "000000000000000000000100";	-- First address for RAM 					= 4;
		transfer_length	<= "000000000000000000000011";	-- Data to be transmitted					= 3;
      wait until rst='0';
      wait for 100 ns;
		ctrl					<= "00100101"; 						-- SRC autoinc: 1; DST autoinc: 1; Mode: Read from port; Start: Enabled;
				
      wait until bus_rq = '0' and ctrl_stop = '1';
		ctrl(0) <= '0';
      wait for 200 ns;
		bus_ak				<= '0';
      wait for clk_period;
		bus_ak				<= '1';
      wait for clk_period * (2 * to_integer((unsigned(transfer_length))));
		
      wait;
   end process;

END;
