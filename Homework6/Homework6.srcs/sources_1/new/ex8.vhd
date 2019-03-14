----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/10/2019 07:41:51 AM
-- Design Name: 
-- Module Name: ex8 - Behavioral
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

entity ex8 is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           X : in STD_LOGIC;
           Z1 : out STD_LOGIC;
           Z2 : out STD_LOGIC;
           Y : out STD_LOGIC_Vector(1 downto 0));
end ex8;

architecture Behavioral of ex8 is
type state_type is (ST0,ST1,ST2,ST3);
    attribute ENUM_ENCODING: STRING;
    attribute ENUM_ENCODING of state_type: type is "00 01 10 11";
    signal PS,NS : state_type;
begin
    sync_proc: process(CLK,NS,RESET)
    begin
        if (RESET = '1') then PS <= ST0;
        elsif (rising_edge(CLK)) then PS <= NS;
        end if;
    end process sync_proc;
    
    comb_proc: process(PS,X)
    begin
        case PS is
            when ST0 => 
                if (X = '0') then NS <= ST0; Z1 <= '1'; Z2 <= '0';
                else NS <= ST2; Z1 <= '1'; Z2 <= '0';
                end if;
            when ST1 => 
                if (X = '1') then NS <= ST1; Z1 <= '0'; Z2 <= '0';
                else NS <= ST3; Z1 <= '0'; Z2 <= '0';
                end if;
            when ST2 => 
                if (X = '0') then NS <= ST1; Z1 <= '0'; Z2 <= '0';
                else NS <= ST0; Z1 <= '1'; Z2 <= '0';
                end if;
            when ST3 => 
                if (X = '0') then NS <= ST0; Z1 <= '1'; Z2 <= '1';
                else NS <= ST1; Z1 <= '0'; Z2 <= '0';
                end if;
            when others =>
                Z1 <= '1'; Z2 <= '0'; NS <= ST0;
            end case;
    end process comb_proc;
-- one-hot encoded approach
with PS select
Y <= "01" when ST0,
"10" when ST1,
"11" when ST2,
"10" when others;


end Behavioral;
