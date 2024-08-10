library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity BCD_7Seg is
    port (
        Entrada : in std_logic_vector(3 downto 0);
        Saida_1 : out std_logic_vector(6 downto 0);
        Saida_2 : out std_logic_vector(6 downto 0)
    );
end BCD_7Seg;

architecture Behavioral of BCD_7Seg is
    signal Saida_1_bit : std_logic;
    signal mod_result : std_logic_vector(3 downto 0);
begin
    -- Determine the bit for Saida_1 based on the condition
    Saida_1_bit <= '1' when unsigned(Entrada) > 9 else '0';

    -- Assign Saida_1 as "000000" concatenated with Saida_1_bit
    Saida_1 <= "000000" & Saida_1_bit;

    -- Calculate mod 10 of Entrada and convert to a 3-bit vector
    mod_result <= std_logic_vector(to_unsigned(to_integer(unsigned(Entrada)) mod 10, 4));

    -- Assign Saida_2 as "000" concatenated with the mod result
    Saida_2 <= "000" & mod_result;

end Behavioral;
