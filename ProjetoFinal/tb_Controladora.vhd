library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Controladora is
    -- Testbench does not have ports
end tb_Controladora;

architecture behavior of tb_Controladora is
    -- Component Declaration
    component Controladora
        port (
            Clock : in std_logic;
            Reset : in std_logic;
            Sobe  : in std_logic;
            Desce : in std_logic;
            Igual : in std_logic;
            Verificado : in std_logic;
            Bot_Emergencia : in std_logic;
            Peso_Ultrapassado : in std_logic;
            Abre : out std_logic;
            Fecha : out std_logic;
            Subindo : out std_logic;
            Descendo : out std_logic;
            Atualizar : out std_logic;
            Emergencia : out std_logic
        );
    end component;

    -- Signals for the testbench
    signal Clock : std_logic := '0';
    signal Reset : std_logic := '0';
    signal Sobe : std_logic := '0';
    signal Desce : std_logic := '0';
    signal Igual : std_logic := '0';
    signal Verificado : std_logic := '0';
    signal Bot_Emergencia : std_logic := '0';
    signal Peso_Ultrapassado : std_logic := '0';
    signal Abre : std_logic;
    signal Fecha : std_logic;
    signal Subindo : std_logic;
    signal Descendo : std_logic;
    signal Atualizar : std_logic;
    signal Emergencia : std_logic;

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Controladora component
    uut: Controladora
        port map (
            Clock => Clock,
            Reset => Reset,
            Sobe => Sobe,
            Desce => Desce,
            Igual => Igual,
            Verificado => Verificado,
            Bot_Emergencia => Bot_Emergencia,
            Peso_Ultrapassado => Peso_Ultrapassado,
            Abre => Abre,
            Fecha => Fecha,
            Subindo => Subindo,
            Descendo => Descendo,
            Atualizar => Atualizar,
            Emergencia => Emergencia
        );

    -- Clock process
    clk_process: process
    begin
        Clock <= '0';
        wait for clk_period / 2;
        Clock <= '1';
        wait for clk_period / 2;
    end process;

    -- Test process
    test_process: process
    begin
        -- Reset the system
        Reset <= '1';
        wait for clk_period;
        Reset <= '0';
        wait for clk_period;

        -- Test Scenario 1: Initial state and transition to ConfereAndar
        Sobe <= '0';
        Desce <= '0';
        Igual <= '0';
        Bot_Emergencia <= '0';
        Peso_Ultrapassado <= '0';
        wait for clk_period;

        -- Test Scenario 2: Trigger Sobe to transition to ElevadorSubindo
        Sobe <= '1';
        wait for clk_period;
        Sobe <= '0';
        wait for clk_period;

        -- Test Scenario 3: Trigger Desce to transition to ElevadorDescendo
        Desce <= '1';
        wait for clk_period;
        Desce <= '0';
        wait for clk_period;

        -- Test Scenario 4: Trigger Igual to transition to AbrePorta
        Igual <= '1';
        wait for clk_period;
        Igual <= '0';
        wait for clk_period;

        -- Test Scenario 5: Trigger Peso_Ultrapassado to transition to ConferePeso
        Peso_Ultrapassado <= '1';
        wait for clk_period;
        Peso_Ultrapassado <= '0';
        wait for clk_period;

        -- Test Scenario 6: Trigger Bot_Emergencia to transition to EstadoEmergencia
        Bot_Emergencia <= '1';
        wait for clk_period;
        Bot_Emergencia <= '0';
        wait for clk_period;

        -- Test Scenario 7: Verify state transition and output signals
        Verificado <= '1';
        wait for clk_period;

        -- Finish simulation
        wait;
    end process;

end behavior;
