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
           RST_uP : in STD_LOGIC; -- actif à 0
           CLK_in : in STD_LOGIC);
end Chemin_donnees;

architecture Behavioral of Chemin_donnees is


COMPONENT detect_alea is
    Port ( 
             A_LI_DI_alea : in STD_LOGIC_VECTOR (7 downto 0) ;
             OP_LI_DI_alea : in STD_LOGIC_VECTOR (7 downto 0) ;
             B_LI_DI_alea : in STD_LOGIC_VECTOR (7 downto 0) ;
             C_LI_DI_alea : in STD_LOGIC_VECTOR (7 downto 0) ;
             A_DI_EX_alea : in STD_LOGIC_VECTOR (7 downto 0) ;
             OP_DI_EX_alea : in STD_LOGIC_VECTOR (7 downto 0);
             B_DI_EX_alea : in STD_LOGIC_VECTOR (7 downto 0) ;
             C_DI_EX_alea : in STD_LOGIC_VECTOR (7 downto 0) ;
             alea_out : out STD_LOGIC; -- 1 si aléa 0 sinon
            RST : in STD_LOGIC; -- actif à 0
            CLK : in STD_LOGIC
           );
end COMPONENT;

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
signal RW_aux_don : STD_LOGIC;
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

signal A_LI_DI_aux : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal OP_LI_DI_aux : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal B_LI_DI_aux : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');
signal C_LI_DI_aux : STD_LOGIC_VECTOR (7 downto 0) := (others=>'0');

signal alea : STD_LOGIC;
signal cnt_alea : STD_LOGIC_VECTOR (1 downto 0) := "10";

begin

Uut_detect_alea : detect_alea PORT MAP (
    A_LI_DI_alea=>A_LI_DI,
     OP_LI_DI_alea=>OP_LI_DI,
     B_LI_DI_alea=>B_LI_DI,
     C_LI_DI_alea=>C_LI_DI,
    
     A_DI_EX_alea=>A_DI_EX,
     OP_DI_EX_alea=>OP_DI_EX,
     B_DI_EX_alea=>B_DI_EX,
     C_DI_EX_alea=>C_DI_EX,
    alea_out => alea,
    RST => RST_uP,
    CLK => CLK_in
);



Uut_inst : Banc_Memoire_Instructions PORT MAP (
    addr => IP,
    CLK => CLK_in,
    Vout => Vout_aux_inst
);

Uut_don : Banc_Memoire_Donnees PORT MAP (
    addr => addr_aux_don,
    Vin => B_EX_MEM,
    RW => RW_aux_don,
    RST => RST_uP,
    CLK => CLK_in,
    Vout => Vout_aux_don
);

Uut_reg : Banc_Registre PORT MAP (
    addr_A => addr_A_aux_reg,
    addr_B => addr_B_aux_reg,
    addr_W => addr_W_aux_reg,
    W => W_aux_reg,
    DATA => DATA_aux_reg,
    RST => RST_uP,
    CLK => CLK_in,
    QA => QA_aux_reg,
    QB => QB_aux_reg
);

