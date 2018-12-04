#SCRIPT TO AUTO-SIMULATE instruction_fetch

#Simulate work.instruction_fetch
vsim -gui work.instruction_fetch -novopt
#vsim -gui work.instruction_fetch -debugdb

#Add the waves
add wave sim:/instruction_fetch/*

#Foce bits
force -freeze sim:/instruction_fetch/reset 1 0
force -freeze sim:/instruction_fetch/instruction 'd15 0
force -freeze sim:/instruction_fetch/CLK 1 0, 0 {50 ns} -r 100
run

force -freeze sim:/instruction_fetch/reset 0 0
force -freeze sim:/instruction_fetch/instruction 'd145 0
force -freeze sim:/instruction_fetch/CLK 1 0, 0 {50 ns} -r 100
run

force -freeze sim:/instruction_fetch/reset 0 0
force -freeze sim:/instruction_fetch/instruction 'd145 0
force -freeze sim:/instruction_fetch/CLK 1 0, 0 {50 ns} -r 100
run

force -freeze sim:/instruction_fetch/reset 0 0
force -freeze sim:/instruction_fetch/instruction 'd145 0
force -freeze sim:/instruction_fetch/CLK 1 0, 0 {50 ns} -r 100
run