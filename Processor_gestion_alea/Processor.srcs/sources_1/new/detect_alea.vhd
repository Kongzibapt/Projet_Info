----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.05.2022 15:11:52
-- Design Name: 
-- Module Name: detect_alea - Behavioral
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
use IEEE.std_logic_unsigned.ALL;
use IEEE.numeric_std.all;
use IEEE.std_logic_arith.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity detect_alea is
    Port ( 
             A_LI_DI_alea : in STD_LOGIC_VECTOR (7 downto 0) ;
             OP_LI_DI_alea : in STD_LOGIC_VECTOR (7 downto 0) ;
             B_LI_DI_alea : in STD_LOGIC_VECTOR (7 downto 0) ;
             C_LI_DI_alea : in STD_LOGIC_VECTOR (7 downto 0) ;
            
             A_DI_EX_alea : in STD_LOGIC_VECTOR (7 downto 0) ;
             OP_DI_EX_alea : in STD_LOGIC_VECTOR (7 downto 0);
             B_DI_EX_alea : in STD_LOGIC_VECTOR (7 downto 0) ;
             C_DI_EX_alea : in STD_LOGIC_VECTOR (7 downto 0) ;
             
             alea_out : out STD_LOGIC; -- 1 si aléa 0 sinon
             RST : in STD_LOGIC; -- actif à 0
             CLK : in STD_LOGIC
           );
end detect_alea;



architecture Behavioral of detect_alea is

signal cnt_nb_alea : STD_LOGIC_VECTOR (2 downto 0) := "100";

begin

    alea_out<='1' when  (cnt_nb_alea /= "000" and 
         -- alea 1 : on fait une copie d'un registre dans un autre alors que l'on a pas fini d'affecter une valeur au registre à copier
           ((OP_LI_DI_alea=x"05" and (OP_DI_EX_alea=x"06" or OP_DI_EX_alea=x"01" or OP_DI_EX_alea=x"02" or OP_DI_EX_alea=x"03") and A_DI_EX_alea=B_LI_DI_alea) or
                                
           -- alea 2 : on fait une copie/affectation/opération et on a une opération qui arrive qui va utiliser le registre que l'on est en train de modifier avec la copie/affectation/opération
           ((OP_LI_DI_alea=x"01" or OP_LI_DI_alea=x"02" or OP_LI_DI_alea=x"03") and (OP_DI_EX_alea=x"05" or OP_DI_EX_alea=x"06" or OP_DI_EX_alea=x"01" or OP_DI_EX_alea=x"02" or OP_DI_EX_alea=x"03") and (A_DI_EX_alea=B_LI_DI_alea or A_DI_EX_alea=C_LI_DI_alea)) or
        
           -- alea 3 : on modifiait un registre avec une instruction et on a store qui arrive et qui veut utiliser le registre en cours de modification
             ((OP_DI_EX_alea=x"01" or OP_DI_EX_alea=x"02" or OP_DI_EX_alea=x"03" or OP_DI_EX_alea=x"05" or OP_DI_EX_alea=x"06" or OP_DI_EX_alea=x"07") and OP_LI_DI_alea=x"08" and A_DI_EX_alea=B_LI_DI_alea) or
             
            --alea 4 : on fait un load et on a une instruction qui arrive utilisant le registre en cours de modification du load 
            ((OP_LI_DI_alea=x"01" or OP_LI_DI_alea=x"02" or OP_LI_DI_alea=x"03" or OP_LI_DI_alea=x"05" or OP_LI_DI_alea=x"06" or OP_LI_DI_alea=x"08") and OP_DI_EX_alea=x"07" and (A_DI_EX_alea=B_LI_DI_alea or A_DI_EX_alea=C_LI_DI_alea)) or
           
           --alea 5 : on fait load alors que l'on a pas fini de store à l'adresse de la mémoire 
           (OP_LI_DI_alea=x"07" and OP_DI_EX_alea=x"08" and A_DI_EX_alea=B_LI_DI_alea) or 
        
           --suivi d'un aléa, on garde aléa à 1 tant que l'on injecte des NOP, on considère ici que l'on a pas d'instruction avec OP=x"00" donc cela ne peut être qu'un NOP si on est pas en train de faire RESET
            ((OP_DI_EX_alea=x"00" and OP_LI_DI_alea=x"00") and RST='1'))) 
    else '0';


    process 
    begin
    
        wait until rising_edge(CLK); 
    
    if (cnt_nb_alea /= "000" and 
         -- alea 1 : on fait une copie d'un registre dans un autre alors que l'on a pas fini d'affecter une valeur au registre à copier
        ((OP_LI_DI_alea=x"05" and (OP_DI_EX_alea=x"06" or OP_DI_EX_alea=x"01" or OP_DI_EX_alea=x"02" or OP_DI_EX_alea=x"03") and A_DI_EX_alea=B_LI_DI_alea) or
                             
        -- alea 2 : on fait une copie/affectation/opération et on a une opération qui arrive qui va utiliser le registre que l'on est en train de modifier avec la copie/affectation/opération
        ((OP_LI_DI_alea=x"01" or OP_LI_DI_alea=x"02" or OP_LI_DI_alea=x"03") and (OP_DI_EX_alea=x"05" or OP_DI_EX_alea=x"06" or OP_DI_EX_alea=x"01" or OP_DI_EX_alea=x"02" or OP_DI_EX_alea=x"03") and (A_DI_EX_alea=B_LI_DI_alea or A_DI_EX_alea=C_LI_DI_alea)) or

        -- alea 3 : on modifiait un registre avec une instruction et on a store qui arrive et qui veut utiliser le registre en cours de modification
          ((OP_DI_EX_alea=x"01" or OP_DI_EX_alea=x"02" or OP_DI_EX_alea=x"03" or OP_DI_EX_alea=x"05" or OP_DI_EX_alea=x"06" or OP_DI_EX_alea=x"07") and OP_LI_DI_alea=x"08" and A_DI_EX_alea=B_LI_DI_alea) or
          
         --alea 4 : on fait un load et on a une instruction qui arrive utilisant le registre en cours de modification du load 
         ((OP_LI_DI_alea=x"01" or OP_LI_DI_alea=x"02" or OP_LI_DI_alea=x"03" or OP_LI_DI_alea=x"05" or OP_LI_DI_alea=x"06" or OP_LI_DI_alea=x"08") and OP_DI_EX_alea=x"07" and (A_DI_EX_alea=B_LI_DI_alea or A_DI_EX_alea=C_LI_DI_alea)) or
        
        --alea 5 : on fait load alors que l'on a pas fini de store à l'adresse de la mémoire 
        (OP_LI_DI_alea=x"07" and OP_DI_EX_alea=x"08" and A_DI_EX_alea=B_LI_DI_alea) or 

        --suivi d'un aléa, on garde aléa à 1 tant que l'on injecte des NOP, on considère ici que l'on a pas d'instruction avec OP=x"00" donc cela ne peut être qu'un NOP si on est pas en train de faire RESET
         ((OP_DI_EX_alea=x"00" and OP_LI_DI_alea=x"00") and RST='1'))) then

        
        cnt_nb_alea<=cnt_nb_alea-1;
    else 
        cnt_nb_alea<="100";
    end if;
    
    end process;
    

end Behavioral;