Uut_ual : UAL PORT MAP (
    A => B_DI_EX,
    B => C_DI_EX,
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
    if RST_uP= '0' then
        IP <= x"00";
    elsif cnt_alea="00" then
        --quand on a finit d'injecter les NOP on met à jour IP pour le replacer au bon endroit dans la mémoire d'instruction
        IP <= IP - X"04";
    else
    
        IP <= IP + X"01";
    end if;
end process;
     --fils = asynchrone
     addr_A_aux_reg <= B_LI_DI(3 downto 0);
     addr_B_aux_reg <= C_LI_DI(3 downto 0);
     Ctrl_Alu_aux_ual <= OP_DI_EX(1 downto 0);
     addr_W_aux_reg <= A_MEM_RE (3 downto 0);
     DATA_aux_reg <= B_MEM_RE;
     W_aux_reg <= '1' when (OP_MEM_RE = X"06") or (OP_MEM_RE = X"05")  or (OP_MEM_RE = X"07") or (OP_MEM_RE = X"01") or  (OP_MEM_RE = X"02") or (OP_MEM_RE = X"03")  else '0';
     RW_aux_don <= '0' when OP_EX_MEM = X"08" else '1';
     addr_aux_don <= A_EX_MEM when OP_EX_MEM = X"08" else B_EX_MEM;
             
process

    begin
    
    wait until rising_edge(CLK_in);
    
         C_LI_DI <= Vout_aux_inst(7 downto 0);
         B_LI_DI <= Vout_aux_inst(15 downto 8);
         OP_LI_DI <= Vout_aux_inst(31 downto 24);
         A_LI_DI <= Vout_aux_inst(23 downto 16); 

         if (OP_LI_DI = X"06") or (OP_LI_DI = X"07") then
            B_DI_EX <= B_LI_DI; --car on écrit dans le registre
         elsif (OP_LI_DI = X"05") or (OP_LI_DI = X"01") or  (OP_LI_DI = X"02") or (OP_LI_DI = X"03") or (OP_LI_DI = X"08") then
            B_DI_EX <= QA_aux_reg;--car on doit lire un registre donc on sort QA
            
         end if;
         
         A_EX_MEM <=  A_DI_EX;
         OP_EX_MEM <=  OP_DI_EX;
         A_MEM_RE <=  A_EX_MEM;
         OP_MEM_RE <=  OP_EX_MEM;
         Vout_QA <= QA_aux_reg;
         Vout_QB <= QB_aux_reg;
         C_DI_EX <= QB_aux_reg;
         OP_DI_EX<=OP_LI_DI;
          A_DI_EX <=  A_LI_DI;

         if (OP_DI_EX = X"01") or  (OP_DI_EX = X"02") or (OP_DI_EX = X"03") then
         -- si addition, multiplication ou soustraction alors on fait le calcul et propage le résultat
             B_EX_MEM <= S_aux_ual;
          else 
          --sinon on propage l'entrée de ual 
             B_EX_MEM <= B_DI_EX;
          end if;

        if OP_EX_MEM = X"07" then
            B_MEM_RE <= Vout_aux_don;
        else
            B_MEM_RE <= B_EX_MEM;
        end if;
        
        --gestion des aleas
        if alea='1'then
        
            if cnt_alea="11" then
            
                -- on détecte un aléa donc on commence à injecter notre premier NOP et on sauvegarde l'instruction bloquée
                OP_LI_DI_aux <= OP_LI_DI;
                A_LI_DI_aux <= A_LI_DI;
                B_LI_DI_aux <= B_LI_DI;
                C_LI_DI_aux <= C_LI_DI;
       
                OP_LI_DI<=x"00";
                A_LI_DI<=x"00";
                B_LI_DI<=x"00";
                C_LI_DI<=x"00";
                
                OP_DI_EX<=x"00";
                A_DI_EX<=x"00";
                B_DI_EX<=x"00";
                C_DI_EX<=x"00";
                
                cnt_alea<=cnt_alea-1;
         
            elsif cnt_alea="00" then 
            
                -- on arrête d'injecter les NOP on recharge l'ancienne valeur
                OP_LI_DI <= OP_LI_DI_aux;
                A_LI_DI <= A_LI_DI_aux;
                B_LI_DI <= B_LI_DI_aux;
                C_LI_DI <= C_LI_DI_aux;
                cnt_alea<="11";
                
            else 
                --on continue d'injecter des NOP
                OP_LI_DI<=x"00";
                A_LI_DI<=x"00";
                B_LI_DI<=x"00";
                C_LI_DI<=x"00";
                
                OP_DI_EX<=x"00";
                A_DI_EX<=x"00";
                B_DI_EX<=x"00";
                C_DI_EX<=x"00";
                cnt_alea<=cnt_alea-1;
            end if;
        
        end if;

    end process;



end Behavioral;
