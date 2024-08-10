library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Datapath is
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
end Datapath;

architecture Structural of Datapath is
	component Contador is
		port (
			Clock   : in std_logic;
			Reset   : in std_logic;
			Control : in std_logic;
			Enable  : in std_logic;
			Start   : in std_logic_vector(3 downto 0) := "0000";
			Count   : out std_logic_vector(3 downto 0)
		);
	end component;

	component Reg_FilaAndar is
		generic (
			W     : natural := 16;
			Log2W : natural := 4
		);
		port (
			Carregar     : in std_logic;
			Clock        : in std_logic;
			Limpar       : in std_logic;
			Reset			 : in std_logic;
			Seletor      : in std_logic_vector(Log2W - 1 downto 0);
			SeletorClear : in std_logic_vector(Log2W - 1 downto 0);
			Saida        : out std_logic_vector(W-1 downto 0)
		);
		end component;

	component Reg_Peso is
		generic (
			W: natural := 10
		);
		port (
			Clock    : in std_logic;
			Reset		: in std_logic;
			Dado 		: in std_logic_vector(9 downto 0);
			Saida   	: out std_logic_vector(9 downto 0)
		);
	end component;
		
	component Reg_Senha is
		port (
			Clock    : in std_logic;
			Reset    : in std_logic;
			Carregar : in std_logic;
			Digito   : in std_logic_vector(3 downto 0);
			Senha    : out std_logic_vector(15 downto 0)
		);
	end component;

	component Multiplexador is
		generic (
			W    : integer := 16;
			Log2W : integer := 4
		);
		port (
			Input 	: in std_logic_vector(W-1 downto 0);
			Seletor : in std_logic_vector(Log2W-1 downto 0);
         Output 	: out std_logic
        );
    end component;

	component Comparador is
		generic (
			W : natural := 4
		);
		port (
			A, B  : in std_logic_vector(W-1 downto 0);
			Enable : in std_logic;
			Maior, Menor, Igual : out std_logic
		);
	end component;

	component BCD_7seg is
		port (
			Entrada : in std_logic_vector(3 downto 0);
			Saida_1 : out std_logic_vector(6 downto 0);
			Saida_2 : out std_logic_vector(6 downto 0)
	  );
	end component;

	signal s_Sig_AndarSelecionado  : std_logic;
	signal s_Sig_Igual             : std_logic;
	signal s_Enable_internal       : std_logic;
	signal s_Control               : std_logic;
	signal s_Sig_Proximo           : std_logic_vector(3 downto 0);
	signal s_Sig_Andar             : std_logic_vector(3 downto 0);
	signal s_Sig_Peso					 : std_logic_vector(9 downto 0);
	signal s_Sig_Reg_FilaAndar     : std_logic_vector(15 downto 0);
	signal s_Sig_Senha             : std_logic_vector(15 downto 0);

begin
	s_Enable_internal <= not(s_Sig_AndarSelecionado);
	s_Control <= Subindo or (not Descendo);

	Instancia_ContadorProximo : Contador port map(
		Clock 	 => Clock,
		Reset 	 => Atualizar,
		Start 	 => s_Sig_Andar,
		Enable  	 => s_Enable_internal,
		Count	 	 => s_Sig_Proximo,
		Control 	 => s_Control
	);
	  
	Instancia_ContadorAndar : Contador port map(
		Clock 	=> Atualizar, 
		Reset 	=> Reset, 
		Enable  	=> '1',
		Count 	=> s_Sig_Andar,
		Control 	=> Subindo
	);

	Instancia_Multiplexador : Multiplexador generic map(W => 16, Log2W => 4) port map(
		Input		=> s_Sig_Reg_FilaAndar,
		Seletor  => s_Sig_Proximo,
		Output	=> s_Sig_AndarSelecionado
    );

	Instancia_Reg_FilaAndar : Reg_FilaAndar generic map(W => 16, Log2W => 4) port map(
		Carregar => Escolher,
		Limpar 	=> Abre,
		Clock 	=> Clock,
		Seletor 	=> Andar,
		Reset		=> Reset,
		SeletorClear => s_Sig_Andar,
		Saida 	=> s_Sig_Reg_FilaAndar
	);

	Instancia_Reg_Peso : Reg_Peso generic map(W => 10) port map(
		Clock 	=> Clock,
		Dado 		=> Peso,
		Reset		=> Reset,
		Saida 	=> s_Sig_Peso
	);
	
	Instancia_Reg_Senha : Reg_Senha port map(
		Clock 	=> Clock,
		Reset 	=> Reset,
		Carregar => Enviar,
		Digito 	=> Digito,
		Senha 	=> s_Sig_Senha
	);

	Instancia_ComparadorAndar : Comparador generic map(W => 4) port map(
		A => s_Sig_Proximo,
		B => s_Sig_Andar,
		Enable => s_Sig_AndarSelecionado,
		Igual  => s_Sig_Igual,
		Maior  => Sobe,
		Menor  => Desce
	);

	Instancia_ComparadorPeso : Comparador generic map(W => 10) port map(
		A => s_Sig_Peso,
		B => "1100100000", -- (800 em binário)
		Enable => '1',
		Maior  => Peso_Ultrapassado
	);

	Instancia_ComparadorSenha : Comparador generic map(W => 16) port map(
		A => s_Sig_Senha,
		B => "0001001000110100", -- (1234 em binário)
		Enable => '1',
		Igual  => Verificado
	);

    Instancia_BCD : BCD_7seg port map(
        Entrada => s_Sig_Andar,
        Saida_1 => BCD1,
        Saida_2 => BCD2
    );

    Sig_Proximo <= s_Sig_Proximo;
    Sig_Andar <= s_Sig_Andar;
    Sig_Reg_FilaAndar <= s_Sig_Reg_FilaAndar;
    Sig_AndarSelecionado <= s_Sig_AndarSelecionado;
	 Sig_Senha <= s_Sig_Senha;
	 Sig_Peso <= s_Sig_Peso;
    Igual <= s_Sig_Igual;
end Structural;