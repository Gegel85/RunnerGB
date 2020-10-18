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
	assets/nocgberror.png \
	assets/numbers.png

COMPRESSED_IMGS = \

COLORED_IMGS = \
	assets/hero1.png \
	assets/hero2.png \
	assets/hero_jump.png \
	assets/ground.png \
	assets/scoring_zone.png \
	assets/bg.png \

OBJ_COLORED_IMGS = \
	assets/spike.png \
	assets/moon.png \

OBJS = $(SRCS:%.asm=%.o)

COMPRESSED_COLORED_IMGS =

IMGSFX = $(IMGS:%.png=%.fx)

COMPRESSEDIMGSFX = $(COMPRESSED_IMGS:%.png=%.zfx)

COLORED_IMGS_FX = $(COLORED_IMGS:%.png=%.cfx)

OBJ_COLORED_IMGS_FX = $(OBJ_COLORED_IMGS:%.png=%.ofx)

COMPRESSED_COLORED_IMGS_FX = $(COMPRESSED_COLORED_IMGS:%.png=%.zcfx)

PALS = $(COLORED_IMGS:%.png=%.pal) $(COMPRESSED_COLORED_IMGS:%.png=%.pal) $(OBJ_COLORED_IMGS:%.png=%.pal)

MAPS = $(IMGS:%.png=%.map) $(COMPRESSED_IMGS:%.png=%.map) $(COLORED_IMGS:%.png=%.map) $(COMPRESSED_COLORED_IMGS:%.png=%.map) $(OBJ_COLORED_IMGS:%.png=%.map)

all:	tools/compressor tools/fixObjPals $(NAME).gbc

tools/compressor:
	$(MAKE) -C tools compressor

tools/fixObjPals:
	$(MAKE) -C tools fixObjPals

run:	re
	wine "$(BGB_PATH)" ./$(NAME).gbc

runw:	re
	"$(BGB_PATH)" ./$(NAME).gbc

%.fx : %.png
	$(FX) $(FXFLAGS) -t `echo $@ | sed 's/.\{3\}$$//'`.map -o $@ $<

%.cfx : %.png
	$(FX) $(FXFLAGS) -t `echo $@ | sed 's/.\{4\}$$//'`.map -P -o $@ $<

%.ofx : %.png
	$(FX) $(FXFLAGS) -t `echo $@ | sed 's/.\{4\}$$//'`.map -P -o `echo $@ | sed 's/.\{1\}$$//'`o $<
	tools/fixObjPals `echo $@ | sed 's/.\{4\}$$//'`.pal `echo $@ | sed 's/.\{1\}$$//'`o

%.zfx : %.png
	$(FX) $(FXFLAGS) -t `echo $@ | sed 's/.\{4\}$$//'`.map -o $@ $<
	tools/compressor $@

%.zcfx : %.png
	$(FX) $(FXFLAGS) -t `echo $@ | sed 's/.\{5\}$$//'`.map -P -o $@ $<
	tools/palette_fixer $(@:%.zcfx=%.pal)
	tools/compressor $@

%.o : %.asm
	$(ASM) -o $@ $(ASMFLAGS) $<

$(NAME).$(EXT): $(COLORED_IMGS_FX) $(COMPRESSED_COLORED_IMGS_FX) $(OBJ_COLORED_IMGS_FX) $(COMPRESSEDIMGSFX) $(IMGSFX) $(OBJS) $(OBJ_COLORED_IMGS_FX)
	$(LD) $(LDFLAGS) -o $@ $(OBJS)
	$(FIX) $(FIXFLAGS) $@

clean:
	$(MAKE) -C tools clean
	$(RM) $(OBJS) $(IMGSFX) $(COMPRESSEDIMGSFX) $(COLORED_IMGS_FX) $(COMPRESSED_COLORED_IMGS_FX) $(MAPS) $(PALS) $(OBJ_COLORED_IMGS_FX) $(OBJ_COLORED_IMGS:%.png=%.ofo)

fclean:	clean
	$(MAKE) -C tools fclean
	$(RM) $(NAME).$(EXT)

re:	fclean all
