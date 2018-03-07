onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_dma_state_machine/clk
add wave -noupdate /tb_dma_state_machine/rst
add wave -noupdate -radix binary /tb_dma_state_machine/ctrl
add wave -noupdate /tb_dma_state_machine/bus_ak
add wave -noupdate /tb_dma_state_machine/base_address
add wave -noupdate /tb_dma_state_machine/source_address
add wave -noupdate /tb_dma_state_machine/destin_address
add wave -noupdate /tb_dma_state_machine/transfer_length
add wave -noupdate /tb_dma_state_machine/bus_rq
add wave -noupdate /tb_dma_state_machine/ram_addr
add wave -noupdate /tb_dma_state_machine/port_addr
add wave -noupdate /tb_dma_state_machine/ram_rw
add wave -noupdate /tb_dma_state_machine/port_rw
add wave -noupdate /tb_dma_state_machine/ram_ce
add wave -noupdate /tb_dma_state_machine/port_ce
add wave -noupdate /tb_dma_state_machine/ctrl_stop
add wave -noupdate -divider dma_fsm
add wave -noupdate /tb_dma_state_machine/uut/current_state
add wave -noupdate /tb_dma_state_machine/uut/next_state
add wave -noupdate -radix decimal /tb_dma_state_machine/uut/transfer_len
add wave -noupdate -radix decimal /tb_dma_state_machine/uut/src
add wave -noupdate -radix decimal /tb_dma_state_machine/uut/src_step
add wave -noupdate -radix decimal /tb_dma_state_machine/uut/dst
add wave -noupdate -radix decimal /tb_dma_state_machine/uut/dst_step
add wave -noupdate -radix decimal /tb_dma_state_machine/uut/base
add wave -noupdate -radix decimal /tb_dma_state_machine/uut/src_result
add wave -noupdate -radix decimal /tb_dma_state_machine/uut/dst_result
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {565000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 259
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
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1589227 ps}
