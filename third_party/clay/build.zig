const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mod = b.addModule(
        "clay",
        .{
            .root_source_file = null,
            .target = target,
            .optimize = optimize,
        },
    );

    mod.addIncludePath(b.path("../zsdl3/include"));
    mod.addIncludePath(b.path("../zsdl3-image/include"));
    mod.addIncludePath(b.path("../zsdl3-ttf/include"));

    mod.addCSourceFiles(.{
        .files = &.{
            "renderers/SDL3/clay_renderer_SDL3.c",
        },
    });
}
