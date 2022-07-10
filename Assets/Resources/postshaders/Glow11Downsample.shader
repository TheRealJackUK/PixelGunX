Shader "Hidden/Glow 11/Downsample" {
Properties {
 _MainTex ("MainTex", 2D) = "white" {}
 _Strength ("Strength", Float) = 0.25
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
uniform highp mat4 glstate_matrix_texture0;
uniform highp vec4 _MainTex_TexelSize;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD0_3;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec4 uv_2;
  mediump vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 inUV_7;
  inUV_7 = tmpvar_1;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = inUV_7;
  uv_2.xy = (glstate_matrix_texture0 * tmpvar_8).xy;
  uv_2.zw = vec2(0.0, 0.0);
  highp float tmpvar_9;
  tmpvar_9 = _MainTex_TexelSize.x;
  highp float tmpvar_10;
  tmpvar_10 = _MainTex_TexelSize.y;
  highp vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, 1.0);
  highp float cse_12;
  cse_12 = -(_MainTex_TexelSize.x);
  tmpvar_11.x = cse_12;
  highp float cse_13;
  cse_13 = -(_MainTex_TexelSize.y);
  tmpvar_11.y = cse_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (uv_2 + tmpvar_11);
  tmpvar_3 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.zw = vec2(0.0, 1.0);
  tmpvar_15.x = tmpvar_9;
  tmpvar_15.y = cse_13;
  highp vec4 tmpvar_16;
  tmpvar_16 = (uv_2 + tmpvar_15);
  tmpvar_4 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.zw = vec2(0.0, 1.0);
  tmpvar_17.x = tmpvar_9;
  tmpvar_17.y = tmpvar_10;
  highp vec4 tmpvar_18;
  tmpvar_18 = (uv_2 + tmpvar_17);
  tmpvar_5 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.zw = vec2(0.0, 1.0);
  tmpvar_19.x = cse_12;
  tmpvar_19.y = tmpvar_10;
  highp vec4 tmpvar_20;
  tmpvar_20 = (uv_2 + tmpvar_19);
  tmpvar_6 = tmpvar_20;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD0_1 = tmpvar_4;
  xlv_TEXCOORD0_2 = tmpvar_5;
  xlv_TEXCOORD0_3 = tmpvar_6;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp float _Strength;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD0_3;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (((
    (texture2D (_MainTex, xlv_TEXCOORD0.xy) + texture2D (_MainTex, xlv_TEXCOORD0_1.xy))
   + texture2D (_MainTex, xlv_TEXCOORD0_2.xy)) + texture2D (_MainTex, xlv_TEXCOORD0_3.xy)) * _Strength);
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
uniform highp mat4 glstate_matrix_texture0;
uniform highp vec4 _MainTex_TexelSize;
out mediump vec4 xlv_TEXCOORD0;
out mediump vec4 xlv_TEXCOORD0_1;
out mediump vec4 xlv_TEXCOORD0_2;
out mediump vec4 xlv_TEXCOORD0_3;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec4 uv_2;
  mediump vec4 tmpvar_3;
  mediump vec4 tmpvar_4;
  mediump vec4 tmpvar_5;
  mediump vec4 tmpvar_6;
  highp vec2 inUV_7;
  inUV_7 = tmpvar_1;
  highp vec4 tmpvar_8;
  tmpvar_8.zw = vec2(0.0, 0.0);
  tmpvar_8.xy = inUV_7;
  uv_2.xy = (glstate_matrix_texture0 * tmpvar_8).xy;
  uv_2.zw = vec2(0.0, 0.0);
  highp float tmpvar_9;
  tmpvar_9 = _MainTex_TexelSize.x;
  highp float tmpvar_10;
  tmpvar_10 = _MainTex_TexelSize.y;
  highp vec4 tmpvar_11;
  tmpvar_11.zw = vec2(0.0, 1.0);
  highp float cse_12;
  cse_12 = -(_MainTex_TexelSize.x);
  tmpvar_11.x = cse_12;
  highp float cse_13;
  cse_13 = -(_MainTex_TexelSize.y);
  tmpvar_11.y = cse_13;
  highp vec4 tmpvar_14;
  tmpvar_14 = (uv_2 + tmpvar_11);
  tmpvar_3 = tmpvar_14;
  highp vec4 tmpvar_15;
  tmpvar_15.zw = vec2(0.0, 1.0);
  tmpvar_15.x = tmpvar_9;
  tmpvar_15.y = cse_13;
  highp vec4 tmpvar_16;
  tmpvar_16 = (uv_2 + tmpvar_15);
  tmpvar_4 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.zw = vec2(0.0, 1.0);
  tmpvar_17.x = tmpvar_9;
  tmpvar_17.y = tmpvar_10;
  highp vec4 tmpvar_18;
  tmpvar_18 = (uv_2 + tmpvar_17);
  tmpvar_5 = tmpvar_18;
  highp vec4 tmpvar_19;
  tmpvar_19.zw = vec2(0.0, 1.0);
  tmpvar_19.x = cse_12;
  tmpvar_19.y = tmpvar_10;
  highp vec4 tmpvar_20;
  tmpvar_20 = (uv_2 + tmpvar_19);
  tmpvar_6 = tmpvar_20;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_3;
  xlv_TEXCOORD0_1 = tmpvar_4;
  xlv_TEXCOORD0_2 = tmpvar_5;
  xlv_TEXCOORD0_3 = tmpvar_6;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp float _Strength;
in mediump vec4 xlv_TEXCOORD0;
in mediump vec4 xlv_TEXCOORD0_1;
in mediump vec4 xlv_TEXCOORD0_2;
in mediump vec4 xlv_TEXCOORD0_3;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (((
    (texture (_MainTex, xlv_TEXCOORD0.xy) + texture (_MainTex, xlv_TEXCOORD0_1.xy))
   + texture (_MainTex, xlv_TEXCOORD0_2.xy)) + texture (_MainTex, xlv_TEXCOORD0_3.xy)) * _Strength);
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

uniform sampler2D _MainTex;
uniform lowp float _Strength;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * _Strength);
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
uniform sampler2D _MainTex;
uniform lowp float _Strength;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture (_MainTex, xlv_TEXCOORD0) * _Strength);
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