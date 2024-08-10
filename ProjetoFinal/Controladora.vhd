library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Controladora is
	port (
		Clock : in std_logic;
		Reset : in std_logic;
		Sobe  : in std_logic;
		Desce : in std_logic;
		Igual : in std_logic;
		Verificado        : in std_logic;
		Bot_Emergencia    : in std_logic;
		Peso_Ultrapassado : in std_logic;
		Abre		  : out std_logic;
		Fecha		  : out std_logic;
		Subindo    : out std_logic;
		Descendo   : out std_logic;
		Atualizar  : out std_logic;
		Emergencia : out std_logic
    );
end Controladora;

architecture Behavioral of Controladora is
	type state_type is (Inicio, ConfereAndar, ElevadorSubindo, ElevadorDescendo, AbrePorta, ConferePeso, FechaPorta, EstadoEmergencia);
	signal State, NextState : state_type;

begin 
	process (Clock, Reset)
	begin
		if Reset = '1' then
			State <= Inicio;
		elsif rising_edge(Clock) then
			State <= NextState;
		end if;
    end process;

	process (State, Sobe, Desce, Igual, Peso_Ultrapassado, Bot_Emergencia, Verificado)
	begin
		Abre 		  <= '0';
		Fecha 	  <= '0';
		Subindo 	  <= '0';
		Descendo   <= '0';
		Atualizar  <= '0';
		Emergencia <= '0';

		case State is
			when Inicio =>
				NextState <= ConfereAndar;

				when ConfereAndar =>
					if Bot_Emergencia = '1' then
						NextState <= EstadoEmergencia;
					elsif Sobe = '1' then
						NextState <= ElevadorSubindo;
					elsif Desce = '1' then
						NextState <= ElevadorDescendo;
					elsif Igual = '1' then
						NextState <= AbrePorta;
					else
						NextState <= ConfereAndar;
					end if;

				when ElevadorSubindo =>
					if Bot_Emergencia = '1' then
						NextState <= EstadoEmergencia;
					else
						NextState <= ConfereAndar;
						Atualizar <= '1';
						Subindo <= '1';
					end if;

				when ElevadorDescendo =>
					if Bot_Emergencia = '1' then
						NextState <= EstadoEmergencia;
					else
						NextState <= ConfereAndar;
						Atualizar <= '1';
						Descendo <= '1';
					end if;

				when AbrePorta =>
					if Bot_Emergencia = '1' then
						NextState <= EstadoEmergencia;
					else
						NextState <= ConferePeso;
						Abre <= '1';
					end if;

				when ConferePeso =>
					if Bot_Emergencia = '1' then
						NextState <= EstadoEmergencia;
					elsif Peso_Ultrapassado = '1' then
						NextState <= ConferePeso;
					else
						NextState <= FechaPorta;
					end if;

				when FechaPorta =>
					if Bot_Emergencia = '1' then
						NextState <= EstadoEmergencia;
					else
						NextState <= ConfereAndar;
						Fecha <= '1';
					end if;

				when EstadoEmergencia =>
					Emergencia <= '1';
					if Verificado = '1' then
						NextState <= ConfereAndar;
					else
						NextState <= EstadoEmergencia;
					end if;

				when others =>
					NextState <= ConfereAndar;
		end case;
	end process;
end Behavioral;