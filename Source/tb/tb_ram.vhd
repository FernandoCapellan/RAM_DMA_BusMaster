--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:25:14 03/03/2018
-- Design Name:   
-- Module Name:   C:/Users/FECP/Documents/Fernando/VHDL/RAM_DMA_BusMaster/Source/tb/tb_ram.vhd
-- Project Name:  RAM_DMA_BusMaster
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ram_2mib
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
 
ENTITY tb_ram IS
END tb_ram;
 
ARCHITECTURE behavior OF tb_ram IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ram
    PORT(
         data : INOUT  t_data;
         address : IN  std_logic_vector(20 downto 0);
         rw : IN  std_logic;
         clk : IN  std_logic;
         rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal addr : std_logic_vector(20 downto 0) := (others => '0');
   signal rw : std_logic := '1';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

	--BiDirs
   signal io_data : t_data;
	
	signal io_data_write : t_data := (others => '0');
	

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ram PORT MAP (
          data => io_data,
          address => addr,
          rw => rw,
          clk => clk,
          rst => rst
        );
		  
	io_data <= io_data_write WHEN rw = '0' else (others => 'Z');

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
	
	-- Reset process definitions
	p_rst : process
   begin
     rst <= '1';
     wait for 250 ns;
     rst <= '0';
     wait;
   end process p_rst;   
 

   -- Stimulus process
   stim_proc: process
		variable v_addr : unsigned(20 downto 0) := (others => '0');
   begin
		addr <= std_logic_vector(v_addr);
		rw <= '1';
      wait until rst='0';
		wait until rising_edge(clk);

		-- writing test
		rw <= '0';
		for i in 0 to 15 loop
			addr <= std_logic_vector(v_addr);
			io_data_write <= std_logic_vector(v_addr(7 downto 0));
			wait until rising_edge(clk);
			v_addr := v_addr + 1;
		end loop;
		
		rw <= '1';
		v_addr := (others => '0');
		addr <= std_logic_vector(v_addr);
		wait for clk_period * 10;
		
		-- read test
		
		for i in 0 to 15 loop
			addr <= std_logic_vector(v_addr);
			wait until rising_edge(clk);
			v_addr := v_addr + 1;
		end loop;

      wait;
   end process;

END;
