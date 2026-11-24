library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity row is
	generic(
		N : natural := 4;   --number of CPA's in that row
		M : natural := 8); -- number of bits in each operand.
	port(
		x : in std_logic_vector(2*N*M - 1 downto 0);
		s : out std_logic_vector(M*N - 1 downto 0)); --half the amount of bits of x.
end entity;

architecture structural of row is

	component CPA is
		generic(N : positive :=8 );
		port(
			A : in unsigned(N-1 downto 0);
			B : in unsigned(N-1 downto 0);
			S : out unsigned(N downto 0)
			);
	end component;
	
begin

	row_generate : for i in 0 to N-1 generate
		signal to_be_sum : unsigned((i+1)*2*M -1 downto i*2*M);
		signal pair_sum : unsigned(M downto 0);
		
	begin
	
		CPA_adder : CPA
			generic map(N => M);  --each CPA will have entrys with M bits
			port map(
			A => to_be_sum(M-1 downto 0),
			B => to_be_sum(M*2-1 downto M),
			S => pair_sum
			);
		
		s((i+1)*M - 1 downto i*M) <= std_logic_vector(pair_sum(M-1 downto 0));  --discards the carry of each CPA
	end generate;

end structural;
		