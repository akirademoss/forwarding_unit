library IEEE;
use IEEE.std_logic_1164.all;

entity projB is

	port(  
		i_Rst          : in std_logic;
		CLK            : in  std_logic);
end projB;


architecture sturcture of projB is
component done is
port (
	i_Rst          : in std_logic;
	CLK            : in  std_logic);
end component;

begin

 c0 : done
	port map(i_Rst, CLK);

end sturcture;