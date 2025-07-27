const std = @import("std");

const csource: []const []const u8 = @import("csource.zon");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const freetype = b.dependency("zfreetype", .{
        .target = target,
        .optimize = optimize,
    });

    const zsdl3_ttf = b.addModule("zsdl3_ttf", .{
        .target = target,
        .optimize = optimize,
        .root_source_file = null,
    });

    zsdl3_ttf.addIncludePath(b.path("../zsdl3/include"));
    zsdl3_ttf.addIncludePath(b.path("third_party/zfreetype/include"));
    zsdl3_ttf.addIncludePath(b.path("include"));

    zsdl3_ttf.addImport("zfreetype", freetype.module("zfreetype"));
    zsdl3_ttf.addCSourceFiles(.{
        .files = csource,
    });
}
