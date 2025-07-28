const std = @import("std");
const csource: []const []const u8 = @import("csource.zon");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const zsdl3_image = b.addModule("zsdl3_image", .{
        .target = target,
        .optimize = optimize,
        .root_source_file = null,
    });

    zsdl3_image.addCSourceFiles(.{
        .files = csource,
    });

    zsdl3_image.addIncludePath(b.path("include"));
    zsdl3_image.addCMacro("LOAD_BMP", "");
    zsdl3_image.addCMacro("LOAD_GIF", "");
    zsdl3_image.addCMacro("LOAD_JPEG", "");
    zsdl3_image.addCMacro("LOAD_LBM", "");
    zsdl3_image.addCMacro("LOAD_PCX", "");
    // zsdl3_image.addCMacro("LOAD_PNG", "");
    zsdl3_image.addCMacro("LOAD_PNM", "");
    zsdl3_image.addCMacro("LOAD_QOI", "");
    zsdl3_image.addCMacro("LOAD_TGA", "");
    zsdl3_image.addCMacro("LOAD_XCF", "");
    zsdl3_image.addCMacro("LOAD_XPM", "");
    zsdl3_image.addCMacro("LOAD_SVG", "");
}
