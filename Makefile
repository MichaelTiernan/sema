# Makefile to build sema
#
.PHONY: clean all

PREFIX=/usr/local

EXEC_INSTALL_DIR = $(PREFIX)/bin
DOC_INSTALL_DIR = $(PREFIX)/share/doc/$(EXEC)

EXEC = sema

DOC_OBJS = AUTHORS INSTALL LICENSE README

CXX = gcc
LIBS = -lpthread
# CPP_FLAGS = -g -Wall -Wextra -pedantic -pthread 
CPP_FLAGS = -g -pedantic -pthread 

SRC = $(EXEC).c

OBJS = $(SRC:.c=.o)

%.o: %.c
	$(CXX) $(CPP_FLAGS) -c $< -o $@

all: $(EXEC)

$(EXEC): $(OBJS)
	$(CXX) -o $(EXEC) $(LIBS) -pthread $(OBJS)

install: all
	install -m 0711 $(EXEC) $(EXEC_INSTALL_DIR)
	install -m 0755 -d $(DOC_INSTALL_DIR)
	for f in $(DOC_OBJS) ; do \
		install $${f} $(DOC_INSTALL_DIR); \
	done

test: all
	$(EXEC) -c $(EXEC)-test; \
	$(EXEC) -r $(EXEC)-test; \
	$(EXEC) -w $(EXEC)-test; \
	$(EXEC) -d $(EXEC)-test; \
	if [ $$? -ne 0 ];\
		then echo "Unit test failed";\
		else echo "All test(s) passed";\
	fi

clean:
	rm -f $(OBJS) $(EXEC)

