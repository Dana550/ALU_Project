----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2023 01:16:56 AM
-- Design Name: 
-- Module Name: Ripple_Carry_Adder - Behavioral
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

entity Ripple_Carry_Adder is
       Port (
            A: in  std_logic_vector(31 downto 0);
            B  : in  std_logic_vector(31 downto 0);
            Cin : in  std_logic;
            S : out std_logic_vector(31 downto 0);
            Cout : out std_logic
    );
  
end Ripple_Carry_Adder;

architecture Behavioral of Ripple_Carry_Adder is

component full_adder is
        Port ( a, b, cin : in std_logic;
                sum, cout: out std_logic
         );
end component;

signal c : std_logic_vector(32 downto 0);

begin

c(0)<= Cin;
fa030: for i in 0 to 31 generate
        full_adder_inst : full_adder port map(A(i), B(i), c(i), S(i), c(i+1));
        end generate fa030;
fa31: full_adder port map(A(31), B(31), c(31), S(31), Cout);
end Behavioral;
