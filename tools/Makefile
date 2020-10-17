NAME =	compressor

SRC =	compressor.c

OBJ =	$(SRC:%.c=%.o)

INC =

LDFLAGS =

CFLAGS= $(INC)	\
		-W		\
		-Wall	\
		-Wextra	\

CC =	gcc

LIBS =

all:	$(LIBS) $(NAME)

$(NAME):$(OBJ)
	$(CC) -o $(NAME) $(OBJ) $(LDFLAGS)

fixObjPals:fixObjPals.o
	$(CC) -o fixObjPals fixObjPals.o $(LDFLAGS)

clean:
	$(RM) $(OBJ) fixObjPals.o

fclean:	clean
	$(RM) $(NAME) $(NAME).exe fixObjPals fixObjPals.exe

ffclean:fclean

re:	fclean all

dbg:	CFLAGS += -g -O0
dbg:	ffclean all
