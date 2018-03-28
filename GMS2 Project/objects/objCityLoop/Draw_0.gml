gpu_set_tex_repeat(true);
shader_set(shdScroller);
shader_set_uniform_f(scrollValueUniform, scrollValue);
draw_self();
shader_reset();
draw_text(10, 10, scrollValue);