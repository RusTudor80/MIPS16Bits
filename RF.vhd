----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 16.03.2020 13:18:09
-- Design Name: 
-- Module Name: RF - Behavioral
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

entity RF is
    Port (
      clk:in std_logic;
        ra1 :in std_logic_vector(2 downto 0);
        ra2 :in std_logic_vector(2 downto 0);
        wa : in std_logic_vector(2 downto 0);
        wd : in std_logic_vector(15 downto 0);
        wen: in std_logic;
        rd1: out std_logic_vector(15 downto 0);
        rd2:out std_logic_vector(15 downto 0));
end RF;

architecture Behavioral of RF is
type reg_array is array (0 to 7) of std_logic_vector(15 downto 0);
signal rf : reg_array:=(
    x"0000",
    x"0001",
    x"0002",
    x"0003",
    x"0004",
    x"0005",
    x"0006",
    x"0007",
    others=>x"0000");
begin
    process(clk)
            begin
                if clk'event and clk='1' then
                    if wen='1'  then
                        rf(conv_integer(wa))<=wd;
                     end if;
                 end if;
        end process;
        
        rd1<=rf(conv_integer(ra1));
        rd2<=rf(conv_integer(ra2));


end Behavioral;
