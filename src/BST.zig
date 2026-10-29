const std = @import("std");
const Node = @import("Node.zig").Node;

pub const BST = struct {
    root: ?*Node = null,
    size: u16 = 0,
    allocator: std.mem.Allocator,

    pub fn init(allocator: std.mem.Allocator) BST {
        return .{ .allocator = allocator };
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

    // pub fn traverseInOrder(bst: *BST) void {
    //     // TODO: Implement
    //     return;
    // }

    pub fn len(bst: *BST) u16 {
        return bst.size;
    }
};
