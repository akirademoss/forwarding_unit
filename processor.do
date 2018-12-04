#SCRIPT TO AUTO-SIMULATE processor

#Simulate work.processor
vsim -gui work.processor -novopt
#vsim -gui work.processor -debugdb

#Add the waves
add wave sim:/processor/*

add wave -position insertpoint  \
sim:/processor/c3/mem

add wave -position insertpoint  \
sim:/processor/c0/w_data

add wave -position insertpoint  \
sim:/processor/c0/i_B

add wave -position insertpoint  \
sim:/processor/c0/i_C

add wave -position insertpoint  \
sim:/processor/c0/i_D

add wave -position insertpoint  \
sim:/processor/c0/i_E

add wave -position insertpoint  \
sim:/processor/c0/i_F

add wave -position insertpoint  \
sim:/processor/c0/rs_data \
sim:/processor/c0/rt_data

# This is our lw operation
# This should allow us to choose register 1 to store data into from our data memory
# I use 12 in decimal as the immediate which is 1100 in binary, the result is that the value in alu_out(9 downto 0), is 3 and so the data memory at address 3 gets stored.
# Note all bits used include: CLK, w_en, w_sel, imm_sel, and imm
force -freeze sim:/processor/CLK 1 0, 0 {50 ns} -r 100
force -freeze sim:/processor/reset 0 0
force -freeze sim:/processor/rs_sel 'd0 0
force -freeze sim:/processor/rt_sel 'd1 0
force -freeze sim:/processor/w_en 'd1 0
force -freeze sim:/processor/w_sel 'd1 0 
force -freeze sim:/processor/mem_sel 'd0 0
force -freeze sim:/processor/imm_sel 'd1 0
force -freeze sim:/processor/imm 'd3 0
force -freeze sim:/processor/ALU_OP 'd0 0
force -freeze sim:/processor/shamt 'd0 0
force -freeze sim:/processor/wren 'd0 0
run



# This is our lw operation
# This should allows us to choose register 2 to store data into from our data memory
# I use 20 decimal as the immediate which is 10100 binary, the result is that the value in alu_out(9 downto 0) is 5 and so the data memory at address 5 gets stored.
# Note all bits used include: CLK, w_en, w_sel, imm_sel, and imm
force -freeze sim:/processor/CLK 1 0, 0 {50 ns} -r 100
force -freeze sim:/processor/reset 0 0
force -freeze sim:/processor/rs_sel 'd0 0
force -freeze sim:/processor/rt_sel 'd0 0
force -freeze sim:/processor/w_en 'd1 0
force -freeze sim:/processor/w_sel 'd2 0 
force -freeze sim:/processor/mem_sel 'd0 0
force -freeze sim:/processor/imm_sel 'd1 0
force -freeze sim:/processor/imm 'd5 0
force -freeze sim:/processor/ALU_OP 'd0 0
force -freeze sim:/processor/shamt 'd0 0
force -freeze sim:/processor/wren 'd0 0
run



# This is our add operation
# This allows us to chose two registers, add them in the ALU, and then we select the reg_dst bit to indicate we would like the alu_out as our data.  
# From there, we select w_en and use w_sel to select which register we would like to 
# Note all bits used CLK, rs_sel, rt_sel, w_en, w_sel, mem_sel
force -freeze sim:/processor/CLK 1 0, 0 {50 ns} -r 100
force -freeze sim:/processor/reset 0 0
force -freeze sim:/processor/rs_sel 'd1 0
force -freeze sim:/processor/rt_sel 'd2 0
force -freeze sim:/processor/w_en 'd1 0
force -freeze sim:/processor/w_sel 'd3 0 
force -freeze sim:/processor/mem_sel 'd1 0
force -freeze sim:/processor/imm_sel 'd0 0
force -freeze sim:/processor/imm 'd0 0
force -freeze sim:/processor/ALU_OP 'd0 0
force -freeze sim:/processor/shamt 'd0 0
force -freeze sim:/processor/wren 'd0 0
run


# This is our lw operation
# This should allow us to choose register 5 to store data into from our data memory
# I use 44 in decimal as the immediate which is 101100 in binary, the result is that the value in alu_out(9 downto 0), is 11 and so the data memory at address 11 gets stored.  In this case this is 0.
# Note all bits used include: CLK, w_en, w_sel, imm_sel, and imm
force -freeze sim:/processor/CLK 1 0, 0 {50 ns} -r 100
force -freeze sim:/processor/reset 0 0
force -freeze sim:/processor/rs_sel 'd0 0
force -freeze sim:/processor/rt_sel 'd0 0
force -freeze sim:/processor/w_en 'd1 0
force -freeze sim:/processor/w_sel 'd5 0 
force -freeze sim:/processor/mem_sel 'd0 0
force -freeze sim:/processor/imm_sel 'd1 0
force -freeze sim:/processor/imm 'd11 0
force -freeze sim:/processor/ALU_OP 'd0 0
force -freeze sim:/processor/shamt 'd0 0
force -freeze sim:/processor/wren 'd0 0
run



# This is our sll operation
# This allows us to chose shift to multiply by shifting bits of rs_sel and storing into w_sel, 
# We need to choose register number of values we want to shift and choose register number of where we want to save the bits too. 
# We also need to make sure that we have w_en selected, and mem_sel to determine that the output will come from the ALU.  Finally we choose
# The appropriate ALU_OP and the shift amount that we want to use.
# Note all bits used CLK, rs_sel [5 bits], rt_sel [5 bits], w_en, w_sel, mem_sel, ALU_OP [4 bits] 1011, shamt [5 bits]
force -freeze sim:/processor/CLK 1 0, 0 {50 ns} -r 100
force -freeze sim:/processor/reset 0 0
force -freeze sim:/processor/rs_sel 'd1 0
force -freeze sim:/processor/rt_sel 'd0 0
force -freeze sim:/processor/w_en 'd1 0
force -freeze sim:/processor/w_sel 'd4 0 
force -freeze sim:/processor/mem_sel 'd1 0
force -freeze sim:/processor/imm_sel 'd0 0
force -freeze sim:/processor/imm 'd0 0
force -freeze sim:/processor/ALU_OP 'b1011 0
force -freeze sim:/processor/shamt 'd1 0
force -freeze sim:/processor/wren 'd0 0
run



# This is our sw operation
# Works!!!
force -freeze sim:/processor/CLK 1 0, 0 {50 ns} -r 100
force -freeze sim:/processor/reset 0 0
force -freeze sim:/processor/rs_sel 'd5 0
force -freeze sim:/processor/rt_sel 'd4 0
force -freeze sim:/processor/w_en 'd0 0
force -freeze sim:/processor/w_sel 'd4 0 
force -freeze sim:/processor/mem_sel 'd1 0
force -freeze sim:/processor/imm_sel 'd1 0
force -freeze sim:/processor/imm 'd0 0
force -freeze sim:/processor/ALU_OP 'd0 0
force -freeze sim:/processor/shamt 'd0 0
force -freeze sim:/processor/wren 'd1 0
run



#Run the clock
force -freeze sim:/processor/CLK 1 0, 0 {50 ns} -r 100
force -freeze sim:/processor/reset 0 0
force -freeze sim:/processor/rs_sel 'd0 0
force -freeze sim:/processor/rt_sel 'd0 0
force -freeze sim:/processor/w_en 'd0 0
force -freeze sim:/processor/w_sel 'd0 0 
force -freeze sim:/processor/mem_sel 'd0 0
force -freeze sim:/processor/imm 'd0 0
force -freeze sim:/processor/imm_sel 'd0 0
force -freeze sim:/processor/ALU_OP 'd0 0
force -freeze sim:/processor/shamt 'd0 0
force -freeze sim:/processor/wren 'd0 0
run