--------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux_Datamem is
    Port ( Datatomem : in  STD_LOGIC_VECTOR (31 downto 0);
           AluResult : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : in  STD_LOGIC_VECTOR (31 downto 0);
           Rfsource : in  STD_LOGIC_VECTOR (1 downto 0);
           Datatoreg : out  STD_LOGIC_VECTOR (31 downto 0));
end Mux_Datamem;

architecture Behavioral of Mux_Datamem is

begin
process(DaTatomem, AluResult, PC, Rfsource)
begin
	case(Rfsource) is
		when "00" =>
			Datatoreg <= Datatomem;
		when "01" => 
			Datatoreg <= AluResult;
		when "10" =>
			Datatoreg <= PC;
		when others =>
			Datatoreg <= AluResult;
	 end case;
end process;


end Behavioral;

