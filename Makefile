# Makefile to build sema
#

PREFIX=/usr/local

CXX = gcc
LIBS = -lpthread
CPP_FLAGS = -g -Wall -Wextra -pedantic -pthread
EXEC = sema
SRC = $(EXEC).c
EXEC_INSTALL_DIR = $(PREFIX)/bin
DOC_INSTALL_DIR = $(PREFIX)/share/doc/$(EXEC)

OBJS = $(SRC:.c=.o)
DOC_OBJS = AUTHORS INSTALL LICENSE README

%.o: %.c
	$(CXX)  $(CPP_FLAGS) -c $< -o $@

.PHONY: all
all: $(EXEC)

$(EXEC): $(OBJS)
	$(CXX)  -o $(EXEC) $(LIBS) -pthread $(OBJS)

install: all
	install $(EXEC) $(EXEC_INSTALL_DIR)
	install -d $(DOC_INSTALL_DIR)
	for f in $(DOC_OBJS); \
	do \
		install $${f} $(DOC_INSTALL_DIR); \
	done

test: all
	$(EXEC) -c $(EXEC)-test;\
	$(EXEC) -r $(EXEC)-test;\
	$(EXEC) -w $(EXEC)-test;\
	$(EXEC) -d $(EXEC)-test;\
	if [ $$? -ne 0 ];\
		then echo "Unit test failed";\
	else \
		echo "All test(s) passed";\
	fi

.PHONY: clean
clean:
	rm -f $(OBJS) $(EXEC)

