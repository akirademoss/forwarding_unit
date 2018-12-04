
library IEEE;
use IEEE.std_logic_1164.all;

entity processor is

	port(CLK            : in  std_logic;
	CLK_FE            : in  std_logic;
	ex_mem_to_reg_out     : out  std_logic;
 	ex_rt_sel_out : out std_logic_vector(4 downto 0);
	muxA_sel_in : in std_logic_vector(1 downto 0);
	muxB_sel_in : in std_logic_vector(1 downto 0);
	fwd_mem_alu_out : out std_logic_vector(31 downto 0);
	fwd_sw_mux_out : out std_logic_vector(31 downto 0);
	instruction_address : out std_logic_vector(31 downto 0);
	out_instruction	: out std_logic_vector(31 downto 0);
	pc_address : out std_logic_vector(31 downto 0);
	o_branch_zero   :  out  std_logic;
	pc_plus_four	: out std_logic_vector(31 downto 0);
	write_reg_sel : out std_logic_vector(4 downto 0);
	reg_write : out std_logic;
	dmem_out : out std_logic_vector(31 downto 0);
	o_equal  : out std_logic;
	ex_mem_regWrite_out  : out std_logic;
	ex_mem_registerRd_out  : out std_logic_vector(4 downto 0);
	mem_wb_regWrite_out  : out std_logic;
	mem_wb_registerRd_out  : out std_logic_vector(4 downto 0);
        i_RST          : in  std_logic); -- resets all registers to 0
end processor;


architecture structure of processor is

component register_file 
generic (N : integer := 32);
  port(CLK            : in  std_logic;
       rs_sel         : in  std_logic_vector(4 downto 0); -- first read address    
       rt_sel         : in  std_logic_vector(4 downto 0); -- second read address
       w_data         : in  std_logic_vector(31 downto 0); -- write data
       w_sel          : in  std_logic_vector(4 downto 0); -- write address
       w_en           : in  std_logic; -- write enable
       reset          : in  std_logic; -- resets all registers to 0
       rs_data        : out std_logic_vector(31 downto 0); -- first read data
       rt_data        : out std_logic_vector(31 downto 0)); -- second read data
       
 end component;



component ALU
 port(ALU_OP        : in  std_logic_vector(3 downto 0);
       shamt         : in  std_logic_vector(4 downto 0);
       i_A           : in  std_logic_vector(31 downto 0);
       i_B           : in  std_logic_vector(31 downto 0);
       zero          : out std_logic;
       ALU_out       : out std_logic_vector(31 downto 0));
end component;


component mem

generic(depth_exp_of_2 	: integer := 10;
			mif_filename 	: string := "dmem.mif");
	port   (address			: IN STD_LOGIC_VECTOR (depth_exp_of_2-1 DOWNTO 0) := (OTHERS => '0');
			byteena			: IN STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '1');
			clock			: IN STD_LOGIC := '1';
			data			: IN STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
			wren			: IN STD_LOGIC := '0';
			q				: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));         
end component;


component my_mux_eight_bit 
  generic(N : integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       i_B  : in std_logic_vector(N-1 downto 0);
       i_S  : in std_logic;
       o_F  : out std_logic_vector(N-1 downto 0));
	   
end component;

component imem

generic(depth_exp_of_2 	: integer := 10;
			mif_filename 	: string := "imem.mif");
	port   (address			: IN STD_LOGIC_VECTOR (depth_exp_of_2-1 DOWNTO 0) := (OTHERS => '0');
			byteena			: IN STD_LOGIC_VECTOR (3 DOWNTO 0) := (OTHERS => '1');
			clock			: IN STD_LOGIC := '1';
			data			: IN STD_LOGIC_VECTOR (31 DOWNTO 0) := (OTHERS => '0');
			wren			: IN STD_LOGIC := '0';
			q				: OUT STD_LOGIC_VECTOR (31 DOWNTO 0));         
end component;


component main_control
port( i_instruction : in std_logic_vector(31 downto 0);
  	    o_reg_dest : out std_logic;
  	    o_jump : out std_logic;
  	    o_branch : out std_logic;
  	    o_mem_to_reg : out std_logic;
  	    o_ALU_op : out std_logic_vector(3 downto 0);
  	    o_mem_write : out std_logic;
  	    o_ALU_src : out std_logic;
  	    o_reg_write : out std_logic
  	    );
 end component;

