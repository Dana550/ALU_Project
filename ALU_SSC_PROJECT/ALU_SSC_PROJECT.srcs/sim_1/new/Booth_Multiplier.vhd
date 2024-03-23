----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/16/2023 09:56:51 PM
-- Design Name: 
-- Module Name: Booth_Multiplier - Behavioral
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

entity Booth_Multiplier is
  generic (
        x : INTEGER := 32;
        y : INTEGER := 32
    );

    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        m : IN STD_LOGIC_VECTOR(x - 1 DOWNTO 0);
        r : IN STD_LOGIC_VECTOR(y - 1 DOWNTO 0);
        result : OUT STD_LOGIC_VECTOR(x + y - 1 DOWNTO 0)
    );

end Booth_Multiplier;

architecture Behavioral of Booth_Multiplier is

    type StateType is (IDLE, COMPUTE);
    signal state : StateType := IDLE;
    signal next_state : StateType;
    
    signal clk_edge : BOOLEAN := FALSE;
begin
process(clk, reset)
        CONSTANT X_ZEROS : STD_LOGIC_VECTOR(x - 1 DOWNTO 0) := (OTHERS => '0');
        CONSTANT Y_ZEROS : STD_LOGIC_VECTOR(y - 1 DOWNTO 0) := (OTHERS => '0');

        VARIABLE a, s, p : STD_LOGIC_VECTOR(x + y + 1 DOWNTO 0);
        VARIABLE mn      : STD_LOGIC_VECTOR(x - 1 DOWNTO 0);

    begin
        if reset = '1' then
            state <= IDLE;
            clk_edge <= FALSE;
        elsif rising_edge(clk) then
            clk_edge <= not clk_edge;
            if clk_edge then
                case STATE is
                    when IDLE =>
                        if (m/= X_ZEROS and r/= Y_ZEROS) then
                            state <= COMPUTE;
                        end if;

                    when COMPUTE =>
                        a:=(OTHERS => '0');
                        s:=(OTHERS => '0');
                        p:=(OTHERS => '0');

                        if (m/=X_ZEROS and r/= Y_ZEROS) then
                            a(x+y downto y + 1) := m;
                            a(x+y+1):= m(x - 1);

                            mn := (not m) + 1;

                            s(x+y downto y + 1) := mn;
                            s(x+y +1) := not(m(x - 1));

                            p(y downto 1) := r;

                            for i in 1 to y loop
                                if (p(1 downto 0) = "01") then
                                    p := p + a;
                                elsif (p(1 downto 0) = "10") then
                                    p := p + s;
                                end if;

                                -- Shift Right Arithmetic
                                p(x + y downto 0) := p(x + y + 1 downto 1);
                            end loop;
                        end if;

                        result <= p(x + y downto 1);
                        state <= IDLE;

                    when OTHERS =>
                        NULL;
                end case;
            end if;
        end if;

    end process;

end Behavioral;
