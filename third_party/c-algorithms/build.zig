const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const mod = b.addModule("cAlgor", .{
        .root_source_file = null,
        .optimize = optimize,
        .target = target,
    });

    mod.addCSourceFiles(.{
        .files = &.{
            "arraylist.c",
            "avl-tree.c",
            "binary-heap.c",
            "binomial-heap.c",
            "bloom-filter.c",
            "compare-int.c",
            "compare-string.c",
            "compare-pointer.c",
            "hash-int.c",
            "hash-pointer.c",
            "hash-string.c",
            "hash-table.c",
            "list.c",
            "queue.c",
            "rb-tree.c",
            "set.c",
            "slist.c",
            "sortedarray.c",
            "trie.c",
        },
        .root = b.path("src"),
    });
}
