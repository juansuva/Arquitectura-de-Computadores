
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

 
ENTITY ExtSigno_tb IS
END ExtSigno_tb;
 
ARCHITECTURE behavior OF ExtSigno_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT ExtSigno
    PORT(
         imm13 : IN  std_logic_vector(12 downto 0);
         imm32 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal imm13 : std_logic_vector(12 downto 0) := (others => '0');

 	--Outputs
   signal imm32 : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: ExtSigno PORT MAP (
          imm13 => imm13,
          imm32 => imm32
        );



   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		imm13 <= "1000000000000";

      wait for 100 ns;	
		imm13 <= "0100000000000";


      wait;
   end process;

END;
