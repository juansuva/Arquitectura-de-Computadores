-----------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity CU is
    Port ( Op : in  STD_LOGIC_VECTOR (1 downto 0);
           Op3 : in  STD_LOGIC_VECTOR(5 downto 0);
           AluOp : out  STD_LOGIC_VECTOR(5 downto 0));
end CU;

architecture Behavioral of CU is

begin
process(Op, Op3)
	begin
	if(Op = "10") then
		case (Op3) is 
			when "000000" => --Add
				AluOp <= "000000";
			when "000100" => --Sub
				AluOp <= "000001";
			when "000001" => --And
				AluOp <= "000010";
			when "000101" => --AndN
				AluOp <= "000011";
			when "000010" => --Or
				AluOp <= "000100";
			when "000110" => --OrN
				AluOp <= "000101";
			when "000011" => --Xor
				AluOp <= "000110";
			when "000111" => --Xnor
				AluOp <= "000111";
			when others =>
				AluOp <= "111111";
		end case;
	end if;
end process;


end Behavioral;

