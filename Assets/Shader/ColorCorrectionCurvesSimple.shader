Shader "Hidden/ColorCorrectionCurvesSimple" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "" {}
 _RgbTex ("_RgbTex (RGB)", 2D) = "" {}
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
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

uniform sampler2D _MainTex;
uniform sampler2D _RgbTex;
uniform lowp float _Saturation;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec2 tmpvar_3;
  tmpvar_3.y = 0.125;
  tmpvar_3.x = tmpvar_2.x;
  lowp vec2 tmpvar_4;
  tmpvar_4.y = 0.375;
  tmpvar_4.x = tmpvar_2.y;
  lowp vec2 tmpvar_5;
  tmpvar_5.y = 0.625;
  tmpvar_5.x = tmpvar_2.z;
  lowp vec4 tmpvar_6;
  tmpvar_6.xyz = (((texture2D (_RgbTex, tmpvar_3).xyz * vec3(1.0, 0.0, 0.0)) + (texture2D (_RgbTex, tmpvar_4).xyz * vec3(0.0, 1.0, 0.0))) + (texture2D (_RgbTex, tmpvar_5).xyz * vec3(0.0, 0.0, 1.0)));
  tmpvar_6.w = tmpvar_2.w;
  color_1.w = tmpvar_6.w;
  color_1.xyz = mix (vec3(dot (tmpvar_6.xyz, vec3(0.22, 0.707, 0.071))), tmpvar_6.xyz, vec3(_Saturation));
  gl_FragData[0] = color_1;
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
uniform sampler2D _MainTex;
uniform sampler2D _RgbTex;
uniform lowp float _Saturation;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec2 tmpvar_3;
  tmpvar_3.y = 0.125;
  tmpvar_3.x = tmpvar_2.x;
  lowp vec2 tmpvar_4;
  tmpvar_4.y = 0.375;
  tmpvar_4.x = tmpvar_2.y;
  lowp vec2 tmpvar_5;
  tmpvar_5.y = 0.625;
  tmpvar_5.x = tmpvar_2.z;
  lowp vec4 tmpvar_6;
  tmpvar_6.xyz = (((texture (_RgbTex, tmpvar_3).xyz * vec3(1.0, 0.0, 0.0)) + (texture (_RgbTex, tmpvar_4).xyz * vec3(0.0, 1.0, 0.0))) + (texture (_RgbTex, tmpvar_5).xyz * vec3(0.0, 0.0, 1.0)));
  tmpvar_6.w = tmpvar_2.w;
  color_1.w = tmpvar_6.w;
  color_1.xyz = mix (vec3(dot (tmpvar_6.xyz, vec3(0.22, 0.707, 0.071))), tmpvar_6.xyz, vec3(_Saturation));
  _glesFragData[0] = color_1;
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