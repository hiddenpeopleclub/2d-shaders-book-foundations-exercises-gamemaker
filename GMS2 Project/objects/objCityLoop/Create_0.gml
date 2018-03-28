scrollSpeed = 1/room_speed/5 //how fast to scroll, seconds divided into room speed, in UV space
scrollValue = 0; //current scrolling amount, increases each step

scrollValueUniform = shader_get_uniform(shdScroller, "scrollValue"); //get shader scrolling uniform