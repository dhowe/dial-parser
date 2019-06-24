parser grammar DialParser;

options { tokenVocab=DialLexer; }

chat: (cmd | set)+;
set: SET ident expr WS*;
//find: CMDFIND (label | query) WS*;
cmd: CMD expr? WS* label? WS* meta? WS*;
expr: WORD (WS+ WORD)*;
meta: LB kv (COM kv)* MRB;
kv: key EQ val;
val: (MID | (DQ expr DQ));
key: MID;
ident: ID1;
label: LABEL; 

// WORKING HERE ***
query: LB kv (COM kv)* MRB;