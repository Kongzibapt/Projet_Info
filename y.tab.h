/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

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

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

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
    tMAIN = 258,
    tOB = 259,
    tCB = 260,
    tCONST = 261,
    tINT = 262,
    tADD = 263,
    tSUB = 264,
    tMUL = 265,
    tDIV = 266,
    tEQ = 267,
    tOP = 268,
    tCP = 269,
    tSPACE = 270,
    tTAB = 271,
    tCOMMA = 272,
    tENDL = 273,
    tSEMI = 274,
    tPRINT = 275,
    tMULTDEF = 276,
    tERROR = 277,
    tIF = 278,
    tELSE = 279,
    tWHILE = 280,
    tSUP = 281,
    tINF = 282,
    tNOT = 283,
    tAND = 284,
    tOR = 285,
    tINTVAL = 286,
    tID = 287
  };
#endif
/* Tokens.  */
#define tMAIN 258
#define tOB 259
#define tCB 260
#define tCONST 261
#define tINT 262
#define tADD 263
#define tSUB 264
#define tMUL 265
#define tDIV 266
#define tEQ 267
#define tOP 268
#define tCP 269
#define tSPACE 270
#define tTAB 271
#define tCOMMA 272
#define tENDL 273
#define tSEMI 274
#define tPRINT 275
#define tMULTDEF 276
#define tERROR 277
#define tIF 278
#define tELSE 279
#define tWHILE 280
#define tSUP 281
#define tINF 282
#define tNOT 283
#define tAND 284
#define tOR 285
#define tINTVAL 286
#define tID 287

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 7 "compilator.y"
 int nb; char var; 

#line 124 "y.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