component Signed_extend
	
	port(in_A     :  in    std_logic_vector(15 downto 0);
	     out_F    :  out   std_logic_vector(31 downto 0));

end component;

component rd_mux
 generic(N : integer := 4);
  port(i_A  : in std_logic_vector(N downto 0);
       i_B  : in std_logic_vector(N downto 0);
       i_S  : in std_logic;
       o_F  : out std_logic_vector(N downto 0));
	   
end component;

component full_adder_eight_bit 
  generic(N : integer := 32);
  port (	i_A : in std_logic_vector(N-1 downto 0);
		i_B : in std_logic_vector(N-1 downto 0);
		i_Carry_in : in std_logic;
		o_Sum : out std_logic_vector(N-1 downto 0);
		o_Carry_out : out std_logic);	
	   
end component;

component barrel_shift is
   generic(N : integer := 32);
   port(i_A  : in std_logic_vector (N-1 downto 0);
	i_S  : in std_logic_vector (4 downto 0);
	o_F  : out std_logic_vector (N-1 downto 0));

end component;

component instruction_fetch is
port (

	reset      :  in std_logic;
	instruction : in std_logic_vector(31 downto 0);
	branch_jump_addr : in std_logic_vector(31 downto 0);
        CLK   :  in std_logic;
	--extended_imm : in std_logic_vector(31 downto 0);
        --branch_zero : in std_logic;
	--jump        :  in std_logic;
	jump_addr   : out std_logic_vector(31 downto 0);
	address     : out std_logic_vector(31 downto 0);
	pc_plus_4   : out std_logic_vector(31 downto 0));
    

end component;

component register_Nbit is
  generic (N : integer := 32);
  port(i_CLK        : in std_logic;     -- Clock input
       i_RST        : in std_logic;     -- Reset input
       i_WE         : in std_logic;     -- Write enable input
       i_D          : in std_logic_vector(N-1 downto 0);     -- Data value input
       o_Q          : out std_logic_vector(N-1 downto 0));   -- Data value output
 end component;


component fetch is
port (i_A   :  in std_logic_vector(25 downto 0);
      i_B   :  in std_logic_vector(3 downto 0);
      o_F   :  out std_logic_vector(31 downto 0));   --jump address

end component;


component if_id is
  port( CLK : in  std_logic;
  	id_flush, id_stall, ifid_reset : in std_logic;
       	if_instruction  : in std_logic_vector(31 downto 0);
       	id_instruction  : out std_logic_vector(31 downto 0);
       	if_pc_plus_4 : in std_logic_vector(31 downto 0);
       	id_pc_plus_4 : out std_logic_vector(31 downto 0);
	if_jump_addr : in std_logic_vector(31 downto 0);
	id_jump_addr : out std_logic_vector(31 downto 0));
 end component;

component id_ex is
  port(CLK           : in  std_logic;
  		ex_flush, ex_stall, idex_reset : in std_logic;
  		id_instruction  : in std_logic_vector(31 downto 0); -- pass instruction along (useful for debugging)
        ex_instruction  : out std_logic_vector(31 downto 0);
        id_pc_plus_4 : in std_logic_vector(31 downto 0);
       	ex_pc_plus_4 : out std_logic_vector(31 downto 0);
	id_jump_addr : in std_logic_vector(31 downto 0);
	ex_jump_addr : out std_logic_vector(31 downto 0);

  	-- CONTROL signals
        id_reg_dest   : in std_logic; --id_reg_dest = out_reg_dest
  	    id_branch 	 : in std_logic; --id_branch = out_branch
  	    id_mem_to_reg : in std_logic; --id_mem_to_reg = out_mem_to_reg
  	    id_ALU_op 	 : in std_logic_vector(3 downto 0); --id_ALU_op = out_ALU_op
  	    id_mem_write  : in std_logic; -- id_mem_write = out_mem_write
  	    id_ALU_src 	 : in std_logic; -- id_ALU_src = out_ALU_src
  	    id_reg_write  : in std_logic; -- id_reg_write = write_register
	    id_jump	: in std_logic;
  	    ex_reg_dest   : out std_logic; --ex_reg_dest 
  	    ex_branch 	 : out std_logic;
  	    ex_mem_to_reg : out std_logic;
  	    ex_ALU_op 	 : out std_logic_vector(3 downto 0);
  	    ex_mem_write  : out std_logic;
  	    ex_ALU_src 	 : out std_logic;
  	    ex_reg_write  : out std_logic;
	    ex_jump	: out std_logic;
  	-- END CONTROL signals

  	-- Register signals
  		id_rs_data : in std_logic_vector(31 downto 0); --q1
  		id_rt_data : in std_logic_vector(31 downto 0); --q2
  		ex_rs_data : out std_logic_vector(31 downto 0);
  		ex_rt_data : out std_logic_vector(31 downto 0);
  		id_rs_sel : in std_logic_vector(4 downto 0); --id_instruction(25 downto 21)
  		id_rt_sel : in std_logic_vector(4 downto 0); -- id_instruction(20 downto 16)
  		id_rd_sel : in std_logic_vector(4 downto 0); -- write_register
  		ex_rs_sel : out std_logic_vector(4 downto 0);
  		ex_rt_sel : out std_logic_vector(4 downto 0);
  		ex_rd_sel : out std_logic_vector(4 downto 0);
  	-- END Register signals

  		id_extended_immediate : in std_logic_vector(31 downto 0); --extend_imm
  		ex_extended_immediate : out std_logic_vector(31 downto 0)
  	    );
