----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2022 10:46:45
-- Design Name: 
-- Module Name: test_chemin_donnees - Behavioral
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

entity test_chemin_donnees is
--  Port ( );
end test_chemin_donnees;

architecture Behavioral of test_chemin_donnees is

COMPONENT Chemin_donnees
    Port (
           Vout_QA : out STD_LOGIC_VECTOR (7 downto 0);
           Vout_QB : out STD_LOGIC_VECTOR (7 downto 0);
           Vout_don : out STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC; -- actif à 0
           CLK_in : in STD_LOGIC);
end COMPONENT;

signal Vout_QA_Test : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal Vout_QB_Test : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal Vout_don_Test : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal RST_Test : STD_LOGIC := '0';
signal CLK_in_Test : STD_LOGIC := '0';


--Clock period definitions
-- Si 100 MHz
constant Clock_period : time := 10 ns;

begin

Uut : Chemin_donnees PORT MAP (
    Vout_QA => Vout_QA_Test,
    Vout_QB => Vout_QB_Test,
    Vout_don => Vout_don_Test,
    RST => RST_Test,
    CLK_in => CLK_in_Test
);

--def du clock process
    Clock_process : process
    begin
        CLK_in_Test<=not(CLK_in_Test);
        wait for Clock_period/2;
    end process;


    RST_Test <= '1', '0' after 400ns;
    

end Behavioral;
