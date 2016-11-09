Library ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY RegisterFile_tb IS
END RegisterFile_tb;
 
ARCHITECTURE behavior OF RegisterFile_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RegisterFile
    PORT(
         Rs1 : IN  std_logic_vector(4 downto 0);
         Rs2 : IN  std_logic_vector(4 downto 0);
         Rd : IN  std_logic_vector(4 downto 0);
         rst : IN  std_logic;
         DataToWrite : IN  std_logic_vector(31 downto 0);
         Crs1 : OUT  std_logic_vector(31 downto 0);
         Crs2 : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Rs1 : std_logic_vector(4 downto 0) := (others => '0');
   signal Rs2 : std_logic_vector(4 downto 0) := (others => '0');
   signal Rd : std_logic_vector(4 downto 0) := (others => '0');
   signal rst : std_logic := '0';
   signal DataToWrite : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal Crs1 : std_logic_vector(31 downto 0);
   signal Crs2 : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
  
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RegisterFile PORT MAP (
          Rs1 => Rs1,
          Rs2 => Rs2,
          Rd => Rd,
          rst => rst,
          DataToWrite => DataToWrite,
          Crs1 => Crs1,
          Crs2 => Crs2
        );

   -- Clock process definitions
   
   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      
		Rs1 <= "00000";
		Rs2 <= "01000";
		Rd <= "00001";
		DataToWrite <= x"00000004";
		rst <= '0';
		wait for 100 ns;	
		Rs1 <= "00011";
		Rs2 <= "00110";
		Rd <= "00010";
		DataToWrite <= x"00000009";
		rst <= '1';
      wait for 100 ns;
		
		Rs1 <= "00011";
		Rs2 <= "01010";
		Rd <= "00000";
		DataToWrite <= x"00000007";
		rst <= '0';
      wait for 100 ns;
      

       

      wait;
   end process;

END;
