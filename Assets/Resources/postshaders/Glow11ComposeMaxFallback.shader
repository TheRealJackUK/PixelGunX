Shader "Hidden/Glow 11/Compose Max Fallback" {
Properties {
 _MainTex ("", 2D) = "white" {}
 _DestTex ("", 2D) = "white" {}
 _Strength ("Strength", Float) = 1
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  ColorMask RGB
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _DestTex;
uniform sampler2D _MainTex;
uniform lowp float _Strength;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = max (texture2D (_DestTex, xlv_TEXCOORD0), (texture2D (_MainTex, xlv_TEXCOORD0) * _Strength));
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
out mediump vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _DestTex;
uniform sampler2D _MainTex;
uniform lowp float _Strength;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = max (texture (_DestTex, xlv_TEXCOORD0), (texture (_MainTex, xlv_TEXCOORD0) * _Strength));
  _glesFragData[0] = tmpvar_1;
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