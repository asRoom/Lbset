const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const physfs = b.addModule("physfs", .{
        .target = target,
        .optimize = optimize,
        .root_source_file = null,
    });

    physfs.addCSourceFiles(.{
        .files = &.{
            "src/physfs.c",
            "src/physfs_archiver_7z.c",
            "src/physfs_archiver_csm.c",
            "src/physfs_archiver_dir.c",
            "src/physfs_archiver_grp.c",
            "src/physfs_archiver_hog.c",
            "src/physfs_archiver_iso9660.c",
            "src/physfs_archiver_lec3d.c",
            "src/physfs_archiver_mvl.c",
            "src/physfs_archiver_qpak.c",
            "src/physfs_archiver_slb.c",
            "src/physfs_archiver_unpacked.c",
            "src/physfs_archiver_vdf.c",
            "src/physfs_archiver_wad.c",
            "src/physfs_archiver_zip.c",
            "src/physfs_byteorder.c",
            "src/physfs_platform_android.c",
            // "src/physfs_platform_libretro.c",
            // "src/physfs_platform_ogc.c",
            // "src/physfs_platform_os2.c",
            // "src/physfs_platform_playdate.c",
            "src/physfs_platform_posix.c",
            // "src/physfs_platform_qnx.c",
            "src/physfs_platform_unix.c",
            "src/physfs_platform_windows.c",
            "src/physfs_unicode.c",
            "src/physfssdl3.c",
        },
    });
}
