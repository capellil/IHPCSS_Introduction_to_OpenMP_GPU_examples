CC = nvc
CFLAGS += -O2 -mp=gpu
SRC_DIR=src
BIN_DIR=bin

default: all

all: create_directory \
	 $(BIN_DIR)/dataenvironment

create_directory:
	@mkdir -p $(BIN_DIR)

$(BIN_DIR)/dataenvironment: $(SRC_DIR)/dataenvironment.c
	$(CC) -o $@ $< $(CFLAGS)
