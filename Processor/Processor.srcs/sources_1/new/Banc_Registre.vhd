----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2022 11:55:37
-- Design Name: 
-- Module Name: Banc_Registre - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned;
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Banc_Registre is
    Port ( addr_A : in STD_LOGIC_VECTOR (3 downto 0);
           addr_B : in STD_LOGIC_VECTOR (3 downto 0);
           addr_W : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC; -- spécifie si un écriture doit être réalisée : actif à 1
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC; -- actif à 0
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end Banc_Registre;

architecture Behavioral of Banc_Registre is

    type Registres is array(0 to 15) of std_logic_vector (7 downto 0);
    signal Reg : Registres := (others=> X"00");
    --signal ad_A : integer := 0;
    --signal ad_B : integer:=0;
    --signal ad_W : integer:=0;

begin

    process
        
    begin
    
    --on a quatre cas : soit on lit A et B, soit on ecrit dans @W et on lit A ou B , soit on ecrit dans @W, soit on lit A ou B -> utilisation de 1 ou 2 ressources 
    
        wait until rising_edge(CLK);
        
        --ad_A <= to_integer(unsigned(addr_A));
        --ad_B <= to_integer(unsigned(addr_B));
        --ad_W <= to_integer(unsigned(addr_W));
        
        if RST='0' then
            Reg <= (others => X"00");
        end if;
            
        if W='1' then
            -- ecriture de DATA à l'adresse @W
            
            Reg(to_integer(unsigned(addr_W)))<=DATA;
        
            
        end if;
     
    end process;

    -- lecture en parallèle de A et B à leur adresse @A et @B renvoyés dans QA et QB
    QB <= Reg(to_integer(unsigned(addr_B))) when addr_B /= addr_W or W = '0' else DATA;
    QA <= Reg(to_integer(unsigned(addr_A))) when addr_A /= addr_W or W = '0' else DATA;

end Behavioral;
