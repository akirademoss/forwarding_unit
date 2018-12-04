
library IEEE;
use IEEE.std_logic_1164.all;

entity full_adder_eight_bit is
  generic(N : integer := 32);
  port (	i_A : in std_logic_vector(N-1 downto 0);
		i_B : in std_logic_vector(N-1 downto 0);
		i_Carry_in : in std_logic;
		o_Sum : out std_logic_vector(N-1 downto 0);
		o_Carry_out : out std_logic);	
	   
end full_adder_eight_bit;

architecture structure of full_adder_eight_bit is

component full_adder
  port (	i_A : in std_logic;
		i_B : in std_logic;
		i_Carry_in : in std_logic;
		o_Sum : out std_logic;
		o_Carry_out : out std_logic);
end component;


signal temp_c  : std_logic_vector(N downto 0);
begin

temp_c(0) <= i_Carry_in;

-- We loop through and instantiate and connect N inv modules
G1: for i in 0 to N-1 generate
  full_adder_i : full_adder
    port map(i_A  => i_A(i),
             i_B  => i_B(i),
             i_Carry_in => temp_c(i),
  	         o_Sum  => o_Sum(i),
		 o_Carry_out => temp_c(i+1));
end generate;
 
end structure;