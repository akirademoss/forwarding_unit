library IEEE;
use IEEE.std_logic_1164.all;

entity done is

	port(  
		i_Rst          : in std_logic;
		CLK            : in  std_logic);
end done;


architecture sturcture of done is
component instruction_fetch is
port (

	reset      :  in std_logic;
	instruction : in std_logic_vector(31 downto 0);
	extended_imm         : in std_logic_vector(31 downto 0);
        branch_zero : in std_logic;
	jump        :  in std_logic;
	address     : out std_logic_vector(31 downto 0);
        CLK   :  in std_logic);
    

end component;


component project1 is

	port(  temp_address   : in std_logic_vector(31 downto 0);
		o_F         :   out  std_logic_vector(31 downto 0);
		out_instruction   :   out  std_logic_vector(31 downto 0);
		o_jump     :  out std_logic;
		o_branch_zero   :  out  std_logic;
		CLK            : in  std_logic);
end component;

signal  t_address , t_F, t_instruction  :  std_logic_vector(31 downto 0); 
signal t_jump, t_branch_zero : std_logic;

begin

 c0 : project1
	port map(t_address, t_F, t_instruction, t_jump, t_branch_zero, CLK);


c1 : instruction_fetch
	port map(i_Rst, t_instruction, t_F, t_branch_zero, t_jump, t_address, CLK);


end sturcture;