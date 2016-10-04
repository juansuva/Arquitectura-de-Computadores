library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

--el selector es el bit 13 que indica si es un inmmediato o un registro entity MUX is
		  PORT(  a      : IN std_logic_vector(31 DOWNTO 0); 
             b      : IN std_logic_vector(31 DOWNTO 0); 
             opt    : IN std_logic; 
             out : OUT std_logic_vector(31 DOWNTO 0));
end MUX;

architecture Behavioral of MUX is

begin

PROCESS (opt, a, b) IS
       BEGIN
         CASE opt IS
           WHEN '0' => out <= a; 
           WHEN '1' => out <= b;
           WHEN OTHERS => out <= (others => '0');
         END CASE;
END PROCESS;

end Behavioral;