----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 2022/09/21 22:06:34
-- Design Name: 
-- Module Name: FPU_8bit - Behavioral
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
use IEEE.std_logic_signed.ALL;
use IEEE.std_logic_arith.ALL;

-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FPU is
    Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
           b : in STD_LOGIC_VECTOR (7 downto 0);
           mul: in std_logic;
           div: in std_logic;
           output: out STD_LOGIC_VECTOR (15 downto 0)
           );
end FPU;

architecture Behavioral of FPU is

begin

    process (a, b, mul, div)
    --calculation
    variable flag_a: std_logic;
    variable flag_b: std_logic;
    
    variable exp_a: integer;
    variable exp_b: integer;
    
    variable manti_a: integer;
    variable manti_b: integer;
    
    -- output
    variable flag_out: std_logic;
    
    variable manti_out: integer;
    variable exp_out: integer;
      
    begin
    flag_a := a(7);
    flag_b := b(7);
    
    exp_a :=  CONV_integer (a(6 downto 4));
    exp_b :=  CONV_INTEGER (b(6 downto 4));
    
    manti_a := CONV_INTEGER (a(3 downto 0));
    manti_b := CONV_INTEGER (b(3 downto 0));
    
    if (mul = '1')then
    exp_out := exp_a * exp_b;
    manti_out := manti_a * manti_b;
    flag_out := flag_a xor flag_b;
    end if;
   
    if (div = '1')then
    exp_out := exp_a / exp_b;
    manti_out := manti_a / manti_b;
    flag_out := flag_a xor flag_b;
    end if;
    
    output(8 downto 0) <= conv_std_logic_vector (manti_out, 9);
    output(14 downto 9) <= conv_std_logic_vector (manti_out, 6);
    output(15) <= flag_out;
    
end process;  

end Behavioral;
