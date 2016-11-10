library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity DataMemory is
    Port ( crd : in  STD_LOGIC_VECTOR (31 downto 0);
           Address : in  STD_LOGIC_VECTOR (31 downto 0);
           Wrenmem : in  STD_LOGIC;
           Rdenmem : in  STD_LOGIC;
           Datatomem : out  STD_LOGIC_VECTOR (31 downto 0));
end DataMemory;

architecture Behavioral of DataMemory is

type ram_type is array (0 to 63) of std_logic_vector(31 downto 0);
signal RAM : ram_type := (others => x"00000000");

begin
process(crd, Address, Wrenmem, Rdenmem)
begin
	if(Rdenmem = '1') then
		if(Wrenmem = '0') then
			Datatomem <= RAM(conv_integer(Address(5 downto 0)));
		else
			RAM(conv_integer(Address(5 downto 0))) <= crd;
		end if;
	end if;
end process;
end Behavioral;

