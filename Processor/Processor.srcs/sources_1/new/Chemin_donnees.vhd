----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.04.2022 09:50:06
-- Design Name: 
-- Module Name: Chemin_donnees - Behavioral
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

entity Chemin_donnees is
    Port (
           Vout_QA : out STD_LOGIC_VECTOR (7 downto 0);
           Vout_QB : out STD_LOGIC_VECTOR (7 downto 0);
           Vout_don : out STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC; -- actif à 0
           CLK_in : in STD_LOGIC);
end Chemin_donnees;

architecture Behavioral of Chemin_donnees is

COMPONENT Banc_Memoire_Instructions is
    Port ( addr : in STD_LOGIC_VECTOR (7 downto 0);
           CLK : in STD_LOGIC;
           Vout : out STD_LOGIC_VECTOR (31 downto 0));
end COMPONENT;

COMPONENT Banc_Memoire_Donnees
    Port ( addr : in STD_LOGIC_VECTOR (7 downto 0);
           Vin : in STD_LOGIC_VECTOR (7 downto 0);
           RW : in STD_LOGIC;
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           Vout : out STD_LOGIC_VECTOR (7 downto 0));
end COMPONENT;

COMPONENT Banc_Registre
    Port ( addr_A : in STD_LOGIC_VECTOR (3 downto 0);
           addr_B : in STD_LOGIC_VECTOR (3 downto 0);
           addr_W : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC; -- spécifie si un écriture doit être réalisée : actif à 1
           DATA : in STD_LOGIC_VECTOR (7 downto 0);
           RST : in STD_LOGIC;
           CLK : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end COMPONENT;

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
    
signal A_aux_ual : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal B_aux_ual : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal N_aux_ual : STD_LOGIC := '0';
signal O_aux_ual : STD_LOGIC := '0';
signal Z_aux_ual : STD_LOGIC := '0';
signal C_aux_ual : STD_LOGIC := '0';
signal S_aux_ual : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal Ctrl_Alu_aux_ual : STD_LOGIC_VECTOR (1 downto 0) := (others=>'0');

signal addr_aux_inst : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal CLK_aux_inst : STD_LOGIC := '0';
signal Vout_aux_inst : STD_LOGIC_VECTOR (31 downto 0) := (others =>'0');

signal addr_aux_don : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal Vin_aux_don : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal RW_aux_don : STD_LOGIC :='0';
signal RST_aux_don : STD_LOGIC := '0';
signal CLK_aux_don : STD_LOGIC := '0';
signal Vout_aux_don : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');

signal addr_A_aux_reg : STD_LOGIC_VECTOR (3 downto 0) := (others=>'0');
signal addr_B_aux_reg : STD_LOGIC_VECTOR (3 downto 0) := (others=>'0');
signal addr_W_aux_reg : STD_LOGIC_VECTOR (3 downto 0) := (others=>'0');
signal W_aux_reg : STD_LOGIC := '0'; -- spécifie si un écriture doit être réalisée : actif à 1
signal DATA_aux_reg : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal RST_aux_reg : STD_LOGIC  := '0'; -- actif à 0
signal CLK_aux_reg : STD_LOGIC  := '0';
signal QA_aux_reg : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal QB_aux_reg : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');

signal A_LI_DI : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal OP_LI_DI : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal B_LI_DI : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal C_LI_DI : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');

signal A_DI_EX : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal OP_DI_EX : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal B_DI_EX : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal C_DI_EX : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');

signal A_EX_MEM : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal OP_EX_MEM : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal B_EX_MEM : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');

signal A_MEM_RE : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal OP_MEM_RE : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal B_MEM_RE : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');

signal IP : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');

begin

Uut_inst : Banc_Memoire_Instructions PORT MAP (
    addr => IP,
    CLK => CLK_in,
    Vout => Vout_aux_inst
);

Uut_don : Banc_Memoire_Donnees PORT MAP (
    addr => addr_aux_don,
    Vin => Vin_aux_don,
    RW => RW_aux_don,
    RST => RST_aux_don,
    CLK => CLK_in,
    Vout => Vout_aux_don
);

Uut_reg : Banc_Registre PORT MAP (
    addr_A => addr_A_aux_reg,
    addr_B => addr_B_aux_reg,
    addr_W => addr_W_aux_reg,
    W => W_aux_reg,
    DATA => DATA_aux_reg,
    RST => RST_aux_reg,
    CLK => CLK_in,
    QA => QA_aux_reg,
    QB => QB_aux_reg
);

Uut_ual : UAL PORT MAP (
    A => A_aux_ual,
    B => B_aux_ual,
    N => N_aux_ual,
    O => O_aux_ual,
    Z => Z_aux_ual,
    C => C_aux_ual,
    S => S_aux_ual,
    Ctrl_Alu => Ctrl_Alu_aux_ual
);

process
begin
    wait until rising_edge(CLK_in);
    if RST = '0' then
        IP <= x"00";
    else
        IP <= IP + X"01";
    end if;
end process;

process

    begin
    
    wait until rising_edge(CLK_in);
    
         C_LI_DI <= Vout_aux_inst(7 downto 0);
         B_LI_DI <= Vout_aux_inst(15 downto 8);
         OP_LI_DI <= Vout_aux_inst(23 downto 16);
         A_LI_DI <= Vout_aux_inst(31 downto 24); 
    
         A_DI_EX <=  A_LI_DI;
         OP_DI_EX <=  OP_LI_DI;
         
         if OP_LI_DI = X"06" then
            B_DI_EX <= B_LI_DI;
         elsif OP_LI_DI = X"05" then
            B_DI_EX <= QA_aux_reg;
         end if;
         
         addr_A_aux_reg <= B_LI_DI(3 downto 0);
         
         A_EX_MEM <=  A_DI_EX;
         OP_EX_MEM <=  OP_DI_EX;
         B_EX_MEM <=  B_DI_EX;
         
         A_MEM_RE <=  A_EX_MEM;
         OP_MEM_RE <=  OP_EX_MEM;
         B_MEM_RE <=  B_EX_MEM;
         
         addr_W_aux_reg <= A_MEM_RE (3 downto 0);
         DATA_aux_reg <= B_MEM_RE;
         
         if OP_MEM_RE = X"06" then
            W_aux_reg <= '1';
         else 
            W_aux_reg <= '0';
         end if;
         
         Vout_QA <= QA_aux_reg;
         Vout_QB <= QB_aux_reg;
         Vout_don <= Vout_aux_don;
    
    end process;


end Behavioral;
