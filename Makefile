SRCS = $(shell find . -name '*.hs')
EXECS = $(SRCS:.hs=)

.PHONY: clear purge

%: %.hs
	ghc --make -O $*.hs

all: $(EXECS)

clean:
	-rm -rf $(SRCS:.hs=.o) $(SRCS:.hs=.hi)

purge: clean
	-rm -rf $(EXECS)
