import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Path;
import java.nio.file.Paths;

public class Assembler{
    private static final String OUTPUT_EXTENSION = ".hack";

    public static void main(String[] args) throws IOException{
        Parser parser;
        for(String arg: args){
            File currentFile = new File(arg);
            String fileName = currentFile.getName();
            int index = fileName.indexOf(".");
            if(index > 0)
                fileName = fileName.substring(0, index);
            fileName += OUTPUT_EXTENSION;
            String filePath = Paths.get(currentFile.getParent()).resolve(fileName).toString();
            File outFile = new File(filePath);

            PrintWriter printW
                = new PrintWriter(new BufferedWriter(new FileWriter(outFile)));

            parser = new Parser(arg);
            while(parser.hasMoreCommands()){
                String line = "";
                parser.advance();
                if(parser.commandType() == Parser.CommandType.A_COMMAND
                    || parser.commandType() == Parser.CommandType.L_COMMAND){
                    int i = Integer.valueOf(parser.symbol()) & 0xffff;
                    line = "0" + String.format("%15s", Integer.toBinaryString(i)).replaceAll("\\s", "0");
                }else if(parser.commandType() == Parser.CommandType.C_COMMAND){
                    String c = parser.comp();
                    String d = parser.dest();
                    String j = parser.jump();
                    String cc = Code.comp(c);
                    String dd = Code.dest(d);
                    String jj = Code.jump(j);

                    line = "111" + cc + dd + jj;
                }
                printW.println(line);
            }
            printW.flush();
            printW.close();
        }
    }
}
