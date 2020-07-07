import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

class Parser {
    private static final String LINE_COMMENT = "//";
    private String currentCommand;
    private FileReader fr;
    private BufferedReader br;

    enum CommandType {
        NOT_A_COMMAND,
        A_COMMAND,
        C_COMMAND,
        L_COMMAND
    }

    Parser(String file){
        try{
            fr = new FileReader(file);
            br = new BufferedReader(fr);
        }catch(IOException e){
            e.printStackTrace();
        }
    }

    boolean hasMoreCommands(){
        try{
            if(br.ready())
                return true;
            fr.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return false;
    }

    void advance(){
        try{
            while(br.ready()){
                String line = br.readLine();
                // Remove empty lines and comments.
                if(line.startsWith(LINE_COMMENT) || line.equals(""))
                    continue;
                else if(line.contains(LINE_COMMENT))
                    line = line.substring(0, line.indexOf(LINE_COMMENT));

                // Replace all white spaces with empty string.
                line = line.replaceAll("\\s+", "");

                // Set current command to line.
                currentCommand = line;
                break;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    CommandType commandType(){
        if(currentCommand.startsWith("@"))
            return CommandType.A_COMMAND;
        else if (currentCommand.contains("=") || currentCommand.contains(";"))
            return CommandType.C_COMMAND;
        else if(currentCommand.startsWith("(") && currentCommand.endsWith(")"))
            return CommandType.L_COMMAND;
        return CommandType.NOT_A_COMMAND;
    }

    String symbol(){
        return currentCommand.substring(1, currentCommand.indexOf(")"));
    }

    String dest(){
        return currentCommand.substring(0, currentCommand.indexOf("="));
    }

    String comp(){
        int start = currentCommand.indexOf("=") > -1 ? currentCommand.indexOf("=") + 1 : 0;
        int end = currentCommand.indexOf(";") > -1 ? currentCommand.indexOf(";") : currentCommand.length();
        return currentCommand.substring(start, end);
    }

    String jump(){
        if(currentCommand.contains(";"))
            return currentCommand.substring(currentCommand.indexOf(";") + 1, currentCommand.length());
        return "";
    }
}
