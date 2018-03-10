onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_top/clk
add wave -noupdate /tb_top/rst
add wave -noupdate -radix binary /tb_top/data
add wave -noupdate -radix decimal /tb_top/address
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
add wave -noupdate /tb_top/uut/i_dma/data
add wave -noupdate /tb_top/uut/i_dma/port_addr
add wave -noupdate /tb_top/uut/i_dma/port_ce
add wave -noupdate /tb_top/uut/i_dma/port_rw
add wave -noupdate /tb_top/uut/i_dma/ram_addr
add wave -noupdate /tb_top/uut/i_dma/ram_ce
add wave -noupdate /tb_top/uut/i_dma/ram_rw
add wave -noupdate /tb_top/uut/i_dma/bus_rq
add wave -noupdate /tb_top/uut/i_dma/bus_ak
add wave -noupdate /tb_top/uut/i_dma/registers
add wave -noupdate /tb_top/uut/i_dma/ctrl_stop
add wave -noupdate -divider FSM
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/transfer_len
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/mode
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/current_state
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/next_state
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/base_address
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/source_address
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/destin_address
add wave -noupdate /tb_top/uut/i_dma/i_dma_state_machine/transfer_length
add wave -noupdate -divider RAM
add wave -noupdate /tb_top/uut/i_ram/data
add wave -noupdate /tb_top/uut/i_ram/address
add wave -noupdate /tb_top/uut/i_ram/ce
add wave -noupdate /tb_top/uut/i_ram/rw
add wave -noupdate /tb_top/uut/i_ram/rd_en
add wave -noupdate /tb_top/uut/i_ram/wr_en
add wave -noupdate /tb_top/uut/i_ram/I
add wave -noupdate /tb_top/uut/i_ram/wr_en_ff_2
add wave -noupdate /tb_top/uut/i_ram/wr_en_ff_1
add wave -noupdate /tb_top/uut/i_ram/write_enable
add wave -noupdate -divider RAM2MIB
add wave -noupdate /tb_top/uut/i_ram/i_ram_2mib/clka
add wave -noupdate /tb_top/uut/i_ram/i_ram_2mib/rsta
add wave -noupdate /tb_top/uut/i_ram/i_ram_2mib/wea
add wave -noupdate /tb_top/uut/i_ram/i_ram_2mib/addra
add wave -noupdate /tb_top/uut/i_ram/i_ram_2mib/dina
add wave -noupdate /tb_top/uut/i_ram/i_ram_2mib/douta
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {205000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 367
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
WaveRestoreZoom {10419 ps} {458839 ps}
