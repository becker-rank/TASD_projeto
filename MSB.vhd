library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;  --log function

entity MSB is
	generic(
		N : natural := 4;  --number of vectors
		W : natural := 8; --number of bits in each vector
	);
	port
	(
		x : in std_logic_vector(N*W - 1 downto 0);
		s : out std_logic_vector(N*W - 1 downto 0)
	);
	
end entity;

architecture structural of MSB is

	unpack : for i in 0 to N-1 generate       --separates x in N operands of W bits each
		operands(i) <= unsigned(x(((i+1)*W - 1) downto i*W));
	end generate;

	
	constant N_of_Levels : natural := integer(ceil(log2(real(N))));  --amount of levels in sumTree
	
	component CPA is
		generic(N : positive :=8 );
		port
			(
			A : in unsigned(N-1 downto 0);
			B : in unsigned(N-1 downto 0);
			S : out unsigned(N downto 0)
			);
	end component;
	

begin

	sumTree : for i in 0 to N_of_Levels generate
		
	


end structural;
	
	