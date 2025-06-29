const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const bn = b.addModule("BN", .{
        .root_source_file = null,
        .target = target,
        .optimize = optimize,
    });

    bn.addCSourceFile(.{
        .file = b.path("bn.c"),
    });
}
