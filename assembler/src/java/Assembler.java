import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Path;
import java.nio.file.Paths;

public class Assembler {
    private static final String OUTPUT_EXTENSION = ".hack";

    public static void main(String[] args) throws IOException {
        for (String arg : args) {
            // For each (XXX):
            // Add the pair (XXX, address) to the symbol table.
            int lineNumber = 0;
            SymbolTable symbolTable = new SymbolTable();
            Parser parser = new Parser(arg);
            while (parser.hasMoreCommands()) {
                parser.advance();
                if (parser.commandType() == Parser.CommandType.L_COMMAND) {
                    String label = parser.symbol();
                    if (symbolTable.contains(label))
                        throw new IllegalStateException("Invalid or duplicate label \"" + label + "\".");
                    else
                        symbolTable.addEntry(label, lineNumber);
                    continue;
                }
                lineNumber++;
            }

            // Binary output file.
            File currentFile = new File(arg);
            String fileName = currentFile.getName();
            int index = fileName.indexOf(".");
            if (index > 0)
                fileName = fileName.substring(0, index);
            fileName += OUTPUT_EXTENSION;
            String filePath = Paths.get(currentFile.getParent()).resolve(fileName).toString();
            File outFile = new File(filePath);
            PrintWriter printW
                = new PrintWriter(new BufferedWriter(new FileWriter(outFile)));

            int varIndex = 16;  // Variable index.
            parser = new Parser(arg);
            while (parser.hasMoreCommands()) {
                parser.advance();
                if (parser.commandType() == Parser.CommandType.A_COMMAND) {
                    String symbol = parser.symbol();
                    String line = "";
                    if (symbolTable.contains(symbol)) {
                        line = to16bitBinaryString(symbolTable.getAddress(symbol));
                    } else if (isNaturalNumber(symbol)) {
                        line = to16bitBinaryString(symbol);
                    } else {
                        symbolTable.addEntry(symbol, varIndex);
                        line = to16bitBinaryString(varIndex);
                        varIndex++;
                    }
                    printW.println(line);
                } else if(parser.commandType() == Parser.CommandType.C_COMMAND) {
                    String c = parser.comp();
                    String d = parser.dest();
                    String j = parser.jump();
                    String cc = Code.comp(c);
                    String dd = Code.dest(d);
                    String jj = Code.jump(j);

                    String line = "111" + cc + dd + jj;
                    printW.println(line);
                }
            }
            printW.flush();
            printW.close();
        }
    }

    static boolean isNaturalNumber(String numStr) {
        return numStr.matches("\\d+");
    }

    static String to16bitBinaryString(int num) {
        return String.format("%16s", Integer.toBinaryString(num)).replaceAll("\\s", "0");
    }

    static String to16bitBinaryString(String numStr) {
        int i = Integer.valueOf(numStr) & 0x7fff;
        return String.format("%16s", Integer.toBinaryString(i)).replaceAll("\\s", "0");
    }
}
