---------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SeuDisp22 is
    Port ( disp22 : in  STD_LOGIC_VECTOR (21 downto 0);
           SEUdisp22 : out  STD_LOGIC_VECTOR (31 downto 0));
end SeuDisp22;

architecture Behavioral of SeuDisp22 is

begin
process(disp22)
begin
SEUdisp22(21 downto 0) <= disp22;
	if(disp22(21) = '1') then
		SEUdisp22(31 downto 22) <= (others => '1');
	else
		SEUdisp22(31 downto 22) <= (others => '0');
	end if;
end process;

end Behavioral;

