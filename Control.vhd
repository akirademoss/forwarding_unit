library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity control is
  port (opcode     	: in std_logic_vector(5 downto 0);
		funct		: in std_logic_vector(5 downto 0);
		RegWrite   	: out std_logic;
		RegDst     	: out std_logic;
		ALUSrc		: out std_logic;
		SignExt		: out std_logic;
		MemWrite   	: out std_logic;
		MemRead    	: out std_logic;
		MemReg   	: out std_logic;
       		ALUOp	   	: out std_logic_vector(3 downto 0);
		VShift		: out std_logic;
		lui 		: out std_logic;
		Branch     	: out std_logic;
		Jump		: out std_logic);
end control;

architecture mix of control is
	
begin
    process(opcode, funct)
    begin
    case opcode is
			when "000000" => 
			    --add
				if (funct = "100000") then 
					RegWrite   	<= '1';
					RegDst     	<= '1';
					ALUSrc		<= '0';
					ALUOp	    <= "0110";
					SignExt		<= '-';					
					MemWrite   	<= '0';
					MemRead		<= '0';
					MemReg    	<= '0';
					VShift		<= '-';
					lui			<= '-';
					Branch      <= '0';
					Jump		<= '0';

					
				--addu
				elsif (funct = "100001") then
					RegWrite   	<= '1';
					RegDst     	<= '1';
					ALUSrc		<= '0';
					ALUOp	    <= "0101";
					SignExt		<= '-';						
					MemWrite   	<= '0';
					MemRead		<= '0';
					MemReg    	<= '0';
					VShift		<= '-';
					lui			<= '-';
					Branch      <= '0';
					Jump		<= '0';
				
				--and
				elsif (funct = "100100") then
					RegWrite   	<= '1';
					RegDst     	<= '1';
					ALUSrc		<= '0';
					ALUOp    	<= "0000";
					SignExt		<= '-';						
					MemWrite   	<= '0';
					MemRead		<= '0';
					MemReg    	<= '0';
					VShift		<= '-';
					lui			<= '-';
					Branch     	<= '0';
					Jump		<= '0';				
				
				--nor
				elsif (funct = "100111") then 
					RegWrite   	<= '1';
					RegDst     	<= '1';
					ALUSrc		<= '0';
					ALUOp	   	<= "0011";
					SignExt		<= '-';						
					MemWrite   	<= '0';
					MemRead		<= '0';
					MemReg    	<= '0';
					VShift		<= '-';
					lui			<= '-';
					Branch     	<= '0';
					Jump		<= '0';	
				
				--xor
				elsif (funct = "100110") then 
					RegWrite   	<= '1';
					RegDst     	<= '1';
					ALUSrc		<= '0';
					ALUOp	   	<= "0010";	
					SignExt		<= '-';					
					MemWrite   	<= '0';
					MemRead		<= '0';
					MemReg    	<= '0';
				    VShift		<= '-';
					lui			<= '-';
					Branch     	<= '0';
					Jump		<= '0';
				
				--or
				elsif (funct = "100101") then
					RegWrite   	<= '1';
					RegDst     	<= '1';
					ALUSrc		<= '0';
					ALUOp	    <= "0001";	
					SignExt		<= '-';					
					MemWrite   	<= '0';
					MemRead		<= '0';
					MemReg    	<= '0';
					VShift		<= '-';
					lui			<= '-';
					Branch      <= '0';
					Jump		<= '0';					
				
				--slt
				elsif (funct = "101010") then 
					RegWrite   	<= '1';
					RegDst     	<= '1';
					ALUSrc		<= '0';
					ALUOp	    <= "1110";	
					SignExt		<= '-';					
					MemWrite   	<= '0';
					MemRead		<= '0';
					MemReg    	<= '0';
					VShift		<= '-';
					lui			<= '-';
					Branch      <= '0';
					Jump		<= '0';
				
				--sltu
				elsif (funct = "101011") then 
					RegWrite   	<= '1';
					RegDst     	<= '1';
					ALUSrc		<= '0';
					ALUOp	   	<= "1101";
					SignExt		<= '-';						
					MemWrite   	<= '0';
					MemRead		<= '0';
					MemReg    	<= '0';
					VShift		<= '-';
					lui			<= '-';
					Branch     	<= '0';
					Jump		<= '0';	
				
				--sll
				elsif (funct = "101011") then
					RegWrite   	<= '1';
					RegDst     	<= '1';
					ALUSrc		<= '0';
					ALUOp	    <= "1000";	
					SignExt		<= '-';					
					MemWrite   	<= '0';
					MemRead		<= '0';
					MemReg    	<= '0';
					VShift		<= '0';
					lui			<= '0';
					Branch      <= '0';
					Jump		<= '0';					
				
				--sll
				elsif (funct = "000000") then
					RegWrite   	<= '1';
					RegDst     	<= '1';
					ALUSrc		<= '0';
					ALUOp	    <= "1001";	
					SignExt		<= '-';					
					MemWrite   	<= '0';
					MemRead		<= '0';
					MemReg    	<= '0';
					VShift		<= '0';
					lui			<= '0';
					Branch      <= '0';
					Jump		<= '0';					
				
				--srl
				elsif (funct = "000010") then 
					RegWrite   	<= '1';
					RegDst     	<= '1';
					ALUSrc		<= '0';
					ALUOp	    <= "1011";	
					SignExt		<= '-';					
					MemWrite   	<= '0';
					MemRead		<= '0';
					MemReg    	<= '0';
					VShift		<= '0';
					lui			<= '0';
					Branch      <= '0';
					Jump		<= '0';	
				
				--sra
				elsif (funct = "000011") then 
					RegWrite   	<= '1';
					RegDst     	<= '1';
					ALUSrc		<= '0';
					ALUOp	    <= "0000";	
					SignExt		<= '-';					
					MemWrite   	<= '0';
					MemRead		<= '0';
					MemReg    	<= '0';
					VShift		<= '0';
					lui			<= '0';
					Branch      <= '0';
					Jump		<= '0';	
				
				--sllv
				elsif (funct = "000100") then
					RegWrite   	<= '1';
					RegDst     	<= '1';
					ALUSrc		<= '0';
					ALUOp	    <= "1000";	
					SignExt		<= '-';					
					MemWrite   	<= '0';
					MemRead		<= '0';
					MemReg    	<= '0';
					VShift		<= '1';
					lui			<= '0';
					Branch      <= '0';
					Jump		<= '0';					
				
				--srlv
				elsif (funct = "000110") then
					RegWrite   	<= '1';
					RegDst     	<= '1';
					ALUSrc		<= '0';
					ALUOp	    <= "1001";
					SignExt		<= '-';						
					MemWrite   	<= '0';
					MemRead		<= '0';
					MemReg    	<= '0';
					VShift		<= '1';
					lui			<= '0';
					Branch     	<= '0';
					Jump		<= '0';					
				
				--srav
				elsif (funct = "000111") then
					RegWrite   	<= '1';
					RegDst     	<= '1';
					ALUSrc		<= '0';
					ALUOp	    <= "1011";	
					SignExt		<= '-';					
					MemWrite   	<= '0';
					MemRead		<= '0';
					MemReg    	<= '0';
					VShift		<= '1';
					lui			<= '0';
					Branch      <= '0';
					Jump		<= '0';					
				
				--sub
				elsif (funct = "100010") then
					RegWrite   	<= '1';
					RegDst     	<= '1';
					ALUSrc		<= '0';
					ALUOp	    <= "1110";	
					SignExt		<= '-';					
					MemWrite   	<= '0';
					MemRead		<= '0';
					MemReg    	<= '0';
					VShift		<= '-';
					lui			<= '-';
					Branch      <= '0';
					Jump		<= '0';					
					
				--subu
				elsif (funct = "100110") then
					RegWrite   	<= '1';
					RegDst     	<= '1';
					ALUSrc		<= '0';
					ALUOp	    <= "1101";	
					SignExt		<= '-';					
					MemWrite   	<= '0';
					MemRead		<= '0';
					MemReg    	<= '0';
					VShift		<= '-';
					lui			<= '-';
					Branch      <= '0';
					Jump		<= '0';				
				
				--jr
				elsif (funct = "001000") then
					RegWrite   	<= '1';
					RegDst     	<= '-';
					ALUSrc		<= '-';				
					MemWrite   	<= '0';
					MemRead		<= '0';
					MemReg    	<= '0';
					VShift		<= '-';
					lui			<= '-';
					Branch      <= '-';
					Jump		<= '1';
				end if;
														
			--addi
			when "001000" => 
				RegWrite   	<= '1';
				RegDst     	<= '0';
				ALUSrc		<= '1';
				ALUOp	    <= "0110";	
				SignExt		<= '1';					
				MemWrite   	<= '0';
				MemRead		<= '0';
				MemReg    	<= '0';
				VShift		<= '-';
				lui			<= '-';
				Branch      <= '0';
				Jump		<= '0';
					
			--addiu
			when "001001" => 
				RegWrite   	<= '1';
				RegDst     	<= '0';
				ALUSrc		<= '1';
				ALUOp    	<= "0101";
				SignExt		<= '1';						
				MemWrite   	<= '0';
				MemRead		<= '0';
				MemReg    	<= '0';
				VShift		<= '-';
				lui			<= '-';
				Branch     	<= '0';
				Jump		<= '0';
			
			--andi
			when "001100" =>
				RegWrite   	<= '1';
				RegDst     	<= '0';
				ALUSrc		<= '1';
				ALUOp	    <= "0000";
				SignExt		<= '0';					
				MemWrite   	<= '0';
				MemRead		<= '0';
				MemReg    	<= '0';
				VShift		<= '-';
				lui			<= '-';
				Branch      <= '0';
				Jump		<= '0';
			
			--lui
			when "001111" => 
				RegWrite   	<= '1';
				RegDst     	<= '0';
				ALUSrc		<= '1';
				ALUOp	    <= "1000";	
				SignExt		<= '-';						
				MemWrite   	<= '0';
				MemRead		<= '0';
				MemReg    	<= '0';
				VShift		<= '-';
				lui			<= '1';
				Branch      <= '0';
				Jump		<= '0';

			--lw
			when "100011" => 
				RegWrite   	<= '1';
				RegDst     	<= '0';
				ALUSrc		<= '1';
				ALUOp	    <= "0110";
				SignExt		<= '1';					
				MemWrite   	<= '0';
				MemRead		<= '1';
				MemReg    	<= '1';
				VShift		<= '-';
				lui			<= '-';
				Branch      <= '0';
				Jump		<= '0';

			--xori
			when "001110" => 
				RegWrite   	<= '1';
				RegDst     	<= '0';
				ALUSrc		<= '1';
				ALUOp	    <= "0010";	
				SignExt		<= '0';						
				MemWrite   	<= '0';
				MemRead		<= '0';
				MemReg    	<= '0';
				VShift		<= '-';
				lui			<= '-';
				Branch      <= '0';
				Jump		<= '0';

			--ori
			when "001101" =>
				RegWrite   	<= '1';
				RegDst     	<= '0';
				ALUSrc		<= '1';
				ALUOp	   	<= "0001";	
				SignExt		<= '0';						
				MemWrite   	<= '0';
				MemRead		<= '0';
				MemReg    	<= '0';
				VShift		<= '-';
				lui			<= '-';
				Branch      <= '0';
				Jump		<= '0';

			--slti
			when "001010" => 
				RegWrite   	<= '1';
				RegDst     	<= '0';
				ALUSrc		<= '1';
				ALUOp	    <= "1110";	
				SignExt		<= '1';				
				MemWrite   	<= '0';
				MemRead		<= '0';
				MemReg    	<= '0';
				VShift		<= '-';
				lui			<= '-';
				Branch      <= '0';
				Jump		<= '0';

			--sltiu
			when "001011" => 
				RegWrite   	<= '1';
				RegDst     	<= '0';
				ALUSrc		<= '1';
				ALUOp	    <= "1101";	
				SignExt		<= '1';				
				MemWrite   	<= '0';
				MemRead		<= '0';
				MemReg    	<= '0';
				VShift		<= '-';
				lui			<= '-';
				Branch      <= '0';
				Jump		<= '0';

			--sw
			when "101011" => 
				RegWrite   	<= '0';
				RegDst     	<= '-';
				ALUSrc		<= '1';
				ALUOp	    <= "0110";
				SignExt		<= '1';					
				MemWrite   	<= '1';
				MemRead		<= '0';
				MemReg    	<= '0';
				VShift		<= '-';
				lui			<= '-';
				Branch      <= '0';
				Jump		<= '0';	
				
			--beq
			when "000100" => 
				RegWrite   	<= '1';
				RegDst     	<= '-';
				ALUSrc		<= '0';				
				MemWrite   	<= '0';
				MemRead		<= '0';
				MemReg    	<= '0';
				VShift		<= '-';
				lui			<= '-';
				Branch      <= '1';
				Jump		<= '0';
			
			--bne
			when "000101" => 
				RegWrite   	<= '1';
				RegDst     	<= '-';
				ALUSrc		<= '0';				
				MemWrite   	<= '0';
				MemRead		<= '0';
				MemReg    	<= '0';
				VShift		<= '-';
				lui			<= '-';
				Branch      <= '1';
				Jump		<= '0';	

			--j
			when "000010" => 
				RegWrite   	<= '1';
				RegDst     	<= '-';
				ALUSrc		<= '0';				
				MemWrite   	<= '0';
				MemRead		<= '0';
				MemReg    	<= '0';
				VShift		<= '-';
				lui			<= '-';
				Branch      <= '-';
				Jump		<= '1';	
					
			--jal
			when "000011" => 
				RegWrite   	<= '1';
				RegDst     	<= '1';
				ALUSrc		<= '0';			
				MemWrite   	<= '0';
				MemRead		<= '0';
				MemReg    	<= '0';
				VShift		<= '-';
				lui			<= '-';
				Branch      <= '-';
				Jump		<= '1';			
					
           		when others => null;

        end case;
    end process;
end mix;