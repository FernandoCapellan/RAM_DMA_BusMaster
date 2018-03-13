onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_dma_fsm_testing/clk
add wave -noupdate /tb_dma_fsm_testing/rst
add wave -noupdate /tb_dma_fsm_testing/port_data
add wave -noupdate /tb_dma_fsm_testing/port_addr
add wave -noupdate /tb_dma_fsm_testing/port_ce
add wave -noupdate /tb_dma_fsm_testing/port_rw
add wave -noupdate /tb_dma_fsm_testing/port_rd_en
add wave -noupdate /tb_dma_fsm_testing/port_wr_en
add wave -noupdate /tb_dma_fsm_testing/uut/ram_data_out
add wave -noupdate /tb_dma_fsm_testing/uut/ram_data_in
add wave -noupdate /tb_dma_fsm_testing/ram_addr
add wave -noupdate /tb_dma_fsm_testing/ram_ce
add wave -noupdate /tb_dma_fsm_testing/ram_rw
add wave -noupdate /tb_dma_fsm_testing/ram_rd_en
add wave -noupdate /tb_dma_fsm_testing/ram_wr_en
add wave -noupdate /tb_dma_fsm_testing/uut/ctrl
add wave -noupdate /tb_dma_fsm_testing/uut/state
add wave -noupdate /tb_dma_fsm_testing/uut/bus_rq
add wave -noupdate /tb_dma_fsm_testing/uut/bus_ak
add wave -noupdate /tb_dma_fsm_testing/uut/ctrl_stop
add wave -noupdate /tb_dma_fsm_testing/uut/base_address
add wave -noupdate /tb_dma_fsm_testing/uut/source_address
add wave -noupdate /tb_dma_fsm_testing/uut/destin_address
add wave -noupdate /tb_dma_fsm_testing/uut/transfer_length
add wave -noupdate /tb_dma_fsm_testing/uut/transfer_len
add wave -noupdate /tb_dma_fsm_testing/uut/src
add wave -noupdate /tb_dma_fsm_testing/uut/dst
add wave -noupdate /tb_dma_fsm_testing/uut/base
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1952501 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 212
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
WaveRestoreZoom {1748929 ps} {2013215 ps}
