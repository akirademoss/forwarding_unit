library IEEE;
use IEEE.std_logic_1164.all;
use work.all;

entity instruction_fetch is
port (
	reset      :  in std_logic;
	instruction : in std_logic_vector(31 downto 0);
	branch_jump_addr : in std_logic_vector(31 downto 0);
        CLK   :  in std_logic;
	jump_addr   : out std_logic_vector(31 downto 0);
	address     : out std_logic_vector(31 downto 0);
	pc_plus_4   : out std_logic_vector(31 downto 0));
    

end instruction_fetch;


architecture structure of instruction_fetch is
component full_adder_eight_bit is
generic(N : integer := 32);
  port (	i_A : in std_logic_vector(N-1 downto 0);
		i_B : in std_logic_vector(N-1 downto 0);
		i_Carry_in : in std_logic;
		o_Sum : out std_logic_vector(N-1 downto 0);
		o_Carry_out : out std_logic);	
end component;


component my_mux_eight_bit is
  generic(N : integer := 32);
  port(i_A  : in std_logic_vector(N-1 downto 0);
       i_B  : in std_logic_vector(N-1 downto 0);
       i_S  : in std_logic;
       o_F  : out std_logic_vector(N-1 downto 0));
	   
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



signal   temp, temp1, pc, four ,pc_plus_four, mux1  :   std_logic_vector(31 downto 0);




begin


	--actual instruction fetch pc register
	four <= x"00000004";
	c0  :  register_Nbit
	port map(CLK, reset, '1',branch_jump_addr, pc );

	--actual instruction fetch adder
	c1  :  full_adder_eight_bit
	port map(pc,four, '0', pc_plus_four, open);

	--jump logic
	c2 : fetch
	port map(instruction(25 downto 0), pc_plus_four(31 downto 28), jump_addr);

	--branch logic calculation
	--c3 : full_adder_eight_bit
	--port map(pc_plus_four, extended_imm, '0', temp1, open);
	
	--branch logic (decide between regular or branched address)
	--c4 : my_mux_eight_bit
	--port map(pc_plus_four, temp1, branch_zero, mux1);

	--jump logic (decide between jump address or regular or branch address)
	--c5 : my_mux_eight_bit
	--port map(mux1, jump_addr, jump, temp);

	address <= pc;
	pc_plus_4 <= pc_plus_four;


end structure;
	
	


