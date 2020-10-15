%{
#include"y.tab.h"

int LineNo=1;

%}

ID [a-zA-Z][_a-zA-Z0-9]*
number [0-9]+|([0-9]*\.[0-9]+)

%%



#.* return KUTUPHANE;
void return VOID;
main\(\) return MAIN;

if return IF;
else return ELSE;
while return WHILE;
int return INT;
float return FLOAT;

{ID} {strcpy(yylval.var,yytext);return ID;}
{ID}("["[0-9]+"]")+ {strcpy(yylval.var,yytext);return ID;}
{ID}("["[a-zA-Z]+"]")+ {strcpy(yylval.var,yytext);return ID;}
{number} {strcpy(yylval.var,yytext);return NUM;}


\< {strcpy(yylval.var,yytext); return Kucuk;}
\> {strcpy(yylval.var,yytext); return Buyuk;}
== {strcpy(yylval.var,yytext); return Esit;}
\!  return Degil;
\/ return Bolme;
\* return Carpma;
\- return Eksi;
\+ return Arti;
\= return Atama;
\( return Parantez_ac;
\)(\;)? return Parantez_kapa;
\&& return Ve;
"||" return Veya;
"/*"({ID}(("["[a-zA-Z]+"]")*)(("["[0-9]+"]")+))"*/"  return Yorum;
\{ return SParantez_ac;
\} return SParantez_kapa;
"[" return KParantez_ac;
"]" return KParantez_kapa;
\; return Noktali_virgul;
\, return Virgul;

[ \t] ;
\n LineNo++;
. return yytext[0];

%%
