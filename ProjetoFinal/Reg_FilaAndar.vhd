library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Reg_FilaAndar is
	generic (
		W     : natural := 16;
		Log2W : natural := 4
	);
	port (
		Clock			 : in std_logic;
		Limpar		 : in std_logic;
		Carregar 	 : in std_logic;
		Reset			 : in std_logic;
		Seletor  	 : in std_logic_vector(Log2W - 1 downto 0);
		SeletorClear : in std_logic_vector(Log2W - 1 downto 0);
		Saida    	 : out std_logic_vector(W-1 downto 0)
	);
end entity Reg_FilaAndar;

architecture Behavioral of Reg_FilaAndar is
	signal Fila : std_logic_vector(W-1 downto 0) := (others => '0');
	
begin
	process (Clock, Reset)
	begin
		if Reset = '1' then
			Fila <= (others => '0');
		elsif rising_edge(Clock) then
			if Carregar = '1' then
				Fila(to_integer(unsigned(Seletor))) <= '1';
			elsif Limpar = '1' then
				Fila(to_integer(unsigned(SeletorClear))) <= '0';
			end if;
		end if;
	end process;

	Saida <= Fila;

end architecture Behavioral;