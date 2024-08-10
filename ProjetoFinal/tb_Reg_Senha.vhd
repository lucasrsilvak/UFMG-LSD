library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_Reg_Senha is
end tb_Reg_Senha;

architecture Behavioral of tb_Reg_Senha is

    -- Component declaration for the Reg_Senha
    component Reg_Senha is
        Port ( Clock    : in  std_logic;
               Reset    : in  std_logic;
               Carregar : in  std_logic;
               Digito   : in  std_logic_vector (3 downto 0);
               Senha    : out std_logic_vector (15 downto 0));
    end component;

    -- Signals to connect to the Reg_Senha
    signal Clock    : std_logic := '0';
    signal Reset    : std_logic := '0';
    signal Carregar : std_logic := '0';
    signal Digito   : std_logic_vector (3 downto 0) := (others => '0');
    signal Senha    : std_logic_vector (15 downto 0);

    -- Clock period definition
    constant Clock_Period : time := 10 ns;

begin

    -- Instantiate the Reg_Senha
    uut: Reg_Senha
        Port map (
            Clock    => Clock,
            Reset    => Reset,
            Carregar => Carregar,
            Digito   => Digito,
            Senha    => Senha
        );

    -- Clock process definitions
    Clock_process :process
    begin
        Clock <= '0';
        wait for Clock_Period/2;
        Clock <= '1';
        wait for Clock_Period/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin	
        -- Reset the Reg_Senha
        Reset <= '1';
        wait for Clock_Period*2;
        Reset <= '0';
        
        -- Load the first digit (1)
        Carregar <= '1';
        Digito <= "0001";
        wait for Clock_Period;
        Carregar <= '0';
        wait for Clock_Period;

        -- Load the second digit (2)
        Carregar <= '1';
        Digito <= "0010";
        wait for Clock_Period;
        Carregar <= '0';
        wait for Clock_Period;

        -- Load the third digit (3)
        Carregar <= '1';
        Digito <= "0011";
        wait for Clock_Period;
        Carregar <= '0';
        wait for Clock_Period;

        -- Load the fourth digit (4)
        Carregar <= '1';
        Digito <= "0100";
        wait for Clock_Period;
        Carregar <= '0';
        wait for Clock_Period;
		  Reset <= '1';

        -- Finish simulation
        wait;
    end process;

end Behavioral;
