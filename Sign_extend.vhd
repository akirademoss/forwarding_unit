
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Signed_extend is
	
	port(in_A     :  in    std_logic_vector(15 downto 0);
	     out_F    :  out   std_logic_vector(31 downto 0));

end Signed_extend;

architecture mixed of Signed_extend is 

begin

with in_A(15) select
	out_F <= 	(x"ffff" & in_A) when '1',
					(x"0000" & in_A) when others;

end mixed;
