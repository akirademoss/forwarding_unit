library IEEE;
use IEEE.std_logic_1164.all;


entity my_mux is



port(i_A : in std_logic;
     i_B : in std_logic;
     i_S : in std_logic;
     o_F : out std_logic );

end my_mux;


architecture dataflow of my_mux is

begin

	o_F <= ((not i_S) and i_A ) or (i_S and i_B);

end dataflow;
