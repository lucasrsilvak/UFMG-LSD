library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Elevador is
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
end Elevador;

architecture Structural of Elevador is
    signal Atualizar_Controladora : std_logic;
    signal Descendo_Controladora  : std_logic;
    signal Subindo_Controladora   : std_logic;
    signal Sobe_Datapath          : std_logic;
    signal Desce_Datapath         : std_logic;
    signal Abre_Controladora      : std_logic;
    signal Fecha_Controladora     : std_logic;
    signal Peso_Datapath          : std_logic;
    signal Verificado_Datapath    : std_logic;
    signal Emergencia_Controladora: std_logic;
    signal Igual_Datapath         : std_logic;

    component Controladora is
        port (
            Clock              : in std_logic;
            Reset              : in std_logic;
            Sobe               : in std_logic;
            Desce              : in std_logic;
            Igual              : in std_logic;
            Peso_Ultrapassado  : in std_logic;
            Bot_Emergencia     : in std_logic;
            Verificado         : in std_logic;
            Abre               : out std_logic;
            Fecha              : out std_logic;
            Atualizar          : out std_logic;
            Subindo            : out std_logic;
            Descendo           : out std_logic;
            Emergencia         : out std_logic
        );
    end component;

    component Datapath is
        port (
            Subindo              : in std_logic;
            Descendo             : in std_logic;
            Clock                : in std_logic;
            Atualizar            : in std_logic;
            Andar                : in std_logic_vector(3 downto 0);
            Digito          		: in std_logic_vector(3 downto 0);
            Escolher             : in std_logic;
				Enviar					: in std_logic;
            Abre                 : in std_logic;
				Reset						: in std_logic;
            Peso                 : in std_logic_vector(9 downto 0);
            Sobe                 : out std_logic;
            Desce                : out std_logic;
            Igual                : out std_logic;
            Peso_Ultrapassado    : out std_logic;
            Verificado           : out std_logic;
            BCD1                 : out std_logic_vector(6 downto 0);
            BCD2                 : out std_logic_vector(6 downto 0)
        );
    end component;

begin

    U1: Controladora
        port map (
            Clock              => Clock_Controladora,
            Reset              => Reset,
            Sobe               => Sobe_Datapath,
            Desce              => Desce_Datapath,
            Igual              => Igual_Datapath,
            Peso_Ultrapassado  => Peso_Datapath,
            Bot_Emergencia     => Bot_Emergencia,
            Abre               => Abre_Controladora,
            Fecha              => Fecha_Controladora,
            Atualizar          => Atualizar_Controladora,
            Subindo            => Subindo_Controladora,
            Descendo           => Descendo_Controladora,
            Emergencia         => Emergencia_Controladora,
            Verificado         => Verificado_Datapath
        );

    U2: Datapath
        port map (
            Peso                => Peso,
            Subindo             => Subindo_Controladora,
            Descendo            => Descendo_Controladora,
            Clock               => Clock_Datapath,
            Atualizar           => Atualizar_Controladora,
            Digito         	  => Digito,
            Andar               => Andar,
            Escolher            => Escolher,
				Enviar				  => Enviar,
				Reset					  => Reset,
            Abre                => Abre_Controladora,
            Sobe                => Sobe_Datapath,
            Desce               => Desce_Datapath,
            Igual               => Igual_Datapath,
            BCD1                => BCD1,
            BCD2                => BCD2,
            Peso_Ultrapassado   => Peso_Datapath,
				Verificado          => Verificado_Datapath
        );

	Abre <= Abre_Controladora;
	Fecha <= Fecha_Controladora;
	Sobe <= Sobe_Datapath;
	Desce <= Desce_Datapath;
	Igual <= Igual_Datapath;
	Emergencia <= Emergencia_Controladora;
	Peso_Ultrapassado <= Peso_Datapath;
end Structural;