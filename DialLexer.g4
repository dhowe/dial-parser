lexer grammar DialLexer;

COMMENT: '//' ~[\r\n]* (NL | EOF) -> skip;

LB: '{' -> mode(META);
SET: 'SET' WS* -> mode(SET1);
//FIND: 'FIND' WS*  -> mode(FIND2);

DQ: '"';
EQ: '=';
WS: [ \t]+;
NL: [\r\n]+ -> skip,  mode(DEFAULT_MODE);
CMD: ('SAY' | 'WAIT' | 'DO' | 'ASK' | 'FIND' | 'OPT' | 'GO' | 'CHAT') WS*;
LABEL: '#' [A-Za-z_][A-Za-z_0-9-]*;
WORD: [0-9A-Za-z,.;:"'?]+;
 

mode SET1;

EQWS: WS* '=' WS* -> skip, mode(DEFAULT_MODE);
WS1: WS -> type(WS);
ID1: '$'? [A-Za-z_][A-Za-z_0-9-]*;


mode FIND2;

NL2: [\r\n]+ -> skip, mode(DEFAULT_MODE);
FOP: ('='|'<='|'>='|'!='|'^='|'$='|'*=');
WS2: WS -> skip;
LABEL2: '#' [A-Za-z_][A-Za-z_0-9-]* -> type(LABEL); 
FLB: '{' -> mode(META);


mode META;

MRB: '}' -> mode(DEFAULT_MODE);
MWS: WS -> skip;
MEQ: EQ -> type(EQ);
MID: [A-Za-z_][A-Za-z_0-9-]*;
COM: ',';


mode QUERY;

QRB: '}' -> mode(DEFAULT_MODE);
QWS: WS -> skip;
QEQ: EQ -> type(EQ);
QID: [A-Za-z_][A-Za-z_0-9-]*;
QOM: ',';
