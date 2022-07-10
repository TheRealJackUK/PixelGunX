Shader "Hidden/Highlighted/StencilOpaqueZ" {
SubShader { 
 Pass {
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _Outline;
void main ()
{
  gl_FragData[0] = _Outline;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _Outline;
void main ()
{
  _glesFragData[0] = _Outline;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
"!!GLES"
}
SubProgram "gles3 " {
"!!GLES3"
}
}
 }
}
Fallback Off
}