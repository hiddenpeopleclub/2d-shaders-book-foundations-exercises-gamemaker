# Gamemaker Studio 2 2d Shaders Foundations Exercises

## Notes

There are differences between Unity's Shaderlab and GLSL(ES) that GMS2 uses.
* The blending operation is actually not part of the shader language itself, rather is a separate API call.  You use either **gpu_set_blendmode()** or for more complicated modes **gpu_set_blendmode_ext()** for this purpose.  You also want to return the blend mode back to **bm_normal** afterwards so that other objects don't get drawn with the same blending mode.
* At this time, you cannot change the blend mode operation.  You can set the multipliers(what comes after *Blend* in Shaderlab, like *SrcColor*, *One*, and *OneMinusSrcAlpha*) via the function **gpu_set_blendmode_ext()**, or for common defaults, you can **gpu_set_blendmode()** which allows a single constant to be specified.  But, the operation between the source and destination(*BlendOp* in Shaderlab), is currently not accessible in GMS2.
 - This leads to an issue trying to reproduce accurately the **subtractive** blend mode.  You can use **bm_subtract** as the parameter to the call to **gpu_set_blendmode()** but this is the same as calling **gpu_set_blendmode_ext()** with parameters **bm_zero** and **bm_inv_src_color**.  The result is technically a form of subtractive blending, but the result color is not an exact subtraction.  For example, subtracting 0.25 source from 0.75 destination should result in 0.5, but actually gives you 0.5625 using GMS2's method.

There is a helper object called objRoomChanger.  It is set to persistent.  It's purpose is simply to receive the spacebar input and change rooms between the two exercises.

## Exercise 1
### Shaders
* shdScroller-This shader takes a single float Uniform which is added to the U value of the UV coordinate.  The GML code increases this value from 0 to 1 based on the speed set in the code.

### objects
* objCityLoop-This draws the looping city background
 - Create-creates the *scrollSpeed* and *scrollValue* variables
 - Step-increases the *scrollValue* variable by the *scrollSpeed*, and reduces the *scrollValue* back to 0 when it reaches 1.
 - Draw-calls **gpu_set_tex_repeat(true)** so that the texture loops instead of clamping(this is a texture import setting in Unity).  It also handles setting the shader, sending the uniform variable, and draws a little debug text so you can see the *scrollvalue*.  Note that you have to call **shader_reset()** to return the shader to the default.  If you don't, all the objects that get drawn afterwards will use the same shader.

### Rooms
* rmScrolling-contains an instance of *objCityLoop*.

## Exercise 2
### Shaders
* There is no separate shader for this exercise, as the blend modes are not part of the shader code in GLSL(ES), unlike Unity's Shaderlab.

### Objects
* objAlpha-This does nothing except use the default drawing(no draw event event).  GMS2 uses alpha blending by default, so there is no need to change blend modes.
* objAdditive-This draws the sprite with additive blending.
 - Draw-sets the blend mode to *bm_add* which is accurate additive blending.  Calling **gpu_set_blendmode(bm_add)** is the same thing as calling **gpu_set_blendmode_ext(bm_one, bm_one)**.  Note that you also call **gpu_set_blendmode(bm_normal)** after drawing the sprite.  This is important because any sprites that get drawn afterwards will use the wrong blend mode.
* objMultiply-This draws the sprite with the multiply blend mode.  Identical to *objAdditive* besides the blend mode.
 - Draw-calls **gpu_set_blendmode_ext(bm_dest_colour, bm_zero)** since this mode is not handled by **gpu_set_blendmode()**.
* objSubtractive-This draws the sprite with the subtractive blend mode.  See the notes as to why this isn't an exact subtractive blend.  Identical to *objAdditive*.
 - Draw-calls **gpu_set_blendmode(bm_subtract)**, draws the srpite, then resets the blend mode.

### Rooms
* rmBlending-Contains instances of *objAlpha*, *objAdditive*, *objMultiply*, and *objSubtractive*.