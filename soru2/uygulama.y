%{

	#include<string.h>
	#include<stdio.h>

	struct quad
	{
		char op[5];
		char arg1[10];
		char arg2[10];
		char result[10];
	}QUAD[30];
	
	struct stack
	{
		int items[100];
		int top;
	}stk;

	int Index=0,tIndex=0,StNo,Ind,tInd;
	extern int LineNo;

%}

%union
{
	char var[10];
}

%token <var> NUM ID Buyuk Kucuk Esit

%token VOID KUTUPHANE MAIN IF ELSE WHILE INT FLOAT 

%token Degil Ve Veya Yorum Noktali_virgul Virgul

%token Atama Arti Eksi Carpma Bolme Parantez_ac Parantez_kapa

%token KParantez_ac KParantez_kapa SParantez_ac SParantez_kapa

%type <var> EXPR ASSIGNMENT CONDITION IFST IFST_ ELSEST WHILELOOP

%%

LIBRARY:KUTUPHANE GLOBAL PROGRAM | KUTUPHANE PROGRAM;

//ALTTAKI 3 TANIMLAMA , GLOBAL TANIMLAMALAR ICIN TASARLANDI. 
//int x=0;   int x,y; gibi tanimlamalari tanimaktadir bunlar sayesinde.

GLOBAL: GLOBAL_ Noktali_virgul;

GLOBAL_:INT GLOBAL_VARLIST |  INT ID Atama NUM |FLOAT GLOBAL_VARLIST |  FLOAT ID Atama NUM ;

GLOBAL_VARLIST: ID Virgul VARLIST | ID;

PROGRAM : VOID MAIN BLOCK | MAIN BLOCK | CODE;

BLOCK: SParantez_ac CODE SParantez_kapa;

CODE: BLOCK | STATEMENT CODE | STATEMENT;

STATEMENT: DESCT Noktali_virgul | ASSIGNMENT Noktali_virgul | CONDST | WHILEST;

DESCT: INT VARLIST | FLOAT VARLIST ;

VARLIST: ID Virgul VARLIST | ID;




//Bu kısım deneme amaçlı yapılmıştı yöntemi değiştirdim.
/*
ARRAY_DESCT: INT ARRAYS | FLOAT ARRAYS;
ARRAY: ID KParantez_ac SAYI | KParantez_ac SAYI ; 
SAYI: NUM SAYI | KParantez_kapa | KParantez_kapa ARRAY  ;
ARRAYS: ARRAY Virgul ARRAYS | ARRAY;
*/

ASSIGNMENT: ID Atama EXPR{ 
	strcpy(QUAD[Index].op, "=");
	strcpy(QUAD[Index].arg1,$3);
	strcpy(QUAD[Index].arg2,"");
	strcpy(QUAD[Index].result,$1);
	strcpy($$,QUAD[Index++].result);
};


EXPR: EXPR Arti EXPR {AddQuadruple("+",$1,$3,$$);}
| EXPR Eksi EXPR {AddQuadruple("-",$1,$3,$$);}
| EXPR Carpma EXPR {AddQuadruple("*",$1,$3,$$);}
| EXPR Bolme EXPR {AddQuadruple("/",$1,$3,$$);}
| Eksi EXPR {AddQuadruple("UMIN",$2,"",$$);}
| Parantez_ac EXPR Parantez_kapa {strcpy($$,$2);}
| ID
| NUM
;

CONDST: IFST{
	Ind=pop();
	sprintf(QUAD[Ind].result,"%d",Index);
	Ind=pop();
	sprintf(QUAD[Ind].result,"%d",Index);
	}
|IFST_{
	Ind=pop();
	sprintf(QUAD[Ind].result,"%d",Index);
	Ind=pop();
	sprintf(QUAD[Ind].result,"%d",Index);
	}
| IFST_ ELSEST
| IFST ELSEST;

IFST: IF Parantez_ac CONDITION Parantez_kapa {
	strcpy(QUAD[Index].op,"==");
	strcpy(QUAD[Index].arg1,$3);
	strcpy(QUAD[Index].arg2,"FALSE");
	strcpy(QUAD[Index].result,"-1");
	push(Index);
	Index++;
}
BLOCK { strcpy(QUAD[Index].op,"GOTO"); strcpy(QUAD[Index].arg1,""); 
	strcpy(QUAD[Index].arg2,"");
	strcpy(QUAD[Index].result,"-1");
	push(Index);
	Index++;
};

IFST_: IF Parantez_ac Degil Parantez_ac CONDITION Parantez_kapa Parantez_kapa {
	strcpy(QUAD[Index].op,"!");
	strcpy(QUAD[Index].arg1,$5);
	strcpy(QUAD[Index].arg2,"FALSE");
	strcpy(QUAD[Index].result,"-1");
	push(Index);
	Index++;
}
BLOCK { strcpy(QUAD[Index].op,"GOTO"); strcpy(QUAD[Index].arg1,""); 
	strcpy(QUAD[Index].arg2,"");
	strcpy(QUAD[Index].result,"-1");
	push(Index);
	Index++;
};

