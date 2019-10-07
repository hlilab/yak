CC=			gcc
CFLAGS=		-g -Wall -O2 -Wno-unused-function #-fno-inline-functions -fno-inline-functions-called-once
CPPFLAGS=
INCLUDES=	
OBJS=		kthread.o sys.o bseq.o bbf.o htab.o count.o
PROG=		yak
LIBS=		-lm -lz -lpthread

.SUFFIXES:.c .o

.c.o:
		$(CC) -c $(CFLAGS) $(CPPFLAGS) $(INCLUDES) $< -o $@

all:$(PROG)

yak:$(OBJS) main.o
		$(CC) $(CFLAGS) $^ -o $@ $(LIBS)

clean:
		rm -fr gmon.out *.o ext/*.o a.out $(PROG) *~ *.a *.dSYM session*

depend:
		(LC_ALL=C; export LC_ALL; makedepend -Y -- $(CFLAGS) $(DFLAGS) -- *.c)

# DO NOT DELETE

bbf.o: bbf.h
bseq.o: bseq.h kseq.h
count.o: kthread.h yak.h bbf.h kmer.h bseq.h sys.h
htab.o: yak.h kmer.h khash.h
kthread.o: kthread.h
main.o: ketopt.h yak.h sys.h
sys.o: sys.h