----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/15/2024 02:49:42 AM
-- Design Name: 
-- Module Name: Alu_tb - Behavioral
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

entity Alu_tb is
--  Port ( );
end Alu_tb;

architecture Behavioral of Alu_tb is

signal a_tb, b_tb: std_logic_vector(31 downto 0);
signal res_tb: std_logic_vector(63 downto 0);
    signal op_tb: std_logic_vector(3 downto 0);
    signal clk_tb, en_tb: std_logic := '0';

    constant clk_period : time := 1 ns;

    component ALU
        Port (
            a_alu: in std_logic_vector(31 downto 0);
            b_alu: in std_logic_vector(31 downto 0);
            res_out: out std_logic_vector(63 downto 0);
            op_alu: in std_logic_vector(3 downto 0);
            clk_alu: in std_logic;
            en_alu: in std_logic
        );
    end component;

begin
  
    uut: ALU port map (a_tb, b_tb, res_tb, op_tb, clk_tb, en_tb);

   
    stimulus_proc: process
    begin
        -- Initialize signals
        a_tb <= (others => '0');
        b_tb <= (others => '0');
        op_tb <= "0000";
        clk_tb <= '0';
        en_tb <= '0';
    
        wait for 10 ns;
    
        -- Test ADD 
        --a_tb <= "00000000000000000000000000000001";
        --b_tb <= "00000000000000000000000000000010";
        --op_tb <= "0000";  -- ADD
        --en_tb <= '1';
    
        --wait for 10 ns;
    
        -- Test SUB 
        a_tb <= "00000000000000000000000000000010";
        b_tb <= "00000000000000000000000000000001";
        op_tb <= "0000";  -- SUB
        en_tb <= '1';
    
        wait for 10 ns;
    
       
        wait;
    end process stimulus_proc;

    
    clk_process :process
       begin
            clk_tb <= '0';
            wait for clk_period/2;  --for 0.5 ns signal is '0'.
            clk_tb <= '1';
            wait for clk_period/2;  --for next 0.5 ns signal is '1'.
       end process;



end Behavioral;
