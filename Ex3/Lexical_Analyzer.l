%{
#include <stdio.h>
#include <stdlib.h>

extern FILE *yyin;
%}

%option caseless

%%

"select"|"from"|"where"|"as"|"distinct"|"order"|"by"|"group"|"having"|"limit"|"like"|"join" {
    printf("<Keyword, %s>\n", yytext);
}

"and"|"or"|"not" {
    printf("<Logical_Operator, %s>\n", yytext);
}

"="|"!="|"<>"|"<="|">="|"<"|">" {
    printf("<Relational_Operator, %s>\n", yytext);
}

"count"|"sum"|"avg"|"min"|"max" {
    printf("<Function, %s>\n", yytext);
}

"*" {
    printf("<Asterisk, %s>\n", yytext);
}

[0-9]+(\.[0-9]+)? {
    printf("<Number, %s>\n", yytext);
}

(\.[0-9]+) {
    printf("<Floating_Point, %s>\n", yytext);
}

[a-zA-Z_][a-zA-Z0-9_]* {
    printf("<Identifier, %s>\n", yytext);
}

\'[^\']*\' {
    printf("<String, %s>\n", yytext);
}

\"[^\"]*\" {
    printf("<String, %s>\n", yytext);
}

";" {
    printf("<Semicolon_Character, %s>\n", yytext);
}

"," {
    printf("<Comma_Character, %s>\n", yytext);
}

[\(\)] {
    printf("<Parenthesis, %s>\n", yytext);
}

"+" {
    printf("<Addition_Operator, %s>\n", yytext);
}

"-" {
    printf("<Subtraction_Operator, %s>\n", yytext);
}

"/" {
    printf("<Division_Operator, %s>\n", yytext);
}

[ \t\n]+ { 
    /* Ignore whitespace and newlines */ 
}

. {
    printf("<Unknown, %s>\n", yytext);
}

%%

int yywrap() {
    return 1;
}

int main() {
    yyin = fopen("input.txt", "r");
    if (!yyin) {
        printf("Could not open file\n");
        return 1;
    }

    yylex();
    fclose(yyin);
    return 0;
}
