#SCRIPT TO AUTO-SIMULATE projB

#Simulate work.finalProj
vsim -gui work.processor -novopt

--INSTRUCTIONS
add wave -position insertpoint  \
sim:/processor/instruction_address
add wave -position insertpoint  \
sim:/processor/instruction

add wave -position insertpoint  \
sim:/processor/branch_comparator_zero



add wave -position insertpoint sim:/processor/fetch_mux/*
add wave -position insertpoint sim:/processor/c10/*
add wave -position insertpoint sim:/processor/branch_addr_mux/*
add wave -position insertpoint sim:/processor/jump_addr_mux/*


-- OUTPUTS STD
add wave -position insertpoint  \
sim:/processor/o_addr
add wave -position insertpoint  \
sim:/processor/instruction_address \
sim:/processor/pc_plus_four \
sim:/processor/dmem_out

--MUX SELECT
add wave -position insertpoint  \
sim:/processor/muxA_sel_in
add wave -position insertpoint  \
sim:/processor/muxB_sel_in
--add wave -position insertpoint  \
--sim:/processor/muxB_sel

--REGISTER VALUES
add wave -position insertpoint  \
sim:/processor/reg_file/i_A \
sim:/processor/reg_file/i_I \
sim:/processor/reg_file/i_J \
sim:/processor/reg_file/i_K \
sim:/processor/reg_file/i_Q
add wave -position insertpoint  \
sim:/processor/reg_file/w_data \
sim:/processor/reg_file/rs_data \
sim:/processor/reg_file/rt_data

--MUX OUTPUTS
add wave -position insertpoint  \
sim:/processor/muxB_out \
sim:/processor/muxA_out

--MUX SIGNALS 
add wave -position insertpoint  \
sim:/processor/s_fwd_mem_alu_out \
sim:/processor/s_sw_mux_out \
sim:/processor/ex_rs_data \
sim:/processor/ex_rt_data


--ALL SIGNALS LOL
add wave -position insertpoint  \
sim:/processor/CLK \
sim:/processor/instruction_address \
sim:/processor/out_instruction \
sim:/processor/o_branch_zero \
sim:/processor/pc_plus_four \
sim:/processor/write_reg_sel \
sim:/processor/reg_write \
sim:/processor/dmem_out \
sim:/processor/i_RST \
sim:/processor/instruction \
sim:/processor/extend_imm \
sim:/processor/j_addr \
sim:/processor/o_addr \
sim:/processor/s_shift \
sim:/processor/write_register \
sim:/processor/shift_amount \
sim:/processor/out_reg_dest \
sim:/processor/out_jump \
sim:/processor/out_branch \
sim:/processor/out_mem_to_reg \
sim:/processor/out_mem_write \
sim:/processor/out_ALU_src \
sim:/processor/out_reg_write \
sim:/processor/zero \
sim:/processor/s_zero \
sim:/processor/out_ALU_op \
sim:/processor/s_clk \
sim:/processor/out_c \
sim:/processor/temp \
sim:/processor/q1 \
sim:/processor/q2 \
sim:/processor/out_ALU \
sim:/processor/mux2 \
sim:/processor/mux1 \
sim:/processor/mux0 \
sim:/processor/out_mem \
sim:/processor/branch_adder_out \
sim:/processor/id_flush \
sim:/processor/id_stall \
sim:/processor/ifid_reset \
sim:/processor/id_instruction \
sim:/processor/s_pc_plus_four \
sim:/processor/id_pc_plus_four \
sim:/processor/id_jump_addr \
sim:/processor/ex_instruction \
sim:/processor/ex_pc_plus_four \
sim:/processor/ex_rs_data \
sim:/processor/ex_rt_data \
sim:/processor/ex_extended_immediate \
sim:/processor/s_ex_address \
sim:/processor/ex_jump_addr \
sim:/processor/ex_rs_sel \
sim:/processor/ex_rt_sel \
sim:/processor/ex_rd_sel \
sim:/processor/ex_flush \
sim:/processor/ex_stall \
sim:/processor/idex_reset \
sim:/processor/ex_reg_dest \
sim:/processor/ex_branch \
sim:/processor/ex_mem_to_reg \
sim:/processor/ex_mem_write \
sim:/processor/ex_ALU_src \
sim:/processor/ex_reg_write \
sim:/processor/ex_jump \
sim:/processor/ex_ALU_op \
sim:/processor/mem_instruction \
sim:/processor/mem_pc_plus_four \
sim:/processor/mem_ALU_out \
sim:/processor/mem_rt_data \
sim:/processor/mem_jump_addr \
sim:/processor/mem_out_jump_addr \
sim:/processor/ex_write_reg_sel \
sim:/processor/mem_write_reg_sel \
sim:/processor/mem_flush \
sim:/processor/mem_stall \
sim:/processor/exmem_reset \
sim:/processor/mem_reg_dest \
sim:/processor/mem_mem_to_reg \
sim:/processor/mem_mem_write \
sim:/processor/mem_reg_write \
sim:/processor/mem_jump \
sim:/processor/wb_instruction \
sim:/processor/wb_pc_plus_four \
sim:/processor/wb_ALU_out \
sim:/processor/wb_dmem_out \
sim:/processor/wb_write_reg_sel \
sim:/processor/wb_flush \
sim:/processor/wb_stall \
sim:/processor/memwb_reset \
sim:/processor/wb_reg_dest \
sim:/processor/wb_mem_to_reg \
sim:/processor/wb_reg_write

--PROCESSOR SIGNALS
add wave -position insertpoint  \
sim:/processor/wb_ALU_out
add wave -position insertpoint  \
sim:/processor/wb_dmem_out
-- MUX SIGNAL
add wave -position insertpoint  \
sim:/processor/wb_mem_to_reg
add wave -position insertpoint  \
sim:/processor/mux2

--MUX BEFORE PC
add wave -position insertpoint  \
sim:/processor/fetch_mux/i_A \
sim:/processor/fetch_mux/i_B \
sim:/processor/fetch_mux/i_S
add wave -position insertpoint  \
sim:/processor/fetch_mux/o_F

--PC REGISTER
add wave -position insertpoint  \
sim:/processor/c10/c0/i_CLK \
sim:/processor/c10/c0/i_RST \
sim:/processor/c10/c0/i_WE \
sim:/processor/c10/c0/i_D
add wave -position insertpoint  \
sim:/processor/c10/c0/s_D \
sim:/processor/c10/c0/s_Q

--INSTRUCTION FETCH LOGIC
add wave -position insertpoint  \
sim:/processor/c10/reset \
sim:/processor/c10/instruction \
sim:/processor/c10/CLK \
sim:/processor/c10/jump_addr \
sim:/processor/c10/address \
sim:/processor/c10/pc_plus_4

--CLOCK / RESET
add wave -position insertpoint  \
sim:/processor/CLK
add wave -position insertpoint  \
sim:/processor/i_RST

--PIPELINE INSTRUCTIONS
add wave -position insertpoint  \
sim:/processor/idxex/id_instruction \
sim:/processor/idxex/ex_instruction
add wave -position insertpoint  \
sim:/processor/ifxid/if_instruction \
sim:/processor/ifxid/id_instruction
add wave -position insertpoint  \
sim:/processor/exxmem/ex_instruction \
sim:/processor/exxmem/mem_instruction
add wave -position insertpoint  \
sim:/processor/memxwb/mem_instruction \
sim:/processor/memxwb/wb_instruction

--
add wave -position insertpoint  \
sim:/processor/o_branch_zero \
sim:/processor/pc_plus_four \
sim:/processor/write_reg_sel \
sim:/processor/reg_write \
sim:/processor/dmem_out

--Start instructions
force -freeze sim:/processor/CLK 1 0, 0 {50 ns} -r 100
force -freeze sim:/processor/CLK_FE 0 0, 1 {50 ns} -r 100
force -freeze sim:/processor/i_RST 1 0
force -freeze sim:/processor/muxB_sel_in 'd2 0
force -freeze sim:/processor/muxA_sel_in 'd0 0
run

force -freeze sim:/processor/CLK 1 0, 0 {50 ns} -r 100
force -freeze sim:/processor/CLK_FE 0 0, 1 {50 ns} -r 100
force -freeze sim:/processor/i_RST 0 0
run

run
run
run
run
run
run
--eight
force -freeze sim:/processor/muxB_sel_in 'd1 0
run
run
run
run
run
run
run
run
run
run
run
run
--twenty
force -freeze sim:/processor/muxB_sel_in 'd0 0
run 
run
run
run
run
force -freeze sim:/processor/muxB_sel_in 'd1 0
run
run
run
run
run






