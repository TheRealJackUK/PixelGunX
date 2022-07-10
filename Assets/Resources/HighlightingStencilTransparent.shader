Shader "Hidden/Highlighted/StencilTransparent" {
Properties {
 _MainTex ("", 2D) = "" {}
 _Cutoff ("", Float) = 0.5
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _Outline;
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float x_1;
  x_1 = (texture2D (_MainTex, xlv_TEXCOORD0).w - _Cutoff);
  if ((x_1 < 0.0)) {
    discard;
  };
  gl_FragData[0] = _Outline;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _Outline;
uniform sampler2D _MainTex;
uniform lowp float _Cutoff;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float x_1;
  x_1 = (texture (_MainTex, xlv_TEXCOORD0).w - _Cutoff);
  if ((x_1 < 0.0)) {
    discard;
  };
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