end component;

component ex_mem is
  port(CLK           : in  std_logic;
		mem_flush, mem_stall, exmem_reset : in std_logic;
		ex_instruction  : in std_logic_vector(31 downto 0); -- pass instruction along (useful for debugging)
        mem_instruction  : out std_logic_vector(31 downto 0);
        ex_pc_plus_4 : in std_logic_vector(31 downto 0);
       	mem_pc_plus_4 : out std_logic_vector(31 downto 0);
		ex_jump_addr : in std_logic_vector(31 downto 0);
		mem_jump_addr : out std_logic_vector(31 downto 0);

  	-- CONTROL signals
        ex_reg_dest   : in std_logic;
  	    ex_mem_to_reg : in std_logic;
  	    ex_mem_write  : in std_logic;
  	    ex_reg_write  : in std_logic;
	    ex_jump	: in std_logic;
  	    mem_reg_dest   : out std_logic;
  	    mem_mem_to_reg : out std_logic;
  	    mem_mem_write  : out std_logic;
  	    mem_reg_write  : out std_logic;
	    mem_jump	: out std_logic;
  	-- END CONTROL signals

  	-- ALU signals
		ex_ALU_out : in std_logic_vector(31 downto 0);
		mem_ALU_out : out std_logic_vector(31 downto 0);
  	-- END ALU signals
	
	--Writ

	-- Register signals
		ex_rt_data : in std_logic_vector(31 downto 0);
		mem_rt_data : out std_logic_vector(31 downto 0);
  		ex_write_reg_sel : in std_logic_vector(4 downto 0); -- see the Reg. Dest. mux in the pipeline archteicture diagram
  		mem_write_reg_sel : out std_logic_vector(4 downto 0)
  	-- END Register signals
  	    );
end component;

component mem_wb is
    port(
	mem_jump : in std_logic;
	wb_jump : out std_logic;
	CLK           : in  std_logic;
		wb_flush, wb_stall, memwb_reset : in std_logic;
		mem_instruction  : in std_logic_vector(31 downto 0); -- pass instruction along (useful for debugging)
        wb_instruction  : out std_logic_vector(31 downto 0);
        mem_pc_plus_4 : in std_logic_vector(31 downto 0);
       	wb_pc_plus_4 : out std_logic_vector(31 downto 0);

  	-- CONTROL signals
        mem_reg_dest   : in std_logic;
  	    mem_mem_to_reg : in std_logic;
  	    mem_reg_write  : in std_logic;
  	    wb_reg_dest   : out std_logic;
  	    wb_mem_to_reg : out std_logic;
  	    wb_reg_write  : out std_logic;
  	-- END CONTROL signals

  	-- ALU signals
		mem_ALU_out : in std_logic_vector(31 downto 0);
		wb_ALU_out : out std_logic_vector(31 downto 0);
  	-- END ALU signals

  	-- Memory signals
		mem_dmem_out : in std_logic_vector(31 downto 0);
		wb_dmem_out : out std_logic_vector(31 downto 0);
  	-- END Memory signals

	-- Register signals
  		mem_write_reg_sel : in std_logic_vector(4 downto 0);
  		wb_write_reg_sel : out std_logic_vector(4 downto 0)
  	-- END Register signals
  	    );
