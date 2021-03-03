----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2020 03:26:44 PM
-- Design Name: 
-- Module Name: MPG - Behavioral
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

entity MPG is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           en : out STD_LOGIC);
end MPG;

architecture Behavioral of MPG is
signal count: std_logic_vector (15 downto 0):=x"0000";
signal Q1 : std_logic;
signal Q2 : std_logic;
signal Q3 : std_logic;
begin
    en <= Q2 and (not Q3);
    
    process (clk)
    begin
        if clk'event and clk='1' then 
               count <= count +1;
        end if;
    end process;
    
    process (clk)
    begin
        if clk'event and clk='1' then
            if count(15 downto 0) = "1111111111111111" then
                Q1 <= btn;
            end if;
        end if;
    end process;
    
    process (clk)
    begin
        if clk'event and clk='1' then
            Q2 <= Q1;
            Q3 <= Q2;
        end if;
    end process;
end Behavioral;
