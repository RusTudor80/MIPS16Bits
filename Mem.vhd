----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2020 18:54:25
-- Design Name: 
-- Module Name: Mem - Behavioral
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


entity MEM is
	port(
			clk: in std_logic;
			ALUResIn : in std_logic_vector(15 downto 0);
			WriteData: in std_logic_vector(15 downto 0);
			MemWrite: in std_logic;			
			enable: in std_logic;	
			MemData:out std_logic_vector(15 downto 0);
			ALUResOut :out std_logic_vector(15 downto 0)
	);
end MEM;

architecture Behavioral of MEM is

signal Address: std_logic_vector(3 downto 0);

type ram_type is array (0 to 15) of std_logic_vector(15 downto 0);
signal RAM:ram_type;

begin

Address<=ALUResIn(3 downto 0);

process(clk,Address) 			
begin
	if(rising_edge(clk)) then
		if enable='1' and MemWrite='1' then
				RAM(conv_integer(Address))<=WriteData;			
			end if;
		end if;	
	MemData<=RAM(conv_integer(Address));
end process;
	
ALUResOut<=ALUResIn;	

end Behavioral;
