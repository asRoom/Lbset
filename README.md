# Lbset
A simple framework which you can easily use SDL3 (include its ttf & image feature), Lua and etc by Pure C17 language.
## Install
To build this repository, you need `zig 0.14.1` or later. You can get it from here [⚡Zig](https://ziglang.org/).

- Add Zig into PATH.
- Clone this repository.
- Change directory into this repository's directory.
- Write your own code and add them into `csource.zon` file.
- Execute `zig build`.

## Usage
You can choose to develop this engine with more codes or just use the provided module interface.
This repository use Pure C17, so there should not be a problem to transplant it.
Zig serve as a build toolchain.

The pre-provided libraries are as follow:
- SDL3 with ttf & image
- Clay UI
- flecs
- cJSON
- c-algorithms
- log.c
- lua
- physfs
- tiny-bignum-c
- zfreetype


## License
This repository uses LGPL 3.0 as its license. You can see it at LICENSE.