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
constant Mem : Memoire := (x"06010744", x"05000100",
    x"00000000", x"00000000",x"00000000", x"00000000", x"01030001",
    x"00000000", x"00000000",x"00000000", x"00000000", x"02040001",
    x"00000000", x"00000000",x"00000000", x"00000000",x"00000000", x"03050401",
    x"00000000", x"00000000",x"00000000", x"00000000",x"00000000", x"08080500",
    x"00000000", x"00000000",x"00000000", x"00000000",x"00000000", x"07060800",
    others=> X"00000000");

begin
-- pour tester on rempli avec des instructions
    --AFC dans R1 on met 07
--    Mem(0) <= 06010744;
--    --COP dans R0 on met la valeur de R1 donc 07
--    Mem(1) <= 05000100;
--    --ADD dans R3 on met R1+R0 donc 14
--    Mem(2) <= 01030001;
--    --MUL dans R4 on met R1*R0 donc 49 --31dans registre
--    Mem(3) <= x"02040001";
--    --DIV on fait pas ?
--    Mem(4) <= x"00000000";
--    --SOU dans R5 on met R4-R1 donc 42 --2a dans registre
--    Mem(5) <= x"03050401";
--    --LOAD dans R6 on load l'adresse 08
--    Mem(6) <= x"07060800";
--    --STORE l'adresse 08 on store la valeur de R5
--    Mem(7) <= x"08080500";
--    Mem(8) <= x"00000000";

--a la fin on a 07 07 00 0e 31 2a 2a
    
    process
    begin
        wait until rising_edge(CLK); 
                
        --lecture
        Vout<=Mem(to_integer(unsigned(addr)));
       
    end process;
    

end Behavioral;
