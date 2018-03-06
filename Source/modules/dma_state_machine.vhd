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
    Port ( clk					: in STD_LOGIC;
			  rst					: in STD_LOGIC;
			  ctrl				: in	t_data;
           bus_ak				: in	STD_LOGIC;
           base_address		: in	t_addr;
           source_address	: in	t_addr;
           destin_address	: in	t_addr;
           transfer_length	: in	STD_LOGIC_VECTOR (23 downto 0);
           bus_rq				: out	STD_LOGIC;
           ram_addr			: out	t_addr;
           port_addr			: out	t_addr;
           ram_rw				: out	STD_LOGIC;
           port_rw			: out	STD_LOGIC;
           ram_ce				: out	STD_LOGIC;
           port_ce			: out	STD_LOGIC;
           reset_ctrl		: out	STD_LOGIC);
end dma_state_machine;

architecture fsm of dma_state_machine is

	type state_type is (
      init_st,
      start_st,
      ak_wait_st,
      transfer_st,
      read_st,
      write_st,
      index_st,
      end_st
   );
	
   signal current_state		: state_type;
   signal next_state			: state_type;
	signal transfer_len		: STD_LOGIC_VECTOR (23 downto 0);
	signal src 					: t_addr := source_address;
	signal dst					: t_addr	:= destin_address;
	signal base					: t_addr := base_address;

begin

   clocked_proc : process (clk) is
   begin
      if rising_edge(clk) then
         if (rst = '1') then
            current_state <= init_st;
         else
            current_state <= next_state;
         end if;
      end if;
   end process clocked_proc;

	nextstate_proc : process (ctrl, bus_ak, transfer_len) is
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
					next_state <= read_st;
				else
					next_state <= write_st;
				end if;
			when read_st =>
				next_state <= index_st;
			when write_st =>
				next_state <= index_st;
			when index_st =>
				if transfer_len = "000000000000000000000000" then 
					next_state <= end_st;
				elsif ctrl(1) = '1' then
					next_state <= read_st;
				else
					next_state <= write_st;
				end if;
			when end_st =>
				next_state <= init_st;
			when others =>
				next_state <= init_st;
		end case;
	end process nextstate_proc;


	output_proc : process (current_state)
   begin
      bus_rq				<= '1';
		transfer_len		<= (others => '0');
		ram_addr				<= (others => '0');
		port_addr			<= (others => 'Z');
		ram_rw				<= '1';
		port_rw				<= '1';
		ram_ce				<= '1';
		port_ce				<= '1';
		reset_ctrl			<= '0';

      case current_state is			
			when start_st =>
            bus_rq <= '0';		
			
			when ak_wait_st =>
            bus_rq <= '1';	
			
			when transfer_st =>
				transfer_len <= transfer_length;
			
			when read_st =>
				ram_addr <= std_logic_vector(unsigned(src) + unsigned(base));
				port_addr <= dst;
				ram_rw <= '1';
				port_rw <= '0';
				ram_ce <= '0';
				port_ce <= '0';
			
			when write_st =>
				ram_addr <= std_logic_vector(unsigned(dst) + unsigned(base));
				port_addr <= src;
				ram_rw <= '0';
				port_rw <= '1';
				ram_ce <= '0';
				port_ce <= '0';
			
			when index_st =>
				transfer_len <= std_logic_vector(unsigned(transfer_len) - 1);
				src <= std_logic_vector(to_unsigned(to_integer(unsigned(src)) + to_integer(signed(ctrl(2 to 4))), 24));
				dst <= std_logic_vector(to_unsigned(to_integer(unsigned(dst)) + to_integer(signed(ctrl(5 to 7))), 24));
				ram_ce <= '1';
				port_ce <= '1';
				
			when end_st =>
				reset_ctrl <= '1';
				
         when others =>
            null;
      end case;
   end process output_proc;

end fsm;

