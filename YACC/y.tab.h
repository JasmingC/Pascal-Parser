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
    ID = 258,
    PROGRAM = 259,
    VAR = 260,
    INTEGER = 261,
    IF = 262,
    THEN = 263,
    Begin = 264,
    END = 265,
    FOR = 266,
    DO = 267,
    TO = 268,
    OF = 269,
    ARRAY = 270,
    READ = 271,
    WRITE = 272,
    INT = 273,
    REAL = 274,
    EQUAL = 275,
    LT = 276,
    RT = 277,
    LE = 278,
    RE = 279,
    DOTDOT = 280,
    MOD = 281,
    SYMBOL = 282,
    STR = 283,
    STRING = 284,
    APO = 285,
    DOT = 286,
    ASSIGN = 287,
    WRITELN = 288,
    PLUS = 289,
    MINUS = 290,
    MUL = 291,
    DIV = 292,
    ELSE = 293
  };
#endif
/* Tokens.  */
#define ID 258
#define PROGRAM 259
#define VAR 260
#define INTEGER 261
#define IF 262
#define THEN 263
#define Begin 264
#define END 265
#define FOR 266
#define DO 267
#define TO 268
#define OF 269
#define ARRAY 270
#define READ 271
#define WRITE 272
#define INT 273
#define REAL 274
#define EQUAL 275
#define LT 276
#define RT 277
#define LE 278
#define RE 279
#define DOTDOT 280
#define MOD 281
#define SYMBOL 282
#define STR 283
#define STRING 284
#define APO 285
#define DOT 286
#define ASSIGN 287
#define WRITELN 288
#define PLUS 289
#define MINUS 290
#define MUL 291
#define DIV 292
#define ELSE 293

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED

union YYSTYPE
{
#line 29 "b075090027.y" /* yacc.c:1909  */

    int 	intVal;
    char	charVal;
    char*	strVal;

#line 136 "y.tab.h" /* yacc.c:1909  */
};

typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
