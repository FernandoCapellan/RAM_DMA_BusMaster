onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_dma/clk
add wave -noupdate /tb_dma/rst
add wave -noupdate -radix decimal /tb_dma/data
add wave -noupdate /tb_dma/reg
add wave -noupdate /tb_dma/bus_rq
add wave -noupdate /tb_dma/bus_ak
add wave -noupdate -radix decimal /tb_dma/port_addr
add wave -noupdate /tb_dma/port_ce
add wave -noupdate /tb_dma/port_rw
add wave -noupdate /tb_dma/ram_rw
add wave -noupdate /tb_dma/ram_ce
add wave -noupdate -radix binary /tb_dma/ram_addr
add wave -noupdate /tb_dma/uut/ctrl_stop
add wave -noupdate /tb_dma/uut/i_dma_state_machine/transfer_len
add wave -noupdate -radix decimal -childformat {{/tb_dma/LEN(23) -radix decimal} {/tb_dma/LEN(22) -radix decimal} {/tb_dma/LEN(21) -radix decimal} {/tb_dma/LEN(20) -radix decimal} {/tb_dma/LEN(19) -radix decimal} {/tb_dma/LEN(18) -radix decimal} {/tb_dma/LEN(17) -radix decimal} {/tb_dma/LEN(16) -radix decimal} {/tb_dma/LEN(15) -radix decimal} {/tb_dma/LEN(14) -radix decimal} {/tb_dma/LEN(13) -radix decimal} {/tb_dma/LEN(12) -radix decimal} {/tb_dma/LEN(11) -radix decimal} {/tb_dma/LEN(10) -radix decimal} {/tb_dma/LEN(9) -radix decimal} {/tb_dma/LEN(8) -radix decimal} {/tb_dma/LEN(7) -radix decimal} {/tb_dma/LEN(6) -radix decimal} {/tb_dma/LEN(5) -radix decimal} {/tb_dma/LEN(4) -radix decimal} {/tb_dma/LEN(3) -radix decimal} {/tb_dma/LEN(2) -radix decimal} {/tb_dma/LEN(1) -radix decimal} {/tb_dma/LEN(0) -radix decimal}} -subitemconfig {/tb_dma/LEN(23) {-height 15 -radix decimal} /tb_dma/LEN(22) {-height 15 -radix decimal} /tb_dma/LEN(21) {-height 15 -radix decimal} /tb_dma/LEN(20) {-height 15 -radix decimal} /tb_dma/LEN(19) {-height 15 -radix decimal} /tb_dma/LEN(18) {-height 15 -radix decimal} /tb_dma/LEN(17) {-height 15 -radix decimal} /tb_dma/LEN(16) {-height 15 -radix decimal} /tb_dma/LEN(15) {-height 15 -radix decimal} /tb_dma/LEN(14) {-height 15 -radix decimal} /tb_dma/LEN(13) {-height 15 -radix decimal} /tb_dma/LEN(12) {-height 15 -radix decimal} /tb_dma/LEN(11) {-height 15 -radix decimal} /tb_dma/LEN(10) {-height 15 -radix decimal} /tb_dma/LEN(9) {-height 15 -radix decimal} /tb_dma/LEN(8) {-height 15 -radix decimal} /tb_dma/LEN(7) {-height 15 -radix decimal} /tb_dma/LEN(6) {-height 15 -radix decimal} /tb_dma/LEN(5) {-height 15 -radix decimal} /tb_dma/LEN(4) {-height 15 -radix decimal} /tb_dma/LEN(3) {-height 15 -radix decimal} /tb_dma/LEN(2) {-height 15 -radix decimal} /tb_dma/LEN(1) {-height 15 -radix decimal} /tb_dma/LEN(0) {-height 15 -radix decimal}} /tb_dma/LEN
add wave -noupdate -divider FSM
add wave -noupdate /tb_dma/uut/i_dma_state_machine/current_state
add wave -noupdate /tb_dma/uut/i_dma_state_machine/next_state
add wave -noupdate -divider REGISTERS
add wave -noupdate /tb_dma/uut/registers
add wave -noupdate /tb_dma/uut/BASEM
add wave -noupdate /tb_dma/uut/BASEH
add wave -noupdate /tb_dma/uut/BASE
add wave -noupdate /tb_dma/uut/SRCL
add wave -noupdate /tb_dma/uut/SRCM
add wave -noupdate /tb_dma/uut/SRCH
add wave -noupdate /tb_dma/uut/SRC
add wave -noupdate /tb_dma/uut/DSTL
add wave -noupdate /tb_dma/uut/DSTM
add wave -noupdate /tb_dma/uut/DSTH
add wave -noupdate /tb_dma/uut/DST
add wave -noupdate /tb_dma/uut/LENL
add wave -noupdate /tb_dma/uut/LENH
add wave -noupdate /tb_dma/uut/LENU
add wave -noupdate /tb_dma/uut/LEN
add wave -noupdate -radix binary /tb_dma/uut/CTRL
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {628415 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
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
WaveRestoreZoom {1951660 ps} {2002545 ps}
