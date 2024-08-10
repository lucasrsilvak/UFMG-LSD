library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_Datapath is
end tb_Datapath;

architecture Behavioral of tb_Datapath is
	component Datapath is
		port (
			Clock             : in std_logic;
			Subindo           : in std_logic;
			Descendo          : in std_logic;
			Atualizar         : in std_logic;
			Abre              : in std_logic;
			Escolher          : in std_logic;
			Enviar				: in std_logic;
			Reset					: in std_logic;
			Digito            : in std_logic_vector(3 downto 0);
			Andar             : in std_logic_vector(3 downto 0);
			Peso              : in std_logic_vector(9 downto 0);
			Sobe              : out std_logic;
			Desce             : out std_logic;
			Igual             : out std_logic;
			Peso_Ultrapassado : out std_logic;
			Verificado        : out std_logic;
			BCD1              : out std_logic_vector(6 downto 0);
			BCD2              : out std_logic_vector(6 downto 0);
			Sig_Peso				: buffer std_logic_vector(9 downto 0);
			Sig_Senha			: buffer std_logic_vector(15 downto 0);
			Sig_Proximo       : buffer std_logic_vector(3 downto 0);
			Sig_Andar         : buffer std_logic_vector(3 downto 0);
			Sig_Reg_FilaAndar : buffer std_logic_vector(15 downto 0);
			Sig_AndarSelecionado : buffer std_logic
		);
	end component;

    -- Signals for the Datapath
    signal Clock             : std_logic := '0';
    signal Subindo           : std_logic := '0';
    signal Descendo          : std_logic := '0';
    signal Atualizar         : std_logic := '0';
    signal Abre              : std_logic := '0';
    signal Escolher          : std_logic := '0';
    signal Enviar            : std_logic := '0';
    signal Reset             : std_logic := '0';
    signal Digito            : std_logic_vector(3 downto 0) := "0000";
    signal Andar             : std_logic_vector(3 downto 0) := "0000";
    signal Peso              : std_logic_vector(9 downto 0) := "0000000000";
    
    -- Outputs from the Datapath
    signal Sobe              : std_logic;
    signal Desce             : std_logic;
    signal Igual             : std_logic;
    signal Peso_Ultrapassado : std_logic;
    signal Verificado        : std_logic;
    signal BCD1              : std_logic_vector(6 downto 0);
    signal BCD2              : std_logic_vector(6 downto 0);
    signal Sig_Peso          : std_logic_vector(9 downto 0);
    signal Sig_Senha         : std_logic_vector(15 downto 0);
    signal Sig_Proximo       : std_logic_vector(3 downto 0);
    signal Sig_Andar         : std_logic_vector(3 downto 0);
    signal Sig_Reg_FilaAndar : std_logic_vector(15 downto 0);
    signal Sig_AndarSelecionado : std_logic;

    -- Clock period definition
    constant clk_period : time := 10 ns;
	 
	 begin

    -- Instantiate the Datapath
    uut: Datapath
        port map (
            Clock             => Clock,
            Subindo           => Subindo,
            Descendo          => Descendo,
            Atualizar         => Atualizar,
            Abre              => Abre,
            Escolher          => Escolher,
            Enviar            => Enviar,
            Reset             => Reset,
            Digito            => Digito,
            Andar             => Andar,
            Peso              => Peso,
            Sobe              => Sobe,
            Desce             => Desce,
            Igual             => Igual,
            Peso_Ultrapassado => Peso_Ultrapassado,
            Verificado        => Verificado,
            BCD1              => BCD1,
            BCD2              => BCD2,
            Sig_Peso          => Sig_Peso,
            Sig_Senha         => Sig_Senha,
            Sig_Proximo       => Sig_Proximo,
            Sig_Andar         => Sig_Andar,
            Sig_Reg_FilaAndar => Sig_Reg_FilaAndar,
            Sig_AndarSelecionado => Sig_AndarSelecionado
        );

    -- Clock generation process
    process
    begin
        Clock <= '0';
        wait for clk_period / 2;
        Clock <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    process
    begin
        -- Initialize inputs
		  Enviar <= '1';
        Digito <= "0001";
        Andar <= "0000";
        Peso <= "0000000000";
			wait for clk_period;
			Enviar <= '0';
			wait for clk_period;
			Enviar <= '1';
			Digito <= "0010";
			wait for clk_period;
			Enviar <= '0';
			wait for clk_period;
			Enviar <= '1';
			Digito <= "0011";
			wait for clk_period;
			Enviar <= '0';
			wait for clk_period;
			Enviar <= '1';
			Digito <= "0101";
			wait for clk_period;
			Enviar <= '0';
			wait for 2*clk_period;
			Enviar <= '1';
			Digito <= "0001";
			wait for clk_period;
			Enviar <= '0';
			wait for clk_period;
			Enviar <= '1';
			Digito <= "0010";
			wait for clk_period;
			Enviar <= '0';
			wait for clk_period;
			Enviar <= '1';
			Digito <= "0011";
			wait for clk_period;
			Enviar <= '0';
			wait for clk_period;
			Enviar <= '1';
			Digito <= "0100";
			wait for clk_period;
			Enviar <= '0';
			wait for clk_period;
			Enviar <= '1';
			Digito <= "0100";
			wait for clk_period;
			Enviar <= '0';
        wait;
    end process;
end Behavioral;
