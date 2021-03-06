
library IEEE;
use IEEE.std_logic_1164.all;

entity rd_mux is
  generic(N : integer := 4);
  port(i_A  : in std_logic_vector(N downto 0);
       i_B  : in std_logic_vector(N downto 0);
       i_S  : in std_logic;
       o_F  : out std_logic_vector(N downto 0));
	   
end rd_mux;

architecture structure of rd_mux is

component my_mux
  port(i_A             : in std_logic;
       i_B             : in std_logic;
       i_S             : in std_logic;
       o_F             : out std_logic);
end component;

begin


G1: for i in 0 to N generate
  mux_i: my_mux 
    port map(i_A  => i_A(i),
             i_B  => i_B(i),
             i_S  => i_S,
  	     o_F  => o_F(i));
end generate;
 
end structure;