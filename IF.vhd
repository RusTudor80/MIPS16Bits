----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.03.2020 21:11:17
-- Design Name: 
-- Module Name: IF - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity IFF is
 Port ( jump: in std_logic;
        jump_adress :in std_logic_vector(15 downto 0);
        pcsrc:in std_logic;
        branch_adress : in std_logic_vector(15 downto 0);
        en: in std_logic;
        rst: in std_logic;
        clk:in std_logic;
        instruction: out std_logic_vector(15 downto 0);
        pcout: out std_logic_vector(15 downto 0));
        
end IFF;

architecture Behavioral of IFF is
signal pc:STD_LOGIC_VECTOR(15 downto 0);
signal d :std_logic_vector(15 downto 0);
signal q :std_logic_vector(15 downto 0);
signal mux_out1 :std_logic_vector(15 downto 0);
signal mux_out2 :std_logic_vector(15 downto 0);

type rom_array is array (0 to 15) of std_logic_vector (15 downto 0);

signal rom: rom_array :=(
B"000_010_011_001_0_000", --ADD $1,$2,$3       --x"0990" --in reg1 punem suma reg2+reg3
B"000_100_010_011_0_001", --SUB $3,$4,$2     --x"1131" --in reg 3 punem dif reg4 -reg2
B"000_000_010_101_1_010", --SRL $5,$2,1      --x"015A" -- in reg5 punem reg2 shiftat la dreapta
B"000_000_010_101_1_011", --SLL $5,$2,1      --x"015B" -- in reg5 punem reg2 shiftat la stanga 
B"000_001_011_101_0_100", --AND $5,$1,$3     --x"05D4" -- in reg5 punem reg1 and reg3
B"000_001_011_110_0_101", --OR  $5,$1,$3     --x"05E5" -- in reg5 punem reg1 or reg3
B"001_010_011_0000111",   --ADDi $3,$2,7     --x"2987" -- in reg3 adunam reg2 si 7
B"010_001_111_0000000",   --LW $7,offset($1) --x"4780" -- in reg7 incarcam valoarea de offset 0 din reg1
B"011_011_111_0000000",   --SW $7,offset($3) --x"6780" -- la adresa cu offsetul 0 din reg3 adaugam valoare din reg7
B"100_101_100_0000100",   --ANDi $4,$5,4     --x"9604" -- in reg4 adaugam un and intre reg5 si valoarea 4
B"101_110_101_0000011",   --ORi  $5,$6,3     --x"BA83" -- in reg5 adauga un or intre reg6 si valoarea 3
B"110_001_001_0000001",   --BEQ $1,$1,1      --x"c481" -- egalitatea este satisfacuta deci se face branch la adresa de offset
B"111_0000000000000",     --JMP 0            --x"E003" -- jump la adresa 0
others=>x"0000");

begin
process(clk)
begin 
    if clk='1' and clk'event then
        if rst='1' then
            q<= x"0000";
         elsif en='1'then
                q<=d;
             end if;
         end if;
     end process;
    
     
     mux_out1<= branch_adress when pcsrc='1' else pc;
     mux_out2<= jump_adress when jump ='1' else mux_out1;
      
     instruction<=rom(conv_integer(q));
     
     pc<=q+1;
     
     pcout<=pc;
    
     d<=mux_out2;


end Behavioral;
