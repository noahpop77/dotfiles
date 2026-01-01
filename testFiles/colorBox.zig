const std = @import("std");

// Imports the legacy version of OpenGL
const gl = @cImport({
    @cInclude("OpenGL/gl.h");
});
// Some OpenGL requirement to use it or something
const glfw = @cImport({
    @cInclude("GLFW/glfw3.h");
});

pub fn main() void {
    if (glfw.glfwInit() == 0) return;
    defer glfw.glfwTerminate();
    
    // Creates the window of specified size with specified name
    const window = glfw.glfwCreateWindow(640, 480, "Red Window", null, null);
    if (window == null) return;

    glfw.glfwMakeContextCurrent(window);

    const GL_COLOR_BUFFER_BIT: u32 = 0x00004000;

    while (glfw.glfwWindowShouldClose(window) == 0) {
        gl.glClearColor(1.0, 0.5, 0.0, 1.0); // Set the color in the box here
        gl.glClear(GL_COLOR_BUFFER_BIT);

        glfw.glfwSwapBuffers(window);
        glfw.glfwPollEvents();
    }
}

