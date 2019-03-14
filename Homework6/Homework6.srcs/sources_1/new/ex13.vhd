----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/10/2019 07:48:28 AM
-- Design Name: 
-- Module Name: ex13 - Behavioral
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

entity ex13 is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           X1 : in STD_LOGIC;
           X2 : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR(2 downto 0);
           CS : out STD_LOGIC;
           RD : out STD_LOGIC);
end ex13;

architecture Behavioral of ex13 is


    type state_type is (ST0,ST1,ST2);
    attribute ENUM_ENCODING: STRING;
    attribute ENUM_ENCODING of state_type: type is "001 010 100";
    signal PS,NS : state_type;
begin
    sync_proc: process(CLK,NS,RESET)
    begin
        if (RESET = '1') then PS <= ST0;
        elsif (rising_edge(CLK)) then PS <= NS;
        end if;
    end process sync_proc;
    
    comb_proc: process(PS,X1,X2)
    begin
        case PS is
            when ST0 => 
                if (X1 = '0') then NS <= ST1; RD <= '1'; CS <= '0';
                else NS <= ST2; RD <= '0'; CS <= '1';
                end if;
            when ST1 => 
                NS <= ST2; CS <= '1'; RD <= '1';
            when ST2 => 
                if (X2 = '0') then NS <= ST0; RD <= '0'; CS <= '0';
                else NS <= ST2; RD <= '1'; CS <= '0';
                end if;
            when others => 
                CS <= '0'; RD <= '0'; NS <= ST0;
            end case;
    end process comb_proc;
-- one-hot encoded approach
with PS select
Y <= "001" when ST0,
"010" when ST1,
"100" when ST2,
"001" when others;



end Behavioral;
