grammar Dial;

chat: line+;
line: cmd WS* text? meta? NL?;
text: (CHAR | ID | WS | '?')+;
meta: '{' (ID WS* EQ WS* ID) (',' WS* ID WS* EQ WS* (MVAL|ID))* '}';
cmd: ('SAY' | 'WAIT' | 'DO' | 'ASK' | 'OPT' | 'SET' | 'GO' | 'FIND' | 'CHAT');

LB: '[';
RB: ']';
EQ: '=';
COMMA: ',';
WS: [ \t]+;
NL: [\r\n]+;
ID: [A-Za-z_][A-Za-z_0-9-]*;
MVAL: [^,}]+;
CHAR: [^{}=)(];
