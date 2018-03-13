onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_dma_test/clk
add wave -noupdate /tb_dma_test/rst
add wave -noupdate /tb_dma_test/reg
add wave -noupdate -radix decimal /tb_dma_test/port_data
add wave -noupdate -radix decimal /tb_dma_test/port_addr
add wave -noupdate /tb_dma_test/port_ce
add wave -noupdate /tb_dma_test/port_rw
add wave -noupdate /tb_dma_test/port_rd_en
add wave -noupdate /tb_dma_test/port_wr_en
add wave -noupdate /tb_dma_test/uut/ram_data_out
add wave -noupdate /tb_dma_test/uut/ram_data_in
add wave -noupdate -radix decimal /tb_dma_test/ram_addr
add wave -noupdate /tb_dma_test/ram_ce
add wave -noupdate /tb_dma_test/ram_rw
add wave -noupdate /tb_dma_test/ram_rd_en
add wave -noupdate /tb_dma_test/ram_wr_en
add wave -noupdate /tb_dma_test/bus_rq
add wave -noupdate /tb_dma_test/bus_ak
add wave -noupdate /tb_dma_test/LENL
add wave -noupdate /tb_dma_test/LENH
add wave -noupdate /tb_dma_test/LENU
add wave -noupdate /tb_dma_test/LEN
add wave -noupdate -divider FSM
add wave -noupdate /tb_dma_test/uut/i_dma_state_machine/transfer_len
add wave -noupdate /tb_dma_test/uut/i_dma_state_machine/state
add wave -noupdate /tb_dma_test/uut/i_dma_state_machine/ctrl_stop
add wave -noupdate /tb_dma_test/uut/i_dma_state_machine/base_address
add wave -noupdate /tb_dma_test/uut/i_dma_state_machine/src
add wave -noupdate /tb_dma_test/uut/i_dma_state_machine/dst
add wave -noupdate /tb_dma_test/uut/i_dma_state_machine/base
add wave -noupdate /tb_dma_test/uut/i_dma_state_machine/source_address
add wave -noupdate /tb_dma_test/uut/i_dma_state_machine/destin_address
add wave -noupdate /tb_dma_test/uut/i_dma_state_machine/transfer_length
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {880000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 357
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
WaveRestoreZoom {713088 ps} {1007440 ps}
