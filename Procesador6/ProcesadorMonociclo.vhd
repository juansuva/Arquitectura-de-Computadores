-----------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity ProcesadorMonociclo is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           ALUResult : out  STD_LOGIC_VECTOR (31 downto 0));
end ProcesadorMonociclo;

architecture Behavioral of ProcesadorMonociclo is
COMPONENT sumador
	PORT(
		constante : IN std_logic_vector(31 downto 0);
		data : IN std_logic_vector(31 downto 0);          
		data_out : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	COMPONENT ProgramCounter
	PORT(
		data : IN std_logic_vector(31 downto 0);
		reset : IN std_logic;
		clk : IN std_logic;          
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
	COMPONENT WindowsManager
	PORT(
		rs1 : IN std_logic_vector(4 downto 0);
		rs2 : IN std_logic_vector(4 downto 0);
		rd : IN std_logic_vector(4 downto 0);
		op : IN std_logic_vector(1 downto 0);
		op3 : IN std_logic_vector(5 downto 0);
		cwp : IN std_logic;          
		nrs1 : OUT std_logic_vector(5 downto 0);
		nrs2 : OUT std_logic_vector(5 downto 0);
		nrd : OUT std_logic_vector(5 downto 0);
		ncwp : OUT std_logic;
		RegistroO7 : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	COMPONENT Mux_RF
	PORT(
		Rd : IN std_logic_vector(5 downto 0);
		RO7 : IN std_logic_vector(5 downto 0);
		Rfdest : IN std_logic;          
		nrd : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	COMPONENT RegisterFile
	PORT(
		Rs1 : IN std_logic_vector(5 downto 0);
		Rs2 : IN std_logic_vector(5 downto 0);
		Rd : IN std_logic_vector(5 downto 0);
		rst : IN std_logic;
		we : IN std_logic;
		DataToWrite : IN std_logic_vector(31 downto 0);          
		Crs1 : OUT std_logic_vector(31 downto 0);
		Crs2 : OUT std_logic_vector(31 downto 0);
		Crd : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
		COMPONENT ExtSigno
	PORT(
		imm13 : IN std_logic_vector(12 downto 0);          
		imm32 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
		COMPONENT CU
	PORT(
		Op : IN std_logic_vector(1 downto 0);
		Op2 : IN std_logic_vector(2 downto 0);
		Op3 : IN std_logic_vector(5 downto 0);
		icc : IN std_logic_vector(3 downto 0);
		cond : IN std_logic_vector(3 downto 0);          
		Rfdest : OUT std_logic;
		Rfsource : OUT std_logic_vector(1 downto 0);
		we : OUT std_logic;
		Wrenmem : OUT std_logic;
		Rdenmem : OUT std_logic;
		pcSource : OUT std_logic_vector(1 downto 0);
		AluOp : OUT std_logic_vector(5 downto 0)
		);
	END COMPONENT;
	COMPONENT SeuDisp22
	PORT(
		disp22 : IN std_logic_vector(21 downto 0);          
		SEUdisp22 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
		COMPONENT SeuDisp30
	PORT(
		Disp30 : IN std_logic_vector(29 downto 0);          
		SEUDisp30 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
		COMPONENT Mux_Alu
	PORT(
		Crs2 : IN std_logic_vector(31 downto 0);
		i : IN std_logic;
		signext : IN std_logic_vector(31 downto 0);          
		Op2 : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
		COMPONENT PSR
	PORT(
		nzvc : IN std_logic_vector(3 downto 0);
		clk : IN std_logic;
		rst : IN std_logic;
		ncwp : IN std_logic;          
		Carry : OUT std_logic;
		cwp : OUT std_logic;
		icc : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	COMPONENT PSRModifier
	PORT(
		AluOp : IN std_logic_vector(5 downto 0);
		AluResult : IN std_logic_vector(31 downto 0);
		Operando1 : IN std_logic;
		Operando2 : IN std_logic;
		Reset : IN std_logic;          
		nzvc : OUT std_logic_vector(3 downto 0)
		);
	END COMPONENT;
	COMPONENT ALU
	PORT(
		AluOp : IN std_logic_vector(5 downto 0);
		Crs1 : IN std_logic_vector(31 downto 0);
		Crs2 : IN std_logic_vector(31 downto 0);
		Carry : IN std_logic;          
		AluResult : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	
		COMPONENT DataMemory
	PORT(
		crd : IN std_logic_vector(31 downto 0);
		Address : IN std_logic_vector(31 downto 0);
		Wrenmem : IN std_logic;
		Rdenmem : IN std_logic;          
		Datatomem : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	COMPONENT Mux_PC
	PORT(
		Pcsource : IN std_logic_vector(1 downto 0);
		Disp30 : IN std_logic_vector(31 downto 0);
		Disp22 : IN std_logic_vector(31 downto 0);
		PC : IN std_logic_vector(31 downto 0);
		AluOut : IN std_logic_vector(31 downto 0);          
		Salida : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;
	COMPONENT Mux_Datamem
	PORT(
		Datatomem : IN std_logic_vector(31 downto 0);
		AluResult : IN std_logic_vector(31 downto 0);
		PC : IN std_logic_vector(31 downto 0);
		Rfsource : IN std_logic_vector(1 downto 0);          
		Datatoreg : OUT std_logic_vector(31 downto 0)
		);
	END COMPONENT;

signal omuxpc, onpc, sumout, opc, oim, instr, omuxdm, ocrs1, ocrs2 : STD_LOGIC_VECTOR(31 downto 0);
signal ocrd, ext13, omuxalu, odisp22, ext22, ext30, odisp30, oalu, datomem : STD_LOGIC_VECTOR(31 downto 0);
signal wind, nextwind, imuxrf, wrf, idm, idm2, acarreo : STD_LOGIC;
signal onrs1, onrs2, onrd, outo7, omuxrf, ialu : STD_LOGIC_VECTOR(5 downto 0);
signal sig, opsrm: STD_LOGIC_VECTOR(3 downto 0);
signal imuxdm, imuxpc: STD_LOGIC_VECTOR(1 downto 0);
begin
		Inst_sumador: sumador PORT MAP(
		constante => "00000000000000000000000000000001",
		data => onpc,
		data_out => sumout
	);

	Inst_nProgramCounter: ProgramCounter PORT MAP(
		data => omuxpc,
		reset => rst,
		clk => clk,
		data_out => onpc
	);
	
	Inst_ProgramCounter: ProgramCounter PORT MAP(
		data => onpc,
		reset => rst,
		clk => clk,
		data_out => opc
	);
	
	Inst_InstructionMemory: InstructionMemory PORT MAP(
		address => opc,
		reset => rst,
		outInstruction => instr
	);
	
	Inst_WindowsManager: WindowsManager PORT MAP(
		rs1 => instr(18 downto 14),
		rs2 => instr(4 downto 0),
		rd => instr(29 downto 25),
		op => instr(31 downto 30),
		op3 => instr(24 downto 19),
		cwp => wind,
		nrs1 => onrs1,
		nrs2 => onrs2,
		nrd => onrd,
		ncwp => nextwind,
		RegistroO7 => outo7
	);
	
	Inst_Mux_RF: Mux_RF PORT MAP(
		Rd => onrd,
		RO7 => outo7,
		Rfdest => imuxrf,
		nrd => omuxrf
	);
	
	Inst_RegisterFile: RegisterFile PORT MAP(
		Rs1 => onrs1,
		Rs2 => onrs2,
		Rd => omuxrf,
		rst => rst,
		we => wrf,
		DataToWrite => omuxdm,
		Crs1 => ocrs1,
		Crs2 => ocrs2,
		Crd => ocrd
	);
	
	Inst_ExtSigno: ExtSigno PORT MAP(
		imm13 => instr(12 downto 0),
		imm32 => ext13
	);
	
	Inst_CU: CU PORT MAP(
		Op => instr(31 downto 30),
		Op2 => instr(24 downto 22),
		Op3 => instr(24 downto 19),
		icc => sig,
		cond => instr(28 downto 25),
		Rfdest => imuxrf,
		Rfsource => imuxdm,
		we => wrf,
		Wrenmem => idm,
		Rdenmem => idm2,
		pcSource => imuxpc,
		AluOp => ialu
	);
	Inst_SeuDisp22: SeuDisp22 PORT MAP(
		disp22 => instr(21 downto 0),
		SEUdisp22 => ext22
	);
	Inst_SeuDisp30: SeuDisp30 PORT MAP(
		Disp30 => instr(29 downto 0),
		SEUDisp30 => ext30
	);
	Inst_Mux_Alu: Mux_Alu PORT MAP(
		Crs2 => ocrs2,
		i => instr(13),
		signext => ext13,
		Op2 => omuxalu
	);
	Inst_PSR: PSR PORT MAP(
		nzvc => opsrm,
		clk => clk,
		rst => rst,
		ncwp => nextwind,
		Carry => acarreo,
		cwp => wind,
		icc => sig
	);
	Inst_PSRModifier: PSRModifier PORT MAP(
		AluOp => ialu,
		AluResult => oalu,
		Operando1 => ocrs1(31),
		Operando2 => omuxalu(31),
		Reset => rst,
		nzvc => opsrm
	);
	Inst_ALU: ALU PORT MAP(
		AluOp => ialu,
		Crs1 => ocrs1,
		Crs2 => omuxalu,
		Carry => acarreo,
		AluResult => oalu
	);
	
	Inst_disp22sumador: sumador PORT MAP(
		constante => opc,
		data => ext22,
		data_out => odisp22
	);
	Inst_IMsumador: sumador PORT MAP(
		constante => ext30,
		data => opc,
		data_out => odisp30
	);
	Inst_DataMemory: DataMemory PORT MAP(
		crd => ocrd,
		Address => oalu,
		Wrenmem => idm,
		Rdenmem => idm2,
		Datatomem => datomem
	);
	Inst_Mux_PC: Mux_PC PORT MAP(
		Pcsource => imuxpc,
		Disp30 => odisp30,
		Disp22 => odisp22,
		PC => sumout,
		AluOut => oalu,
		Salida => omuxpc
	);
	Inst_Mux_Datamem: Mux_Datamem PORT MAP(
		Datatomem => datomem,
		AluResult => oalu,
		PC => opc,
		Rfsource => imuxdm,
		Datatoreg => omuxdm
	);
	ALUResult <= omuxdm;
end Behavioral;

