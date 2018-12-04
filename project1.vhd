library IEEE;
use IEEE.std_logic_1164.all;

entity project1 is

	port(  
		i_Rst          : in std_logic;
		out_address   : out std_logic_vector(31 downto 0);
		out_instruction   :   out  std_logic_vector(31 downto 0);
		o_branch_zero   :  out  std_logic;
		pc_plus_four	: out std_logic_vector(31 downto 0);
		CLK            : in  std_logic);
end project1;


architecture structure of project1 is

component processor
port(CLK            : in  std_logic;
       rs_sel         : in  std_logic_vector(4 downto 0); -- first read address    
       rt_sel         : in  std_logic_vector(4 downto 0); -- second read address
       w_sel          : in  std_logic_vector(4 downto 0); -- write address
       w_en           : in  std_logic; -- write enable
       wren           : in  std_logic;
       reset          : in  std_logic; -- resets all registers to 0
	imm           : in  std_logic_vector(31 downto 0);   -- imm input
	shamt         : in  std_logic_vector(4 downto 0);    -- shift amount
	imm_sel       :  in std_logic;
	mem_sel       :  in std_logic;
	ALU_OP        :  in std_logic_vector(3 downto 0);			-- alu operation
	ALU_zero      :  out std_logic );

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
	extended_imm         : in std_logic_vector(31 downto 0);
        branch_zero : in std_logic;
	jump        :  in std_logic;
	address     : out std_logic_vector(31 downto 0);
	pc_plus_4   : out std_logic_vector(31 downto 0);
        CLK   :  in std_logic);
    

end component;

component if_id is
  port( CLK : in  std_logic;
  	id_flush, id_stall, ifid_reset : in std_logic;
       	if_instruction  : in std_logic_vector(31 downto 0);
       	id_instruction  : out std_logic_vector(31 downto 0);
       	if_pc_plus_4 : in std_logic_vector(31 downto 0);
       	id_pc_plus_4 : out std_logic_vector(31 downto 0));
 end component;


signal  instruction,extend_imm, o_addr, s_shift, id_instruction, s_pc_plus_four, id_pc_plus_four   :  std_logic_vector(31 downto 0);
signal write_register   :   std_logic_vector(4 downto 0);
signal out_reg_dest, out_jump, out_branch, out_mem_to_reg, out_mem_write, out_ALU_src, out_reg_write    : std_logic;
signal out_ALU_op    :   std_logic_vector(3 downto 0);
signal shift_amount  :   std_logic_vector(4 downto 0);
signal zero, flush, stall, reset, s_zero     :  std_logic;



begin

	shift_amount <= "00010";
	flush <= '0';
	stall <= '0';
	reset <= '0';

	c0 : imem
	port map(o_addr(9 downto 0),open,CLK,open,'0',instruction);
	ifxid : if_id -- first pipeline register
	port map(CLK, flush, stall, reset, instruction, id_instruction, s_pc_plus_four, id_pc_plus_four );


	c1 : main_control
	port map(id_instruction,out_reg_dest, out_jump, out_branch, out_mem_to_reg,out_ALU_op, out_mem_write, out_ALU_src, out_reg_write);
	c2 : rd_mux
	port map(id_instruction(20 downto 16), id_instruction(15 downto 11), out_reg_dest, write_register);	
	c3 : Signed_extend
	port map(id_instruction(15 downto 0), extend_imm);

	c4 : processor
	port map(CLK, id_instruction(25 downto 21), id_instruction(20 downto 16), write_register, out_reg_write, out_mem_write, '0', extend_imm, "00000", out_ALU_src, out_mem_to_reg, out_ALU_op,zero);

	c5 : barrel_shift
	port map(extend_imm, shift_amount, s_shift);
	c6 : instruction_fetch
	port map(i_Rst, id_instruction, extend_imm, s_zero, out_jump, o_addr, s_pc_plus_four, CLK);

	out_address <= o_addr;
	out_instruction <= instruction;
	s_zero <= out_branch and zero; --store result in signal
	o_branch_zero <= s_zero;
	pc_plus_four <= s_pc_plus_four;
	

end structure;
