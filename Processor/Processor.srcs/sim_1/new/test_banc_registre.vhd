----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2022 10:13:42
-- Design Name: 
-- Module Name: test_banc_registre - Behavioral
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

entity test_banc_registre is
--  Port ( );
end test_banc_registre;

architecture Behavioral of test_banc_registre is
COMPONENT Banc_Registre
    Port ( addr_A : in STD_LOGIC_VECTOR (3 downto 0);
           addr_B : in STD_LOGIC_VECTOR (3 downto 0);
           addr_W : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC; -- spécifie si un écriture doit être réalisée : actif à 1
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC; -- actif à 0
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end COMPONENT;

signal addr_A_Test : STD_LOGIC_VECTOR (3 downto 0) := (others=>'0');
signal addr_B_Test : STD_LOGIC_VECTOR (3 downto 0) := (others=>'0');
signal addr_W_Test : STD_LOGIC_VECTOR (3 downto 0) := (others=>'0');
signal W_Test : STD_LOGIC := '0'; -- spécifie si un écriture doit être réalisée : actif à 1
signal DATA_Test : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal RST_Test : STD_LOGIC  := '0'; -- actif à 0
signal CLK_Test : STD_LOGIC  := '0';
signal QA_Test : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal QB_Test : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');


--Clock period definitions
-- Si 100 MHz
constant Clock_period : time := 10 ns;

begin

Uut : Banc_Registre PORT MAP (
    addr_A => addr_A_Test,
    addr_B => addr_B_Test,
    addr_W => addr_W_Test,
    W => W_Test,
    DATA => DATA_Test,
    RST => RST_Test,
    CLK => CLK_Test,
    QA => QA_Test,
    QB => QB_Test
);

--def du clock process
    Clock_process : process
    begin
        CLK_Test<=not(CLK_Test);
        wait for Clock_period/2;
    end process;

    RST_Test <= '1', '0' after 400ns;
    addr_A_Test <= X"1" after 100ns, X"3" after 220ns, X"2" after 300ns;
    addr_B_Test <= X"e" after 100ns;
    addr_W_Test <= X"2" after 170ns;
    DATA_Test <= X"03" after 180ns;
    W_Test <= '1' after 200ns, '0' after 250ns;

end Behavioral;
