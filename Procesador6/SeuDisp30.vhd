------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SeuDisp30 is
    Port ( Disp30 : in  STD_LOGIC_VECTOR (29 downto 0);
           SEUDisp30 : out  STD_LOGIC_VECTOR (31 downto 0));
end SeuDisp30;

architecture Behavioral of SeuDisp30 is

begin
process(Disp30)
begin
	SEUDisp30(29 downto 0) <= Disp30;
	if(Disp30(29) = '1') then
		SEUDisp30(31 downto 30) <= (others => '1');
	else
		SEUDisp30(31 downto 30) <= (others => '0');
	end if;
end process;


end Behavioral;

