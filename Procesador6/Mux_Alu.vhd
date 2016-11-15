-------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux_Alu is
    Port ( Crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           i : in  STD_LOGIC;
           signext : in  STD_LOGIC_VECTOR (31 downto 0);
           Op2 : out  STD_LOGIC_VECTOR (31 downto 0));
end Mux_Alu;

architecture Behavioral of Mux_Alu is

begin
process(Crs2, i, signext)
begin
	if(i = '0') then
		Op2 <= Crs2;
	else
		Op2 <= signext;
	end if;
end process;


end Behavioral;

