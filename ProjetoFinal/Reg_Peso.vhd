library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Reg_Peso is
    generic (
        W : natural := 10
    );
    port (
        Clock : in std_logic;
		  Reset : in std_logic;
        Dado  : in std_logic_vector(W-1 downto 0);
        Saida : out std_logic_vector(W-1 downto 0)
    );
end entity Reg_Peso;

architecture Behavioral of Reg_Peso is
    signal Peso : std_logic_vector(W-1 downto 0) := (others => '0');
begin
	process (Clock, Reset)
	begin
		if Reset = '1' then
			Peso <= (others => '0');
		elsif rising_edge(Clock) then
			Peso <= Dado;
		end if;
	end process;

	Saida <= Peso;
end architecture Behavioral;