end component;


component branch_comparator is
  port( i_rs_data, i_rt_data : in std_logic_vector(31 downto 0);
  	    o_equal : out std_logic); -- '1' if A==B, '0' otherwise
 end component;


component mux_3to1 is
generic (N : integer := 32);
port (i_A        :     in   std_logic_vector(N-1 downto 0);
      i_B        :     in   std_logic_vector(N-1 downto 0);
      i_C        :     in   std_logic_vector(N-1 downto 0);
      i_D        :     in   std_logic_vector(N-1 downto 0);
      i_S        :     in   std_logic_vector(1 downto 0);
      o_F        :     out  std_logic_vector(N-1 downto 0));

end component;


component forwarding_unit is
    Port ( 
				
				ex_mem_regWrite : 		in  STD_LOGIC;
				ex_mem_registerRd : 		in  STD_LOGIC_VECTOR(4 downto 0);
				
				mem_wb_regWrite : 		in  STD_LOGIC;
				mem_wb_registerRd : 		in  STD_LOGIC_VECTOR(4 downto 0);
				
				id_ex_registerRs : 		in  STD_LOGIC_VECTOR(4 downto 0);
				id_ex_registerRt : 		in  STD_LOGIC_VECTOR(4 downto 0);
				
				fordward_a : out STD_LOGIC_VECTOR(1 downto 0);
				fordward_b : out STD_LOGIC_VECTOR(1 downto 0)
				
			  );
end component;


component hazard_detector is
    Port ( memory_read : in  STD_LOGIC;
	   EX_reg_write: in STD_LOGIC_VECTOR(4 downto 0); -- destination register of load instruction
	   ID_reg_a: in STD_LOGIC_VECTOR(4 downto 0); -- operand a of instruction in decode stage
	   ID_reg_b: in STD_LOGIC_VECTOR(4 downto 0); -- operand b of instruction in decode
           stall_pipeline: out STD_LOGIC
	 );
end component;



--project1 signals
signal  instruction,extend_imm, j_addr, o_addr, s_shift, alusrc_mux_out, s_fwd_mem_alu_out, muxB_out, muxA_out, s_sw_mux_out :  std_logic_vector(31 downto 0); --may delete j_addr signal
signal write_register,shift_amount :   std_logic_vector(4 downto 0);
signal out_reg_dest, out_jump, out_branch, out_mem_to_reg, out_mem_write, out_ALU_src, out_reg_write,zero, s_zero, stall  : std_logic;
signal out_ALU_op    :   std_logic_vector(3 downto 0);
signal fwd_muxA, fwd_muxB : std_logic_vector(1 downto 0);
--processor signals
signal   s_clk, out_c   :  std_logic;
signal   temp      :   std_logic_vector(9 downto 0);
signal   q1,q2,out_ALU ,mux2,mux1, mux0, out_mem  :  std_logic_vector(31 downto 0);
--new signals
signal   branch_adder_out  :   std_logic_vector(31 downto 0);

--###################### pipeline output signals [begin] ############################

--if_id
signal id_flush, id_stall, ifid_reset, branch_comparator_zero : std_logic;
signal id_instruction, s_pc_plus_four, id_pc_plus_four, id_jump_addr, s_null :  std_logic_vector(31 downto 0);
--id_ex
signal ex_instruction, ex_pc_plus_four, ex_rs_data, ex_rt_data, ex_extended_immediate, s_ex_address, ex_jump_addr :  std_logic_vector(31 downto 0);
signal ex_rs_sel, ex_rt_sel, ex_rd_sel   :   std_logic_vector(4 downto 0);
signal ex_flush, ex_stall, idex_reset, ex_reg_dest, ex_branch, ex_mem_to_reg, ex_mem_write, ex_ALU_src, ex_reg_write, ex_jump  :  std_logic;
signal ex_ALU_op    :   std_logic_vector(3 downto 0);
--ex_mem
signal mem_instruction, mem_pc_plus_four, mem_ALU_out, mem_rt_data, mem_jump_addr, mem_out_jump_addr :  std_logic_vector(31 downto 0);
signal ex_write_reg_sel, mem_write_reg_sel : std_logic_vector(4 downto 0);
signal mem_flush, mem_stall, exmem_reset, mem_reg_dest, mem_mem_to_reg, mem_mem_write, mem_reg_write, mem_jump : std_logic;
--mem_wb
signal wb_instruction, wb_pc_plus_four, wb_ALU_out, wb_dmem_out :  std_logic_vector(31 downto 0);
signal wb_write_reg_sel: std_logic_vector(4 downto 0);
signal wb_flush, wb_stall, memwb_reset, wb_reg_dest, wb_mem_to_reg, wb_reg_write, wb_jump : std_logic;

