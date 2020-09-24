import java.util.HashMap;

class SymbolTable{
    private HashMap<String, Integer> symbolTable = new HashMap<>();

    private static final String[] defaultSymbol = {
        "R0", "R1", "R2",  "R3",  "R4",  "R5",  "R6", "R7",
        "R8", "R9", "R10", "R11", "R12", "R13", "R14", "R15",
        "SCREEN", "KBD",
        "SP", "LCL", "ARG", "THIS", "THAT"
    };

    private static final int[] defaultSymbolValues = {
        0, 1, 2,  3,  4,  5,  6,  7,
        8, 9, 10, 11, 12, 13, 14, 15,
        16384, 24576,
        0, 1, 2, 3, 4
    };

    SymbolTable(){
        for(int i = 0 ; i < defaultSymbol.length ; i++)
            symbolTable.put(defaultSymbol[i], defaultSymbolValues[i]);
    }

    void addEntry(String symbol, int address){
        symbolTable.put(symbol, address);
    }

    boolean contains(String symbol){
        return symbolTable.containsKey(symbol);
    }

    int getAddress(String symbol){
        return symbolTable.get(symbol);
    }
}
