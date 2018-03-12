onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /tb_ram/data_in
add wave -noupdate /tb_ram/data_out
add wave -noupdate /tb_ram/uut/address
add wave -noupdate /tb_ram/uut/ce
add wave -noupdate /tb_ram/uut/rw
add wave -noupdate /tb_ram/uut/rd_en
add wave -noupdate /tb_ram/uut/wr_en
add wave -noupdate /tb_ram/uut/clk
add wave -noupdate /tb_ram/uut/rst
add wave -noupdate /tb_ram/uut/wr_en_ff_1
add wave -noupdate /tb_ram/uut/wr_en_ff_2
add wave -noupdate /tb_ram/uut/read_port
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {255000 ps} 0}
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
WaveRestoreZoom {0 ps} {1050 ns}
