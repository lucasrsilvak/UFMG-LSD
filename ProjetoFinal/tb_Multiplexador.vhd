library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Multiplexador is
end tb_Multiplexador;

architecture Behavioral of tb_Multiplexador is
    component Multiplexador
        generic (
            W : integer := 16;
            Log2W : integer := 4
        );
        port (
            Input  : in  std_logic_vector(W-1 downto 0);
            Seletor : in  std_logic_vector(Log2W-1 downto 0);
            Output  : out std_logic
        );
    end component;

    constant W : integer := 16;
    constant Log2W : integer := 4;

    signal Input  : std_logic_vector(W-1 downto 0);
    signal Seletor : std_logic_vector(Log2W-1 downto 0);
    signal Output  : std_logic;

begin
    uut: Multiplexador
        generic map (
            W => W,
            Log2W => Log2W
        )
        port map (
            Input => Input,
            Seletor => Seletor,
            Output => Output
        );

    stim_proc: process
    begin
        -- Teste 1
        Input <= "0000000000010010";
        Seletor <= "0000";
        wait for 10 ns;
        Seletor <= "0001";
        wait for 10 ns;
        Seletor <= "0010";
			wait for 10 ns;
			Seletor <= "0011";
						wait for 10 ns;
			Seletor <= "0100";
									wait for 10 ns;
			Seletor <= "0101";
												wait for 10 ns;
			Seletor <= "0110";
        wait;
    end process;
end Behavioral;
