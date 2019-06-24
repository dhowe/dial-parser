lexer grammar DialLexer;

COMMENT: '//' ~[\r\n]* (NL | EOF) -> skip;

LB: '{' -> mode(META);
SET: 'SET' WS* -> mode(SET1);

EQ: '=';
WS: [ \t]+;
NL: [\r\n]+ -> skip,  mode(DEFAULT_MODE);
CMD: ('SAY' | 'WAIT' | 'DO' | 'ASK' | 'FIND' | 'OPT' | 'GO' | 'CHAT') WS*;
LABEL: '#' [A-Za-z_][A-Za-z_0-9-]*;
WORD: [0-9A-Za-z,.;:"'?]+;
ID: '$' [A-Za-z_][A-Za-z_0-9-]*;


mode SET1;

EQWS: WS* '=' WS* -> skip, mode(DEFAULT_MODE);
WS1: WS -> type(WS);
ID1: '$'? [A-Za-z_][A-Za-z_0-9-]*;


mode META;

MRB: '}' -> mode(DEFAULT_MODE);
MWS: WS -> skip;
OP: (EQ | '>'|  '<' | '>=' | '<=' | '!=' | '^=' | '$=' | '*=');
MID: '$'? [A-Za-z_][A-Za-z_0-9-]*;
COM: ',';
OQ: '\'' -> mode(METAQ);
DWORD: [0-9A-Za-z"?]+ -> type(WORD);
MDOL: '$';

mode METAQ;

CQ: '\'' -> mode(META);
QEXPR: ~('\'' | '$' | '}')+;
QID: '$' [A-Za-z_][A-Za-z_0-9-]* -> type(ID);



