library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ProcesadorMonociclo is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           ALUResult : out  STD_LOGIC_VECTOR (31 downto 0));
end ProcesadorMonociclo;

architecture Behavioral of ProcesadorMonociclo is
	COMPONENT ProgramCounter
	PORT(
		data : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;
		clk : IN std_logic;          
		data_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	COMPONENT sumador
	PORT(
		constante : IN std_logic_vector(31 downto 0);
		data : IN std_logic_vector(31 downto 0);          
		data_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	COMPONENT InstructionMemory
	PORT(
		address : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;          
		outInstruction : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	COMPONENT CU
	PORT(
		Op : IN std_logic_vector(1 downto 0);
		Op3 : IN std_logic_vector(5 downto 0);          
		AluOp : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;

	COMPONENT RegisterFile
	PORT(
		Rs1 : IN std_logic_vector(4 downto 0);
		Rs2 : IN std_logic_vector(4 downto 0);
		Rd : IN std_logic_vector(4 downto 0);
		rst : IN std_logic;
		DataToWrite : IN std_logic_vector(31 downto 0);          
		Crs1 : OUT std_logic_vector(31 downto 0);
		Crs2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT ExtSigno
	PORT(
		imm13 : IN std_logic_vector(12 downto 0);          
		imm32 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT MUX
	PORT(
		a : IN std_logic_vector(31 downto 0);
		b : IN std_logic_vector(31 downto 0);
		opt : IN std_logic;          
		MuxOut : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

	COMPONENT ALU
	PORT(
		AluOp : IN std_logic_vector(5 downto 0);
		Crs1 : IN std_logic_vector(31 downto 0);
		Crs2 : IN std_logic_vector(31 downto 0);          
		AluResult : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

signal aux1, aux2, aux3, aux4, aux5, aux6, aux7, aux8, aux10: std_logic_vector(31 downto 0);
signal aux9: std_logic_vector(5 downto 0);
begin
	Inst_nProgramCounter: ProgramCounter PORT MAP(
		data => aux2,
		reset => reset,
		clk => clk,
		data_out => aux1
	);

	Inst_ProgramCounter: ProgramCounter PORT MAP(
		data => aux1,
		reset => reset,
		clk => clk,
		data_out => aux3
	);

	Inst_sumador: sumador PORT MAP(
		constante => "00000000000000000000000000000001" ,
		data => aux1,
		data_out => aux2
	);

	Inst_InstructionMemory: InstructionMemory PORT MAP(
		address => aux3,
		reset => reset,
		outInstruction => aux4
	);

	Inst_CU: CU PORT MAP(
		Op => aux4(31 downto 30),
		Op3 => aux4(24 downto 19),
		AluOp => aux9
	);

	Inst_RegisterFile: RegisterFile PORT MAP(
		Rs1 => aux4(18 downto 14),
		Rs2 => aux4(4 downto 0),
		Rd => aux4(29 downto 25),
		rst => reset,
		DataToWrite => aux10,
		Crs1 => aux6,
		Crs2 => aux7
	);

	Inst_ExtSigno: ExtSigno PORT MAP(
		imm13 => aux4(12 downto 0),
		imm32 => aux5
	);	

	Inst_MUX: MUX PORT MAP(
		a => aux7,
		b => aux5,
		opt => aux4(13),
		MuxOut => aux8
	);

	Inst_ALU: ALU PORT MAP(
		AluOp => aux9,
		Crs1 => aux6,
		Crs2 => aux8,
		AluResult => aux10 
	);
	ALUResult <= aux10;
end Behavioral;

