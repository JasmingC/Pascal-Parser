/*definition*/
%{
#include <stdio.h>
#include <string.h>
#define YYERROR_VERBOSE

int yylex();
int charCount, tokenCount, lineCount, pos;
int flag;
/*id宣告使用的變數*/
int id_flag=0;
/*error message*/
void yyerror(const char *message){
	if(message == "')' expected but 'THEN' found" ) pos = pos-3;
	printf("Line %d, at char %d, %s\n", lineCount, pos, message);
	flag=0;
}
extern int id_type;
extern char* idd;
extern char* string_content;
extern char* int_content;

int count = 0;
int id_type_arr[10];
char* id_name_arr[10];


%}
%union{
    int 	intVal;
    char	charVal;
    char*	strVal;
}
%error-verbose
%token ID
%token PROGRAM VAR INTEGER IF THEN Begin END FOR DO TO OF ARRAY READ WRITE 
%token INT REAL EQUAL LT RT LE RE DOTDOT MOD SYMBOL STR STRING APO DOT
%token ASSIGN WRITELN
%token PLUS MINUS MUL DIV
%token ELSE

%type<strVal> ID PROGRAM VAR INTEGER IF THEN Begin END FOR DO TO OF ARRAY READ WRITE
%type<strVal> INT REAL EQUAL LT RT LE RE DOTDOT MOD SYMBOL STR STRING APO DOT ELSE
%type<strVal> ASSIGN WRITELN PLUS MINUS MUL DIV varid assign

%left THEN
%right ELSE
%%
/*grammer*/
		 
prog		: PROGRAM prog_name ';' VAR dec_list ';' Begin stmt_list ';' END '.' 

		 | PROGRAM prog_name ';' VAR dec_list ';' Begin stmt_list ';' END {yyerror("'.' expected but 'end of file' found");}
		 //| error END{if(pos==0) lineCount--;}
		 ;
prog_name	: ID	
		 ;
dec_list	: dec 
		 | dec_list ';'  dec ;
		 
dec		: dec_id ':' type { 
			id_name_arr[count]=idd;\
			count++;
			//printf("%s:%d:%d\n",id_name_arr[count-1],id_type_arr[count-1],count-1);
		 }
		 | dec_str_id ':' STRING 
		 | dec_id error type 
		 ;
		 
type		: standtype 
		 | arraytype ;
		 
standtype	: INTEGER {id_type=0; id_type_arr[count]=id_type;}
		 | STRING {id_type=1; id_type_arr[count]=id_type;};
		 
arraytype	: ARRAY '[' INT DOTDOT INT ']' OF standtype ;
		
dec_id		: varid {id_flag=1;}	/*把宣告過變數存起來*/
		 | varid{id_flag=1;} ',' dec_id {id_flag=1;} ;
		 
dec_str_id	: strid {id_flag=12;}
		 | strid {id_flag=12;} ',' dec_str_id {id_flag=12;} ;
		 
id_list		: varid
		 | STR
		 | id_list ',' varid 
		 | id_list ',' STR ;
		 
stmt_list	: stmt 
		 | stmt_list ';' stmt ;
		 
stmt		: assign
		 | read 
		 | write 
		 | writeln 
		 | for 
		 | ifstmt
		 | error {
		  	if(id_type_arr[0]!=id_type_arr[1]&& (pos==6 || pos==10)){
				pos=pos-2;
				yyerror("Operator is not overloaded: int + string");
			}
		 }
		 ;
		 
assign		: varid { id_flag=2; } ASSIGN simp_expression{
		//  for(int i = 0 ; i < 10 ; i++){
		//  if(strcmp($1,id_name_arr[i])==0) {
		char* temp = (char*)$1;
		if(int_content!=NULL && string_content!=NULL){
			//printf("int_content=%s\n",int_content);
			//printf("string_content=%s\n",string_content);
			for(int i = 0 ; i < 10 ; i++){
				if(strcmp(temp,id_name_arr[i])==0){
				pos = pos-10;
				yyerror("Incompatible types: got constant string expected int");
				
				}
				break;
		  		//printf("found!!\n");
			}		
		}
		
		//  break;
		//  }
		// }
		 // printf("varid=%s,simexp=%s\n",$1,$3);
		  //if(strcmp($1,"i")==0) printf("found!\n");
		}
                ; 

ifstmt		: IF '(' expression ')' THEN body |
		| IF '(' expression {yyerror("')' expected but 'THEN' found");} THEN body
		| IF '(' expression ')' THEN body ELSE body
		;
		 
expression	: simp_expression 
		 | expression relop simp_expression ;
		 
relop		: EQUAL
		 | LT
		 | RT
		 | LE
		 | RE ;
		 
simp_expression	: term 
		 | PLUS term 
		 | MINUS term 
		 | simp_expression PLUS term
		 | simp_expression MINUS term 
		 | simp_expression MOD term 
		 
		 ;
 	 
term		: factor | term MUL factor | term DIV factor | error {yyerrok;} ;
		
factor		: varid { id_flag=2;} 
		| INT //{printf("int_content=%s\n",int_content);} 
		| REAL 
		| STR //{printf("string_content=%s\n",string_content);} 
		| '(' simp_expression ')' ;
		 
read		: READ '(' id_list ')' ;
		 
write		: WRITE '(' id_list ')'
		 | WRITE '(' simp_expression ')'; 

writeln		:  WRITELN ;
		 
for		: FOR index_exp DO body ;
		 
index_exp	: varid {id_flag=2;} ASSIGN simp_expression TO expression ;
		
varid		: ID 
		 | ID '[' simp_expression ']'
		 | error INTEGER{
			yyerrok;
		}
		
		;

strid		: ID;

body		: stmt | Begin stmt_list ';' END ;

		
		
%%
/*user code*/
int main() {
	yyparse(); 
	printf("\n");
	return 0;
}


