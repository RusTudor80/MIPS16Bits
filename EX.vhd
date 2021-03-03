----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2020 17:56:52
-- Design Name: 
-- Module Name: EX - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity EX is
Port(
	PCplus1:in std_logic_vector(15 downto 0);
	RD1: in std_logic_vector(15 downto 0);
	RD2: in std_logic_vector(15 downto 0);
	Ext_Imm: in std_logic_vector(15 downto 0);
	Func: in std_logic_vector(2 downto 0);
	SA: in std_logic;
	ALUSrc: in std_logic;
	ALUOp: in std_logic_vector(2 downto 0);
	BranchAddress: out std_logic_vector(15 downto 0);
	ALURes: out std_logic_vector(15 downto 0);
	ZeroSignal: out std_logic);
end EX;

architecture Behavioral of EX is

signal B:std_logic_vector(15 downto 0);
signal ALUControl: std_logic_vector(2 downto 0);
signal AuxIesireAlu:std_logic_vector(15 downto 0);
signal ZeroAux: std_logic;

begin



    with  ALUSrc select
	B<=RD2 when '0',
	Ext_Imm when others;
	
	BranchAddress<=PCplus1+Ext_Imm;	  

process(ALUOp,Func)
begin
	case (ALUOp) is
		when "000"=>
				case (Func) is
					when "000"=> ALUControl<="000"; --ADD
					when "001"=> ALUControl<="001"; --SUB
					when "010"=> ALUControl<="010"; --SRL
					when "011"=> ALUControl<="011"; --SLL
					when "100"=> ALUControl<="100"; --AND
					when "101"=> ALUControl<="101";	--OR
					when "110"=> ALUControl<="110";	--SRA
					when "111"=> ALUControl<="111"; --SLA
					when others=> ALUControl<="000";
				end case;
		when "001"=> ALUControl<="000";		--ADDi
		when "010"=> ALUControl<="000";		--LW
		when "011"=> ALUControl<="000";     --SW
		when "100"=> ALUControl<="100";     --ANDi
		when "101"=> ALUControl<="101";		--ORi
		when "110"=> ALUControl<="001";		--BEQ
		when "111"=> AluControl<="000";     --JMP
		when others=> ALUControl<="000";	
	end case;
end process;

process(ALUControl,RD1,B,SA,AuxIesireAlu)
begin
	case(ALUControl) is
		when "000" => AuxIesireAlu<=RD1+B;  --ADD		
		when "001" => AuxIesireAlu<=RD1-B;	--SUB			
		when "010" => case (SA) is          --SRL
						when '1' => AuxIesireAlu<="0" & RD1(15 downto 1);
						when others => AuxIesireAlu<=RD1;
					end case;				       
		when "011" => case (SA) is          --SLL
						when '1' => AuxIesireAlu<=RD1(14 downto 0) & "0";
						when others => AuxIesireAlu<=RD1;	
					end case;						
		when "100" => AuxIesireAlu<=RD1 and B; --AND				
		when "101" => AuxIesireAlu<=RD1 or B;  --OR							
		when "110" => AuxIesireAlu<=RD1(RD1'left-1 downto 0)&'0';   --SRA					
		when "111" => AuxIesireAlu<='0'&RD1(RD1'left downto 1);     --SLA     
		when others => AuxIesireAlu<=X"000";	                    --JUMP	       
	end case;

	case (AuxIesireAlu) is	--Detectie de 0
		when X"0000" => ZeroAux<='1'; --iesirea de 0 ia val 1 
		when others => ZeroAux<='0';
	end case;

end process;

   
ALURes<=AuxIesireAlu; -- Iesire Alu
ZeroSignal<=ZeroAux;  -- Detectie de zero 

end Behavioral;

