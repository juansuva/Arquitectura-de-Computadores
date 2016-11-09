
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

ENTITY Mux_tb IS
END Mux_tb;
 
ARCHITECTURE behavior OF Mux_tb IS 
 
    
 
    COMPONENT MUX
    PORT(
         a : IN  std_logic_vector(31 downto 0);
         b : IN  std_logic_vector(31 downto 0);
         opt : IN  std_logic;
         MuxOut : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(31 downto 0) := (others => '0');
   signal b : std_logic_vector(31 downto 0) := (others => '0');
   signal opt : std_logic := '0';

 	--Outputs
   signal MuxOut : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MUX PORT MAP (
          a => a,
          b => b,
          opt => opt,
          MuxOut => MuxOut
        );

 
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	
		opt <= '0';
      a <= x"00000001";
		b <= x"00000002";
		
		 wait for 100 ns;	
		opt <= '1';
      a <= x"00000003";
		b <= x"00000004";
      -- insert stimulus here 

      wait;
   end process;

END;