--###################### pipeline output signals [end] ############################

begin

	shift_amount <= "00010";
	id_flush <= '0';
	id_stall <= '0';
	ifid_reset <= i_RST;
	ex_flush <= '0';
	ex_stall <= '0';
	idex_reset <= i_RST;
	mem_flush <= '0';
	mem_stall <= '0';
	exmem_reset <= i_RST;
	wb_flush <= '0';
	wb_stall <= '0';
	memwb_reset <= i_RST;

--#####################################    fetch     ################################################
--NOTE TODO: get appropriate output signals 
	fetch_mux : my_mux_eight_bit
	port map(s_pc_plus_four, mem_out_jump_addr, s_zero, mux0);

	c10 : instruction_fetch
	port map(i_Rst, instruction, mux0, CLK, j_addr, o_addr, s_pc_plus_four); --output signals: j_addr = jump address, s_pc_plus_four = regular address


	c0 : imem
	port map(o_addr(11 downto 2),open,CLK,open,'0',instruction); 

--#####################################     if_id     ##############################################
	-- first pipeline register file
	ifxid : if_id 
	port map(CLK, id_flush, id_stall, ifid_reset, instruction, id_instruction, s_pc_plus_four, id_pc_plus_four, j_addr, id_jump_addr );
	
	--hazard detection
	hzd_detect : hazard_detector
	port map(ex_mem_to_reg, ex_rt_sel, id_instruction(25 downto 21), id_instruction(20 downto 16), stall);

	-- main control
	main_ctl : main_control
	port map(id_instruction,out_reg_dest, out_jump, out_branch, out_mem_to_reg, out_ALU_op, out_mem_write, out_ALU_src, out_reg_write);

	--sign extension
	sign_ext : Signed_extend
	port map(id_instruction(15 downto 0), extend_imm);

	--register file
	reg_file : register_file
	port map(CLK_FE, id_instruction(25 downto 21), id_instruction(20 downto 16), mux2, wb_write_reg_sel, wb_reg_write, i_Rst, q1, q2);

	--branch comparator
	bc : branch_comparator
	port map(q1, q2, branch_comparator_zero);


--#####################################     id_ex     ##############################################
	--second pipeline register file
	idxex : id_ex 
	port map(CLK, ex_flush, ex_stall, idex_reset, id_instruction, ex_instruction, id_pc_plus_four, ex_pc_plus_four, id_jump_addr, ex_jump_addr,
                 out_reg_dest, out_branch, out_mem_to_reg, out_ALU_op, out_mem_write, out_ALU_src, out_reg_write, out_jump,
                 ex_reg_dest, ex_branch, ex_mem_to_reg, ex_ALU_op, ex_mem_write, ex_ALU_src, ex_reg_write, ex_jump,
                 q1, q2, ex_rs_data, ex_rt_data, id_instruction(25 downto 21), id_instruction(20 downto 16), write_register, ex_rs_sel, ex_rt_sel, ex_rd_sel, 
                 extend_imm, ex_extended_immediate ); 

	-- select between rt and rd mux
	rtrd_mux : rd_mux
	port map(ex_instruction(20 downto 16), ex_instruction(15 downto 11), ex_reg_dest, write_register);  
													    
													    
	
