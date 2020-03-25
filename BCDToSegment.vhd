library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity BCDToSegment is
	port (
		i_Digit : in STD_LOGIC_VECTOR(3 downto 0);
		o_SegLED : out STD_LOGIC_VECTOR(7 downto 0)
	);
end BCDToSegment;

architecture Behavioral of BCDToSegment is
begin
	-- 0 is to light up the segment
	-- o_SegLED is dot c b a g f e d
	with i_Digit select
		o_SegLED <= "10001000" when "0000",
					   "10011111" when "0001",
					   "11000100" when "0010",
					   "10000110" when "0011",
					   "10010011" when "0100",
					   "10100010" when "0101",
					   "10100000" when "0110",
				   	"10001111" when "0111",
				 	   "10000000" when "1000",
					   "10000010" when "1001",
					   "00000000" when others;
end Behavioral;

