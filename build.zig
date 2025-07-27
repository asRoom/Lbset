const std = @import("std");

const csource: []const []const u8 = @import("csource.zon");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe_mod = b.createModule(.{
        // .root_source_file = b.path("src/main.zig"),
        .root_source_file = null,
        .target = target,
        .optimize = optimize,
    });

    exe_mod.addIncludePath(b.path("third_party/flecs"));
    exe_mod.addIncludePath(b.path("third_party/logc"));
    exe_mod.addIncludePath(b.path("third_party/cJSON"));
    exe_mod.addIncludePath(b.path("third_party/tiny-bignum-c"));
    exe_mod.addIncludePath(b.path("third_party/c-algorithms/src"));
    exe_mod.addIncludePath(b.path("third_party/lua/src"));
    exe_mod.addIncludePath(b.path("third_party/physfs/src"));
    exe_mod.addIncludePath(b.path("third_party/clay"));

    exe_mod.addCSourceFiles(.{
        .files = csource,
        .root = b.path("src"),
    });

    // const zimgui = b.dependency("zimgui", .{
    //     .target = target,
    //     .optimize = optimize,
    // });

    // const zimgui_mod = zimgui.module("zimgui");

    const exe = b.addExecutable(.{
        .name = "Lbset",
        .root_module = exe_mod,
    });

    const zclay = b.dependency("clay", .{
        .target = target,
        .optimize = optimize,
    });
    exe_mod.addImport("clay", zclay.module("clay"));

    const flecs = b.dependency("flecs", .{
        .target = target,
        .optimize = optimize,
    });
    exe_mod.addImport("flecs", flecs.module("flecs"));

    const logc = b.dependency("logc", .{
        .target = target,
        .optimize = optimize,
    });
    exe_mod.addImport("logc", logc.module("logc"));

    const cjson = b.dependency("cJSON", .{
        .target = target,
        .optimize = optimize,
    });
    exe_mod.addImport("cJSON", cjson.module("cJSON"));

    const tiny_bignum_c = b.dependency("tiny_bignum_c", .{
        .target = target,
        .optimize = optimize,
    });
    exe_mod.addImport("tiny_bignum_c", tiny_bignum_c.module("BN"));

    const cAlgor = b.dependency("cAlgor", .{
        .target = target,
        .optimize = optimize,
    });
    exe_mod.addImport("cAlgor", cAlgor.module("cAlgor"));

    const lua = b.dependency("lua", .{
        .target = target,
        .optimize = optimize,
    });
    exe_mod.addImport("lua", lua.module("lua"));

    const physfs = b.dependency("physfs", .{
        .target = target,
        .optimize = optimize,
    });
    exe_mod.addImport("physfs", physfs.module("physfs"));

    const zsdl3_ttf = b.dependency("zsdl3_ttf", .{
        .target = target,
        .optimize = optimize,
    });
    exe.root_module.addImport("zsdl3_ttf", zsdl3_ttf.module("zsdl3_ttf"));

    const zsdl3 = b.dependency("zsdl3", .{
        .target = target,
        .optimize = optimize,
        //.preferred_linkage = .static,
        //.strip = null,
        //.sanitize_c = null,
        //.pic = null,
        //.lto = null,
        //.emscripten_pthreads = false,
        //.install_build_config_h = false,
    });

    exe.linkLibrary(zsdl3.artifact("SDL3"));

    // exe.linkSystemLibrary("SDL3");
    // exe.linkSystemLibrary("SDL3_ttf");
    // exe.linkSystemLibrary("freetype");
    // exe.linkSystemLibrary("harfbuzz");
    // exe.linkSystemLibrary("cairo");
    // exe.linkSystemLibrary("libpng");
    // exe.linkSystemLibrary("zlib");

    exe.linkLibC();
    // exe.linkLibCpp();

    switch (target.result.os.tag) {
        .windows => {
            exe.linkSystemLibrary("opengl32");
        },
        else => {
            exe.linkSystemLibrary("GL");
            // exe.linkSystemLibrary("dl");
            // exe.linkSystemLibrary("pthread");
        },
    }

    // switch (target.result.os.tag) {
    //     .windows => {
    //         exe.linkSystemLibrary("setupapi");
    //         exe.linkSystemLibrary("cfgmgr32");
    //         exe.linkSystemLibrary("kernel32");
    //         exe.linkSystemLibrary("user32");
    //         exe.linkSystemLibrary("gdi32");
    //         exe.linkSystemLibrary("winmm");
    //         exe.linkSystemLibrary("imm32");
    //         exe.linkSystemLibrary("ole32");
    //         exe.linkSystemLibrary("oleaut32");
    //         exe.linkSystemLibrary("shell32");
    //         exe.linkSystemLibrary("version");
    //         exe.linkSystemLibrary("uuid");
    //     },
    //     .macos => {
    //         exe.linkFramework("Foundation");
    //         exe.linkFramework("Cocoa");
    //         exe.linkFramework("Carbon");
    //         exe.linkFramework("IOKit");
    //         exe.linkFramework("CoreAudio");
    //         exe.linkFramework("AudioToolbox");
    //         exe.linkFramework("ForceFeedback");
    //         exe.linkFramework("CoreVideo");
    //         exe.linkFramework("CoreGraphics");
    //         exe.linkFramework("Metal");
    //     },
    //     else => {
    //         exe.linkSystemLibrary("m");
    //         exe.linkSystemLibrary("dl");
    //         exe.linkSystemLibrary("rt");
    //         exe.linkSystemLibrary("pthread");
    //     },
    // }

    b.installDirectory(
        .{
            .source_dir = b.path("data"),
            .install_dir = .{
                .custom = "data",
            },
            .install_subdir = "",
        },
    );

    // b.installDirectory(
    //     .{
    //         .source_dir = b.path("assets"),
    //         .install_dir = .{
    //             .custom = "assets",
    //         },
    //         .install_subdir = "",
    //     },
    // );

    // b.installDirectory(
    //     .{
    //         .source_dir = b.path("config"),
    //         .install_dir = .{
    //             .custom = "config",
    //         },
    //         .install_subdir = "",
    //     },
    // );

    // b.installDirectory(
    //     .{
    //         .source_dir = b.path("mods"),
    //         .install_dir = .{
    //             .custom = "mods",
    //         },
    //         .install_subdir = "",
    //     },
    // );

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);

    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);

    const exe_unit_tests = b.addTest(.{
        .root_module = exe_mod,
    });

    const run_exe_unit_tests = b.addRunArtifact(exe_unit_tests);

    const test_step = b.step("test", "Run unit tests");
    test_step.dependOn(&run_exe_unit_tests.step);
}
