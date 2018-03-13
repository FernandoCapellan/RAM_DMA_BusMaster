----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:47:46 03/06/2018 
-- Design Name: 
-- Module Name:    dma_state_machine - fsm 
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

entity dma_state_machine is
		Port (
			clk			: in std_logic;
			rst			: in std_logic;
			
			port_data			: inout	t_data;
		   port_addr			: inout	STD_LOGIC_VECTOR(20 DOWNTO 0);
		   port_ce				: inout	STD_LOGIC;
		   port_rw				: inout	STD_LOGIC;
		   port_rd_en			: in		STD_LOGIC;
		   port_wr_en			: out		STD_LOGIC;
			
			ram_data_out		: in		t_data;
			ram_data_in			: out		t_data;
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
end dma_state_machine;

architecture fsm of dma_state_machine is

	type state_type is (
      init_st,
      start_st,
      ak_wait_st,
      transfer_st,
      ram_read_st,
		ram_read_finish_st,
      port_write_st,
      port_read_st,
      ram_write_st,
      index_st
   );
	
	component a1_complement_adder
		Generic (
			g_bus_width : positive := 24
		);
		Port (
			address	: in  STD_LOGIC_VECTOR (g_bus_width - 1 downto 0);
			step		: in  STD_LOGIC_VECTOR (g_bus_width - 1 downto 0);
			result	: out STD_LOGIC_VECTOR (g_bus_width - 1 downto 0)
		);
	end component;
	
--   signal current_state				: state_type;
--   signal next_state					: state_type;
	signal state						: state_type;
	
	signal transfer_len				: STD_LOGIC_VECTOR (20 downto 0) := (others => '0');

	signal src, dst					: STD_LOGIC_VECTOR (20 DOWNTO 0) := (others => '0');
	signal base							: STD_LOGIC_VECTOR (20 DOWNTO 0) := base_address;
	signal src_step, dst_step		: STD_LOGIC_VECTOR (20 DOWNTO 0);
	signal src_result, dst_result	: STD_LOGIC_VECTOR (20 DOWNTO 0) := (others => '0');
	
begin

	src_adder : a1_complement_adder 
	GENERIC MAP (
		g_bus_width => 21
	)
	PORT MAP (
		address => src,
		step => src_step,
		result => src_result
	);
	
	dst_adder : a1_complement_adder 
	GENERIC MAP (
		g_bus_width => 21
	)
	PORT MAP (
		address => dst,
		step => dst_step,
		result => dst_result
	);
	
	
	
	
	clocked_fsm_proc : process (clk, rst, base_address, state, transfer_len) is
   begin
      if rising_edge(clk) then
			port_data			<= (others => 'Z');
			port_addr			<= (others => 'Z');
			port_ce				<= 'Z';
			port_rw				<= 'Z';
			port_wr_en			<= ram_wr_en;
			
			ram_data_in			<= (others => '0');
			ram_addr				<= port_addr;
			ram_ce				<= '1';
			ram_rw				<= port_rw;
			ram_rd_en			<= port_rd_en;
			
			bus_rq 				<= '1';
			ctrl_stop			<= '0';
			src 					<= src;
			dst 					<= dst;
			base					<= base_address;
			src_step				<= (20 downto ctrl(4 downto 2)'length => ctrl(4 downto 2)(ctrl(4 downto 2)'high)) & ctrl(4 downto 2);
			dst_step				<= (20 downto ctrl(7 downto 5)'length => ctrl(7 downto 5)(ctrl(7 downto 5)'high)) & ctrl(7 downto 5);
			transfer_len		<= transfer_len;
	
			
         if (rst = '1') then
				state				<= init_st;
				
				port_data			<= (others => 'Z');
				port_addr			<= (others => 'Z');
				port_ce				<= 'Z';
				port_rw				<= 'Z';
				port_wr_en			<= ram_wr_en;
				
				ram_data_in			<= (others => '0');
				ram_addr				<= (others => '0');
				ram_ce				<= '1';
				ram_rw				<= '1';
				ram_rd_en			<= '0';
				
				bus_rq 				<= '1';
				ctrl_stop			<= '0';
				src 					<= (others => '0');
				dst 					<= (others => '0');
				base					<= (others => '0');
				src_step				<= (20 downto ctrl(4 downto 2)'length => ctrl(4 downto 2)(ctrl(4 downto 2)'high)) & ctrl(4 downto 2);
				dst_step				<= (20 downto ctrl(7 downto 5)'length => ctrl(7 downto 5)(ctrl(7 downto 5)'high)) & ctrl(7 downto 5);
				transfer_len		<= transfer_length;
		
				
         else
				case state is
					when init_st =>
						if ctrl(0) = '1' then 
							state <= start_st;
						else
							state <= init_st;
						end if;
						
						
						if ram_wr_en = '1' then
							port_data	<= ram_data_out;
						else
							ram_data_in	<= port_data;		-- Slave passive listen
						end if;
						
						if reg = '1' then
							ram_ce		<= port_ce;
						end if;
						src 				<= (others => '0');
						dst 				<= (others => '0');
						base				<= (others => '0');
					
					when start_st =>
						state <= ak_wait_st;
						
						
						port_ce 			<= '1';
						port_rw 			<= '1';
						
						bus_rq 			<= '0';
						ctrl_stop 		<= '1';
					
					when ak_wait_st =>
						if bus_ak = '0' then 
							state <= transfer_st;
						else
							state <= ak_wait_st;
						end if;

						port_ce 			<= '1';
						port_rw 			<= '1';

					when transfer_st =>
						if ctrl(1) = '0' then 
							state <= port_read_st;
						else
							state <= ram_read_st;
						end if;
						
						port_ce 			<= '1';
						port_rw 			<= '1';
						
						src				<= source_address;
						dst				<= destin_address;
						--transfer_len	<= transfer_length;
						
						transfer_len <= std_logic_vector(unsigned(transfer_length) - 1);
						
					
					when port_read_st =>
						state <= ram_write_st;
						
						
						port_addr 		<= src;
						port_ce 			<= '0';
						port_rw 			<= '1';
					
					when ram_write_st =>
						state <= index_st;
						
					
						port_ce 			<= '1';
						port_rw 			<= '1';
						
						ram_data_in		<= port_data;
						ram_addr 		<= std_logic_vector(unsigned(dst) + unsigned(base));
						ram_ce 			<= '0';
						ram_rw 			<= '0';
						
				
					when ram_read_st =>
						state <= ram_read_finish_st;
					
					
						port_ce 			<= '1';
						port_rw 			<= '1';
						
						ram_addr 		<= std_logic_vector(unsigned(src) + unsigned(base));
						ram_ce 			<= '0';
						ram_rw 			<= '1';
												
					when ram_read_finish_st =>
						state <= port_write_st;
					
					when port_write_st =>
						state <= index_st;
					
					
						port_data 		<= ram_data_out;
						port_addr 		<= dst;
						port_ce 			<= '0';
						port_rw 			<= '0';
						port_wr_en 		<= ram_wr_en;
						

					when index_st =>
--						if current_state'event then
--							transfer_len 	<= std_logic_vector(unsigned(transfer_len) - 1);
--						end if;
						if transfer_len <= "000000000000000000000" then 
							state <= init_st;
						else							
							transfer_len 	<= std_logic_vector(unsigned(transfer_len) - 1);
							src 				<= src_result;
							dst 				<= dst_result;
							if ctrl(1) = '0' then
								state <= port_read_st;
							else
								state <= ram_read_st;
							end if;
						end if;


						port_ce 			<= '1';
						port_rw 			<= '1';
						
					

					when others =>
						state <= init_st;
				end case;
			
            
         end if;			
      end if;
   end process clocked_fsm_proc;
	

end fsm;

