CC=gcc
LEXER=flex
YACC=yacc
# CFLAGS=-I.
# DEPS = hellomake.h
# OBJ = hellomake.o hellofunc.o 

NAME=wiki

$(NAME):
	$(LEXER) -l $(NAME).l
	$(YACC) -vd --verbose $(NAME).y
#	-v: generates the DFA
#	-d: generate the y.tab.h file
	$(CC) -o $@ $^ y.tab.c symbol_table.c utils.c -ly -ll

# *To see the moves of the parser:
debug:
	$(CC) -o $@ $^ -DYYDEBUG y.tab.c -ly -ll

test:
	make clean
	make $(NAME)
	./wiki < test_modules/test_cases.txt 2>/dev/null | diff -c test_modules/test_cases_expected.txt - && echo "TEST: SUCCEEDED" || exit 0

.PHONY: clean

clean:
	rm -f *.o *~ $(NAME) y.tab.c y.tab.h lex.yy.c y.output symbol_table.o
