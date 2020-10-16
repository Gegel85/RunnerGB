NAME = runner

EXT = gbc

ASM = rgbasm

LD = rgblink

FIX = rgbfix

FIXFLAGS = -Cjsv -k 01 -l 0x33 -m 0x01 -p 0 -r 00 -t "`echo "$(NAME)" | tr a-z A-Z | tr "_" " "`"

ASMFLAGS =

LDFLAGS = -n $(NAME).sym -l $(NAME).link

FXFLAGS = -u

FX = rgbgfx

SRCS = \
	src/main.asm \
	src/mem_layout.asm \
	src/assets.asm \
	src/text.asm

IMGS = \
	assets/ground.png \
	assets/player.png \
	assets/spike.png \
	assets/moon.png \
	assets/bg.png

COMPRESSED_IMGS = \
	assets/numbers.png

COMPRESSEDIMGSFX = $(COMPRESSED_IMGS:%.png=%.cfx)

IMGSFX = $(IMGS:%.png=%.fx)

OBJS = $(SRCS:%.asm=%.o)

all:	tools/compressor $(NAME).$(EXT)

tools/compressor:
	$(MAKE) -C tools compressor

run:	re
	wine "$(BGB_PATH)" ./$(NAME).$(EXT)

runw:	re
	"$(BGB_PATH)" ./$(NAME).$(EXT)

%.fx : %.png
	$(FX) $(FXFLAGS) -o $@ -t `echo $@ | sed "s/.\{3\}$$//"`.map $<

%.cfx : %.png
	$(FX) $(FXFLAGS) -o $@ -t `echo $@ | sed 's/.\{4\}$$//'`.map $<
	tools/compressor $@

%.o : %.asm
	$(ASM) -o $@ $(ASMFLAGS) $<

$(NAME).$(EXT):	$(COMPRESSEDIMGSFX) $(IMGSFX) $(OBJS)
	$(LD) $(LDFLAGS) -o $@ $(OBJS)
	$(FIX) $(FIXFLAGS) $@

clean:
	$(MAKE) -C tools clean
	$(RM) $(OBJS) $(IMGSFX) $(COMPRESSEDIMGSFX)

fclean:	clean
	$(MAKE) -C tools fclean
	$(RM) $(NAME).$(EXT)

re:	fclean all
