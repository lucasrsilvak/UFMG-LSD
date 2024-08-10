library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Multiplexador is
	generic (
		W : integer := 16;
		Log2W : integer := 4
	);
	port (
		Input 	: in  std_logic_vector(W-1 downto 0);
		Seletor	: in  std_logic_vector(Log2W-1 downto 0);
		Output 	: out std_logic
	);
end Multiplexador;

architecture Behavioral of Multiplexador is
begin
	process(Input, Seletor)
		begin
			if to_integer(unsigned(Seletor)) < W then
				Output <= Input(to_integer(unsigned(Seletor)));
			else
				Output <= 'Z';
			end if;
	end process;
end Behavioral;