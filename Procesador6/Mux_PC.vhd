---------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Mux_PC is
    Port ( Pcsource : in  STD_LOGIC_VECTOR (1 downto 0);
           Disp30 : in  STD_LOGIC_VECTOR (31 downto 0);
           Disp22 : in  STD_LOGIC_VECTOR (31 downto 0);
           PC : in  STD_LOGIC_VECTOR (31 downto 0);
           AluOut : in  STD_LOGIC_VECTOR (31 downto 0);
           Salida : out  STD_LOGIC_VECTOR (31 downto 0));
end Mux_PC;

architecture Behavioral of Mux_PC is

begin
process(Pcsource, Disp30, Disp22, PC, AluOut)
begin	
	case(Pcsource) is
		when "00" =>
			Salida <= Disp30;
		when "01" =>
			Salida <= Disp22;
		when "10" =>
			Salida <= PC;
		when others =>
			Salida <= AluOut;
		end case;
end process;

end Behavioral;

