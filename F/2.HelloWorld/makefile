CC = nvfortran
CFLAGS += -O2 -mp=gpu
SRC_DIR=src
BIN_DIR=bin

default: all

all: create_directory \
	 $(BIN_DIR)/helloworld

create_directory:
	@mkdir -p $(BIN_DIR)

$(BIN_DIR)/helloworld: $(SRC_DIR)/helloworld.f08
	$(CC) -o $@ $< $(CFLAGS)
