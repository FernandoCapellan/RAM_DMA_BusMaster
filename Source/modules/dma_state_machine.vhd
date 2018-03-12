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
      port_write_st,
      port_read_st,
      ram_write_st,
      port_write_finish_st,
		ram_write_finish_st,
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
	
   signal current_state				: state_type;
   signal next_state					: state_type;
	
	signal transfer_len				: STD_LOGIC_VECTOR (20 downto 0) := (others => '0');

	signal src, dst, base			: STD_LOGIC_VECTOR (20 DOWNTO 0) := (others => '0');
	signal src_step, dst_step		: STD_LOGIC_VECTOR (20 DOWNTO 0);	
	signal src_result, dst_result	: STD_LOGIC_VECTOR (20 DOWNTO 0);
	
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

   clocked_proc : process (clk) is
   begin
      if rising_edge(clk) then
         if (rst = '1') then
				current_state	<= init_st;
         else
            current_state <= next_state;
         end if;			
      end if;
   end process clocked_proc;

nextstate_proc : process (current_state, ctrl, bus_ak, transfer_len) is
	begin
		case current_state is
			when init_st =>
				if ctrl(0) = '1' then 
					next_state <= start_st;
				else
					next_state <= init_st;
				end if;
			when start_st =>
				next_state <= ak_wait_st;
			when ak_wait_st =>
				if bus_ak = '0' then 
					next_state <= transfer_st;
				else
					next_state <= ak_wait_st;
				end if;
			when transfer_st =>
				if ctrl(1) = '1' then 
					next_state <= ram_read_st;
				else
					next_state <= port_read_st;
				end if;
						
			when ram_read_st =>
				next_state <= port_write_st;
			when port_write_st =>
				next_state <= port_write_finish_st;
			
			when port_read_st =>
				next_state <= ram_write_st;
			when ram_write_st =>
				next_state <= ram_write_finish_st;
				
			when port_write_finish_st =>
				next_state <= index_st;
			when ram_write_finish_st =>
				next_state <= index_st;
				
			when index_st =>
				if transfer_len <= "000000000000000000000" then 
					next_state <= init_st;
				elsif ctrl(1) = '1' then
					next_state <= ram_read_st;
				else
					next_state <= port_read_st;
				end if;
			when others =>
				next_state <= init_st;
		end case;
	end process nextstate_proc;

output_proc : process (current_state, port_data, port_addr, port_rd_en, ram_wr_en)
   begin			
		port_data			<= (others => 'Z');
		port_addr			<= (others => 'Z');
		port_rw				<= 'Z';
		port_ce				<= 'Z';
		bus_rq 				<= '1';
		ctrl_stop			<= '0';	
		
		src_step				<= (20 downto ctrl(4 downto 2)'length => ctrl(4 downto 2)(ctrl(4 downto 2)'high)) & ctrl(4 downto 2);
		dst_step				<= (20 downto ctrl(7 downto 5)'length => ctrl(7 downto 5)(ctrl(7 downto 5)'high)) & ctrl(7 downto 5);
		base <= base_address;

		--ram_data_in			<= (others => '0');		
		
      case current_state is
			when init_st =>
				if ram_wr_en = '1' then
					port_data	<= ram_data_out;
				else
					ram_data_in	<= port_data;		-- Slave passive listen
				end if;
				ram_addr			<= port_addr;
				if reg = '1' then
					ram_ce		<= port_ce;
				else
					ram_ce		<= '1';
				end if;
				ram_rw			<= port_rw;
				ram_rd_en		<= port_rd_en;
				port_wr_en		<= ram_wr_en;
						
			when start_st =>
            bus_rq 			<= '0';
				ctrl_stop 		<= '1';
			
			when ak_wait_st =>
            bus_rq 			<= '1';
				ctrl_stop 		<= '0';
			
			when transfer_st =>
				src				<= source_address;
				dst				<= destin_address;
				transfer_len	<= transfer_length;
								
				
			when ram_read_st =>
				ram_addr 		<= std_logic_vector(unsigned(src) + unsigned(base));
				ram_ce 			<= '0';
				ram_rw 			<= '1';
				port_ce 			<= '1';
			
			when port_write_st =>
				port_data 		<= ram_data_out;
				port_addr 		<= dst;
				port_ce 			<= '0';
				port_rw 			<= '0';
				port_wr_en 		<= ram_wr_en;
				ram_ce 			<= '1';
				
				
			when port_read_st =>
				port_addr 		<= src;
				port_ce 			<= '0';
				port_rw 			<= '1';
				ram_ce 			<= '1';
			
			when ram_write_st =>
				port_ce 			<= '1';
				ram_data_in		<= port_data;
				ram_addr 		<= std_logic_vector(unsigned(dst) + unsigned(base));
				ram_ce 			<= '0';
				ram_rw 			<= '0';
				ram_rd_en		<= port_rd_en;
				
			
			when port_write_finish_st =>
				port_ce 			<= '1';
			when ram_write_finish_st =>
				ram_ce 			<= '1';			
				-- ram_rd_en	<= '0'; implicit: opposite module disables signal
				
			when index_st =>
				if current_state'event then
					transfer_len 	<= std_logic_vector(unsigned(transfer_len) - 1);
				end if;
				--transfer_len 	<= std_logic_vector(unsigned(transfer_len) - 1);
				src 				<= src_result;
				dst 				<= dst_result;
			
         when others =>
				null;
      end case;
   end process output_proc;

end fsm;

