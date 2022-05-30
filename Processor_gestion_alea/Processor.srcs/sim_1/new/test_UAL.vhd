----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2022 11:05:33
-- Design Name: 
-- Module Name: test_UAL - Behavioral
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

entity test_UAL is
--  Port ( );
end test_UAL;

architecture Behavioral of test_UAL is
    COMPONENT UAL 
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
    end COMPONENT;
    
    signal A_Test : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
    signal B_Test : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
    signal N_Test : STD_LOGIC := '0';
    signal O_Test : STD_LOGIC := '0';
    signal Z_Test : STD_LOGIC := '0';
    signal C_Test : STD_LOGIC := '0';
    signal S_Test : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
    signal Ctrl_Alu_Test : STD_LOGIC_VECTOR (1 downto 0) := (others=>'0');

begin

Uut:UAL PORT MAP (
    A => A_Test,
    B => B_Test,
    N => N_Test,
    O => O_Test,
    Z => Z_Test,
    C => C_Test,
    S => S_Test,
    Ctrl_Alu => Ctrl_Alu_Test
);

-- ordre : Z/addition, soustraction/N
A_Test <= X"00",X"01" after 100ns, X"02" after 250ns, X"ff" after 400ns;
B_Test <= X"00",X"01" after 150ns, X"03" after 300ns;
Ctrl_Alu_Test <= "00", "01" after 50ns, "10" after 200ns, "11" after 350ns, "01" after 450ns; 
    

end Behavioral;
