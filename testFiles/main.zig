const std = @import("std");

pub fn main() !void {
    
    std.debug.print("This is printing to STDERR\n", .{});
    
    // Buffering helps reduce sys calls which are slow
    // Creates a character buffer for use in the writer
    var stdout_buffer: [256]u8 = undefined;

    // WRITERS AND HOW THEY WORK -----------------------------------------------
    // These 2 lines compile to the same machine code. The first line is syntax
    // sugar to clean things up and the second line is the more explicit version
    // In the first line stdout() returns a file handler an that is automatically
    // passed as an argument to the following function .writer()
    // If you call 2 sub functions in a row it passes the return of the first
    // to the input params of the next.
    //      var stdout_writer: std.fs.File.Writer = std.fs.File.stdout().writer(&stdout_buffer);
    //      var stdout_writer: std.fs.File.Writer = std.fs.File.writer(std.fs.File.stdout(), &stdout_buffer);
    var stdout_writer: std.fs.File.Writer = std.fs.File.stdout().writer(&stdout_buffer);
    
    // An interface that lets us communicate in a way we want with the upcoming
    // print function
    const stdout: *std.Io.Writer = &stdout_writer.interface;

    // Print is an interface that expects the thing its attached to, to be a valid
    // writer such as std.Io.Writer
    for (1..11) |i| {
        try stdout.print("{d}. Hello \n", .{i});
    }

    // don't forget to flush
    try stdout.flush();
}

