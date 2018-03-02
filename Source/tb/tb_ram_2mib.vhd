--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:25:14 03/02/2018
-- Design Name:   
-- Module Name:   C:/Users/FECP/Documents/Fernando/VHDL/RAM_DMA_BusMaster/Source/tb/tb_ram_2mib.vhd
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
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_ram_2mib IS
END tb_ram_2mib;
 
ARCHITECTURE behavior OF tb_ram_2mib IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ram_2mib
    PORT(
         data : INOUT  std_logic_vector(7 downto 0);
         address : IN  std_logic_vector(20 downto 0);
         rw : IN  std_logic;
         clk : IN  std_logic;
         rst : IN  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal addr : std_logic_vector(20 downto 0) := (others => '0');
   signal rw : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

	--BiDirs
   signal io_data : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ram_2mib PORT MAP (
          data => io_data,
          address => addr,
          rw => rw,
          clk => clk,
          rst => rst
        );
		  
	io_data <= T_Tx_Data WHEN T_WriteEn = '1';

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
		variable v_addr : unsigned(3 downto 0) := "0000";
   begin
		addr <= std_logic_vector(v_addr);
		rw <= '1';
		io_data <= (others => 'Z');
      wait until rst='0';
		wait until rising_edge(clk);

		-- writing test
		rw <= '0';
		for i in 0 to 16 loop
			v_addr := v_addr + 1;
			addr <= std_logic_vector(v_addr);
			io_data <= std_logic_vector(v_addr * 2);
			wait until rising_edge(clk);
		end loop;
		
		-- read test
		v_addr := 0;
		addr <= std_logic_vector(v_addr);
		rw <= '1';
		io_data <= (others => 'Z');
		for i in 0 to 16 loop
			v_addr := v_addr + 1;
			addr <= std_logic_vector(v_addr);
			io_data <= (others => 'Z');
			wait until rising_edge(clk);
		end loop;

      wait;
   end process;

END;
