library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity CPA is
	generic(N : positive :=8 );
	port
	(
	A : in unsigned(N-1 downto 0);
	B : in unsigned(N-1 downto 0);
	S : out unsigned(N downto 0)
	);
end entity;

architecture structural of CPA is

	component fulladder is 
		port
		(
		a : in std_logic;
		b : in std_logic;
		cin : in std_logic;
		s : out std_logic;
		cout : out std_logic
		);
	end component;
	
	signal carry : unsigned(N downto 0);

begin 
	carry(0) <= '0';
	
	GEN_ADD : for i in 0 to (N-1) generate
	
		ADD_INS : fulladder 
			port map (
			a => A(i),
			b => B(i),
			cin => carry(i),
			s => S(i),
			cout => carry(i+1)
			);
	end generate GEN_ADD;
	S(N) <= carry(N);

end structural;