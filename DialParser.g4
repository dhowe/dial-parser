parser grammar DialParser;

options { tokenVocab=DialLexer; }

chat: (cmd | set)+;
set: SET ident expr WS*;
cmd: CMD expr? WS* label? WS* meta? WS*;
expr: (WORD | id) (WS+ (WORD | id))*;
meta: LB kv (COM kv)* MRB;
val: (MID | (OQ (QEXPR | MID)+ CQ));

kv: key op val;
id: ID;
op: OP;
key: MID;
ident: ID1;
label: LABEL; 