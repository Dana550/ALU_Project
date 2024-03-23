----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2023 10:02:38 PM
-- Design Name: 
-- Module Name: Substractor - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Substractor is
    Port (A: in  std_logic_vector(31 downto 0);
          B  : in  std_logic_vector(31 downto 0);
          Cin : in  std_logic;
          Sub : out std_logic_vector(31 downto 0);
          Cout : out std_logic );
end Substractor;

architecture Behavioral of Substractor is

component full_sub is
    Port (a, b, cin : in std_logic;
          sub, cout: out std_logic );
end component;

signal c : std_logic_vector(32 downto 0);
begin

c(0)<= Cin;
fa030: for i in 0 to 31 generate
        full_adder_inst : full_sub port map(A(i), B(i), c(i), Sub(i), c(i+1));
       end generate fa030;
fa31: full_sub port map(A(31), B(31), c(31), Sub(31), Cout);
end Behavioral;
