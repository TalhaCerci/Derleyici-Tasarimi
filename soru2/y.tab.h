/* A Bison parser, made by GNU Bison 3.0.4.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    NUM = 258,
    ID = 259,
    Buyuk = 260,
    Kucuk = 261,
    Esit = 262,
    VOID = 263,
    KUTUPHANE = 264,
    MAIN = 265,
    IF = 266,
    ELSE = 267,
    WHILE = 268,
    INT = 269,
    FLOAT = 270,
    Degil = 271,
    Ve = 272,
    Veya = 273,
    Yorum = 274,
    Noktali_virgul = 275,
    Virgul = 276,
    Atama = 277,
    Arti = 278,
    Eksi = 279,
    Carpma = 280,
    Bolme = 281,
    Parantez_ac = 282,
    Parantez_kapa = 283,
    KParantez_ac = 284,
    KParantez_kapa = 285,
    SParantez_ac = 286,
    SParantez_kapa = 287
  };
#endif
/* Tokens.  */
#define NUM 258
#define ID 259
#define Buyuk 260
#define Kucuk 261
#define Esit 262
#define VOID 263
#define KUTUPHANE 264
#define MAIN 265
#define IF 266
#define ELSE 267
#define WHILE 268
#define INT 269
#define FLOAT 270
#define Degil 271
#define Ve 272
#define Veya 273
#define Yorum 274
#define Noktali_virgul 275
#define Virgul 276
#define Atama 277
#define Arti 278
#define Eksi 279
#define Carpma 280
#define Bolme 281
#define Parantez_ac 282
#define Parantez_kapa 283
#define KParantez_ac 284
#define KParantez_kapa 285
#define SParantez_ac 286
#define SParantez_kapa 287

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 26 "uygulama.y" /* yacc.c:1909  */

	char var[10];

#line 122 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
