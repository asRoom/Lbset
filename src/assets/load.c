/*
    Lbset - A cards game engine.
    Copyright (C) 2025 asRoom

    This program is free software: you can redistribute it and/or modify
    it under the terms of the Lesser GNU General Public License as
    published by the Free Software Foundation, either version 3 of the 
    License, or (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    Lesser GNU General Public License for more details.

    You should have received a copy of the Lesser GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

#include "load.h"

#include <SDL3/SDL_assert.h>
#include <physfs.h>

static inline void mount(const char* path, const char* mountPoint, int appendToPath) {
	SDL_assert(path != NULL);
	SDL_assert(mountPoint != NULL);
	SDL_assert(PHYSFS_mount(path, mountPoint, appendToPath) != 0);
}

static inline void unmount(const char* mountPoint) {
	SDL_assert(mountPoint != NULL);
	SDL_assert(PHYSFS_unmount(mountPoint) != 0);
}

bool ASSETS_Init(void) {
	mount("../assets", "/assets", 0);
	mount("../assets/mods", "/mods", 0);
	mount("../assets/sounds", "/sounds", 0);
	mount("../assets/textures", "/textures", 0);
	mount("../assets/fonts", "/fonts", 0);
	mount("../assets/models", "/models", 0);
	mount("../assets/shaders", "/shaders", 0);
	mount("../assets/scripts", "/scripts", 0);

	return true;
}

bool ASSETS_Quit(void) {
	unmount("/assets");
	unmount("/mods");
	unmount("/sounds");
	unmount("/textures");
	unmount("/fonts");
	unmount("/models");
	unmount("/shaders");
	unmount("/scripts");

	return true;
}

bool ASSETS_Query(enum AssetsCategory category, const char* name, void** outData, uint32_t* outSize) {
	SDL_assert(name != NULL);
	SDL_assert(outData != NULL);
	SDL_assert(outSize != NULL);

    const uint32_t maxLength = 256;

	char* filePath = NULL;

	switch (category) {
	case ASSETS_CATEGORY_TEXTURE: {
		filePath = SDL_strlcat("/textures/", name, maxLength);
		break;
	};
	case ASSETS_CATEGORY_SOUND: {
		filePath = SDL_strlcat("/sounds/", name, maxLength);
		break;
	};
	case ASSETS_CATEGORY_FONT: {
		filePath = SDL_strlcat("/fonts/", name, maxLength);
		break;
	};
	case ASSETS_CATEGORY_MODEL: {
		filePath = SDL_strlcat("/models/", name, maxLength);
		break;
	};
	case ASSETS_CATEGORY_SHADER: {
		filePath = SDL_strlcat("/shaders/", name, maxLength);
		break;
	};
	case ASSETS_CATEGORY_SCRIPT: {
		filePath = SDL_strlcat("/scripts/", name, maxLength);
		break;
	};
	case ASSETS_CATEGORY_MOD: {
		filePath = SDL_strlcat("/mods/", name, maxLength);
		break;
	};
	default: {
		SDL_assert(false && "Unknown assets category");
		return false;
	};
	}
	SDL_assert(filePath != NULL);
	*outData = PHYSFS_openRead(filePath);
}