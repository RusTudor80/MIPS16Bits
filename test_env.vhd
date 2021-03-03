-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/26/2020 02:31:55 PM
-- Design Name: 
-- Module Name: test_env - Behavioral
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

entity test_env is
    Port ( clk : in STD_LOGIC;
           sw : in STD_LOGIC_VECTOR (15 downto 0);
           btn : in STD_LOGIC_VECTOR (5 downto 0);
           led : out STD_LOGIC_VECTOR (15 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           cat : out STD_LOGIC_VECTOR (6 downto 0));
end test_env;

architecture Behavioral of test_env is

component MPG is
    Port ( clk : in STD_LOGIC;
           btn : in STD_LOGIC;
           en : out STD_LOGIC);
end component;

component display is
    Port (clk: in std_logic;
      input :in std_logic_vector(15 downto 0);
      an : out STD_LOGIC_VECTOR (3 downto 0);
      cat : out STD_LOGIC_VECTOR (6 downto 0));
end component;

component RF is 
port(
        clk:in std_logic;
        ra1 :in std_logic_vector(3 downto 0);
        ra2 :in std_logic_vector(3 downto 0);
        wa : in std_logic_vector(3 downto 0);
        wd : in std_logic_vector(15 downto 0);
        wen: in std_logic;
        rd1: out std_logic_vector(15 downto 0);
        rd2:out std_logic_vector(15 downto 0));
end component;

component IFF is
Port (  jump: in std_logic;
        jump_adress :in std_logic_vector(15 downto 0);
        pcsrc:in std_logic;
        branch_adress : in std_logic_vector(15 downto 0);
        en: in std_logic;
        rst: in std_logic;
        clk:in std_logic;
        instruction: out std_logic_vector(15 downto 0);
        pcout: out std_logic_vector(15 downto 0));
        
end component;

component ID is 
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
        
end component;

component UnitControl is 
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
          
          
end component;

component EX is
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
end component;

component MEM is
	port(
			clk: in std_logic;
			ALUResIn : in std_logic_vector(15 downto 0);
			WriteData: in std_logic_vector(15 downto 0);
			MemWrite: in std_logic;			
			enable: in std_logic;	
			MemData:out std_logic_vector(15 downto 0);
			ALUResOut :out std_logic_vector(15 downto 0)
	);
end component;

signal RegDst:std_logic;
signal ExtOp:std_logic;
signal AluSrc:std_logic;
signal Branch:std_logic;
signal Jump:std_logic;
signal MemWrite:std_logic;
signal MemtoReg:std_logic;
signal RegWrite:std_logic;
signal AluOp:std_logic_vector(2 downto 0);

signal enableIFF:std_logic; --enable pt IFF
signal resetIFF:std_logic; --reset pt IFF
signal BranchAdress:std_logic_vector(15 downto 0);
signal JumpAdress:std_logic_vector(15 downto 0);
signal SSD:std_logic_vector(15 downto 0);
signal Instr:std_logic_vector(15 downto 0);
signal PCplus1:std_logic_vector(15 downto 0);
signal AluRes:std_logic_vector(15 downto 0);
signal Zero:std_logic;
signal Func:std_logic_vector(2 downto 0);
signal SA:std_logic;
signal PCSrc:std_logic;
signal RD1:std_logic_vector(15 downto 0);
signal RD2:std_logic_vector(15 downto 0);
signal Ext_Imm:std_logic_vector(15 downto 0);
signal MemData:std_logic_vector(15 downto 0);
signal AluFinal:std_logic_vector(15 downto 0);
signal WriteData:std_logic_vector(15 downto 0);

begin

muxMemtoReg:process(MemtoREg,AluFinal,MemData)
begin
    case(MemtoReg) is
        when '1'=>WriteData<=MemData;
        when '0'=>WriteData<=AluFinal;
    end case;
end process;

muxSwitchuri:process(Instr,PCplus1,RD1,RD2,Ext_Imm,AluRes,MemData,WriteData,sw)
begin
    case(sw(7 downto 5)) is
        when "000"=>SSD<=Instr;
        when "001"=>SSD<=PCplus1;
        when "010"=>SSD<=RD1;
        when "011"=>SSD<=RD2;
        when "100"=>SSD<=Ext_Imm;
        when "101"=>SSD<=AluRes;
        when "110"=>SSD<=MemData;
        when "111"=>SSD<=WriteData;
        
        when others=> SSD<=x"BBBB";
   end case;
end process;
muxSemnale:process(RegDst,ExtOp,AluSrc,Branch,Jump,MemWrite,MemtoReg,RegWrite,AluOp,sw)
begin
            if sw(0)='0' then
                  led(7)<=RegDst;
                  led(6)<=ExtOp;
                  led(5)<=AluSrc;
                  led(4)<=Branch;
                  led(3)<=Jump;
                  led(2)<=MemWrite;
                  led(1)<=MemtoReg;
                  led(0)<=RegWrite;
             else
                led(2 downto 0)<=AluOp(2 downto 0);
                led(7 downto 3)<="00000";
             end if;
end process;

poartaSipentruPcSrc:PCSrc<=Zero And Branch;
adresadeJump:JumpAdress<=PCplus1(15 downto 14)&Instr(13 downto 0);
          

InstructionFetch:IFF port map(Jump,JumpAdress,PCSrc,BranchAdress,enableIFF,resetIFF,clk,Instr,PCplus1);
InstructionDecode:ID port map(RegWrite,Instr,Func,SA,WriteData,RD1,RD2,RegDst,clk,Ext_Imm,ExtOP);
ControlUnit:UnitControl port map(Instr(15 downto 13),RegDst,ExtOp,AluSrc,Branch,Jump,MemWrite,MemtoReg,RegWrite,AluOp);
ExecutionUnit:EX port map(PCplus1,RD1,RD2,Ext_Imm,Func,SA,AluSRc,AluOp,BranchAdress,AluRes,Zero);
Memory:MEM port map(clk,AluRes,RD2,MemWrite,enableIFF,MemData,AluFinal);
SSD1:display port map(clk,SSD,an,cat);
mpg1:MPG port map(clk,btn(0),enableIFF);
mpg2:MPG port map(clk,btn(1),resetIFF);

 
end Behavioral;
