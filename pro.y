%{
#include <stdio.h>
#include <string.h>
#include <ctype.h>
void yyerror(char *); 
extern FILE *yyin;								
extern FILE *yyout;	
int yylex();
extern int yylineno;
extern char *yytext;
extern void eat_to_sem();
int errors;
char metavs[100][100];
char syns[100][100];
int i;
int j;
%}

%union {
	char *sval;
}

%token CONTINUE BREAK RETURN
%token INT CHAR BOOL DOUBLE VOID BYREF
%token IF ELSE FOR TRUE FALSE NLL NEW
%token DELETE PE LO LA NE EQ GE LE PLE ME DE NGE PP NN
%token <sval> ID 
%token EO
%left ','
%right '=' PLE NGE ME DE PE
%right ':' '?'
%left LO
%left LA
%left '&'
%left EQ NE
%left '<' '>' LE GE
%left '+' '-'
%left '*' '/' '%'
%right '!' PP NN
%left '(' ')' '[' ']'
%%

prog : dec x {printf("Ολοκληρώθηκε ο έλεγχος στο αρχειο εισοδου\n");}
    ;
x: dec x
    |
    ;
dec :   decvar
    |   decfun
    |   deffun 
    ;
decvar : datatype dilot y';' 
    |   error ';'
    |   error  datatype
    |   error EO
    
    ;
y : y ','dilot
    |
    ;
datatype : basetype
    |   basetype z
    ;
z :     z '*'
    |   '*'
    ;
basetype : INT
    |   CHAR
    |   BOOL
    |   DOUBLE
    |   VOID
    ;
dilot : ID '['sekfr']' { strcpy(metavs[i],$1); i++; }
    |   ID { strcpy(metavs[i],$1); i++; }
    ;
decfun : datatype ID'('lparam')'';' { strcpy(syns[j],$2); j++; }
    |   datatype ID'('')'';' { strcpy(syns[j],$2); j++; }
    |   error ';'
    |   error  datatype
    |   error EO
    ;
lparam : param
    | lparam',' param
    ;
param : datatype ID
    |   BYREF datatype ID
    ;
deffun : datatype ID'('')''{''}' { int x,flag=0; for (x=0; x<i; x++){if (strcmp(syns[x],$2)==0) {flag=1;}} if (flag == 0 ) {printf("Den exeis dilosei sunartisi %s\n",$2); }}
    |   datatype ID'('lparam')''{''}' { int x,flag=0; for (x=0; x<i; x++){if (strcmp(syns[x],$2)==0) {flag=1;}} if (flag == 0 ) {printf("Den exeis dilosei sunartisi %s\n",$2); }}
    |   datatype ID '('lparam')''{'decvars'}' { int x,flag=0; for (x=0; x<i; x++){if (strcmp(syns[x],$2)==0) {flag=1;}} if (flag == 0 ) {printf("Den exeis dilosei sunartisi %s\n",$2); }}
    |   datatype ID '('')''{'decvars'}' { int x,flag=0; for (x=0; x<i; x++){if (strcmp(syns[x],$2)==0) {flag=1;}} if (flag == 0 ) {printf("Den exeis dilosei sunartisi %s\n",$2); }}
    |   datatype ID '('')''{'prots'}' { int x,flag=0; for (x=0; x<i; x++){if (strcmp(syns[x],$2)==0) {flag=1;}} if (flag == 0 ) {printf("Den exeis dilosei sunartisi %s\n",$2); }}
    |   datatype ID '('lparam')''{'prots'}' { int x,flag=0; for (x=0; x<i; x++){if (strcmp(syns[x],$2)==0) {flag=1;}} if (flag == 0 ) {printf("Den exeis dilosei sunartisi %s\n",$2); }}
    |   datatype ID '('')''{'decvars prots'}' { int x,flag=0; for (x=0; x<i; x++){if (strcmp(syns[x],$2)==0) {flag=1;}} if (flag == 0 ) {printf("Den exeis dilosei sunartisi %s\n",$2); }}
    |   datatype ID '('lparam')''{'decvars prots'}' { int x,flag=0; for (x=0; x<i; x++){if (strcmp(syns[x],$2)==0) {flag=1;}} if (flag == 0 ) {printf("Den exeis dilosei sunartisi %s\n",$2); }}
    |   error ';'
    |   error  datatype
    |   error EO
    ;
