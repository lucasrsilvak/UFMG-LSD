library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Reg_Senha is
    port (
        Clock    : in  std_logic;
        Reset    : in  std_logic;
        Carregar : in  std_logic;
        Digito   : in  std_logic_vector (3 downto 0);
        Senha    : out std_logic_vector (15 downto 0)
    );
end Reg_Senha;

architecture Behavioral of Reg_Senha is
    signal sigSenha  : std_logic_vector (15 downto 0) := (others => '0');
    signal Carregado : std_logic := '0';
    signal Contador  : integer range 0 to 4 := 0;
    signal Limpar    : std_logic := '0';
begin
    process(Clock, Reset)
    begin
        if Reset = '1' then
            sigSenha <= (others => '0');
            Contador <= 0;
            Carregado <= '0';
            Limpar <= '0';
        elsif rising_edge(Clock) then
            if Carregar = '1' and Carregado = '0' then
                if Limpar = '1' then
                    sigSenha <= (others => '0');
                    Contador <= 0;
                    Limpar <= '0';
					 end if;
					 sigSenha(15 downto 12) <= sigSenha(11 downto 8);
					 sigSenha(11 downto 8)  <= sigSenha(7 downto 4);
					 sigSenha(7 downto 4)   <= sigSenha(3 downto 0);
					 sigSenha(3 downto 0)   <= Digito;

					 if Contador < 3 then
							Contador <= Contador + 1;
					 else
							Limpar <= '1';
                end if;
            end if;
            Carregado <= Carregar;
        end if;
    end process;
    Senha <= sigSenha;
end Behavioral;