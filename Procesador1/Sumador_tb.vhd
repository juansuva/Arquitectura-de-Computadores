--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:07:19 10/04/2016
-- Design Name:   
-- Module Name:   C:/Users/utp/Desktop/ProcesadorMonociclo/ProcesadorMonociclo/Sumador_tb.vhd
-- Project Name:  ProcesadorMonociclo
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: sumador
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Sumador_tb IS
END Sumador_tb;
 
ARCHITECTURE behavior OF Sumador_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT sumador
    PORT(
         constante : IN  std_logic_vector(31 downto 0);
         data : IN  std_logic_vector(31 downto 0);
         data_out : OUT  std_logic_vector(31 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal constante : std_logic_vector(31 downto 0) := (others => '0');
   signal data : std_logic_vector(31 downto 0) := (others => '0');

 	--Outputs
   signal data_out : std_logic_vector(31 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   --constant <clock>_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sumador PORT MAP (
          constante => constante,
          data => data,
          data_out => data_out
        );

   -- Clock process definitions
  

   -- Stimulus process
   stim_proc: process
   begin		
     
      --reset <= '1';
      wait for 100 ns;	
		data <= x"00000001"; 
		constante <= x"00000100";
      --reset <= '0'; 
		wait for 100 ns;	
		data <= x"00000010"; 
		constante <= x"00001000";
		
		wait for 100 ns;	
		data <= x"00000001"; 
		constante <= x"00000001";

      -- insert stimulus here 

      wait;
   end process;

END;
