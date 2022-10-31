all:	clean y.tab.c lex.yy.c
	gcc lex.yy.c y.tab.c -ly -lfl -o b075090027

y.tab.c:
	bison -y -d b075090027.y

lex.yy.c:
	flex b075090027.l

clean:
	rm -f b075090027 lex.yy.c y.tab.c y.tab.h
