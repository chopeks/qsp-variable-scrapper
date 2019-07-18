lexer grammar QspLexer;

import UnicodeClasses;

ShebangLine
    : '#' ~[\u000A\u000D]*
      -> channel(HIDDEN)
    ;

LineComment
    : '!!' ~[\u000A\u000D]*
      -> channel(HIDDEN)
    ;

EndLineComment
    : AND '!' ~[\u000A\u000D]*
      -> channel(HIDDEN)
    ;

MultilineComment
    : NL '!' ~[\u000A\u000D]*
    ;

WS : [\u0020\u0009\u000C] -> skip ;
HASH : '#' -> skip ;

LINE_BREAK: '_' (WS)* NL -> skip;


// we are looking for assignments, so hack it for now

ASSIGNMENT_OPERATORS: EQ | ADD_ASSIGN | SUB_ASSIGN | MUL_ASSIGN | DIV_ASSIGN ;

// this is valid qsp lexer (to some point, but enough for purpose
NL: '\u000A' | '\u000D' '\u000A' ;

DOT: '.' ;
COMMA: ',' ;
COLON: ':' ;
EQ: '=';
EXCL_EQ: '!' ;
MOD: M O D ;

ADD_ASSIGN: ADD (WS)* EQ;
SUB_ASSIGN: SUB (WS)* EQ;
MUL_ASSIGN: MUL (WS)* EQ;
DIV_ASSIGN: DIV (WS)* EQ;

ADD: '+' ;
SUB: '-' ;
MUL: '*' ;
DIV: '/' ;

AND: '&' ;

NOT_EQ: '<>';
LANGLE: '<' ;
RANGLE: '>' ;
LE: '<=' | '=<' ;
GE: '>=' | '=>';

CONJ: A N D ;
DISJ: O R ;
NO: N O;

LCURL: '{' ;
RCURL: '}' ;
LPAREN: '(' ;
RPAREN: ')' ;
LSQUARE: '[' ;
RSQUARE: ']' ;

// keywords
IF: I F;
ELSE: E L S E;
ELSEIF: ELSE IF;
END: E N D;

SET: S E T;
LET: L E T;

LOC: L O C ;
OBJ: O B J;

StringLiteral
    : STRING (STRING)*
    | STRING_QUOT (STRING_QUOT)*
    ;

STRING: '\'' ~('\r' | '\n' | '\'' )* '\'' ;
STRING_QUOT: '"' ~('\r' | '\n' | ':' )* ':' ;

IntegerLiteral
    : ('0'
      | DecDigitNoZero DecDigit*
      | DecDigitNoZero DecDigit + DecDigit
      )
    ;

fragment A : [aA]; // match either an 'a' or 'A'
fragment B : [bB];
fragment C : [cC];
fragment D : [dD];
fragment E : [eE];
fragment F : [fF];
fragment G : [gG];
fragment H : [hH];
fragment I : [iI];
fragment J : [jJ];
fragment K : [kK];
fragment L : [lL];
fragment M : [mM];
fragment N : [nN];
fragment O : [oO];
fragment P : [pP];
fragment Q : [qQ];
fragment R : [rR];
fragment S : [sS];
fragment T : [tT];
fragment U : [uU];
fragment V : [vV];
fragment W : [wW];
fragment X : [xX];
fragment Y : [yY];
fragment Z : [zZ];

fragment DecDigit
    : UNICODE_CLASS_ND
    ;

fragment DecDigitNoZero
    : UNICODE_CLASS_ND_NoZeros
    ;

fragment UNICODE_CLASS_ND_NoZeros
	: '\u0031'..'\u0039'
	| '\u0661'..'\u0669'
	| '\u06f1'..'\u06f9'
	| '\u07c1'..'\u07c9'
	| '\u0967'..'\u096f'
	| '\u09e7'..'\u09ef'
	| '\u0a67'..'\u0a6f'
	| '\u0ae7'..'\u0aef'
	| '\u0b67'..'\u0b6f'
	| '\u0be7'..'\u0bef'
	| '\u0c67'..'\u0c6f'
	| '\u0ce7'..'\u0cef'
	| '\u0d67'..'\u0d6f'
	| '\u0de7'..'\u0def'
	| '\u0e51'..'\u0e59'
	| '\u0ed1'..'\u0ed9'
	| '\u0f21'..'\u0f29'
	| '\u1041'..'\u1049'
	| '\u1091'..'\u1099'
	| '\u17e1'..'\u17e9'
	| '\u1811'..'\u1819'
	| '\u1947'..'\u194f'
	| '\u19d1'..'\u19d9'
	| '\u1a81'..'\u1a89'
	| '\u1a91'..'\u1a99'
	| '\u1b51'..'\u1b59'
	| '\u1bb1'..'\u1bb9'
	| '\u1c41'..'\u1c49'
	| '\u1c51'..'\u1c59'
	| '\ua621'..'\ua629'
	| '\ua8d1'..'\ua8d9'
	| '\ua901'..'\ua909'
	| '\ua9d1'..'\ua9d9'
	| '\ua9f1'..'\ua9f9'
	| '\uaa51'..'\uaa59'
	| '\uabf1'..'\uabf9'
	| '\uff11'..'\uff19'
	;

fragment Letter
    : UNICODE_CLASS_LL
    | UNICODE_CLASS_LM
    | UNICODE_CLASS_LO
    | UNICODE_CLASS_LT
    | UNICODE_CLASS_LU
    | UNICODE_CLASS_NL
    ;

Identifier
    : (Letter | '_') (Letter | '_' | DecDigit)*
    | '$' (WS)* (Letter | '_') (Letter | '_' | DecDigit)*
    ;

IGNORE : . -> skip;