ELSEST: ELSE{
	tInd=pop();
	Ind=pop();
	push(tInd);
	sprintf(QUAD[Ind].result,"%d",Index);
}
BLOCK{
	Ind=pop();
	sprintf(QUAD[Ind].result,"%d",Index);
};
CONDITION: ID Esit ID {AddQuadruple($2,$1,$3,$$);
			StNo=Index-1;
			}
|ID Esit NUM {AddQuadruple($2,$1,$3,$$);
			StNo=Index-1;
			}
|NUM Esit ID {AddQuadruple($2,$1,$3,$$);
			StNo=Index-1;
			}
|NUM Esit NUM {AddQuadruple($2,$1,$3,$$);
			StNo=Index-1;
			}
|ID Kucuk ID {AddQuadruple($2,$1,$3,$$);
			StNo=Index-1;
			}
|ID Kucuk NUM {AddQuadruple($2,$1,$3,$$);
			StNo=Index-1;
			}
|NUM Kucuk ID {AddQuadruple($2,$1,$3,$$);
			StNo=Index-1;
			}
|NUM Kucuk NUM {AddQuadruple($2,$1,$3,$$);
			StNo=Index-1;
			}
|ID Buyuk ID {AddQuadruple($2,$1,$3,$$);
			StNo=Index-1;
			}
|ID Buyuk NUM {AddQuadruple($2,$1,$3,$$);
			StNo=Index-1;
			}
|NUM Buyuk ID {AddQuadruple($2,$1,$3,$$);
			StNo=Index-1;
			}
|NUM Buyuk NUM {AddQuadruple($2,$1,$3,$$);
			StNo=Index-1;
			}
| ID
| NUM;

WHILEST: WHILELOOP{
		Ind=pop();
		sprintf(QUAD[Ind].result,"%d",StNo);
		Ind=pop();
		sprintf(QUAD[Ind].result,"%d",Index);
};

WHILELOOP: WHILE Parantez_ac CONDITION Parantez_kapa {
	strcpy(QUAD[Index].op,"==");
	strcpy(QUAD[Index].arg1,$3);
	strcpy(QUAD[Index].arg2,"FALSE");
	strcpy(QUAD[Index].result,"-1");
	push(Index);
	Index++;
}
BLOCK {
	strcpy(QUAD[Index].op,"GOTO");
	strcpy(QUAD[Index].arg1,"");
	strcpy(QUAD[Index].arg2,"");
	strcpy(QUAD[Index].result,"-1");
	push(Index);
	Index++;
};

%%

extern FILE *yyin;
int main(int argc,char *argv[])
{
	
	FILE *cikti;
	cikti=fopen("g161210305_soru2.txt","a");


	FILE *fp;
	int i;
	if(argc>1)
	{
		fp=fopen(argv[1],"r");
		if(!fp)
		{
			printf("\n File not found");
			exit(0);
		}
		yyin=fp;
	}
	yyparse();
	
	printf("\nISLEM TAMAMLANDI, KOD UYGUNDUR ! \n");
	fprintf(cikti,"\nISLEM TAMAMLANDI, KOD UYGUNDUR ! \n\n");

	printf("\n\n"); 
	return 0;


	/*printf("\n\n\t\t ----------------------------""\n\t\t Pos Operator \tArg1 \tArg2 \tResult" "\n\t\t--------------------");

	for(i=0;i<Index;i++)
	{
		printf("\n\t\t %d\t %s\t %s\t %s\t%s",i,QUAD[i].op,QUAD[i].arg1,QUAD[i].arg2,QUAD[i].result);
	}
	printf("\n\t\t --------------------------------------------");
	*/


}

void push(int data)
{
	stk.top++;
	if(stk.top==100)
	{
		printf("\n Stack overflow\n");
		exit(0);
	}
	stk.items[stk.top]=data;
}

int pop()
{
	int data;
	if(stk.top==-1)
	{
		printf("\n Stack underflow\n");
		exit(0);
	}
	data=stk.items[stk.top--];
	return data;
}

void AddQuadruple(char op[5],char arg1[10],char arg2[10],char result[10])
{
	strcpy(QUAD[Index].op,op);
	strcpy(QUAD[Index].arg1,arg1);
	strcpy(QUAD[Index].arg2,arg2);
	sprintf(QUAD[Index].result,"t%d",tIndex++);
	strcpy(result,QUAD[Index++].result);
}

yyerror()
{
	printf("\n Tanimlanamayan Satir Numarasi : %d",LineNo);
}
