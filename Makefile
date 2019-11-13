pro.tab.c pro.tab.h: pro.y
	bison -d pro.y -v

lex.yy.c: pro.l pro.tab.h
	flex pro.l

pro: lex.yy.c pro.tab.c pro.tab.h
	gcc pro.tab.c lex.yy.c -ll -o pro