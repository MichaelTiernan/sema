# Makefile to build sema
#

CXX = gcc
LIBS = -lpthread
# CPP_FLAGS = -g -Wall -Wextra -pedantic -pthread 
CPP_FLAGS = -g -pedantic -pthread 
EXEC = sema
SRC = sema.c
EXEC_INSTALL_DIR = ~/.local/bin
DOC_INSTALL_DIR = ~/.local/share/doc/sema

OBJS = $(SRC:.c=.o)
DOC_OBJS = AUTHORS INSTALL LICENSE README

%.o: %.c
	$(CXX)  $(CPP_FLAGS) -c $< -o $@

.PHONY: all
all: $(EXEC)

$(EXEC): $(OBJS)
	$(CXX)  -o $(EXEC) $(LIBS) -pthread $(OBJS)

install: all
	install -m 0711 $(EXEC) $(EXEC_INSTALL_DIR)
	install -m 0755 -d $(DOC_INSTALL_DIR)
	for f in $(DOC_OBJS); \
	do \
	 install -m 0644 $${f} $(DOC_INSTALL_DIR); \
	done

test: all
	./$(EXEC) -c sema-test;\
	./$(EXEC) -r sema-test;\
	./$(EXEC) -w sema-test;\
	./$(EXEC) -d sema-test;\
	if [ $$? -ne 0 ];\
		then echo "Unit test failed";\
	else \
		echo "All test(s) passed";\
	fi 	

.PHONY: clean
clean:
	rm -f $(OBJS) $(EXEC)

