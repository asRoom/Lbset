const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const cJSON = b.addModule("cJSON", .{
        .root_source_file = null,
        .target = target,
        .optimize = optimize,
    });

    cJSON.addCSourceFiles(
        .{
            .files = &.{ "cJSON_Utils.c", "cJSON.c" },
        },
    );
}
