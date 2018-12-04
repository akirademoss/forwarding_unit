#SCRIPT TO AUTO-SIMULATE done

#Simulate work.done
vsim -gui work.done -novopt
#vsim -gui work.done -debugdb

#Add the waves
add wave sim:/done/*

#Registers 0, 8, 9, 10 and 16 respectively
add wave -position insertpoint  \
sim:/done/c0/c4/c0/i_A
add wave -position insertpoint  \
sim:/done/c0/c4/c0/i_I
add wave -position insertpoint  \
sim:/done/c0/c4/c0/i_J
add wave -position insertpoint  \
sim:/done/c0/c4/c0/i_K
add wave -position insertpoint  \
sim:/done/c0/c4/c0/i_Q


#Add data, and rs, rt waves for testing
add wave -position insertpoint  \
sim:/done/c0/c4/c0/w_data
add wave -position insertpoint  \
sim:/done/c0/c4/c0/rs_data
add wave -position insertpoint  \
sim:/done/c0/c4/c0/rt_data


#Reset
force -freeze sim:/done/i_Rst 1 0
force -freeze sim:/done/CLK 1 0, 0 {50 ns} -r 100
run

force -freeze sim:/done/i_Rst 0 0
force -freeze sim:/done/CLK 1 0, 0 {50 ns} -r 100
run


run 
run
run 
run

