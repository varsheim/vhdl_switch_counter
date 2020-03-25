library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity top_module is
	port (
		i_Switch : in STD_LOGIC_VECTOR(1 downto 0);
		i_Clk : in STD_LOGIC;
		
		o_LED : out STD_LOGIC;
		o_SegEn : out STD_LOGIC_VECTOR(2 downto 0);
		o_SegLED : out STD_LOGIC_VECTOR(7 downto 0)
	);
end top_module;

architecture Behavioral of top_module is
-- CONSTANTS
	constant c_SEGMENT_PERIOD : integer := 12000; -- 1 miliseconds
	
-- SIGNALS
	signal r_LED_1 : STD_LOGIC := '0';
	signal r_Switch : STD_LOGIC_VECTOR(1 downto 0) := "00";
	signal w_Switch : STD_LOGIC_VECTOR(1 downto 0);
	
-- SIGNALS button counter
	signal r_SwitchBCDcnt : STD_LOGIC_VECTOR(11 downto 0) := "000000000000";
	
-- SIGNALS 7 segments display
	signal r_CurrentSegment : STD_LOGIC_VECTOR(2 downto 0) := "001"; --change to std_logic_vector
	signal r_SegmentTimer : integer range 0 to c_SEGMENT_PERIOD := 0;
	signal r_SegmentCurrentDigit : STD_LOGIC_VECTOR(3 downto 0) := "0000";
	
begin
	-- Instantiate Debounce Filter
	Debounce_Inst_1 : entity work.DebounceSwitch
		port map (
			i_Clk    => i_Clk,
			i_Switch => i_Switch(0),
			o_Switch => w_Switch(0));
	
	Debounce_Inst_2 : entity work.DebounceSwitch
		port map (
			i_Clk    => i_Clk,
			i_Switch => i_Switch(1),
			o_Switch => w_Switch(1));
			
	-- Instantiate BCD to 7SEG
	BCDToSegment_Inst : entity work.BCDToSegment
		port map (
			i_Digit => r_SegmentCurrentDigit,
			o_SegLED => o_SegLED);
			
	p_Register : process (i_Clk) is
	begin
		if rising_edge(i_Clk) then
			-- na narastajace zbocze zegara
			-- LED ma zmienic stan na puszczenie przycisku
			r_Switch <= not(w_Switch);
			
			-- przycisk 1 zostal puszczony
			if r_Switch(0) = '1' and not(w_Switch(0)) = '0' then
				-- zmiana stanu LED
				r_LED_1 <= not r_LED_1;
				
				-- inkrementacja licznika BCD
				if r_SwitchBCDcnt(3 downto 0) < 9 then
					r_SwitchBCDcnt(3 downto 0) <= r_SwitchBCDcnt(3 downto 0) + 1;
				else
					r_SwitchBCDcnt(3 downto 0) <= "0000";
					if r_SwitchBCDcnt(7 downto 4) < 9 then
						r_SwitchBCDcnt(7 downto 4) <= r_SwitchBCDcnt(7 downto 4) + 1;
					else
						r_SwitchBCDcnt(7 downto 4) <= "0000";
						if r_SwitchBCDcnt(11 downto 8) < 1 then
							r_SwitchBCDcnt(11 downto 8) <= r_SwitchBCDcnt(11 downto 8) + 1;
						else
							r_SwitchBCDcnt(11 downto 8) <= "0000";
						end if;
					end if;
				end if;
			end if;
			
			-- przycisk 2 zostal puszczony
			if r_Switch(1) = '1' and not(w_Switch(1)) = '0' then
				r_SwitchBCDcnt(11 downto 0) <= "000000000000";
			end if;
		end if;
	end process p_Register;
	
	-- multiplekser na kazda cyfre
	with r_CurrentSegment select
		r_SegmentCurrentDigit <= r_SwitchBCDcnt(3 downto 0) when "001",
										 r_SwitchBCDcnt(7 downto 4) when "010",
										 r_SwitchBCDcnt(11 downto 8) when "100",
										 "0000" when others;

	p_Display : process (i_Clk) is
	begin
		if rising_edge(i_Clk) then
			-- na narastajace zbocze
			
			-- aktywacja wyswietlacza na zdefiniowany czas
			if r_SegmentTimer < c_SEGMENT_PERIOD - 1 then
				r_SegmentTimer <= r_SegmentTimer + 1;
			elsif r_SegmentTimer = c_SEGMENT_PERIOD - 1 then
				-- shift register
				r_CurrentSegment <= r_CurrentSegment(0) & r_CurrentSegment(2 downto 1);
				r_SegmentTimer <= 0;
			end if;
		end if;
	end process p_Display;
	
	o_SegEn <= not(r_CurrentSegment);
	o_LED <= r_LED_1;
end Behavioral;

