const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mod = b.addModule("logc", .{
        .root_source_file = null,
        .optimize = optimize,
        .target = target,
    });

    mod.addCSourceFile(.{
        .file = b.path("src/log.c"),
    });
}
