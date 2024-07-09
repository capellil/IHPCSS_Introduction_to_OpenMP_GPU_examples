CC = nvc
CFLAGS += -O2 -mp=gpu
SRC_DIR=src
BIN_DIR=bin

default: all

all: create_directory \
	 $(BIN_DIR)/multilevelparallelism \
	 $(BIN_DIR)/solution

create_directory:
	@mkdir -p $(BIN_DIR)

$(BIN_DIR)/multilevelparallelism: $(SRC_DIR)/multilevelparallelism.c
	$(CC) -o $@ $< $(CFLAGS)

$(BIN_DIR)/solution: $(SRC_DIR)/solution.c
	$(CC) -o $@ $< $(CFLAGS)
