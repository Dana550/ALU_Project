----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/14/2024 01:57:25 AM
-- Design Name: 
-- Module Name: Logic_Op - Behavioral
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

entity Logic_Op is
  Port ( a : in std_logic_vector(31 downto 0);
        b : in std_logic_vector(31 downto 0); 
        op : in std_logic_vector(3 downto 0); 
        result : out std_logic_vector(31 downto 0)
   );
end Logic_Op;

architecture Behavioral of Logic_Op is

begin
process(op) 
begin
    case op is
        when "0010" => result <= a AND b;
        when "0011" => result <= a OR b; 
        when "0111" =>  result <= NOT a;
        when others =>  result <=a; 
      end case;
end process;

end Behavioral;
