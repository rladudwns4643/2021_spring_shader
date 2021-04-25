#version 450

in vec3 a_Position;		//float position 3개
in vec3 a_Velocity;		//float velocity 3개
in float a_EmitTime;	//float emittime 1개
in float a_LifeTime;	//float Lifetime 1개
in float a_Period;		//float Period 1개
in float a_Amp;			//float Amp 1개
in float a_Rand;		//float rand 1개
in vec4 a_Color;		//float rand 4개

uniform float u_Time; //누적 시간
uniform vec3 u_ExForce; //외부 입력

const vec3 c_Gravity = vec3(0, -0.8, 0);
const mat3 c_NV = mat3(0, -1, 0, 1, 0, 0, 0, 0, 0); //열 기준 정렬

out vec4 v_Color;
void main()
{
	float newTime = u_Time - a_EmitTime;
	//vec3 newPos = a_Position;
	vec3 newPos;
	newPos.x = a_Position.x + cos(a_Rand*2*3.14);
	newPos.y = a_Position.y + sin(a_Rand*2*3.14);

	newPos.x = a_Position.x + (16 * pow(sin(a_Rand*2*3.14), 3)) * 0.03;
	newPos.y = a_Position.y + (13*cos(a_Rand*2*3.14) - 5*cos(2*a_Rand*2*3.14) - 2*cos(3*a_Rand*2*3.14) - cos(4*a_Rand*2*3.14)) * 0.03;
	vec4 color = vec4(0);
	if(newTime < 0.0)
	{
		newPos = vec3(10000,10000,10000);
	}
	else
	{
		//newTime = mod(newTime, a_LifeTime);
		//newPos = newPos + vec3(newTime, 0, 0);
		//newPos.y = newPos.y + (a_Amp * newTime ) *sin(newTime * 3.14 * 2 * a_Period);
		float t = newTime;
		float tt = newTime * newTime;
		vec3 newAcc = c_Gravity + u_ExForce;
		vec3 curVel = a_Velocity + t * newAcc;
		vec3 normalv = normalize(curVel * c_NV);
		newPos = newPos + t * a_Velocity + 0.5 * newAcc * tt;
		newPos = newPos + normalv * a_Amp * sin(newTime*2*3.14*a_Period);

		float intensity = 1.0 - t/a_LifeTime;
		color = a_Color * intensity;
	}
	
	gl_Position = vec4(newPos, 1);
	v_Color = color;
}
