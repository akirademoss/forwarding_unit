library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity forwarding_unit is
    Port ( 
				
				ex_mem_regWrite : 		in  STD_LOGIC;
				ex_mem_registerRd : 		in  STD_LOGIC_VECTOR(4 downto 0);
				
				mem_wb_regWrite : 		in  STD_LOGIC;
				mem_wb_registerRd : 		in  STD_LOGIC_VECTOR(4 downto 0);
				
				id_ex_registerRs : 		in  STD_LOGIC_VECTOR(4 downto 0);
				id_ex_registerRt : 		in  STD_LOGIC_VECTOR(4 downto 0);
				
				fordward_a : out STD_LOGIC_VECTOR(1 downto 0);
				fordward_b : out STD_LOGIC_VECTOR(1 downto 0)
				
			  );
end forwarding_unit;

architecture Behavioral of Forwarding_unit is

begin

	process(ex_mem_regWrite, ex_mem_registerRd, mem_wb_regWrite, 
			  mem_wb_registerRd, id_ex_registerRs, id_ex_registerRt ) is
	begin
		
		-- first alu register
		if ((ex_mem_regWrite = '1') -- EX HAZARD
			and (ex_mem_registerRd /="00000") 
			and (ex_mem_registerRd = id_ex_registerRs)) then
				fordward_a <= b"10"; 
				
		elsif ((mem_wb_regWrite = '1') -- MEM HAZARD
			and (mem_wb_registerRd /="00000") 
			and not(ex_mem_regWrite = '1' and (ex_mem_registerRd /= "00000")
				and (ex_mem_registerRd = id_ex_registerRs))
			and (mem_wb_registerRd = id_ex_registerRs)) then
				fordward_a <= b"01"; 
		else 
			fordward_a <= b"00";
		end if;
		
		-- second alu register
		if ((ex_mem_regWrite = '1') -- MEM HAZARD
			and (ex_mem_registerRd /="00000") 
			and (ex_mem_registerRd = id_ex_registerRt)) then
				fordward_b <= b"10"; 
				
		elsif ((mem_wb_regWrite = '1') -- MEM HAZARD
			and (mem_wb_registerRd /="00000") 
				and not(ex_mem_regWrite = '1' and (ex_mem_registerRd /= "00000")
				and (ex_mem_registerRd = id_ex_registerRt))
			and (mem_wb_registerRd = id_ex_registerRt)) then
				fordward_b <= b"01"; 
		
		else 
			fordward_b <= b"00";
		end if;
		
	
	end process;

end Behavioral;