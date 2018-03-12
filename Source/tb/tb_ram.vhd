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
    Port ( data_in	: in  	t_data;
			  data_out	: out  	t_data;
           address 	: in  	STD_LOGIC_VECTOR(20 DOWNTO 0);
           ce 			: in  	STD_LOGIC;
           rw 			: in  	STD_LOGIC;
			  rd_en 		: in  	STD_LOGIC;
			  wr_en 		: out  	STD_LOGIC;
			  clk 		: in  	STD_LOGIC;
           rst 		: in  	STD_LOGIC
			  );
    END COMPONENT;
    

   --Inputs
   signal addr : std_logic_vector(20 downto 0) := (others => '0');
   signal ce : std_logic := '1';
   signal rw : std_logic := '1';
   signal wr_en : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal data_in : t_data := (others => '0');

   --Outputs
   signal rd_en : std_logic := '0';
   signal data_out : t_data := (others => '0');
	
	--BiDirs
   --signal io_data : t_data;
	
	signal data_write : t_data := (others => '0');
	

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ram PORT MAP (
          data_in => data_in,
          data_out => data_out,
          address => addr,
          ce => ce,
          rw => rw,
          rd_en => rd_en,
          wr_en => wr_en,
          clk => clk,
          rst => rst
        );
		  
	--io_data <= io_data_write WHEN rw = '0' and ce = '0' else (others => 'Z');

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
		ce <= '1';
		rw <= '1';
      wait until rst='0';
		wait until rising_edge(clk);

		-- writing test
		ce <= '0';
		rw <= '0';
		for i in 0 to 15 loop
			addr <= std_logic_vector(v_addr);
			data_in <= std_logic_vector(v_addr(7 downto 0));
			rd_en <= '1';
			wait until rising_edge(clk);
			v_addr := v_addr + 1;
			rd_en <= '0';
		end loop;
		
		ce <= '1';
		rw <= '1';
		v_addr := (others => '0');
		addr <= std_logic_vector(v_addr);
		--wait for clk_period * 9;
		wait for clk_period * 10;
		
		
		-- read test		
		ce <= '0';
		wait for clk_period/2;
		
		for i in 0 to 15 loop
			addr <= std_logic_vector(v_addr);
			wait until rising_edge(clk);
			v_addr := v_addr + 1;
		end loop;

      wait;
   end process;

END;
