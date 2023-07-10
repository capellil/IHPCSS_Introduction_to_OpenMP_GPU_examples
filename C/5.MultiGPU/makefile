CC = nvc
CFLAGS += -O3 -mp=gpu
SRC_DIR=src
BIN_DIR=bin

default: all

all: create_directory \
	 $(BIN_DIR)/multigpu

create_directory:
	@mkdir -p $(BIN_DIR)

$(BIN_DIR)/multigpu: $(SRC_DIR)/multigpu.c
	$(CC) -o $@ $< $(CFLAGS)
