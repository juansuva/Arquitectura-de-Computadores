-----------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux_RF is
    Port ( Rd : in  STD_LOGIC_VECTOR (5 downto 0);
           RO7 : in  STD_LOGIC_VECTOR (5 downto 0);
           Rfdest : in  STD_LOGIC;
           nrd : out  STD_LOGIC_VECTOR (5 downto 0));
end Mux_RF;

architecture Behavioral of Mux_RF is

begin
process(Rd, RO7, Rfdest)
	begin
		if(Rfdest = '0') then
			nrd <= Rd;
		else
			nrd <= RO7;
		end if;
end process;

end Behavioral;

