const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lua = b.addModule("lua", .{
        .target = target,
        .optimize = optimize,
        .root_source_file = null,
    });

    lua.addCSourceFiles(.{
        .files = &.{
            "src/lapi.c",
            "src/lauxlib.c",
            "src/lbaselib.c",
            "src/lcode.c",
            "src/lcorolib.c",
            "src/lctype.c",
            "src/ldblib.c",
            "src/ldebug.c",
            "src/ldo.c",
            "src/ldump.c",
            "src/lfunc.c",
            "src/lgc.c",
            "src/linit.c",
            "src/liolib.c",
            "src/llex.c",
            "src/lmathlib.c",
            "src/lmem.c",
            "src/loadlib.c",
            "src/lobject.c",
            "src/lopcodes.c",
            "src/loslib.c",
            "src/lparser.c",
            "src/lstate.c",
            "src/lstring.c",
            "src/lstrlib.c",
            "src/ltablib.c",
            "src/ltable.c",
            "src/ltm.c",
            "src/lundump.c",
            "src/lutf8lib.c",
            "src/lvm.c",
            "src/lzio.c",
        },
    });
}
