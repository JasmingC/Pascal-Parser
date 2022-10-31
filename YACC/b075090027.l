%{
#include<stdio.h>
#include<ctype.h>
#include<string.h>
#include "y.tab.h"

int charCount = 0, tokenCount = 0, lineCount = 1, pos = 0;
int id_flag, id_int_num, id_str_num;
char id_int[256][256], id_str[256][256];
int flag = 1;
char all_msg[256];
void printer();
void yyerror(const char *message);

int id_type;
char* idd;
char* string_content;
char* int_content;
%}
letter			[a-zA-Z]
/*Reserved word*/
Program			[pP][rR][oO][gG][rR][aA][mM]
Integer			[Ii][nN][tT][eE][gG][eE][rR]
Var				[vV][Aa][Rr]
If				[iI][fF]
Then			[Tt][hH][eE][Nn]
Else			[eE][lL][sS][eE]
Begin			[Bb][Ee][Gg][Ii][Nn]
End				[Ee][Nn][Dd]
While			[Ww][hH][iI][lL][Ee]
For				[fF][oO][rR]
Do 				[dD][oO]
To				[Tt][Oo]
String			[Ss][Tt][Rr][Ii][Nn][Gg]
Of				[oO][fF]
Array			[aA][rR][rR][aA][yY]
Read			[rR][eE][aA][dD]
Write			[Ww][Rr][Ii][Tt][Ee]
Writeln			[Ww][Rr][Ii][Tt][Ee][Ll][Nn]
Mod				[Mm][Oo][Dd]
		


INT				[0-9]+
REAL			({INT}|({INT}\.([0-9]*[1-9]*)))([Ee]{INT}+)?
string 			[\'][^\']+[\']
identify		([\_]|{letter})([0-9]+|{letter})*
space			[ ]
eol			[\n]
Symbol   	    ","|"."|":"|";"|"("|")"|":="|"<"|">"|"=="|"<="|">="|\]|\[|"*"|"/"|"+"|"-"

%%

{Program}		{ printer();return(PROGRAM); }
{Integer}		{ printer();return(INTEGER); }
{Var}			{ printer();return(VAR); }
{If}			{ printer();return(IF); }
{End}			{ printer();return(END); }
{For}			{ printer();return(FOR); }
{Then}			{ printer();return(THEN); }
{Else}			{ printer();return(ELSE); }
{Begin}			{ printer();return(Begin); }
{Do} 			{ printer();;return(DO); }
{To}			{ printer();return(TO); }
{String}		{ printer();return(STRING); }
{Of}			{ printer();return(OF); }
{Array}			{ printer();return(ARRAY); }
{Read}			{ printer();return(READ); }
{Write}			{ printer();return(WRITE); }
{Writeln}		{ printer();return(WRITELN); }
{Mod}			{ printer();return(MOD); }
{string}		{ printer();string_content = strdup(yytext);return(STR);}
{identify}		{ printer();
			  if(id_flag ==1){
			  	//add new ID
				strcat(id_int[id_int_num], yytext);
				id_int_num++;
				id_flag=0;
			  }
			  else if(id_flag == 12){
			  	//add new ID
				strcat(id_str[id_str_num], yytext);
				id_str_num++;
				id_flag=0;
			  
			  }
			  else if(id_flag == 2){
			  	//check ID existance
				for(int i=0;i<id_int_num;i++){
				  	if(strcmp(yytext, id_int[i])==0) {
						id_flag = 0;break;}
					}
				if(id_flag == 2){
				  	flag = 0;
				  	printf("Line %d, at char %d, variable %s undefined.\n",lineCount, pos, yytext);

				  	}
				 }
			  idd = strdup(yytext);
			  yylval.strVal = strdup(yytext);
			  return(ID);
			 }



":="			{ printer();return(ASSIGN); }
"+"			{ printer();return(PLUS);}
"-"			{ printer();return(MINUS);}
"*"			{ printer();return(MUL);}
"/"			{ printer();return(DIV);}
";"			{ printer();return(';');}
"["			{ printer();return('[');}
"]"			{ printer();return(']');}
","			{ printer();return(',');}
"."			{ printer();return('.');}
":"			{ printer();return(':');}
"'"			{ printer();return(APO);}
"("			{ printer();return('(');}
")"			{ printer();return(')');}

".."			{ printer();return(DOTDOT); }
"="			{ printer();return(EQUAL); }
"<"			{ printer();return(LT); }
">"			{ printer();return(RT); }			
"<="			{ printer();return(LE); }
">="			{ printer();return(RE); }


{INT}			{ printer();int_content = strdup(yytext);return(INT);}
{REAL}			{ printer();return(REAL); }




"(*"			{ int c;
					while((c=input())){
						if( c == '*' )
							if((c=input())==')'){
								flag =0;
								break;
								}
							else unput(c);
						else if(c == '\n') {
							lineCount++;
							}
					}				
				}

{Symbol}		{ printer();return(SYMBOL); }
{space}			{ pos++;strcat(all_msg, yytext);}
{eol}			{ pos = 0;
				  if(flag == 1)
					printf("Line %d: %s\n", lineCount, all_msg);
				  else 
					flag = 1;
				  lineCount++;
				  strcpy(all_msg,""); 
			}

<<EOF>>		{ pos = 0;
				  if(flag == 1){
					printf("Line %d: %s\n", lineCount, all_msg);
				  }
				  else 
					flag = 1;
				  lineCount++;
		  		  strcpy(all_msg,""); 
		  return 0;
		}
%%
void printer() {
	strcat(all_msg, yytext);
	tokenCount++;
	charCount += yyleng;
	pos += yyleng;
}

int yywrap(){
    return 1;
}


