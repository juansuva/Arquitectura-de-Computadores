-----------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CU is
    Port ( Op : in  STD_LOGIC_VECTOR (1 downto 0);
			  Op2: in STD_LOGIC_VECTOR (2 downto 0);
           Op3 : in  STD_LOGIC_VECTOR(5 downto 0);
			  icc : in STD_LOGIC_VECTOR(3 downto 0);
			  cond : in STD_LOGIC_VECTOR(3 downto 0);
			  Rfdest: out STD_LOGIC;
			  Rfsource: out STD_LOGIC_VECTOR(1 downto 0);
			  we: out STD_LOGIC;
			  Wrenmem: out STD_LOGIC;
			  Rdenmem: out STD_LOGIC;
			  pcSource: out STD_LOGIC_VECTOR (1 downto 0);
           AluOp : out  STD_LOGIC_VECTOR(5 downto 0));

end CU;

architecture Behavioral of CU is

begin
process(Op, Op2, Op3, icc, cond)
	begin
	Wrenmem <= '0';
	Rdenmem <= '1';
	RfDest <= '0';
	
	if(op = "01") then --CALL
		Rfdest <= '1';
		Rfsource <= "10";
		we <= '1';
		AluOp <= "111111";
		pcSource <= "00";
	else
		if(Op = "00") then
			if(Op2 = "010") then
				case cond is
					when "1000" => -- BA
						Rfsource <= "01";
						we <= '0';
						pcSource <= "01";
						AluOp <= "111111";
					when "1001" => --BNE
						if(not(icc(2)) = '1') then -- not Z
							Rfsource <= "01";
							we <= '0';
							pcSource <= "01";
							AluOp <= "111111";
						else
							Rfsource <= "01";
							we <= '0';
							pcSource <= "10";
							AluOp <= "111111";
						end if;
					when "0001" => -- BE
						if(icc(2) = '1') then -- Z
							Rfsource <= "01";
							we <= '0';
							pcSource <= "01";
							AluOp <= "111111";
						else
							Rfsource <= "01";
							we <= '0';
							pcSource <= "10";
							AluOp <= "111111";
						end if;
					when "1010" => --BG
						if((not (icc(2) or (icc(3) xor icc(1)))) = '1') then -- not(Z or (N xor V))
							Rfsource <= "01";
							we <= '0';
							pcSource <= "01";
							AluOp <= "111111";
						else
							Rfsource <= "01";
							we <= '0';
							pcSource <= "10";
							AluOp <= "111111";
						end if;
					when "0010" => --BLE
						if((icc(2) or (icc(3) xor icc(1))) = '1') then -- Z or (N xor V)
							Rfsource <= "01";
							we <= '0';
							pcSource <= "01";
							AluOp <= "111111";
						else
							Rfsource <= "01";
							we <= '0';
							pcSource <= "10";
							AluOp <= "111111";
						end if;
					when "1011" => --BGE
						if((not(icc(3) xor icc(1))) = '1') then -- not(N xor V)
							Rfsource <= "01";
							we <= '0';
							pcSource <= "01";
							AluOp <= "111111";
						else
							Rfsource <= "01";
							we <= '0';
							pcSource <= "10";
							AluOp <= "111111";
						end if;
					when "0011" => --BL
						if((icc(3) xor icc(1)) = '1') then -- (N xor V)
							Rfsource <= "01";
							we <= '0';
							pcSource <= "01";
							AluOp <= "111111";
						else
							Rfsource <= "01";
							we <= '0';
							pcSource <= "10";
							AluOp <= "111111";
						end if;
					when others =>
						Rfsource <= "01";
						we <= '0';
						pcSource <= "10";
						AluOp <= "111111";
			end case;
		else
			if(Op2 = "100") then -- NOP
				Rfsource <= "01";
				we <= '0';
				pcSource <= "10";
				AluOp <= "111111";
			end if;
		end if;
		
	if(Op = "10") then
		case (Op3) is 
			when "000000" => --Add
				AluOp <= "000000";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "000100" => --Sub
				AluOp <= "000100";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "000001" => --And
				AluOp <= "000001";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "000101" => --AndN
				AluOp <= "000101";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "000010" => --Or
				AluOp <= "000010";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "000110" => --OrN
				AluOp <= "000110";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "000011" => --Xor
				AluOp <= "000011";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "000111" => --Xnor
				AluOp <= "000111";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "010100" => --SUBcc
				AluOp <= "010100";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "001100" => --SUBx
				AluOp <= "001100";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "011100" => --SUBxcc
				AluOp <= "011100";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "010001" => --ANDcc
				AluOp <= "001011";
			when "010101" => --ANDNcc
				AluOp <= "010101";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "010010" => --ORcc
				AluOp <= "010010";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "010110" => --ORNcc
				AluOp <= "010110";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "010011" => --XORcc
				AluOp <= "010011";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "010111" => --XNORcc
				AluOp <= "010111";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "001000" => --ADDx
				AluOp <= "001000";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "011000" => --ADDxcc
				AluOp <= "011000";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "010000" => --ADDcc
				AluOp <= "010000";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "111100" => --Save
				AluOp <= "000000";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "111101" => --Restore
				AluOp <= "000000";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when "111000" => --JMPL
				AluOp <= "000000";
				Rfsource <= "01";
				we <= '1';
				pcSource <= "10";
			when others =>
				AluOp <= "111111";
				Rfsource <= "01";
				we <= '0';
				pcSource <= "10";
		end case;
	else
		if(op = "11") then
			case op3 is
				when "000100" => --STORE
					AluOp <= "000000";
					Rfsource <= "01";
					Wrenmem <= '1';
					we <= '0';
					pcSource <= "10";
				when "000000" => -- LOAD
					AluOp <= "111111";
					Rfsource <= "01";
					we <= '0';
					pcSource <= "10";
				when others =>
					AluOp <= "111111";
					Rfsource <= "01";
					we <= '0';
					pcSource <= "10";					
			end case;					
		end if;
	end if;
end if;
end if;
end process;


end Behavioral;

