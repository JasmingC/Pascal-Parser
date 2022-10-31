%{
#include<stdio.h>
unsigned lineCount = 1, firstChar = 1, preChar = 0;

%}
/*保留字 不分大小寫*/
reserved ([Aa][Bb][Ss][Oo][Ll][Uu][Tt][Ee]|[Aa][Nn][Dd]|[Bb][Ee][Gg][Ii][Nn]|[Bb][Rr][Ee][Aa][Kk]|[Cc][Aa][Ss][Ee]|[Cc][Oo][Nn][Ss][Tt]|[Cc][Oo][Nn][Tt][Ii][Nn][Uu][Ee]|[Dd][Oo]|[Ee][Ll][Ss][Ee]|[Ee][Nn][Dd]|[Ff][Oo][Rr]|[Ff][Uu][Nn][Cc][Tt][Ii][Oo][Nn]|[Ii][Ff]|[Mm][Oo][Dd]|[Nn][Ii][Ll]|[Nn][Oo][Tt]|[Oo][Bb][Jj][Ee][Cc][Tt]|[Oo][Ff]|[Oo][Rr]|[Pp][Rr][Oo][Gg][Rr][Aa][Mm]|[Tt][Hh][Ee][Nn]|[Tt][Oo]|[Vv][Aa][Rr]|[Ww][Hh][Ii][Ll][Ee]|[Aa][Rr][Rr][Aa][Yy]|[Ii][Nn][Tt][Ee][Gg][Ee][Rr]|[Dd][Oo][Uu][Bb][Ll][Ee]|[Ww][Rr][Ii][Tt][Ee]|[Ww][Rr][Ii][Tt][Ee][Ll][Nn]|[Ss][Tt][Rr][Ii][Nn][Gg]|[Ff][Ll][Oo][Aa][Tt]|[Rr][Ee][Aa][Dd])

letter [a-zA-Z]
digit [0-9]

/*識別字 第一個字必須是英文字母或底線 最長15個字元*/
id [A-Za-z_][A-Za-z_0-9]{0,14}


/*實數有正負 分成整數、有小數點、科學記號*/
integer ((\+|\-)?{digit}+)
point {integer}[\.]{digit}+
exp ({point}|{integer})[eE][\+|\-]{digit}+
realnum {integer}|{point}|{exp}
split {realnum}\+|\-|\*|\/


/*字串常數 字數最長30個字元*/
String \'([^'\n]|'')*\'

/*註解*/
Comment "(*"({digit}|{letter}|{Symbol}|[ ]|\n|\r)*"*)"

/*超過16個字 數字^#開頭*/
WrongID ([A-Za-z_][A-Za-z_0-9]{15,})|([0-9]|\#|\^){letter}+

/*小數點連續兩個0結尾  錯誤表示（ex 1. , .1 , 0300 , 0300.0 ）*/
WrongReal ({integer}[\.]{digit}*[0]{2,})|([\.]{digit}+)|{digit}+[\.]|[0]+{digit}+|[0]+{digit}+[\.]{digit}*
/*超過31個字 只有單邊引號 奇數個引號*/
WrongStr ([\']({letter}|{space}){31,}[\'])|([\']{letter}+[^\'\;])|([^\']{letter}+[\'])|\'([^'\n==]|')*\'
/*單邊註解*/
WrongCmt "(*"[^"*)"]+


space [ ]
eol \n


/*符號*/
Symbol ("."|";"|":"|"("|")"|"["|"]"|"+"|"-"|"*"|"/"|":="|">"|"<"|"="|"=="|"<="|">="|",")
%%
{split} {

	int i,j;
	for(i = 0 ; i < yyleng ; i++){
		if(yytext[i] == '+' || yytext[i] == '-' || yytext[i] == '*' || yytext[i] == '/' )
		break;
	}
	printf("Line: %d, 1st char: %d,\"", lineCount, firstChar+preChar);
	firstChar+=preChar;
	preChar = yyleng;
	
	for(j = 0 ; j < i ; j++){
		printf("%c", yytext[j]);
	}
	printf("\" is a \"real number\".\n");
	
	//symbol
	printf("Line: %d, 1st char: %d,", lineCount, firstChar+i);
	printf("\"%c\" is a  \"symbol\".\n" , yytext[j]);
}
{reserved} {
	printf("Line: %d, 1st char: %d,\"%s\" is a \"reserved word\".\n", lineCount, firstChar+preChar, yytext);
	firstChar+=preChar;
	preChar = yyleng;
}
{String} {
	printf("Line: %d, 1st char: %d,\"%s\" is an \"string\".\n", lineCount, firstChar+preChar, yytext);
	firstChar+=preChar;
	preChar = yyleng;
}	
{WrongStr} {
	printf("Line: %d, 1st char: %d,\"%s\" is an invaild \"string\".\n", lineCount, firstChar+preChar, yytext);
	firstChar+=preChar;
	preChar = yyleng;
}

{WrongID} {
	printf("Line: %d, 1st char: %d,\"%s\" is an invaild \"ID\".\n", lineCount, firstChar+preChar, yytext);
	firstChar+=preChar;
	preChar = yyleng;
}

{id} {
	printf("Line: %d, 1st char: %d,\"%s\" is an \"ID\".\n", lineCount, firstChar+preChar, yytext);
	firstChar+=preChar;
	preChar = yyleng;
}

{Comment} {
	int i ;
	for(i = 0; i < yyleng ; i++){
		if( yytext[i] == '*' && yytext[i+1] == ')' && i != yyleng - 1){
		break;
		}
	}
	
	printf("Line: %d, 1st char: %d,\"", lineCount, firstChar+preChar);
	firstChar+=preChar;
	preChar = yyleng;
	
	for(int j = 0 ; j <= i+1 ; j++){
		printf("%c", yytext[j]);
	}
	printf("\" is a \"Comment\".\n");
	
	//invalid
	printf("Line: %d, 1st char: %d,\"", lineCount, firstChar+i+2);
	for(int j = i+2 ; j < yyleng ; j++){
		printf("%c", yytext[j]);
	}
	printf("\" is an invalid \"Comment\".\n");

}
{WrongCmt} {
	printf("Line: %d, 1st char: %d,\"%s\" is an invaild \"Comment\".\n", lineCount, firstChar+preChar, yytext);
	firstChar+=preChar;
	preChar = yyleng;
}
{space} {
	firstChar++;
}
{eol} {
	lineCount++;
	firstChar = 1;
	preChar = 0;
}
{Symbol} {
	printf("Line: %d, 1st char: %d,\"%s\" is a \"symbol\".\n", lineCount, firstChar+preChar, yytext);
	firstChar+=preChar;
	preChar = yyleng;
}
{WrongReal} {
	printf("Line: %d, 1st char: %d,\"%s\" is an invaild \"real number\".\n", lineCount, firstChar+preChar, yytext);
	firstChar+=preChar;
	preChar = yyleng;
}
{realnum} {
	printf("Line: %d, 1st char: %d,\"%s\" is a \"real number\".\n", lineCount, firstChar+preChar, yytext);
	firstChar+=preChar;
	preChar = yyleng;
}

%%

int main()
{
	yylex();
	return 0;
}
