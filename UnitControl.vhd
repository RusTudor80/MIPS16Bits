----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.04.2020 00:25:27
-- Design Name: 
-- Module Name: UnitControl - Behavioral
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

entity UnitControl is
  Port (
          opcode:in std_logic_vector(2 downto 0);
          regdst: out std_logic;
          extop:out std_logic;
          alusrc:out std_logic;
          branch:out std_logic;
          jump: out std_logic;
          memwrite:out std_logic;
          memtoreg:out std_logic;
          regwrite:out std_logic;
          alu_op:out std_logic_vector(2 downto 0));
          
          
end UnitControl;

architecture Behavioral of UnitControl is

begin
    process(opcode)
       begin
             case opcode is
                when "000" => -- instructiuni de tip R
                    regdst<='1';
                    extop<='0';
                    alusrc<='0';
                    branch<='0';
                    jump<='0';
                    memwrite<='0';
                    memtoreg<='0';
                    regwrite<='1';
                    alu_op<="000";
                    
                when "001" =>  --ADDi
                    regdst<='0';
                    extop<='1';
                    alusrc<='1';
                    branch<='0';
                    jump<='0';
                    memwrite<='0';
                    memtoreg<='0';
                    regwrite<='1';
                    alu_op<="001";
                    
                  when "010" => -- load word
                    regdst<='0';
                    extop<='1';
                    alusrc<='1';
                    branch<='0';
                    jump<='0';
                    memwrite<='0';
                    memtoreg<='1';
                    regwrite<='1';
                    alu_op<="001";
                   
                 when "011"=> -- store word
                    regdst<='X';
                    extop<='1';
                    alusrc<='1';
                    branch<='0';
                    jump<='0';
                    memwrite<='1';
                    memtoreg<='X';
                    regwrite<='0';
                    alu_op<="001";
                    
                    when "100" => --ANDi
                             regdst<='0';
                             extop<='0';
                             alusrc<='1';
                             branch<='0';
                             jump<='0';
                             memwrite<='0';
                             memtoreg<='0';
                             regwrite<='1';
                             alu_op<="010";
                    
                 when "101" => -- ORi
                         regdst<='0';
                         extop<='0';
                         alusrc<='1';
                         branch<='0';
                         jump<='0';
                         memwrite<='0';
                         memtoreg<='0';
                         regwrite<='1';
                         alu_op<="011";
                         
                 when "110" => -- branch on equal
                    regdst<='X';
                    extop<='1';
                    alusrc<='0';
                    branch<='1';
                    jump<='0';
                    memwrite<='0';
                    memtoreg<='X';
                    regwrite<='0';
                    alu_op<="100";
                   
                         
                    when "111" => --JUMP--
                            regdst<='X';
                            extop<='X';
                            alusrc<='X';
                            branch<='X';
                            jump<='1';
                            memwrite<='0';
                            memtoreg<='X';
                            regwrite<='0';
                            alu_op<="111";
                            
                    when others => 
                        regdst<='X';
                         extop<='X';
                         alusrc<='X';
                         branch<='0';
                         jump<='0';
                         memwrite<='0';
                         memtoreg<='0';
                         regwrite<='0';
                         alu_op<="000";
        end case;
    end process;                   
                   


end Behavioral;
