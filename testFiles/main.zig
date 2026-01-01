// const std = @import("std");
//
// pub fn main() !void {
//     var print = std.fs.File.stdout();
//     try print.writeAll("BOBBYB\n");
//     try std.fs.File.stdout().writeAll("Hello, World!\n");
//     std.debug.print("Hello, {s}\n", .{"BITCH"});
// }


const std = @import("std");

pub fn main() !void {
    
    // Buffering helps reduce sys calls which are slow
    // Release note: Please use buffering! and don't forget to flush!!!
    // we take a pointer, because, that's what the function needs (use @fieldParentPtr)!
    var stdout_buffer: [256]u8 = undefined;
    var stdout_writer: std.fs.File.Writer = std.fs.File.stdout().writer(&stdout_buffer);
    const stdout: *std.Io.Writer = &stdout_writer.interface;

    for (1..11) |i| {
        try stdout.print("{d}. Hello \n", .{i});
    }

    // don't forget to flush
    try stdout.flush();
}
