
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterFile is
    Port ( Rs1 : in  STD_LOGIC_VECTOR (5 downto 0);
           Rs2 : in  STD_LOGIC_VECTOR (5 downto 0);
           Rd : in  STD_LOGIC_VECTOR (5 downto 0);
           rst : in  STD_LOGIC;
			  we: in STD_LOGIC;
           DataToWrite : in  STD_LOGIC_VECTOR (31 downto 0);
           Crs1 : out  STD_LOGIC_VECTOR (31 downto 0);
           Crs2 : out  STD_LOGIC_VECTOR (31 downto 0);
			  Crd : out STD_LOGIC_VECTOR (31 downto 0));
end RegisterFile;

architecture Behavioral of RegisterFile is

type ram_type is array (0 to 39) of std_logic_vector(31 downto 0);
signal RAM: ram_type := (others => x"00000000");

begin
		process(Rs1, Rs2, Rd, DataToWrite, rst)
			begin
				if(rst = '1') then
					RAM <= (others => x"00000000");
					Crs1 <= (others => '0');
					Crs2 <= (others => '0');
					Crd <=(others => '0');
				else
					Crs1 <= RAM(conv_integer(Rs1));
					Crs2 <= RAM(conv_integer(Rs2));
					Crd <= RAM(conv_integer(Rd));
					
					if (we = '1' and Rd /= "000000") then
						RAM(conv_integer(Rd)) <= DataToWrite;
					end if;
				end if;
		end process;
end Behavioral;

