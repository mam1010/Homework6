----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/10/2019 04:08:31 AM
-- Design Name: 
-- Module Name: FSM - Behavioral
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

entity FSM is
    Port ( CLK : in STD_LOGIC;
           RESET : in STD_LOGIC;
           X1 : in STD_LOGIC;
           X2 : in STD_LOGIC;
           Z : out STD_LOGIC;
           Y : out STD_LOGIC_Vector(1 downto 0));
end FSM;

architecture Behavioral of FSM is
    type state_type is (ST0,ST1,ST2);
    attribute ENUM_ENCODING: STRING;
    attribute ENUM_ENCODING of state_type: type is "01 10 11";
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
                if (X2 = '0') then NS <= ST1; Z <= '1';
                else NS <= ST2; Z <= '0';
                end if;
            when ST1 => 
                if (X1 = '1') then NS <= ST0; Z <= '0';
                else NS <= ST1; Z <= '0';
                end if;
            when ST2 => 
                if (X2 = '0') then NS <= ST1; Z <= '1';
                else NS <= ST2; Z <= '0';
                end if;
            when others => -- the catch all condition
                Z <= '1'; NS <= ST0;
            end case;
    end process comb_proc;
-- one-hot encoded approach
with PS select
Y <= "01" when ST0,
"10" when ST1,
"11" when ST2,
"10" when others;

end Behavioral;