decvars : decvar
    |   decvars decvar
    ;
prots : prot
    |   prots prot
    ;
prot : ';'
    |   ekfr';'
    |   '{''}'
    |   '{'prots'}'
    |   IF'('ekfr')' prot
    |   IF'('ekfr')' prot ELSE prot
    |   ID':'FOR'('';'';'')'prot
    |   ID':'FOR'('';'';'ekfr')'prot
    |   ID':'FOR'('';'ekfr';'')'prot
    |   ID':'FOR'('';'ekfr';'ekfr')'prot
    |   ID':'FOR'('ekfr';'';'')'prot
    |   ID':'FOR'('ekfr';'';'ekfr')'prot
    |   ID':'FOR'('ekfr';'ekfr';'')'prot
    |   ID':'FOR'('ekfr';'ekfr';'ekfr')'prot
    |   FOR'('';'';'')'prot
    |   FOR'('';'';'ekfr')'prot
    |   FOR'('';'ekfr';'')'prot
    |   FOR'('';'ekfr';'ekfr')'prot
    |   FOR'('ekfr';'';'')'prot
    |   FOR'('ekfr';'';'ekfr')'prot
    |   FOR'('ekfr';'ekfr';'')'prot
    |   FOR'('ekfr';'ekfr';'ekfr')'prot
    |   CONTINUE ID';'
    |   CONTINUE ';'
    |   BREAK ID';'
    |   BREAK ';'
    |   RETURN ekfr ';'
    |   RETURN ';'
    ;
ekfr : ID { int x,flag=0; for (x=0; x<i; x++){if (strcmp(metavs[x],$1)==0) {flag=1;}} if (flag == 0) { int flag2=0; int y;  for (y=0; y<strlen($1); y++){if (isdigit($1[y])){flag2++;} } if(flag2!=strlen($1)) { printf("Den exeis dilosei metavliti %s\n",$1);}} }
    |   '('ekfr')'
    |   TRUE
    |   FALSE  
    |   NLL
    |   ID '('lekfr')'
    |   '('lekfr')'
    |   ekfr'['ekfr']'
    |   mtel ekfr
    |   ekfr dtel ekfr
    |   mtelan ekfr
    |   ekfr mtelan
    |   ekfr dtelan ekfr
    |   '('datatype')'ekfr
    |   ekfr '?' ekfr ':' ekfr
    |   NEW datatype
    |   NEW datatype '['ekfr']'
    |   DELETE ekfr
lekfr : ekfr 
    | lekfr',' ekfr
    ;
sekfr : ekfr
    ;
mtel : '&'
    |   '*'
    |   '+'
    |   '-'
    |   '!'
    ;
dtel : '*'
    |   '/'
    |   '%'
    |   '+'
    |   '-'
    |   '<'
    |   '>'
    |   LE
    |   GE
    |   EQ
    |   NE
    |   LA
    |   LO
    |   ','
    ;
mtelan : PP
    |   NN
    ;
dtelan : '='
    |   PE
    |   DE
    |   ME
    |   PLE
    |   NGE
    ;



%%								    
    
void yyerror(char *s) {
    printf("Λάθος στήν γραμμή %d\n",yylineno);
    errors++;
}	
						
int main (int argc, char** argv) {
  errors = 0;
  i = 0;
  j = 0;
  if (argc < 2) {
      return 0;
  }
  yyin = fopen( argv[1], "r" );
  if (yyin == NULL){
      return 0;
  }
  do {
		yyparse();
  } while (!feof(yyin));
  printf("Βρήκα %d λάθοι\n",errors);
  return 0;
}   
	

