const std = @import("std");
const Node = @import("Node.zig").Node;

pub const BST = struct {
    root: ?*Node = null,
    size: u16 = 0,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) BST {
        return .{ .allocator = allocator };
    }

    pub fn initFromString(allocator: std.mem.Allocator, nodes: []const i32) BST {
        // I want to be able to accept a string and output the BST, so I need to
        // split on the delimiter (maybe accept that as a parameter?) and loop
        // over the array.
        const bst: BST = .init(allocator);
        for (nodes) |node| {
            bst.insert(node);
        }
    }

    fn createNode(bst: *BST, value: i32) !*Node {
        const node = try bst.allocator.create(Node);
        node.* = .{ .value = value };
        return node;
    }

    pub fn insert(bst: *BST, value: i32) !void {
        if (bst.root == null) {
            const node = try bst.createNode(value);
            bst.root = node;
            return;
        }

        if (try bst.insertRecursive(bst.root.?, value)) {
            bst.size += 1;
        }
    }

    fn insertRecursive(bst: *BST, parent: *Node, value: i32) !bool {
        if (value == parent.value) {
            return false;
        }

        if (value < parent.value) {
            if (parent.left == null) {
                const node = try bst.createNode(value);
                parent.left = node;
                return true;
            }
            return try bst.insertRecursive(parent.left.?, value);
        } else {
            if (parent.right == null) {
                const node = try bst.createNode(value);
                parent.right = node;
                return true;
            }
            return try bst.insertRecursive(parent.right.?, value);
        }
    }

    pub fn search(bst: *BST, value: i32) bool {
        if (bst.root == null) {
            return false;
        }
        return bst.searchRecursive(bst.root.?, value);
    }

    fn searchRecursive(bst: *BST, parent: *Node, value: i32) bool {
        if (value == parent.value) {
            return true;
        }

        if (value < parent.value) {
            if (parent.left == null) {
                return false;
            }
            return bst.searchRecursive(parent.left.?, value);
        } else {
            if (parent.right == null) {
                return false;
            }
            return bst.searchRecursive(parent.right.?, value);
        }
    }

    pub fn traverseInOrder(bst: *BST) void {
        if (bst.root == null) return;

        bst.traverseInOrderRecursive(bst.root.?);
    }

    fn traverseInOrderRecursive(bst: *BST, parent: *Node) void {
        if (parent.left != null) {
            bst.traverseInOrderRecursive(parent.left.?);
        }

        std.debug.print("Node: {d}\n", .{parent.value});

        if (parent.right != null) {
            bst.traverseInOrderRecursive(parent.right.?);
        }
    }

    pub fn traverseNormalOrderOrWhateverItsCalled(bst: *BST) void {
        if (bst.root == null) return;

        bst.traverseNormalOrderOrWhateverItsCalledRecursive(bst.root.?);
    }

    fn traverseNormalOrderOrWhateverItsCalledRecursive(bst: *BST, parent: *Node) void {
        std.debug.print("Node: {d}\n", .{parent.value});
        if (parent.left != null) {
            bst.traverseNormalOrderOrWhateverItsCalledRecursive(parent.left.?);
        }
        if (parent.right != null) {
            bst.traverseNormalOrderOrWhateverItsCalledRecursive(parent.right.?);
        }
    }

    pub fn len(bst: *BST) u16 {
        return bst.size;
    }
};