-- FORWARDING UNIT
	fwd_unit: forwarding_unit	
	port map(mem_reg_write, mem_write_reg_sel, wb_reg_write, wb_write_reg_sel, ex_rs_sel, ex_rt_sel, fwd_muxA, fwd_muxB);	

										   
	--START HAZARD DETECTION
	-- Forwarding MuxB
	fwdMuxB   :   mux_3to1
	port map(ex_rt_data, s_sw_mux_out, s_fwd_mem_alu_out, s_null, fwd_muxB, muxB_out);	

	alusrc_mux : my_mux_eight_bit 
	port map(muxB_out, ex_extended_immediate, ex_ALU_src, alusrc_mux_out);

	-- Forwarding MuxA
	fwdMuxA   :   mux_3to1
	port map(ex_rs_data, s_sw_mux_out, s_fwd_mem_alu_out, s_null, fwd_muxA, muxA_out);

	--ALU / ALUCtl 
	ex_ALU : ALU
	port map(ex_ALU_op, "00000", muxA_out, alusrc_mux_out, zero, out_ALU);--note that zero and out_ALU and zero go in ex_mem	  				 (3), (4) [x]

	--branch logic shifter
	sl2 : barrel_shift
	port map(ex_extended_immediate, shift_amount, s_shift);

	--branch logic adder
	adder : full_adder_eight_bit
	port map(ex_pc_plus_four, ex_extended_immediate, '0', branch_adder_out, open); --note j_addr will go into ex_mem					  (5)[x]

	--branch logic (decide between regular or branched address)
	branch_addr_mux : my_mux_eight_bit
	port map(ex_pc_plus_four, branch_adder_out, s_zero, mux1);

	--jump logic (decide between jump address or regular or branch address)
	jump_addr_mux : my_mux_eight_bit
	port map(mux1, ex_jump_addr, ex_jump, mem_out_jump_addr);

--#####################################     ex_mem     ##############################################
 

--NOTE TODO: will need to insert the branch_adder_out signal into the ex_mem pipeline

	--third pipeline register
	exxmem : ex_mem
	port map(CLK, mem_flush, mem_stall, exmem_reset, 
		 ex_instruction, mem_instruction, ex_pc_plus_four, mem_pc_plus_four, ex_jump_addr, mem_jump_addr,
		 ex_reg_dest, ex_mem_to_reg, ex_mem_write, ex_reg_write, ex_jump, mem_reg_dest, mem_mem_to_reg, mem_mem_write, mem_reg_write, mem_jump,
		 out_ALU, mem_ALU_out, 
		 muxB_out, mem_rt_data, write_register, mem_write_reg_sel);

	c7 : mem
	port map(mem_ALU_out(11 downto 2), open, CLK, mem_rt_data, mem_mem_write, out_mem); --mem_write_reg_sel, mem_ALU_out and out_mem get inputted into mem_wb

--NOTE TODO: finish branch logic connections with pipelining



--#####################################     mem_wb     ##############################################
--NOTE TODO: connect the mem_wb pipeline 
	--fourth pipeline
	memxwb : mem_wb
	port map(mem_jump, wb_jump, CLK, wb_flush, wb_stall, memwb_reset, 
		 mem_instruction, wb_instruction, mem_pc_plus_four, wb_pc_plus_four, 
		 mem_reg_dest, mem_mem_to_reg, mem_reg_write, wb_reg_dest, wb_mem_to_reg, wb_reg_write, 
		 mem_ALU_out, wb_ALU_out, 
		 out_mem, wb_dmem_out, 
		 mem_write_reg_sel, wb_write_reg_sel);

	sw_mux : my_mux_eight_bit
	port map(wb_dmem_out, wb_ALU_out, wb_mem_to_reg, mux2);

--####################################     End CPU    ################################################
--NOTE TODO: may need to add extra output signals



	pc_address <= mem_out_jump_addr; 
	s_zero <= ex_branch and branch_comparator_zero; --store result in signal
	o_branch_zero <= s_zero;
	pc_plus_four <= s_pc_plus_four;
	write_reg_sel <= wb_write_reg_sel;
	reg_write <= wb_reg_write;
	s_sw_mux_out <= mux2;
	fwd_sw_mux_out <= s_sw_mux_out;
	dmem_out <= mux2;
	instruction_address <= o_addr;
	out_instruction <= instruction;
	s_fwd_mem_alu_out <= mem_ALU_out;
	fwd_mem_alu_out <= s_fwd_mem_alu_out;
	ex_mem_regWrite_out <= mem_reg_write;
	mem_wb_regWrite_out <= wb_reg_write;
	ex_mem_registerRd_out <= mem_write_reg_sel;
	mem_wb_registerRd_out <= wb_write_reg_sel;
	ex_mem_to_reg_out <= ex_mem_to_reg;
	ex_rt_sel_out <= ex_rt_sel;

end structure;

	

	


