--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   08:10:26 03/07/2018
-- Design Name:   
-- Module Name:   C:/Users/FECP/Documents/Fernando/VHDL/RAM_DMA_BusMaster/Source/tb/tb_a1_complement_adder.vhd
-- Project Name:  RAM_DMA_BusMaster
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: a1_complement_adder
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
 
ENTITY tb_a1_complement_adder IS
END tb_a1_complement_adder;
 
ARCHITECTURE behavior OF tb_a1_complement_adder IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
	constant bus_width : positive := 4;
 
	COMPONENT a1_complement_adder
		Generic (
			g_bus_width : positive := 24
		);
		Port (
			address	: in  STD_LOGIC_VECTOR (g_bus_width - 1 downto 0);
			step		: in  STD_LOGIC_VECTOR (g_bus_width - 1 downto 0);
			result	: out STD_LOGIC_VECTOR (g_bus_width - 1 downto 0)
		);
		END COMPONENT;
    

   --Inputs
   signal address : std_logic_vector(bus_width - 1 downto 0) := (others => '0');
   signal step : std_logic_vector(bus_width - 1 downto 0) := (others => '0');

 	--Outputs
   signal result : std_logic_vector(bus_width - 1 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
	signal clk_signal : std_logic := '0';
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: a1_complement_adder 
	GENERIC MAP (
		g_bus_width => 4
	)
	PORT MAP (
		address => address,
		step => step,
		result => result
	);

   -- Clock process definitions
   clk_process :process
   begin
		clk_signal <= '0';
		wait for clk_period/2;
		clk_signal <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
		address <= "0000";
		step <= "0001";
      wait for 100 ns;	
		
		address <= "0000";
		step <= "1110";
      wait for 100 ns;	
		
		address <= "0100";
		step <= "1100";
      wait for 100 ns;	
		
		address <= "0010";
		step <= "1100";
      wait for 100 ns;	
		
		address <= "0010";
		step <= "1110";
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
