----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/14/2024 02:58:23 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
    Port ( a_alu:in std_logic_vector(31 downto 0);
        b_alu: in std_logic_vector(31 downto 0);
        res_out: out std_logic_vector(63 downto 0);
        op_alu: in std_logic_vector(3 downto 0);
        clk_alu:in std_logic;
        en_alu: in std_logic
    );
end ALU;

architecture Behavioral of ALU is

    component Ripple_Carry_Adder is
        Port (
            A: in  std_logic_vector(31 downto 0);
            B: in  std_logic_vector(31 downto 0);
            Cin: in  std_logic;
            S: out std_logic_vector(31 downto 0);
            Cout: out std_logic
        );
    end component;
    
    component Substractor is
        Port (A: in  std_logic_vector(31 downto 0);
              B  : in  std_logic_vector(31 downto 0);
              Cin : in  std_logic;
              Sub : out std_logic_vector(31 downto 0);
              Cout : out std_logic );
    end component;
    
    component Logic_Op is
      Port ( a : in std_logic_vector(31 downto 0);
            b : in std_logic_vector(31 downto 0); 
            op : in std_logic_vector(3 downto 0); 
            result : out std_logic_vector(31 downto 0)
       );
    end component;

    
    component Shift_Op is
    Port (a : in std_logic_vector(31 downto 0);
            b : in std_logic_vector(31 downto 0); 
            op : in std_logic_vector(3 downto 0); 
            result : out std_logic_vector(31 downto 0) );
    end component;
    
    component Booth_Multiplier is
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
    
    end component;

    
    component Divider is
        generic(x: INTEGER := 32); 
        port(reset: in STD_LOGIC; 
        clk: in STD_LOGIC; 
        
        num: in STD_LOGIC_VECTOR((x - 1) downto 0); 
        den: in STD_LOGIC_VECTOR((x - 1) downto 0); 
        res: out STD_LOGIC_VECTOR((x - 1) downto 0); 
        rm: out STD_LOGIC_VECTOR((x - 1) downto 0) 
           ); 
    end component;


    signal resAdd: std_logic_vector(31 downto 0);
    signal coutALU: std_logic;
    signal resSub: std_logic_vector(31 downto 0);
    signal coutSub: std_logic;
    signal reslogic: std_logic_vector(31 downto 0);
    signal resshift: std_logic_vector(31 downto 0);
    signal resMul: std_logic_vector(63 downto 0);
    signal resDiv: std_logic_vector(31 downto 0);
    signal remainder : std_logic_vector(31 downto 0);
    
begin
    ADD: Ripple_Carry_Adder port map(a_alu, b_alu, '0', resAdd, coutALU);
    SUB: Substractor port map (a_alu, b_alu, '0', resSub, coutSub);
    LOGOP: Logic_Op port map (a_alu, b_alu, op_alu, reslogic  );
    SHIFT: Shift_Op port map ( a_alu, b_alu, op_alu, resshift);
    MUL: Booth_Multiplier port map (clk_alu, '0', a_alu, b_alu, resMul);
    DIV: Divider port map ('0',clk_alu, a_alu, b_alu, resDiv, remainder );
    
    process(op_alu, a_alu, b_alu, clk_alu, en_alu)
    begin
        if rising_edge(clk_alu) then
            if en_alu = '1' then
                case op_alu is
                    when "0000" => -- ADD
                        res_out(63 downto 32) <= (others => resAdd(31));
                        res_out(31 downto 0) <= resAdd;
                    when "0001" => -- SUB   
                        res_out(63 downto 32) <= (others => resSub(31));
                          res_out(31 downto 0) <= resSub;
                        
                   when "0010" => --AND
                        res_out(31 downto 0) <= reslogic;
                        
                   when "0011" => --OR
                        res_out(31 downto 0) <= reslogic; 
                        
                   when "0111" => --NOT
                        res_out(31 downto 0) <= reslogic; 
                        
                   when "0100" => -- SHIFT LEFT
                         res_out(31 downto 0) <= resshift;
                         
                   when "1000" => -- SHIFT RIGHT
                         res_out(31 downto 0) <= resshift;
                          
                    when "1010" => -- ROTATE LEFT
                          res_out(31 downto 0) <= resshift;
                          
                    when "1011" => -- ROTATE RIGHT 
                          res_out(31 downto 0) <= resshift;
                          
                    when "0110" => --INC
                        res_out(31 downto 0) <= a_alu + "00000000000000000000000000000001";
                        
                    when "1001" => --DEC
                        res_out(31 downto 0) <= a_alu - "00000000000000000000000000000001";                    
                    
                    when "0101" => --MUL
                         res_out<= resMul;
                    
                    when"1100"=> --DIV
                          res_out(63 downto 32) <= (others => resDiv(31));
                          res_out(31 downto 0) <= resDiv;
                          
                    when others => res_out <= (others => '0');
                end case;
            end if;
        end if;
    end process;

end Behavioral;
