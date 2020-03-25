--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   13:03:20 03/24/2020
-- Design Name:   
-- Module Name:   C:/xilinx_ws/segment_display/simulation.vhd
-- Project Name:  segment_display
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: top_module
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
 
ENTITY simulation IS
END simulation;
 
ARCHITECTURE behavior OF simulation IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_module
    PORT(
         i_Switch_1 : IN  std_logic;
         i_Clk : IN  std_logic;
         o_LED : OUT  std_logic;
         o_SegEn : OUT  std_logic_vector(2 downto 0);
         o_SegLED : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal i_Switch_1 : std_logic := '0';
   signal i_Clk : std_logic := '0';

 	--Outputs
   signal o_LED : std_logic;
   signal o_SegEn : std_logic_vector(2 downto 0);
   signal o_SegLED : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant i_Clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_module PORT MAP (
          i_Switch_1 => i_Switch_1,
          i_Clk => i_Clk,
          o_LED => o_LED,
          o_SegEn => o_SegEn,
          o_SegLED => o_SegLED
        );

   -- Clock process definitions
   i_Clk_process :process
   begin
		i_Clk <= '0';
		wait for i_Clk_period/2;
		i_Clk <= '1';
		wait for i_Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for i_Clk_period*10;

      -- insert stimulus here 
		i_Switch_1 <= '1';
		wait for 20 ms;
		
				i_Switch_1 <= '1';
		wait for 30 ms;
				i_Switch_1 <= '0';
		wait for 30 ms;
				i_Switch_1 <= '1';
		wait for 30 ms;
				i_Switch_1 <= '0';
		wait for 30 ms;
						i_Switch_1 <= '1';
		wait for 30 ms;
				i_Switch_1 <= '0';
		wait for 30 ms;
						i_Switch_1 <= '1';
		wait for 30 ms;
				i_Switch_1 <= '0';
		wait for 30 ms;
						i_Switch_1 <= '1';
		wait for 30 ms;
				i_Switch_1 <= '0';
		wait for 30 ms;
						i_Switch_1 <= '1';
		wait for 30 ms;
				i_Switch_1 <= '0';
		wait for 30 ms;
						i_Switch_1 <= '1';
		wait for 30 ms;
				i_Switch_1 <= '0';
		wait for 30 ms;
						i_Switch_1 <= '1';
		wait for 30 ms;
				i_Switch_1 <= '0';
		wait for 30 ms;
						i_Switch_1 <= '1';
		wait for 30 ms;
				i_Switch_1 <= '0';
		wait for 30 ms;
						i_Switch_1 <= '1';
		wait for 30 ms;
				i_Switch_1 <= '0';
		wait for 30 ms;
						i_Switch_1 <= '1';
		wait for 30 ms;
				i_Switch_1 <= '0';
		wait for 30 ms;
						i_Switch_1 <= '1';
		wait for 30 ms;
				i_Switch_1 <= '0';
		wait for 30 ms;
      wait;
   end process;

END;
