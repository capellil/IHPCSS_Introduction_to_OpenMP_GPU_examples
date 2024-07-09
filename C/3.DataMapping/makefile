CC = nvc
CFLAGS += -O2 -mp=gpu
SRC_DIR=src
BIN_DIR=bin

default: all

all: create_directory \
	 $(BIN_DIR)/datamapping \
	 $(BIN_DIR)/solution

create_directory:
	@mkdir -p $(BIN_DIR)

$(BIN_DIR)/datamapping: $(SRC_DIR)/datamapping.c
	$(CC) -o $@ $< $(CFLAGS)

$(BIN_DIR)/solution: $(SRC_DIR)/solution.c
	$(CC) -o $@ $< $(CFLAGS)
