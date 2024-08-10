library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Reg_FilaAndar is
end entity tb_Reg_FilaAndar;

architecture behavior of tb_Reg_FilaAndar is
    -- Component declaration for the unit under test (UUT)
    component Reg_FilaAndar is
        generic (
            W     : natural := 16;
            Log2W : natural := 4
        );
        port (
            Clock         : in  std_logic;
            Limpar        : in  std_logic;
            Carregar      : in  std_logic;
            Reset         : in  std_logic;
            Seletor       : in  std_logic_vector(Log2W - 1 downto 0);
            SeletorClear  : in  std_logic_vector(Log2W - 1 downto 0);
            Saida         : out std_logic_vector(W-1 downto 0)
        );
    end component;

    -- Signals for testbench
    signal Limpar        : std_logic := '0';
    signal Carregar      : std_logic := '0';
    signal Reset         : std_logic := '0';
    signal Clock         : std_logic := '0';
    signal Seletor       : std_logic_vector(3 downto 0) := (others => '0');
    signal SeletorClear  : std_logic_vector(3 downto 0) := (others => '0');
    signal Saida         : std_logic_vector(15 downto 0);

    -- Clock period definition
    constant clk_period : time := 10 ns;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: Reg_FilaAndar
        generic map (
            W     => 16,
            Log2W => 4
        )
        port map (
            Clock         => Clock,
            Limpar        => Limpar,
            Carregar      => Carregar,
            Reset         => Reset,
            Seletor       => Seletor,
            SeletorClear  => SeletorClear,
            Saida         => Saida
        );

    -- Clock generation process
    clk_process : process
    begin
        Clock <= '0';
        wait for clk_period/2;
        Clock <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initial values
        Reset <= '1';
        wait for clk_period;
        Reset <= '0';
        wait for clk_period;

        -- Test case 1: Load floor 3
        Carregar <= '1';
        Seletor <= "0011";  -- Select floor 3
        wait for clk_period;
        Carregar <= '0';
        wait for clk_period;
        Carregar <= '1';
        Seletor <= "0111";  -- Select floor 7
        wait for clk_period;
        Carregar <= '0';
        wait for clk_period;
		  Limpar <= '1';
        SeletorClear <= "0011";  -- Clear floor 7
        wait for clk_period;
        Limpar <= '0';
        wait for clk_period;
		  Reset <= '1';
        wait;
    end process;

end architecture behavior;
