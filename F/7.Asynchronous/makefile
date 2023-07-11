CC = nvfortran
CFLAGS += -O2 -mp=gpu
SRC_DIR=src
BIN_DIR=bin

default: all

all: create_directory \
	 $(BIN_DIR)/asynchronous

create_directory:
	@mkdir -p $(BIN_DIR)

$(BIN_DIR)/asynchronous: $(SRC_DIR)/asynchronous.f08
	$(CC) -o $@ $< $(CFLAGS)
