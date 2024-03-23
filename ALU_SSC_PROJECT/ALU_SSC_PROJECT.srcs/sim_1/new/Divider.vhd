----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/03/2023 10:10:38 PM
-- Design Name: 
-- Module Name: Divider - Behavioral
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
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STD_LOGIC_SIGNED.all;  
use IEEE.STD_LOGIC_ARITH.all; 
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Divider is
  generic(x: INTEGER := 32); 
   port(reset: in STD_LOGIC; 
       clk: in STD_LOGIC; 
        
       num: in STD_LOGIC_VECTOR((x - 1) downto 0); 
       den: in STD_LOGIC_VECTOR((x - 1) downto 0); 
       res: out STD_LOGIC_VECTOR((x - 1) downto 0); 
       rm: out STD_LOGIC_VECTOR((x - 1) downto 0) 
       ); 
end Divider;

architecture Behavioral of Divider is
 signal buf: STD_LOGIC_VECTOR((2 * x - 1) downto 0); 
    signal dbuf: STD_LOGIC_VECTOR((x - 1) downto 0); 
    signal sm: INTEGER range 0 to x; 
     
    alias buf1 is buf((2 * x - 1) downto x); 
    alias buf2 is buf((x - 1) downto 0); 
begin 
    process(reset, clk) 
    begin 
        if reset = '1' then 
            res <= (others => '0'); 
            rm <= (others => '0'); 
            sm <= 0; 
        elsif rising_edge(clk) then 
                case sm is 
                when 0 => 
                    buf1 <= (others => '0'); 
                    buf2 <= num; 
                    dbuf <= den; 
                    res <= buf2; 
                    rm <= buf1; 
                    sm <= sm + 1; 
                when others => 
                    if buf((2 * x - 2) downto (x - 1)) >= dbuf then 
                        buf1 <= '0' & (buf((2 * x - 3) downto (x - 1)) - dbuf((x - 2) downto 0)); 
                        buf2 <= buf2((x - 2) downto 0) & '1'; 
                    else 
                        buf <= buf((2 * x - 2) downto 0) & '0'; 
                    end if; 
                    if sm /= x then 
                        sm <= sm + 1; 
                    else 
                        sm <= 0; 
                    end if; 
                end case; 
            end if; 
    end process; 
end Behavioral;
