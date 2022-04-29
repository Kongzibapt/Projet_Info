----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2022 11:29:33
-- Design Name: 
-- Module Name: test_banc_memoire_donnees - Behavioral
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

entity test_banc_memoire_donnees is
--  Port ( );
end test_banc_memoire_donnees;

architecture Behavioral of test_banc_memoire_donnees is

COMPONENT Banc_Memoire_Donnees
    Port ( addr : in STD_LOGIC_VECTOR (7 downto 0);
           Vin : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Vout : out STD_LOGIC_VECTOR (7 downto 0));
end COMPONENT;

signal addr_Test : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal Vin_Test : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal RW_Test : STD_LOGIC :='0';
signal RST_Test : STD_LOGIC := '0';
signal CLK_Test : STD_LOGIC := '0';
signal Vout_Test : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');


--Clock period definitions
-- Si 100 MHz
constant Clock_period : time := 10 ns;

begin

Uut : Banc_Memoire_Donnees PORT MAP (
    addr => addr_Test,
    Vin => Vin_Test,
    RW => RW_Test,
    RST => RST_Test,
    CLK => CLK_Test,
    Vout => Vout_Test
);

--def du clock process
    Clock_process : process
    begin
        CLK_Test<=not(CLK_Test);
        wait for Clock_period/2;
    end process;
    
    RST_Test <= '1', '0' after 400ns;
    addr_Test <= X"01";
    RW_Test <= '1' after 100ns, '0' after 200ns;
    Vin_Test <= X"0F";
    

end Behavioral;
