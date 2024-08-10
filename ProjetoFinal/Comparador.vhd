library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Comparador is
	generic (
		W : natural := 16
	);
	port (
		A      : in  std_logic_vector(W-1 downto 0); 
		B      : in  std_logic_vector(W-1 downto 0);  
		Enable : in  std_logic;                       
		Maior  : out std_logic;                        
		Menor  : out std_logic;                        
		Igual  : out std_logic                          
    );  
end Comparador;

architecture Behavioral of Comparador is
begin
	process (A, B, Enable)
	begin
		if Enable = '1' then
			if unsigned(A) > unsigned(B) then
				Maior <= '1';
			else
				Maior <= '0';
			end if;
            
			if unsigned(A) < unsigned(B) then
				Menor <= '1';
			else
				Menor <= '0';
			end if;
            
			if unsigned(A) = unsigned(B) then
				Igual <= '1';
			else
				Igual <= '0';
			end if;
		else
			Maior <= '0';
			Menor <= '0';
			Igual <= '0';
		end if;
	end process;
end Behavioral;