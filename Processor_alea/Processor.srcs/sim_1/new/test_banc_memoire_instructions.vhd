----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2022 11:50:05
-- Design Name: 
-- Module Name: test_banc_memoire_instructions - Behavioral
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

entity test_banc_memoire_instructions is
--  Port ( );
end test_banc_memoire_instructions;

architecture Behavioral of test_banc_memoire_instructions is

COMPONENT Banc_Memoire_Instructions is
    Port ( addr : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           Vout : out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

signal addr_Test : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal CLK_Test : STD_LOGIC := '0';
signal Vout_Test : STD_LOGIC_VECTOR (31 downto 0) := (others =>'0');


--Clock period definitions
-- Si 100 MHz
constant Clock_period : time := 10 ns;

begin

Uut : Banc_Memoire_Instructions PORT MAP (
    addr => addr_Test,
    CLK => CLK_Test,
    Vout => Vout_Test
);

--def du clock process
    Clock_process : process
    begin
        CLK_Test<=not(CLK_Test);
        wait for Clock_period/2;
    end process;
    
    addr_Test <= X"00", X"01" after 200ns;
    
end Behavioral;
