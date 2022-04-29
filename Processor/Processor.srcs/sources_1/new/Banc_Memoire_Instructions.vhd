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
signal Mem : Memoire := (others=> X"00000000");

begin
-- pour tester on rempli avec des instructions
    Mem(0) <= x"01060744";
    Mem(1) <= x"00000000";
    Mem(2) <= x"00000000";
    Mem(3) <= x"00000000";
    Mem(4) <= x"00000000";
    Mem(5) <= x"00000000";
    Mem(6) <= x"00000000";
    Mem(7) <= x"00000000";
    Mem(8) <= x"55050188";
    
    process
    begin
        wait until rising_edge(CLK); 
                
        --lecture
        Vout<=Mem(to_integer(unsigned(addr)));
       
    end process;
    

end Behavioral;
