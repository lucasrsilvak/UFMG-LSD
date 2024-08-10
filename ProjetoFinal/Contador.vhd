library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Contador is
	port (
		Clock   : in  std_logic;                 
		Reset   : in  std_logic;                 
		Control : in  std_logic;                 
		Start   : in  std_logic_vector(3 downto 0);  
		Enable  : in  std_logic;                 
		Count   : out std_logic_vector(3 downto 0)
	);
end Contador;

architecture Behavioral of Contador is
	signal Incrementa : boolean := true; 
	signal Conta 		:	std_logic_vector(3 downto 0) := (others => '0');
	signal W	  		 	: integer := 15;
	
begin
	process (Clock, Reset)
	begin
		if Reset = '1' then
			Conta <= Start;
			Incrementa <= Control = '1'; 
		elsif rising_edge(Clock) then
			if Enable = '1' then
				if Control = '1' then 
					if Incrementa then
						if to_integer(unsigned(Conta)) < W then
							Conta <= std_logic_vector(unsigned(Conta) + 1); 
						else
							Incrementa <= false;
							Conta <= std_logic_vector(unsigned(Conta) - 1); 
						end if;
					else
						if to_integer(unsigned(Conta)) > 0 then
							Conta <= std_logic_vector(unsigned(Conta) - 1);
						else
							Incrementa <= true;
							Conta <= std_logic_vector(unsigned(Conta) + 1); 
						end if;
					end if;
				elsif Control = '0' then
					if Incrementa then
						if to_integer(unsigned(Conta)) > 0 then
							Conta <= std_logic_vector(unsigned(Conta) - 1);
						else
							Incrementa <= false;
							Conta <= std_logic_vector(unsigned(Conta) + 1); 
						end if;
					else
						if to_integer(unsigned(Conta)) < W then
							Conta <= std_logic_vector(unsigned(Conta) + 1); 
						else
							Incrementa <= true; 
							Conta <= std_logic_vector(unsigned(Conta) - 1); 
						end if;
					end if;
				end if;
			end if;
		end if;
	end process;
    
	Count <= Conta;
end Behavioral;