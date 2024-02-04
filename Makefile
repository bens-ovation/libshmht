CC=gcc
AR=ar
CFLAGS=-O2
INCLUDE=-I.
LIBNAME=libshmht

all: shmht.o
	$(CC) -o $(LIBNAME).so $(CFLAGS) -shared $^
	$(AR) rcs $(LIBNAME).a $^

shmht.o: shmht.c shmht.h
	$(CC) $(CFLAGS) $(INCLUDE) -fPIC -c shmht.c

test: shmht_tests
	./shmht_tests

shmht_tests: shmht.o shmht_tests.o
	$(CC) $(CFLAGS) $(INCLUDE) -o $< $^

shmht_tests.o: shmht.h
	$(CC) $(CFLAGS) $(INCLUDE) -fPIC -c shmht_tests.c

install: all
	install -m 644 $(LIBNAME).so /usr/lib/$(LIBNAME).so
	install -m 644 $(LIBNAME).a /usr/lib/$(LIBNAME).a
	install -m 644 shmht.h /usr/include/shmht.h

.PHONY: clean
clean:
	rm -f *.so *.a *.o

.PHONY: uninstall
uninstall:
	rm -f /usr/lib/$(LIBNAME).so /usr/lib/$(LIBNAME).a /usr/include/shmht.h
