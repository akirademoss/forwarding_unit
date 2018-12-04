#SCRIPT TO AUTO-SIMULATE project1

#Simulate work.project1
vsim -gui work.project1 -novopt
#vsim -gui work.project1 -debugdb

#Add the waves
add wave sim:/project1/*

#Registers 0, 8, 9, 10 and 16 respectively
add wave -position insertpoint  \
sim:/project1/c4/c0/i_A
add wave -position insertpoint  \
sim:/project1/c4/c0/i_I
add wave -position insertpoint  \
sim:/project1/c4/c0/i_J
add wave -position insertpoint  \
sim:/project1/c4/c0/i_K
add wave -position insertpoint  \
sim:/project1/c4/c0/i_Q


#Add data, and rs, rt waves for testing
add wave -position insertpoint  \
sim:/project1/c4/c0/w_data
add wave -position insertpoint  \
sim:/project1/c4/c0/rs_data
add wave -position insertpoint  \
sim:/project1/c4/c0/rt_data


#Reset
force -freeze sim:/project1/i_Rst 1 0
force -freeze sim:/project1/CLK 1 0, 0 {50 ns} -r 100
run

force -freeze sim:/project1/i_Rst 0 0
force -freeze sim:/project1/CLK 1 0, 0 {50 ns} -r 100
run


run 
run
run 
run

