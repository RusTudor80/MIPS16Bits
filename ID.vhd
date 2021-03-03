----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.04.2020 21:43:03
-- Design Name: 
-- Module Name: ID - Behavioral
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

entity ID is
 Port (
        Reg_write :in std_logic;
        Instr :in std_logic_vector(15 downto 0);
        Func:out std_logic_vector(2 downto 0);
        Sa:out std_logic;
        Write_data: in std_logic_vector(15 downto 0);
        Read_data1:out std_logic_vector(15 downto 0);
        Read_data2:out std_logic_vector(15 downto 0);
        Reg_dst:in std_logic;
        clk:in std_logic;
        exit_imm:out std_logic_vector(15 downto 0);
        exit_op:in std_logic);
        
end ID;

architecture Behavioral of ID is
component RF is 
   Port (
      clk:in std_logic;
        ra1 :in std_logic_vector(2 downto 0);
        ra2 :in std_logic_vector(2 downto 0);
        wa : in std_logic_vector(2 downto 0);
        wd : in std_logic_vector(15 downto 0);
        wen: in std_logic;
        rd1: out std_logic_vector(15 downto 0);
        rd2:out std_logic_vector(15 downto 0));
end component;

signal Write_adress: std_logic_vector(2 downto 0);
signal ReadAdress1: std_logic_vector(2 downto 0);
signal ReadAdress2: std_logic_vector(2 downto 0);

begin
mux1:process(Reg_dst,Instr)
    begin
     case Reg_dst is 
        when '0' => Write_adress<= Instr(9 downto 7);
        when '1' => Write_adress<= Instr(6 downto 4);
     end case;
end process;

mux2:process(exit_op)
    begin 
        case exit_op is 
             when '0'=> exit_imm<="000000000"& Instr(6 downto 0);
             when '1'=> exit_imm<=Instr(6)& "000000000"&Instr(5 downto 0);
        end case;
end process;
sa<=Instr(3);
func<=Instr(2 downto 0);
ReadAdress1<=Instr(12 downto 10);
ReadAdress2<=Instr(9 downto 7);

RF1:RF port map(clk,ReadAdress1,ReadAdress2,Write_adress,Write_data,Reg_Write,Read_data1,Read_data2);


  
end Behavioral;
