onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top/clk
add wave -noupdate /tb_top/rst
add wave -noupdate -radix hexadecimal /tb_top/data
add wave -noupdate -radix decimal -childformat {{/tb_top/address(23) -radix decimal} {/tb_top/address(22) -radix decimal} {/tb_top/address(21) -radix decimal} {/tb_top/address(20) -radix decimal} {/tb_top/address(19) -radix decimal} {/tb_top/address(18) -radix decimal} {/tb_top/address(17) -radix decimal} {/tb_top/address(16) -radix decimal} {/tb_top/address(15) -radix decimal} {/tb_top/address(14) -radix decimal} {/tb_top/address(13) -radix decimal} {/tb_top/address(12) -radix decimal} {/tb_top/address(11) -radix decimal} {/tb_top/address(10) -radix decimal} {/tb_top/address(9) -radix decimal} {/tb_top/address(8) -radix decimal} {/tb_top/address(7) -radix decimal} {/tb_top/address(6) -radix decimal} {/tb_top/address(5) -radix decimal} {/tb_top/address(4) -radix decimal} {/tb_top/address(3) -radix decimal} {/tb_top/address(2) -radix decimal} {/tb_top/address(1) -radix decimal} {/tb_top/address(0) -radix decimal}} -subitemconfig {/tb_top/address(23) {-radix decimal} /tb_top/address(22) {-radix decimal} /tb_top/address(21) {-radix decimal} /tb_top/address(20) {-radix decimal} /tb_top/address(19) {-radix decimal} /tb_top/address(18) {-radix decimal} /tb_top/address(17) {-radix decimal} /tb_top/address(16) {-radix decimal} /tb_top/address(15) {-radix decimal} /tb_top/address(14) {-radix decimal} /tb_top/address(13) {-radix decimal} /tb_top/address(12) {-radix decimal} /tb_top/address(11) {-radix decimal} /tb_top/address(10) {-radix decimal} /tb_top/address(9) {-radix decimal} /tb_top/address(8) {-radix decimal} /tb_top/address(7) {-radix decimal} /tb_top/address(6) {-radix decimal} /tb_top/address(5) {-radix decimal} /tb_top/address(4) {-radix decimal} /tb_top/address(3) {-radix decimal} /tb_top/address(2) {-radix decimal} /tb_top/address(1) {-radix decimal} /tb_top/address(0) {-radix decimal}} /tb_top/address
add wave -noupdate /tb_top/reg
add wave -noupdate /tb_top/ce
add wave -noupdate /tb_top/rw
add wave -noupdate /tb_top/bus_rq
add wave -noupdate /tb_top/bus_ak
add wave -noupdate /tb_top/wr_en
add wave -noupdate /tb_top/rd_en
add wave -noupdate /tb_top/LENL
add wave -noupdate /tb_top/LENH
add wave -noupdate /tb_top/LENU
add wave -noupdate /tb_top/LEN
add wave -noupdate -divider DMA
add wave -noupdate /tb_top/uut/i_dma/reg
add wave -noupdate /tb_top/uut/i_dma/port_data
add wave -noupdate /tb_top/uut/i_dma/port_addr
add wave -noupdate /tb_top/uut/i_dma/port_ce
add wave -noupdate /tb_top/uut/i_dma/port_rw
add wave -noupdate /tb_top/uut/i_dma/port_rd_en
add wave -noupdate /tb_top/uut/i_dma/port_wr_en
add wave -noupdate /tb_top/uut/i_dma/ram_data_in
add wave -noupdate -radix hexadecimal /tb_top/uut/i_dma/ram_data_out
add wave -noupdate /tb_top/uut/i_dma/ram_addr
add wave -noupdate /tb_top/uut/i_dma/ram_ce
add wave -noupdate /tb_top/uut/i_dma/ram_rw
add wave -noupdate /tb_top/uut/i_dma/ram_rd_en
add wave -noupdate /tb_top/uut/i_dma/ram_wr_en
add wave -noupdate /tb_top/uut/i_dma/bus_rq
add wave -noupdate /tb_top/uut/i_dma/bus_ak
add wave -noupdate /tb_top/uut/i_dma/registers
add wave -noupdate /tb_top/uut/i_dma/ctrl_stop
add wave -noupdate -divider FSM
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/transfer_len
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/current_state
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/next_state
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/base_address
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/source_address
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/destin_address
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/transfer_length
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/port_data
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/port_addr
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/port_ce
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/port_rw
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/port_rd_en
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/port_wr_en
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/ram_data_in
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/ram_data_out
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/ram_addr
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/ram_ce
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/ram_rw
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/ram_rd_en
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/ram_wr_en
add wave -noupdate -divider RAM
add wave -noupdate /tb_top/uut/i_ram/data_in
add wave -noupdate /tb_top/uut/i_ram/data_out
add wave -noupdate /tb_top/uut/i_ram/address
add wave -noupdate /tb_top/uut/i_ram/ce
add wave -noupdate /tb_top/uut/i_ram/rw
add wave -noupdate /tb_top/uut/i_ram/rd_en
add wave -noupdate /tb_top/uut/i_ram/wr_en
add wave -noupdate /tb_top/uut/i_ram/wr_en_ff_2
add wave -noupdate /tb_top/uut/i_ram/wr_en_ff_1
add wave -noupdate /tb_top/uut/i_ram/read_port
add wave -noupdate -divider RAM2MIB
add wave -noupdate /tb_top/uut/i_ram/i_ram_2mib/clka
add wave -noupdate /tb_top/uut/i_ram/i_ram_2mib/rsta
add wave -noupdate /tb_top/uut/i_ram/i_ram_2mib/wea(0)
add wave -noupdate /tb_top/uut/i_ram/i_ram_2mib/addra
add wave -noupdate /tb_top/uut/i_ram/i_ram_2mib/dina
add wave -noupdate /tb_top/uut/i_ram/i_ram_2mib/douta
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {405000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 324
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {385356 ps} {671706 ps}
