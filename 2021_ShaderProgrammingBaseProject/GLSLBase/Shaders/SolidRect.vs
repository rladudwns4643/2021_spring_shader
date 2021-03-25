#version 450

in vec3 a_Position;
//uniform float u_Scale;
//uniform vec3 u_Position;

void main()
{
	//vec3 temp = a_Position;
	//temp = temp + u_Position;
	//gl_Position = vec4(temp* u_Scale, 1);
	gl_Position = vec4(a_Position, 1);
}
