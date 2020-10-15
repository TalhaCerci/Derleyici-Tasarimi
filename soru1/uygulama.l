%{

	#include <ctype.h>
	#include <string.h>
	#include<stdio.h>
	int COMMENT=0;	

%}
ID [a-zA-Z][a-zA-Z0-9]*
NUMBER ([0-9]+)|([0-9]*\.[0-9]+)


%%
	FILE *cikti;
	cikti=fopen("g161210008_soru1.txt","w");

#.* {printf("\n%s --- KUTUPHANE ",yytext);fprintf(cikti,"\n%s --- KUTUPHANE ",yytext);}
void {printf("\n%s --- VOID ",yytext);fprintf(cikti,"\n%s --- VOID ",yytext);}
main\(\) {printf("\n%s --- MAIN ",yytext);fprintf(cikti,"\n%s --- MAIN ",yytext);}
int {printf("\n%s --- INT ",yytext);fprintf(cikti,"\n%s --- INT ",yytext);}
float {printf("\n%s --- FLOAT ",yytext);fprintf(cikti,"\n%s --- FLOAT ",yytext);}
while {printf("\n%s --- WHILE ",yytext);fprintf(cikti,"\n%s --- WHILE ",yytext);}
if {printf("\n%s --- IF ",yytext);fprintf(cikti,"\n%s --- IF ",yytext);}
else {printf("\n%s --- ELSE ",yytext);fprintf(cikti,"\n%s --- ELSE ",yytext);}


{ID} {if(!COMMENT)printf("\n%s --- ID ",yytext);fprintf(cikti,"\n%s --- ID ",yytext);}
{NUMBER} {if(!COMMENT)printf("\n%s --- SAYI(LAR) ",yytext);fprintf(cikti,"\n%s --- SAYI(LAR) ",yytext);}


"/*" {COMMENT=1;}{printf("\n%s --- Yorum ",yytext);fprintf(cikti,"\n%s --- Yorum ",yytext);}
\( {if(!COMMENT)printf("\n%s --- Parantez_ac ",yytext);fprintf(cikti,"\n%s --- Parantez_ac ",yytext);}
\{ {if(!COMMENT)printf("\n%s --- SParantez_ac ",yytext);fprintf(cikti,"\n%s --- SParantez_ac ",yytext);}
\} {if(!COMMENT)printf("\n%s --- SParantez_kapa ",yytext);fprintf(cikti,"\n%s --- SParantez_kapa ",yytext);}
\[ {if(!COMMENT)printf("\n%s --- KParantez_ac ",yytext);fprintf(cikti,"\n%s --- KParantez_ac ",yytext);}
\] {if(!COMMENT)printf("\n%s --- KParantez_kapa ",yytext);fprintf(cikti,"\n%s --- KParantez_kapa ",yytext);}
\; {if(!COMMENT)printf("\n%s --- Noktali_virgul ",yytext);fprintf(cikti,"\n%s --- Noktali_virgul ",yytext);}
\, {if(!COMMENT)printf("\n%s --- Virgul ",yytext);fprintf(cikti,"\n%s --- Virgul ",yytext);}
\)(\;)? {if(!COMMENT)printf("\n%s --- Parantez_kapa ",yytext);fprintf(cikti,"\n%s --- Parantez_kapa ",yytext);}
\".*\" {if(!COMMENT)printf("\n");}
[0-9]+ {if(!COMMENT)printf("\n");}
= {if(!COMMENT)printf("\n%s --- Atama ",yytext);fprintf(cikti,"\n%s --- Atama ",yytext);}
== {if(!COMMENT)printf("\n%s --- Esit ",yytext);fprintf(cikti,"\n%s --- Esit ",yytext);}
\< {if(!COMMENT)printf("\n%s --- Kucuk ",yytext);fprintf(cikti,"\n%s --- Kucuk ",yytext);}
\> {if(!COMMENT)printf("\n%s --- Buyuk ",yytext);fprintf(cikti,"\n%s --- Buyuk ",yytext);}
\+ {if(!COMMENT)printf("\n%s --- Arti ",yytext);fprintf(cikti,"\n%s --- Arti ",yytext);}
\- {if(!COMMENT)printf("\n%s --- Eksi ",yytext);fprintf(cikti,"\n%s --- Eksi ",yytext);}
\* {if(!COMMENT)printf("\n%s --- Carpma ",yytext);fprintf(cikti,"\n%s --- Carpma ",yytext);}
\/ {if(!COMMENT)printf("\n%s --- Bolu ",yytext);fprintf(cikti,"\n%s --- Bolu ",yytext);}
\&& {if(!COMMENT)printf("\n%s --- Ve ",yytext);fprintf(cikti,"\n%s --- Ve ",yytext);}
"||" {if(!COMMENT)printf("\n%s --- Veya ",yytext);fprintf(cikti,"\n%s --- Veya ",yytext);}
\! {if(!COMMENT)printf("\n%s --- Degil ",yytext);fprintf(cikti,"\n%s --- Degil ",yytext);}


%%


int yywrap(){return(1);}

int main(){

	char fileName[25];
	//Burada dosya adının .c uzantısıyla beraber girilmesi gerekli.
	printf("Dosya Adi Giriniz -> ");
	scanf("%s",fileName);

	FILE *file;
	file=fopen(fileName,"r");
	if(!file){printf("Dosya Acilmadi ! ");exit(0);}
	yyin=file;
	yylex();
	printf("\n");


	return 0;
}
