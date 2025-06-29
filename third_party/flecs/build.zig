const std = @import("std");
const builtin = @import("builtin");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});
    const opt_use_shared = b.option(bool, "shared", "Make shared (default: false)") orelse false;
    _ = b.addModule("root", .{
        .root_source_file = null,
    });

    const flecs = b.addModule("flecs", .{
        .root_source_file = null,
        .target = target,
        .optimize = optimize,
    });

    flecs.addCSourceFile(
        .{
            .file = b.path("flecs.c"),
            .flags = &.{
                "-fno-sanitize=undefined",
                "-DFLECS_NO_CPP",
                "-DFLECS_USE_OS_ALLOC",
                if (builtin.mode == .Debug) "-DFLECS_SANITIZE" else "",
                if (opt_use_shared) "-DFLECS_SHARED" else "",
            },
        },
    );

    if (target.result.os.tag == .windows) {
        flecs.linkSystemLibrary("ws2_32", .{});
    }
}
