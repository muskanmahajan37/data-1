grammar Data;

compilationUnit
    : importDeclaration* typeDeclaration* EOF
    ;

importDeclaration
    : IMPORT IDENTIFIER
    ;

typeDeclaration
    : operationDeclaration
    | ruleDeclaration
    | typeTypeDeclaration
    | customTypeDeclaration
    ;

customTypeDeclaration
    : 'type' typeName '{' typeAttribute* '}'
    ;

typeName: IDENTIFIER;

typeAttribute
    : 'name' ':'
    ;

//

typeTypeDeclaration
    : TYPETYPE IDENTIFIER '{' attribute* '}'
    ;

attribute: IDENTIFIER ':' predefinedType;

predefinedType: IDENTIFIER;

TYPETYPE
    : 'string'
    | 'number'
    | 'array'
    ;

operationDeclaration
    : OPERAPTION
    ;

OPERAPTION: 'operaption';

//

ruleDeclaration: RULE IDENTIFIER TRANSFORM sourceModel TO targetModel;


sourceModel: IDENTIFIER;
targetModel: IDENTIFIER;

RULE: 'rule';
TRANSFORM: 'transform';
TO: 'to';

IMPORT: 'import';
IDENTIFIER:         Letter LetterOrDigit*;

// Whitespace and comments

WS:                 [ \t\r\n\u000C]+ -> channel(HIDDEN);
COMMENT:            '/*' .*? '*/'    -> channel(HIDDEN);
LINE_COMMENT:       '//' ~[\r\n]*    -> channel(HIDDEN);

fragment LetterOrDigit
    : Letter
    | [0-9]
    ;

fragment Letter
    : [a-zA-Z$_] // these are the "java letters" below 0x7F
    | ~[\u0000-\u007F\uD800-\uDBFF] // covers all characters above 0x7F which are not a surrogate
    | [\uD800-\uDBFF] [\uDC00-\uDFFF] // covers UTF-16 surrogate pairs encodings for U+10000 to U+10FFFF
    ;
