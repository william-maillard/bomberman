CC=emcc
CFLAGS= -sUSE_SDL=2 -sUSE_SDL_IMAGE=2 -sSDL2_IMAGE_FORMATS=png,jpeg -sUSE_SDL_TTF=2 --preload-file=medias --use-preload-plugins
LDLIBS=`pkg-config --libs-only-l MLV`
MODS= /src/build/main_menu.wasm \
		/src/buil/jeu_solo.wasm \
		/src/build/initialiser_jeu_solo.wasm \
		src/build/images-animations.wasm

index.html: $(MODS)
	emcc /src/src/game/bomberman.c $(CFLAGS) -sMAIN_MODULE -o/src/build/index.html $(MODS) 

/src/build/main_menu.wasm:
	emcc /src/src/graphics/main_menu_window.c $(CFLAGS) -sSIDE_MODULE -o/src/build/main_menu.wasm

/src/buil/jeu_solo.wasm:
	emcc /src/src/game/jeu_solo.c $(CFLAGS) -sSIDE_MODULE -o/src/buil/jeu_solo.wasm

/src/build/initialiser_jeu_solo.wasm:
	emcc /src/src/game/initialiser_jeu_solo.c -sSIDE_MODULE -o/src/buil/initialiser_jeu_solo.wasm

/src/build/images-animations.wasm:
	emcc /src/src/graphics/images-animations.c $(CFLAGS) -sSIDE_MODULE -o/src/build/images-animations.wasm

# compilation native C wsl
# gcc bomberman/src/game/bomberman.c -o  bomberman/bin/bomberman $(sdl2-config --cflags --libs) -lSDL2_ttf -lSDL2_image -lm

# S'en inspirer quand les fichiers seront tous modifiés comme il fat

# # variables de compilation
# CC=gcc
# CFLAGS= -g -O2 -Wall `pkg-config --cflags MLV` `pkg-config --libs-only-other --libs-only-L MLV`
# LDLIBS=`pkg-config --libs-only-l MLV`

# # Répertoire racine du projet
# ROOT_DIR=./bomberman

# # Nom de l'exécutable
# EXECUTABLE=$(ROOT_DIR)/bin/bomberman

# # Répertoires sources et objets
# SRC_DIR=$(ROOT_DIR)/src
# OBJ_DIR=$(ROOT_DIR)/obj

# # Chemin relatif vers les fichiers d'en-tête 
# # depuis les fichiers source
# INC_DIR_PATH="../../inc"

# # Liste des répertoires de sources
# SUB_DIRS=$(shell ls $(SRC_DIR))

# # Liste des fichiers sources (avec les chemins complets)
# #SOURCES=$(wildcard $(SRC_DIR)/**/*.c)
# SOURCES=$(foreach dir,$(SUB_DIRS),$(wildcard $(SRC_DIR)/$(dir)/*.c))

# # Génération des noms de fichiers objets (avec les chemins complets)
# OBJECTS = $(patsubst $(SRC_DIR)/%.c,$(OBJ_DIR)/%.o,$(SOURCES))

# # Règle pour la cible finale
# $(EXECUTABLE): $(OBJECTS)
# 	$(CC) $(CFLAGS) $(OBJECTS) -o $@ $(LDLIBS)

# # Règle générique pour la compilation des fichiers objets
# $(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
# 	$(CC) $(CFLAGS) -c $< -o $@ $(LDLIBS)




# # Règle pour nettoyer les fichiers objets et l'exécutable
# clean:
# 	rm -f $(OBJ_DIR)/**/*.o $(EXECUTABLE)
