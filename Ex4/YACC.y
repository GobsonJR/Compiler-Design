%{
#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);
%}

%token SELECT FROM WHERE ID NUM STAR COMMA OP

%%

S : SELECT C FROM ID
    {
        printf("Parsed successfully\n");
    }
  | SELECT C FROM ID WHERE ID OP NUM
    {
        printf("Parsed successfully\n");
    }
  ;

C : STAR
  | ID
  | ID COMMA C
  ;

%%

int yylex(void)
{
    int ch;

    /* Ignore white spaces */
    while ((ch = getchar()) == ' ' || ch == '\t' || ch == '\n')
        ;

    /* End of input */
    if (ch == EOF)
        return 0;

    /* STAR */
    if (ch == '*')
        return STAR;

    /* COMMA */
    if (ch == ',')
        return COMMA;

    /* Operators */
    if (ch == '=' || ch == '>' || ch == '<' || ch == '!')
        return OP;

    /* Number */
    if (isdigit(ch))
    {
        while (isdigit(ch = getchar()))
            ;

        ungetc(ch, stdin);
        return NUM;
    }

    /* Identifier or SQL keyword */
    if (isalpha(ch))
    {
        char word[100];
        int i = 0;

        word[i++] = ch;

        while (isalnum(ch = getchar()) || ch == '_')
        {
            word[i++] = ch;
        }

        word[i] = '\0';

        ungetc(ch, stdin);

        if (strcmp(word, "SELECT") == 0)
            return SELECT;

        if (strcmp(word, "FROM") == 0)
            return FROM;

        if (strcmp(word, "WHERE") == 0)
            return WHERE;

        return ID;
    }

    return ch;
}

int main(void)
{
    printf("Enter SQL SELECT statement:\n");

    yyparse();

    return 0;
}

void yyerror(const char *s)
{
    printf("Not parsed successfully\n");
}
