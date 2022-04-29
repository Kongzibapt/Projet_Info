----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2022 10:16:50
-- Design Name: 
-- Module Name: UAL - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UAL is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0); --opérande 1
           B : in STD_LOGIC_VECTOR (7 downto 0); --opérande 2
           
           --flags 
           N : out STD_LOGIC;
           O : out STD_LOGIC;
           Z : out STD_LOGIC;
           C : out STD_LOGIC;
           
           --sortie
           S : out STD_LOGIC_VECTOR (7 downto 0);
           
           Ctrl_Alu : in STD_LOGIC_VECTOR (1 downto 0)); --code opérateur
end UAL;

architecture Behavioral of UAL is

signal result : STD_LOGIC_VECTOR (15 downto 0) :=(others=>'0');

begin

    --addition
    result <= (X"00"&A)+(X"00"&B) when Ctrl_Alu="01" else
    
            --soustraction
            (X"00"&A)-(X"00"&B) when Ctrl_Alu="10" else
    
            --multiplication
            A*B when Ctrl_Alu="11"
            ;
    --Division à ne pas faire

    C<= result(8) when Ctrl_Alu="01" else '0'; --si on a une retenue, que si addition
    O<='0' when result(15 downto 8)=X"00" else '1' when Ctrl_Alu="11" else '0'; --si les bits de poids forts sont à 0 alors on a pas d'overflow, que si multiplication
    Z<='1' when result=X"0000" else '0'; --si le resultat est nul
    N<=result(15) when Ctrl_Alu="10" else '0'; --si le bit leplus à gauche vaut 1 le nb est négatif, que pour soustraction, on est en complément à 2 donc X"02"-X"03" = X"ff"
    
    
    S<= result(7 downto 0);


end Behavioral;
