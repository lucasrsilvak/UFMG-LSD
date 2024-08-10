library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Elevador is
end tb_Elevador;

architecture behavior of tb_Elevador is
	component Elevador is
	port (
		Clock_Controladora : in std_logic;
		Clock_Datapath     : in std_logic;
		Reset              : in std_logic;
		Escolher           : in std_logic;
		Enviar           	 : in std_logic;
		Bot_Emergencia     : in std_logic;
		Peso               : in std_logic_vector(9 downto 0);
		Andar              : in std_logic_vector(3 downto 0);
		Digito        		 : in std_logic_vector(3 downto 0);
		Abre               : out std_logic;
		Fecha              : out std_logic;
		Sobe               : out std_logic;
		Desce              : out std_logic;
		Igual              : out std_logic;
		Emergencia         : out std_logic;
		Peso_Ultrapassado  : out std_logic;
		BCD1               : out std_logic_vector(6 downto 0);
		BCD2               : out std_logic_vector(6 downto 0)
    );
end component;
    -- Sinais de teste
    signal Clock_Controladora : std_logic := '0';
    signal Clock_Datapath     : std_logic := '0';
    signal Reset              : std_logic := '0';
    signal Andar              : std_logic_vector(3 downto 0) := (others => '0');
    signal Digito             : std_logic_vector(3 downto 0) := (others => '0');
    signal Escolher           : std_logic := '0';
    signal Enviar             : std_logic := '0';
    signal Peso               : std_logic_vector(9 downto 0) := (others => '0');
    signal Bot_Emergencia     : std_logic := '0';
    signal Abre               : std_logic;
    signal Fecha              : std_logic;
    signal Sobe               : std_logic;
    signal Desce              : std_logic;
    signal Igual              : std_logic;
    signal BCD1               : std_logic_vector(6 downto 0);
    signal BCD2               : std_logic_vector(6 downto 0);
    signal Emergencia         : std_logic;
    signal Peso_Ultrapassado  : std_logic;

    -- Clock period
    constant Clock_Period_Controladora : time := 500 ns;
    constant Clock_Period_Datapath     : time := 20 ns;

begin
    -- Geração do Clock para Controladora
    process
    begin
        Clock_Controladora <= '0';
        wait for Clock_Period_Controladora / 2;
        Clock_Controladora <= '1';
        wait for Clock_Period_Controladora / 2;
    end process;

    -- Geração do Clock para Datapath
    process
    begin
        Clock_Datapath <= '0';
        wait for Clock_Period_Datapath / 2;
        Clock_Datapath <= '1';
        wait for Clock_Period_Datapath / 2;
    end process;

    -- Instância do Elevador
    uut: Elevador
        port map (
            Clock_Controladora => Clock_Controladora,
            Clock_Datapath     => Clock_Datapath,
            Reset              => Reset,
            Andar              => Andar,
            Digito             => Digito,
            Escolher           => Escolher,
            Enviar             => Enviar,
            Peso               => Peso,
            Bot_Emergencia     => Bot_Emergencia,
            Abre               => Abre,
            Fecha              => Fecha,
            Sobe               => Sobe,
            Desce              => Desce,
            Igual              => Igual,
            BCD1               => BCD1,
            BCD2               => BCD2,
            Emergencia         => Emergencia,
            Peso_Ultrapassado  => Peso_Ultrapassado
        );

    -- Processo de estímulo
    process
    begin
        -- Reset
        Reset <= '1';
        wait for 20 ns;
        Reset <= '0';

        -- Test Case 1: Seleção de andar
        Andar <= "0010"; -- Exemplo de andar 2
        Escolher <= '1';
        wait for 40 ns;
        Escolher <= '0';
        wait for 500 ns;

        -- Test Case 2: Seleção de outro andar
        Andar <= "1111"; -- Exemplo de andar 4
        Escolher <= '1';
        wait for 40 ns;
        Escolher <= '0';
        wait for 1000 ns;

        -- Test Case 3: Retornar ao andar 0
        Andar <= "0000"; -- Exemplo de andar 0
        Escolher <= '1';
        wait for 20 ns;
        Escolher <= '0';
        wait for 10000 ns;
		  Andar <= "1000"; -- Exemplo de andar 4
        Escolher <= '1';
        wait for 40 ns;
        Escolher <= '0';

        -- Finaliza a simulação
        wait;
    end process;

end behavior;
