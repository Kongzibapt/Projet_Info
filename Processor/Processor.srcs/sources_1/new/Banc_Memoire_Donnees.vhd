----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 14.04.2022 11:07:02
-- Design Name: 
-- Module Name: Banc_Memoire_Donnees - Behavioral
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

entity Banc_Memoire_Donnees is
    Port ( addr : in STD_LOGIC_VECTOR (7 downto 0);
           Vin : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Vout : out STD_LOGIC_VECTOR (7 downto 0));
end Banc_Memoire_Donnees;

architecture Behavioral of Banc_Memoire_Donnees is

type Memoire is array(0 to 255) of std_logic_vector (7 downto 0);
signal Mem : Memoire := (others=> X"00");
    
begin

    process
    begin
        wait until rising_edge(CLK); 
        
        if RST='0' then
            Mem <= (others => X"00");
        end if;
                    
        if RW='1' then
            --écriture
            Mem(to_integer(unsigned(addr)))<=Vin;
            
        else 
            --lecture
            Vout<=Mem(to_integer(unsigned(addr)));
            
        end if;
        
        
    end process;
    


end Behavioral;
