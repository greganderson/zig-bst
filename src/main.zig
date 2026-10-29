const std = @import("std");
const BST = @import("BST.zig").BST;

pub fn main(init: std.process.Init) !void {
    const arena: std.mem.Allocator = init.arena.allocator();

    var bst: BST = .init(arena);

    // TODO: Write some dang tests

    checkValue(&bst, 5, false); // expect not there

    try bst.insert(5);

    checkValue(&bst, 5, true); // expect to find
    checkValue(&bst, 7, false); // expect not there

    try bst.insert(7);
    checkValue(&bst, 7, true); // expect to find
    checkValue(&bst, 3, false); // expect not there
    checkValue(&bst, -3, false); // expect not there

    try bst.insert(-3);
    checkValue(&bst, -3, true); // expect to find
}

fn checkValue(bst: *BST, value: i32, should_find: bool) void {
    const expecting = if (should_find) "yes" else "no";
    if (bst.search(value)) {
        std.debug.print("Searched for {d}: yes, expecting {s}\n", .{ value, expecting });
    } else {
        std.debug.print("Searched for {d}: no, expecting {s}\n", .{ value, expecting });
    }
}
