const std = @import("std");
const csource: []const []const u8 = @import("csource.zon");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const zfreetype = b.addModule("zfreetype", .{
        .optimize = optimize,
        .target = target,
        .root_source_file = null,
    });

    zfreetype.addCSourceFiles(.{
        .files = csource,
    });
    zfreetype.addIncludePath(b.path("include"));
    zfreetype.addCMacro("FT2_BUILD_LIBRARY", "");

    if (target.result.os.tag == .macos) {
        zfreetype.addCSourceFile(.{
            .file = b.path("src/base/ftmac.c"),
        });
    }
}
