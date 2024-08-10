library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Reg_Peso is
end entity tb_Reg_Peso;

architecture Behavioral of tb_Reg_Peso is
    constant W : natural := 10;

    signal Clock : std_logic := '0';
    signal Reset : std_logic := '0';
    signal Dado  : std_logic_vector(W-1 downto 0) := (others => '0');
    signal Saida : std_logic_vector(W-1 downto 0);

    -- Instanciar o componente a ser testado (UUT)
    component Reg_Peso is
        generic (
            W : natural := 10
        );
        port (
            Clock : in std_logic;
            Reset : in std_logic;
            Dado  : in std_logic_vector(W-1 downto 0);
            Saida : out std_logic_vector(W-1 downto 0)
        );
    end component;

begin
    -- Instanciar o UUT
    uut: Reg_Peso
        generic map (
            W => W
        )
        port map (
            Clock => Clock,
            Reset => Reset,
            Dado  => Dado,
            Saida => Saida
        );

    -- Geração do clock
    Clock_process : process
    begin
        Clock <= '0';
        wait for 10 ns;
        Clock <= '1';
        wait for 10 ns;
    end process;

    -- Processo de estímulos
    stim_proc: process
    begin
        -- Inicialização
        Reset <= '1';
        Dado <= (others => '0');
        wait for 20 ns;

        -- Liberar reset
        Reset <= '0';
        wait for 20 ns;

        -- Carregar dados no registrador
        Dado <= "0000001010"; -- 10 em binário
        wait for 20 ns;

        -- Carregar novos dados
        Dado <= "0010010101"; -- 21 em binário
        wait for 20 ns;

        -- Carregar mais dados
        Dado <= "1011111111"; -- 1023 em binário
        wait for 20 ns;
		  
		  Reset <= '1';

        -- Finalizar simulação
        wait;
    end process;

end architecture Behavioral;
