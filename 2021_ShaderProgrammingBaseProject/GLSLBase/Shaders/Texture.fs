#version 450

layout(location=0) out vec4 FragColor;

uniform sampler2D u_TexSampler;
in vec2 v_TexPos;
uniform float u_step;

const float PI = 3.141592;

vec4 P1()
{
	vec2 newTex = v_TexPos;
	newTex.y = abs(newTex.y - 0.5) * 2.0;
	vec4 returnColor =  texture(u_TexSampler, newTex);
	return returnColor;
}

vec4 P2(){
	vec2 newTex = v_TexPos;
	newTex.x = fract(newTex.x*3.0);

	vec4 returnColor = texture(u_TexSampler, newTex);
	return returnColor;
}

vec4 SingleTexture()
{
	FragColor = texture(u_TexSampler, v_TexPos);
	return FragColor;
}

vec4 spriteTexture()
{
	vec2 newTex = vec2(v_TexPos.x, u_step/6.0 + v_TexPos.y /6.0);
	return texture(u_TexSampler, newTex);
}

void main()
{
	//FragColor = P2();
	//FragColor = spriteTexture();
	FragColor = SingleTexture();
}
