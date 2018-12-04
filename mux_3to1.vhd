library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux_3to1 is

generic (N : integer := 32);
port (i_A        :     in   std_logic_vector(N-1 downto 0);
      i_B        :     in   std_logic_vector(N-1 downto 0);
      i_C        :     in   std_logic_vector(N-1 downto 0);
      i_D        :     in   std_logic_vector(N-1 downto 0);
      i_S        :     in   std_logic_vector(1 downto 0);
      o_F        :     out  std_logic_vector(N-1 downto 0));

end mux_3to1;


architecture mixed of mux_3to1 is 

begin

with i_S select
		o_F <= 	i_A when "00",
			i_B when "01",
			i_C when "10",
			i_D when others;
			


end mixed;