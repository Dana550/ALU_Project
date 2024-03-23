----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/14/2024 02:05:05 AM
-- Design Name: 
-- Module Name: Shift_Op - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Shift_Op is
  Port (a : in std_logic_vector(31 downto 0);
        b : in std_logic_vector(31 downto 0); 
        op : in std_logic_vector(3 downto 0); 
        result : out std_logic_vector(31 downto 0) );
end Shift_Op;

architecture Behavioral of Shift_Op is

begin
process(op) 
begin
    case op is 
        when "0100" => -- SHIFT LEFT
            result <= a(30 downto 0) & '0';
        when "1000" => -- SHIFT RIGHT
            result <= '0' & a(31 downto 1);
        when "1010" => -- ROTATE LEFT
            result <= a(30 downto 0) & a(31);
        when "1011" => -- ROTATE RIGHT 
            result <= a(0) & a(31 downto 1);
        when others => 
            result <= a(31 downto 0);
      end case;
end process;

end Behavioral;
