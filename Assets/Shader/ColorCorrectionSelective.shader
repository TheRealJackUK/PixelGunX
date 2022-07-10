Shader "Hidden/ColorCorrectionSelective" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "" {}
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp vec4 selColor;
uniform highp vec4 targetColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec3 x_3;
  x_3 = (tmpvar_2.xyz - selColor.xyz);
  lowp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp ((2.0 * sqrt(
    dot (x_3, x_3)
  )), 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (targetColor, tmpvar_2, vec4(tmpvar_4));
  color_1 = tmpvar_6;
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
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp vec4 selColor;
uniform highp vec4 targetColor;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  highp vec3 x_3;
  x_3 = (tmpvar_2.xyz - selColor.xyz);
  lowp float tmpvar_4;
  highp float tmpvar_5;
  tmpvar_5 = clamp ((2.0 * sqrt(
    dot (x_3, x_3)
  )), 0.0, 1.0);
  tmpvar_4 = tmpvar_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = mix (targetColor, tmpvar_2, vec4(tmpvar_4));
  color_1 = tmpvar_6;
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