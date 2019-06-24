import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;

import javax.print.PrintException;

import org.antlr.v4.gui.TestRig;
import org.antlr.v4.gui.Trees;
import org.antlr.v4.runtime.*;
import org.antlr.v4.runtime.atn.PredictionMode;

public class AntlrTestRig extends TestRig
{
  public static void main(String[] args) throws Exception
  {
    TestRig testRig = new AntlrTestRig(new String[] {
        "Dial", "chat", "-tokens", "-tree", "input.txt"
    });
    testRig.process();
  }

  public AntlrTestRig(String[] arg0) throws Exception
  {
    super(arg0);
  }

  protected void process(Lexer lexer, Class<? extends Parser> parserClass, Parser parser, CharStream input) throws IOException, IllegalAccessException, InvocationTargetException, PrintException
  {
    lexer.setInputStream(input);
    CommonTokenStream tokens = new CommonTokenStream(lexer);

    tokens.fill();

    if (showTokens) {
      for (Token tok : tokens.getTokens()) {
        if (tok instanceof CommonToken) {
          System.out.println(((CommonToken) tok).toString(lexer));
        }
        else {
          System.out.println(tok.toString());
        }
      }
    }

    if (startRuleName.equals(LEXER_START_RULE_NAME)) return;

    if (diagnostics) {
      parser.addErrorListener(new DiagnosticErrorListener());
      parser.getInterpreter().setPredictionMode(PredictionMode.LL_EXACT_AMBIG_DETECTION);
    }

    if (printTree || gui || psFile != null) {
      parser.setBuildParseTree(true);
    }

    if (SLL) { // overrides diagnostics
      parser.getInterpreter().setPredictionMode(PredictionMode.SLL);
    }

    parser.setTokenStream(tokens);
    parser.setTrace(trace);

    try {
      Method startRule = parserClass.getMethod(startRuleName);
      ParserRuleContext tree = (ParserRuleContext) startRule.invoke(parser, (Object[]) null);

      if (printTree) {
        String s = tree.toStringTree(parser);
        s = s.replaceAll("\\(cmd","\n  (cmd");
        s = s.replaceAll("\\(set","\n  (set");
        s = s.replaceAll("\\(find","\n  (find");
        s = s.replaceAll("\\(expr ([^)]+)", "(expr '$1'");
        s = s.replaceAll("   ", " ");
        System.out.println("\n"+s);//.replaceAll(" ", "_"));
      }
      if (gui) {
        Trees.inspect(tree, parser);
      }
      if (psFile != null) {
        Trees.save(tree, parser, psFile); // Generate postscript
      }
    } catch (NoSuchMethodException nsme) {
      System.err.println("No method for rule " + startRuleName + " or it has arguments");
    }
  }
}
