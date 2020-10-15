%{
	#include<string.h>
	#include<stdio.h>
	#include<stdlib.h>
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
	int label[20];
	int no=0;

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
	cikti=fopen("g161210008_soru4.txt","a");


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
	
	
	printf("\n\nLEX DOSYASI SCAN ISLEMINE TABI TUTULDU: BASARILI !");
	printf("\n\nYACC DOSYASI PARSE ISLEMINE TABI TUTULDU: BASARILI !\n\n");

	printf("\n\n\t\t ------------------------------------------""\n\t\t Pos Operator \tArg1 \tArg2 \tResult" "\n\t\t-------------------------------------------");

	for(i=0;i<Index;i++)
	{
		printf("\n\t\t %d\t %s\t %s\t %s\t%s",i,QUAD[i].op,QUAD[i].arg1,QUAD[i].arg2,QUAD[i].result);
	}
	printf("\n\t\t --------------------------------------------");
	

	fprintf(cikti,"\n\n\t\t ------------------------------------------""\n\t\t Pos Operator \tArg1 \tArg2 \tResult" "\n\t\t--------------------------------------------");

	for(i=0;i<Index;i++)
	{
		fprintf(cikti,"\n\t\t %d\t %s\t %s\t %s\t%s",i,QUAD[i].op,QUAD[i].arg1,QUAD[i].arg2,QUAD[i].result);
	}
	fprintf(cikti,"\n\t\t --------------------------------------------");
	
	
	printf("\n\n"); 

	fprintf(cikti,"\n\n\nISLEM TAMAMLANDI, KOD UYGUNDUR ! \n\n");
	fprintf(cikti,"\n--------------------------------------------------------------------------------------------------\n");
	printf("\n\n"); 

       	printf("----------------------------------------------\n");

       	printf("----------------------------MACHINE CODE------------------------");

	FILE *fp1,*fp2;
	char fname[10],op[10],ch;
	char operand1[8],operand2[8],result[8];
	int x=0;
	printf("\n Kaynak AST dosyasinin ismini giriniz : ");
	scanf("%s",&fname);
	fp1=fopen(fname,"r");
	fp2=fopen("cikti.txt","w");
	if(fp1==NULL || fp2==NULL)
	{
		printf("\n Dosya acilisinda hata yasandi ! ");
		exit(0);
	}

	while(!feof(fp1))
	{
		fprintf(fp2,"\n"); fscanf(fp1,"%s",op);
		x++;
		fprintf (fp2,"Row %d >> " ,x);
		if(check_label(x))
			fprintf(fp2,"\nlabel#%d: ",x);

		if(strcmp(op,"print")==0)
		{
			fscanf(fp1,"%s",result);
			fprintf(fp2,"\n\t OUT %s",result);
		}

		if(strcmp(op,"goto")==0)
		{
			fscanf(fp1,"%s %s",operand1,operand2);
			fprintf(fp2,"\n\t JMP %s,label#%s",operand1,operand2);
			label[no++]=atoi(operand2);			
		}
		
		if(strcmp(op,"[]=")==0)
		{
			fscanf(fp1,"%s %s %s",operand1,operand2,result);
			fprintf(fp2,"\n\t STORE %s[%s],%s",operand1,operand2,result);
		}
		
		if(strcmp(op,"uminus")==0)
		{
			
			fscanf(fp1,"%s %s",operand1,result);
			fprintf(fp2,"\n\t LOAD -%s,R1",operand1);
			fprintf(fp2,"\n\t STORE R1,%s",result);
		}

		switch(op[0])
		{
			case '*': fscanf(fp1,"%s %s %s",operand1,operand2,result);
			fprintf(fp2,"\n \t LOAD %s,R0",operand1);
			fprintf(fp2,"\n \t LOAD %s,R1",operand2);
			fprintf(fp2,"\n \t MUL R1,R0");
			fprintf(fp2,"\n \t STORE R0,%s",result);
			break;

			case '+': fscanf(fp1,"%s %s %s",operand1,operand2,result);
			fprintf(fp2,"\n \t LOAD %s,R0",operand1);
			fprintf(fp2,"\n \t LOAD %s,R1",operand2);
			fprintf(fp2,"\n \t ADD R1,R0");
			fprintf(fp2,"\n \t STORE R0,%s",result);
			break;
			
			case '-': fscanf(fp1,"%s %s %s",operand1,operand2,result);
			fprintf(fp2,"\n \t LOAD %s,R0",operand1);
			fprintf(fp2,"\n \t LOAD %s,R1",operand2);
			fprintf(fp2,"\n \t SUB R1,R0");
			fprintf(fp2,"\n \t STORE R0,%s",result);
			break;

			case '/': fscanf(fp1,"%s %s %s",operand1,operand2,result);
			fprintf(fp2,"\n \t LOAD %s,R0",operand1);
			fprintf(fp2,"\n \t LOAD %s,R1",operand2);
			fprintf(fp2,"\n \t DIV R1,R0");
			fprintf(fp2,"\n \t STORE R0,%s",result);
			break;
			
			case '%': fscanf(fp1,"%s %s %s",operand1,operand2,result);
			fprintf(fp2,"\n \t LOAD %s,R0",operand1);
			fprintf(fp2,"\n \t LOAD %s,R1",operand2);
			fprintf(fp2,"\n \t DIV R1,R0");
			fprintf(fp2,"\n \t STORE R0,%s",result);
			break;
			
			case '=': fscanf(fp1,"%s %s",operand1,result);
			fprintf(fp2,"\n\t STORE %s %s",operand1,result);
			break;
			
			case '>': fscanf(fp1,"%s %s %s",operand1,operand2,result);
			fprintf(fp2,"\n \t LOAD %s,R0",operand1);
			fprintf(fp2,"\n\t JGT %s,label#%s",operand2,result);
			label[no++]=atoi(result);
			break;
			
			case '<': fscanf(fp1,"%s %s %s",operand1,operand2,result);
			fprintf(fp2,"\n \t LOAD %s,R0",operand1);
			fprintf(fp2,"\n\t JLT %s,label#%d",operand2,result);
			label[no++]=atoi(result);
			break;
		}
	}
	fclose(fp2);
	fclose(fp1);

	fp2=fopen("cikti.txt","r");
	if(fp2==NULL)
	{
		printf("\n Dosya acilisinda hata yasandi ! \n");
		exit(0);
	}
	do
	{
		ch=fgetc(fp2);
		printf("%c",ch);
	} while(ch!=EOF);
	fclose(fp1);

	return 0;



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


int check_label(int k)
{
	int j;
	for(j=0;j<no;j++)
	{
		
		if(k==label[j]) {
			return 1;
		}
	}
	return 0;
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
