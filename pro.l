%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "pro.tab.h"
%}

%%

[ \t]		;
[ \n]   { yylineno = yylineno + 1;}
int	{ return INT; }
bool {return BOOL;}
continue {return CONTINUE;}
break {return BREAK;}
char {return CHAR;}
void {return VOID;}
return {return RETURN;}
byref {return BYREF;}
true {return TRUE;}
false {return FALSE;}
null {return NLL;}
'\0' {return EO;}
new {return NEW;}
delete {return DELETE;}
"/*"[a-zA-Z0-9]+"*/" ;
"//"[a-zA-Z0-9]+"\n" {yylineno = yylineno + 1;}
"//"[a-zA-Z0-9]+'\0' ;
";" {return ';';}
"*=" {return PE;}
"/=" {return DE;}
"%=" {return ME;}
"+=" {return PLE;}
"-=" {return NGE;}
"," {return ',';}
"{" {return '{';}
"}" {return '}';}
"(" {return '(';}
")" {return ')';}
double {return DOUBLE;}
for 	{return FOR;}
if	{return IF;}
else	{return ELSE;}
"<="    {return LE;}
">="    {return GE;}
"=="    {return EQ;}
"!="    {return NE;}
"&&" {return LA;}
"||" {return LO;}
">"	{return '>';}
"<"	{return '<';}
"++" {return PP;}
"--" {return NN;}
"&" {return '&';}
"*" {return '*';}
"+" {return '+';}
"-" {return '-';}
"=" {return '=';}
"!" {return '!';}
"/" {return '/';}
"%" {return '%';}
[a-zA-Z0-9]+ { yylval.sval = strdup(yytext); return ID; }


%%

