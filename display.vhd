----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/04/2020 04:09:05 PM
-- Design Name: 
-- Module Name: ssd - Behavioral
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


entity display is
Port (clk: in std_logic;
      input:in std_logic_vector(15 downto 0);
      an : out STD_LOGIC_VECTOR (3 downto 0);
      cat : out STD_LOGIC_VECTOR (6 downto 0));
end display;

architecture Behavioral of display is
signal counter1 : STD_LOGIC_VECTOR(15 downto 0):=(others =>'0');
signal out_mux2: std_logic_vector(3 downto 0):=(others =>'0');
begin

counter_1:process(clk)
begin
    if(rising_edge(clk)) then
        counter1<=counter1+1;
    end if;
end process; 

mux_1:process(counter1(15 downto 14))
begin
    case counter1(15 downto 14) is
        when "00" => an <= "1110";
        when "01" => an <= "1101";
        when "10" => an <= "1011";
        when "11" => an <= "0111";
    end case;
end process;

mux_2:process(counter1(15 downto 14),input)
begin
    case counter1(15 downto 14) is
            when "00" => out_mux2 <= input(3 downto 0);
            when "01" => out_mux2 <= input(7 downto 4);
            when "10" => out_mux2 <= input(11 downto 8);
            when "11" => out_mux2 <= input(15 downto 12);
    end case;
end process;
--decodificator hex 7 seg
hex_to7: process(out_mux2)
begin
    case out_mux2 is
     when "0001" => cat <= "1111001";
     when "0010" => cat <= "0100100";
     when "0011" => cat <= "0110000";
     when "0100" => cat <= "0011001";
     when "0101" => cat <= "0010010";
     when "0110" => cat <= "0000010";
     when "0111" => cat <= "1111000";
     when "1000" => cat <= "0000000";
     when "1001" => cat <= "0010000";
     when "1010" => cat <= "0001000";
     when "1011" => cat <= "0000011";
     when "1100" => cat <= "1000110";
     when "1101" => cat <= "0100001";
     when "1110" => cat <= "0000110";
     when "1111" => cat <= "0001110";
     when others => cat <= "1000000";
    end case;
end process;  
end Behavioral;
