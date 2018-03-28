//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float scrollValue;

void main()
{
	vec2 scroll = vec2(scrollValue, 0);
	vec2 newUVs = v_vTexcoord + scroll;
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, newUVs );
}
