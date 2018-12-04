library IEEE;
use IEEE.std_logic_1164.all;

entity barrel_shift is
   generic(N : integer := 32);
   port(i_A  : in std_logic_vector (N-1 downto 0);
	i_S  : in std_logic_vector (4 downto 0);
	o_F  : out std_logic_vector (N-1 downto 0));

end barrel_shift;


architecture structure of barrel_shift is
component my_mux
port(i_A   : in std_logic;
	     i_B   : in std_logic;
	     i_S   : in std_logic;
	     o_F   : out std_logic);
end component;


signal     first_col, second_col, third_col, fourth_col, fifth_col     :   std_logic_vector(31 downto 0);




begin


mux_first  :   my_mux
	port map(i_A => i_A(0) ,
		 i_B => '0' ,
		 i_S => i_S(0),
		 o_F    =>  first_col(0));




G1:  for i in 1 to N-1 generate
	mux_first_layer  :  my_mux
	port map(i_A => i_A(i),
		 i_B => i_A(i-1),
		 i_S => i_S(0),      
		 o_F =>    first_col(i));
end generate;



mux_second_0  :  my_mux
	port map(i_A => first_col(0),    
		 i_B => '0',
		 i_S =>  i_S(1),
		 o_F => second_col(0));


mux_second_1  :  my_mux
	port map(i_A => first_col(1),    
		 i_B => '0',
		 i_S => i_S(1),
		 o_F => second_col(1));


G2:  for i in 2 to N-1 generate
	

	mux_second_layer   :  my_mux
	port map(i_A =>  first_col(i),  
		 i_B =>  first_col(i-2),
		 i_S =>  i_S(1),
		 o_F => second_col(i));
end generate;







G3:  for i in 0 to 3 generate

	mux_second_third   :  my_mux
	port map(i_A => second_col(i),
		 i_B => '0',
	         i_S => i_S(2),
		 o_F => third_col(i));
end generate;

G4:  for i in 4 to N-1 generate

	mux_third_layer   :  my_mux
	port map(i_A =>  second_col(i),  
		 i_B =>  second_col(i-4),
		 i_S =>  i_S(2),
		 o_F => third_col(i));
end generate;

G5:  for i in 0 to 7 generate
mux_fourth_layer   :  my_mux
	port map(i_A =>  third_col(i),    
		 i_B =>  '0',
		 i_S =>  i_S(3),
		 o_F =>  fourth_col(i));
end generate;


G6   :  for i in 8 to N-1 generate
mux_fourth    :  my_mux
	port map(i_A  =>  third_col(i),
		 i_B  =>  third_col(i-8),
	 	 i_S  =>  i_S(3),
		 o_F  =>  fourth_col(i));
end generate;

G7 : for i in 0 to 15 generate
mux_fifth_layer   :  my_mux
	port map(i_A =>   fourth_col(i),    
		 i_B =>   '0',
		 i_S =>   i_S(4),
		 o_F =>    o_F(i));
end generate;

G8   : for i in 16 to N-1 generate
mux_fifth  :   my_mux
	port map(i_A =>   fourth_col(i),    
		 i_B =>   fourth_col(i-16),
		 i_S =>   i_S(4),
		 o_F =>    o_F(i));



end generate;
end structure;
	

	