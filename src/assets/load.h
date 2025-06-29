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

#ifndef ASSETS_LOAD_H
#define ASSETS_LOAD_H

#include <stddef.h>
#include <stdint.h>
#include <stdbool.h>

enum AssetsCategory {
	ASSETS_CATEGORY_NONE = 0,
	ASSETS_CATEGORY_TEXTURE = 1 << 0,
	ASSETS_CATEGORY_SOUND = 1 << 1,
	ASSETS_CATEGORY_FONT = 1 << 2,
	ASSETS_CATEGORY_MODEL = 1 << 3,
	ASSETS_CATEGORY_SHADER = 1 << 4,
	ASSETS_CATEGORY_SCRIPT = 1 << 5,
        ASSETS_CATEGORY_MOD = 1 << 6,
};

typedef struct AssetsManager {
        void* TextureTable;
        void* AudioTable;
        void* FontTable;
        void* ModelTable;
        void* ShaderTable;
        void* ScriptTable;
        void* ModTable;
} AssetsManager;

bool ASSETS_Init (void);
bool ASSETS_Quit (void);

bool ASSETS_Load (enum AssetsCategory category, const char* name);
bool ASSETS_Query (enum AssetsCategory category, const char* name, void** outData, uint32_t* outSize);
bool ASSETS_Unload (enum AssetsCategory category, const char* name);

#endif