----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2022 11:41:58
-- Design Name: 
-- Module Name: Banc_Memoire_Instructions - Behavioral
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

entity Banc_Memoire_Instructions is
    Port ( addr : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           Vout : out STD_LOGIC_VECTOR (31 downto 0));
end Banc_Memoire_Instructions;

architecture Behavioral of Banc_Memoire_Instructions is

type Memoire is array(0 to 255) of std_logic_vector (31 downto 0);
constant Mem : Memoire := (x"06010744", x"06070900", x"05000100",x"01030001", x"02040001", x"03050401", x"08080500",x"07060800",
    others=> X"00000000");

begin
-- pour tester on rempli avec des instructions
-- 06010744 AFC dans R1 on met 07 
-- 05000100 COP dans R0 on met la valeur de R1 donc 07
-- 01030001 ADD dans R3 on met R1+R0 donc 14 soit 0e
-- 02040001 MUL dans R4 on met R1*R0 donc 49 soit 31
-- 03050401 SOU dans R5 on met R4-R1 donc 42 soit 2a
-- 08080500 STORE l'adresse 08 on store la valeur de R5
-- 07060800 LOAD dans R6 on load l'adresse 08
--a la fin avec ce jeu d'instruction on a on a 07 07 00 0e 31 2a 2a

--on en a rajoute d'autres ensuite pour tester les aléas
    
    process
    begin
        wait until rising_edge(CLK);          
        --lecture
        Vout<=Mem(to_integer(unsigned(addr)));
       
    end process;
    

end Behavioral;
