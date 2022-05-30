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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity detect_alea is
    Port ( 
             A_LI_DI : in STD_LOGIC_VECTOR (7 downto 0) ;
             OP_LI_DI : in STD_LOGIC_VECTOR (7 downto 0) ;
             B_LI_DI : in STD_LOGIC_VECTOR (7 downto 0) ;
             C_LI_DI : in STD_LOGIC_VECTOR (7 downto 0) ;
            
             A_DI_EX : in STD_LOGIC_VECTOR (7 downto 0) ;
             OP_DI_EX : in STD_LOGIC_VECTOR (7 downto 0);
             B_DI_EX : in STD_LOGIC_VECTOR (7 downto 0) ;
             C_DI_EX : in STD_LOGIC_VECTOR (7 downto 0) ;
            
--             A_EX_MEM : in STD_LOGIC_VECTOR (7 downto 0) ;
--             OP_EX_MEM : in STD_LOGIC_VECTOR (7 downto 0) ;
--             B_EX_MEM : in STD_LOGIC_VECTOR (7 downto 0) ;
            
--             A_MEM_RE : in STD_LOGIC_VECTOR (7 downto 0) ;
--             OP_MEM_RE : in STD_LOGIC_VECTOR (7 downto 0) ;
--             B_MEM_RE : in STD_LOGIC_VECTOR (7 downto 0) ;

             alea_out : out STD_LOGIC; -- 1 si aléa 0 sinon
            RST : in STD_LOGIC; -- actif à 0
            CLK : in STD_LOGIC
           );
end detect_alea;

architecture Behavioral of detect_alea is

begin

    --exemple de l'énoncé
    alea_out<='1' when (OP_LI_DI=x"05" and OP_DI_EX=x"06" and A_DI_EX=B_LI_DI)
    
        else '0';


end Behavioral;
