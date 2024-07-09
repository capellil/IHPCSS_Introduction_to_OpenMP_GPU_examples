CC = nvfortran
CFLAGS += -O2 -mp=gpu
SRC_DIR=src
BIN_DIR=bin

default: all

all: create_directory \
	 $(BIN_DIR)/multigpu \
	 $(BIN_DIR)/solution

create_directory:
	@mkdir -p $(BIN_DIR)

$(BIN_DIR)/multigpu: $(SRC_DIR)/multigpu.f08
	$(CC) -o $@ $< $(CFLAGS)

$(BIN_DIR)/solution: $(SRC_DIR)/solution.f08
	$(CC) -o $@ $< $(CFLAGS)
