library IEEE;
use IEEE.std_logic_1164.all;
use work.all;

entity fetch is
port (i_A   :  in std_logic_vector(25 downto 0);
      i_B   :  in std_logic_vector(3 downto 0);
      o_F   :  out std_logic_vector(31 downto 0));   --jump address

end fetch;


architecture dataflow of fetch is


begin
	o_F <= i_B & i_A  & "00";


end dataflow;
