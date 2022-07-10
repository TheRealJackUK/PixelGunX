Shader "Hidden/Glow 11/Blur" {
Properties {
 _MainTex ("", 2D) = "" {}
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
uniform mediump float _offset1;
uniform mediump float _offset2;
uniform mediump vec4 _MainTex_TexelSize;
varying mediump vec2 xlv_TEXCOORD;
varying mediump vec2 xlv_TEXCOORD_1;
varying mediump vec2 xlv_TEXCOORD_2;
varying mediump vec2 xlv_TEXCOORD_3;
varying mediump vec2 xlv_TEXCOORD_4;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_2.y = tmpvar_1.y;
  tmpvar_3.y = tmpvar_1.y;
  tmpvar_4.y = tmpvar_1.y;
  tmpvar_5.y = tmpvar_1.y;
  mediump float cse_6;
  cse_6 = (_offset1 * _MainTex_TexelSize.x);
  tmpvar_2.x = (_glesMultiTexCoord0.x - cse_6);
  tmpvar_3.x = (_glesMultiTexCoord0.x + cse_6);
  mediump float cse_7;
  cse_7 = (_offset2 * _MainTex_TexelSize.x);
  tmpvar_4.x = (_glesMultiTexCoord0.x - cse_7);
  tmpvar_5.x = (_glesMultiTexCoord0.x + cse_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD = tmpvar_1;
  xlv_TEXCOORD_1 = tmpvar_2;
  xlv_TEXCOORD_2 = tmpvar_3;
  xlv_TEXCOORD_3 = tmpvar_4;
  xlv_TEXCOORD_4 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD;
varying mediump vec2 xlv_TEXCOORD_1;
varying mediump vec2 xlv_TEXCOORD_2;
varying mediump vec2 xlv_TEXCOORD_3;
varying mediump vec2 xlv_TEXCOORD_4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (((texture2D (_MainTex, xlv_TEXCOORD) * 0.227027) + (
    (texture2D (_MainTex, xlv_TEXCOORD_1) + texture2D (_MainTex, xlv_TEXCOORD_2))
   * 0.316216)) + ((texture2D (_MainTex, xlv_TEXCOORD_3) + texture2D (_MainTex, xlv_TEXCOORD_4)) * 0.0702703));
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
uniform mediump float _offset1;
uniform mediump float _offset2;
uniform mediump vec4 _MainTex_TexelSize;
out mediump vec2 xlv_TEXCOORD;
out mediump vec2 xlv_TEXCOORD_1;
out mediump vec2 xlv_TEXCOORD_2;
out mediump vec2 xlv_TEXCOORD_3;
out mediump vec2 xlv_TEXCOORD_4;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_2.y = tmpvar_1.y;
  tmpvar_3.y = tmpvar_1.y;
  tmpvar_4.y = tmpvar_1.y;
  tmpvar_5.y = tmpvar_1.y;
  mediump float cse_6;
  cse_6 = (_offset1 * _MainTex_TexelSize.x);
  tmpvar_2.x = (_glesMultiTexCoord0.x - cse_6);
  tmpvar_3.x = (_glesMultiTexCoord0.x + cse_6);
  mediump float cse_7;
  cse_7 = (_offset2 * _MainTex_TexelSize.x);
  tmpvar_4.x = (_glesMultiTexCoord0.x - cse_7);
  tmpvar_5.x = (_glesMultiTexCoord0.x + cse_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD = tmpvar_1;
  xlv_TEXCOORD_1 = tmpvar_2;
  xlv_TEXCOORD_2 = tmpvar_3;
  xlv_TEXCOORD_3 = tmpvar_4;
  xlv_TEXCOORD_4 = tmpvar_5;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
in mediump vec2 xlv_TEXCOORD;
in mediump vec2 xlv_TEXCOORD_1;
in mediump vec2 xlv_TEXCOORD_2;
in mediump vec2 xlv_TEXCOORD_3;
in mediump vec2 xlv_TEXCOORD_4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (((texture (_MainTex, xlv_TEXCOORD) * 0.227027) + (
    (texture (_MainTex, xlv_TEXCOORD_1) + texture (_MainTex, xlv_TEXCOORD_2))
   * 0.316216)) + ((texture (_MainTex, xlv_TEXCOORD_3) + texture (_MainTex, xlv_TEXCOORD_4)) * 0.0702703));
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
uniform mediump float _offset1;
uniform mediump float _offset2;
uniform mediump vec4 _MainTex_TexelSize;
varying mediump vec2 xlv_TEXCOORD;
varying mediump vec2 xlv_TEXCOORD_1;
varying mediump vec2 xlv_TEXCOORD_2;
varying mediump vec2 xlv_TEXCOORD_3;
varying mediump vec2 xlv_TEXCOORD_4;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_2.x = tmpvar_1.x;
  tmpvar_3.x = tmpvar_1.x;
  tmpvar_4.x = tmpvar_1.x;
  tmpvar_5.x = tmpvar_1.x;
  mediump float cse_6;
  cse_6 = (_offset1 * _MainTex_TexelSize.y);
  tmpvar_2.y = (_glesMultiTexCoord0.y - cse_6);
  tmpvar_3.y = (_glesMultiTexCoord0.y + cse_6);
  mediump float cse_7;
  cse_7 = (_offset2 * _MainTex_TexelSize.y);
  tmpvar_4.y = (_glesMultiTexCoord0.y - cse_7);
  tmpvar_5.y = (_glesMultiTexCoord0.y + cse_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD = tmpvar_1;
  xlv_TEXCOORD_1 = tmpvar_2;
  xlv_TEXCOORD_2 = tmpvar_3;
  xlv_TEXCOORD_3 = tmpvar_4;
  xlv_TEXCOORD_4 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD;
varying mediump vec2 xlv_TEXCOORD_1;
varying mediump vec2 xlv_TEXCOORD_2;
varying mediump vec2 xlv_TEXCOORD_3;
varying mediump vec2 xlv_TEXCOORD_4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (((texture2D (_MainTex, xlv_TEXCOORD) * 0.227027) + (
    (texture2D (_MainTex, xlv_TEXCOORD_1) + texture2D (_MainTex, xlv_TEXCOORD_2))
   * 0.316216)) + ((texture2D (_MainTex, xlv_TEXCOORD_3) + texture2D (_MainTex, xlv_TEXCOORD_4)) * 0.0702703));
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
uniform mediump float _offset1;
uniform mediump float _offset2;
uniform mediump vec4 _MainTex_TexelSize;
out mediump vec2 xlv_TEXCOORD;
out mediump vec2 xlv_TEXCOORD_1;
out mediump vec2 xlv_TEXCOORD_2;
out mediump vec2 xlv_TEXCOORD_3;
out mediump vec2 xlv_TEXCOORD_4;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_2.x = tmpvar_1.x;
  tmpvar_3.x = tmpvar_1.x;
  tmpvar_4.x = tmpvar_1.x;
  tmpvar_5.x = tmpvar_1.x;
  mediump float cse_6;
  cse_6 = (_offset1 * _MainTex_TexelSize.y);
  tmpvar_2.y = (_glesMultiTexCoord0.y - cse_6);
  tmpvar_3.y = (_glesMultiTexCoord0.y + cse_6);
  mediump float cse_7;
  cse_7 = (_offset2 * _MainTex_TexelSize.y);
  tmpvar_4.y = (_glesMultiTexCoord0.y - cse_7);
  tmpvar_5.y = (_glesMultiTexCoord0.y + cse_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD = tmpvar_1;
  xlv_TEXCOORD_1 = tmpvar_2;
  xlv_TEXCOORD_2 = tmpvar_3;
  xlv_TEXCOORD_3 = tmpvar_4;
  xlv_TEXCOORD_4 = tmpvar_5;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
in mediump vec2 xlv_TEXCOORD;
in mediump vec2 xlv_TEXCOORD_1;
in mediump vec2 xlv_TEXCOORD_2;
in mediump vec2 xlv_TEXCOORD_3;
in mediump vec2 xlv_TEXCOORD_4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (((texture (_MainTex, xlv_TEXCOORD) * 0.227027) + (
    (texture (_MainTex, xlv_TEXCOORD_1) + texture (_MainTex, xlv_TEXCOORD_2))
   * 0.316216)) + ((texture (_MainTex, xlv_TEXCOORD_3) + texture (_MainTex, xlv_TEXCOORD_4)) * 0.0702703));
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
uniform mediump float _offset1;
uniform mediump float _offset2;
uniform mediump vec4 _MainTex_TexelSize;
varying mediump vec2 xlv_TEXCOORD;
varying mediump vec2 xlv_TEXCOORD_1;
varying mediump vec2 xlv_TEXCOORD_2;
varying mediump vec2 xlv_TEXCOORD_3;
varying mediump vec2 xlv_TEXCOORD_4;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_2.y = tmpvar_1.y;
  tmpvar_3.y = tmpvar_1.y;
  tmpvar_4.y = tmpvar_1.y;
  tmpvar_5.y = tmpvar_1.y;
  mediump float cse_6;
  cse_6 = (_offset1 * _MainTex_TexelSize.x);
  tmpvar_2.x = (_glesMultiTexCoord0.x - cse_6);
  tmpvar_3.x = (_glesMultiTexCoord0.x + cse_6);
  mediump float cse_7;
  cse_7 = (_offset2 * _MainTex_TexelSize.x);
  tmpvar_4.x = (_glesMultiTexCoord0.x - cse_7);
  tmpvar_5.x = (_glesMultiTexCoord0.x + cse_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD = tmpvar_1;
  xlv_TEXCOORD_1 = tmpvar_2;
  xlv_TEXCOORD_2 = tmpvar_3;
  xlv_TEXCOORD_3 = tmpvar_4;
  xlv_TEXCOORD_4 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _varStrength;
varying mediump vec2 xlv_TEXCOORD;
varying mediump vec2 xlv_TEXCOORD_1;
varying mediump vec2 xlv_TEXCOORD_2;
varying mediump vec2 xlv_TEXCOORD_3;
varying mediump vec2 xlv_TEXCOORD_4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (((texture2D (_MainTex, xlv_TEXCOORD) * _varStrength.x) + (
    (texture2D (_MainTex, xlv_TEXCOORD_1) + texture2D (_MainTex, xlv_TEXCOORD_2))
   * _varStrength.y)) + ((texture2D (_MainTex, xlv_TEXCOORD_3) + texture2D (_MainTex, xlv_TEXCOORD_4)) * _varStrength.z));
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
uniform mediump float _offset1;
uniform mediump float _offset2;
uniform mediump vec4 _MainTex_TexelSize;
out mediump vec2 xlv_TEXCOORD;
out mediump vec2 xlv_TEXCOORD_1;
out mediump vec2 xlv_TEXCOORD_2;
out mediump vec2 xlv_TEXCOORD_3;
out mediump vec2 xlv_TEXCOORD_4;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_2.y = tmpvar_1.y;
  tmpvar_3.y = tmpvar_1.y;
  tmpvar_4.y = tmpvar_1.y;
  tmpvar_5.y = tmpvar_1.y;
  mediump float cse_6;
  cse_6 = (_offset1 * _MainTex_TexelSize.x);
  tmpvar_2.x = (_glesMultiTexCoord0.x - cse_6);
  tmpvar_3.x = (_glesMultiTexCoord0.x + cse_6);
  mediump float cse_7;
  cse_7 = (_offset2 * _MainTex_TexelSize.x);
  tmpvar_4.x = (_glesMultiTexCoord0.x - cse_7);
  tmpvar_5.x = (_glesMultiTexCoord0.x + cse_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD = tmpvar_1;
  xlv_TEXCOORD_1 = tmpvar_2;
  xlv_TEXCOORD_2 = tmpvar_3;
  xlv_TEXCOORD_3 = tmpvar_4;
  xlv_TEXCOORD_4 = tmpvar_5;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _varStrength;
in mediump vec2 xlv_TEXCOORD;
in mediump vec2 xlv_TEXCOORD_1;
in mediump vec2 xlv_TEXCOORD_2;
in mediump vec2 xlv_TEXCOORD_3;
in mediump vec2 xlv_TEXCOORD_4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (((texture (_MainTex, xlv_TEXCOORD) * _varStrength.x) + (
    (texture (_MainTex, xlv_TEXCOORD_1) + texture (_MainTex, xlv_TEXCOORD_2))
   * _varStrength.y)) + ((texture (_MainTex, xlv_TEXCOORD_3) + texture (_MainTex, xlv_TEXCOORD_4)) * _varStrength.z));
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
uniform mediump float _offset1;
uniform mediump float _offset2;
uniform mediump vec4 _MainTex_TexelSize;
varying mediump vec2 xlv_TEXCOORD;
varying mediump vec2 xlv_TEXCOORD_1;
varying mediump vec2 xlv_TEXCOORD_2;
varying mediump vec2 xlv_TEXCOORD_3;
varying mediump vec2 xlv_TEXCOORD_4;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_2.x = tmpvar_1.x;
  tmpvar_3.x = tmpvar_1.x;
  tmpvar_4.x = tmpvar_1.x;
  tmpvar_5.x = tmpvar_1.x;
  mediump float cse_6;
  cse_6 = (_offset1 * _MainTex_TexelSize.y);
  tmpvar_2.y = (_glesMultiTexCoord0.y - cse_6);
  tmpvar_3.y = (_glesMultiTexCoord0.y + cse_6);
  mediump float cse_7;
  cse_7 = (_offset2 * _MainTex_TexelSize.y);
  tmpvar_4.y = (_glesMultiTexCoord0.y - cse_7);
  tmpvar_5.y = (_glesMultiTexCoord0.y + cse_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD = tmpvar_1;
  xlv_TEXCOORD_1 = tmpvar_2;
  xlv_TEXCOORD_2 = tmpvar_3;
  xlv_TEXCOORD_3 = tmpvar_4;
  xlv_TEXCOORD_4 = tmpvar_5;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _varStrength;
varying mediump vec2 xlv_TEXCOORD;
varying mediump vec2 xlv_TEXCOORD_1;
varying mediump vec2 xlv_TEXCOORD_2;
varying mediump vec2 xlv_TEXCOORD_3;
varying mediump vec2 xlv_TEXCOORD_4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (((texture2D (_MainTex, xlv_TEXCOORD) * _varStrength.x) + (
    (texture2D (_MainTex, xlv_TEXCOORD_1) + texture2D (_MainTex, xlv_TEXCOORD_2))
   * _varStrength.y)) + ((texture2D (_MainTex, xlv_TEXCOORD_3) + texture2D (_MainTex, xlv_TEXCOORD_4)) * _varStrength.z));
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
uniform mediump float _offset1;
uniform mediump float _offset2;
uniform mediump vec4 _MainTex_TexelSize;
out mediump vec2 xlv_TEXCOORD;
out mediump vec2 xlv_TEXCOORD_1;
out mediump vec2 xlv_TEXCOORD_2;
out mediump vec2 xlv_TEXCOORD_3;
out mediump vec2 xlv_TEXCOORD_4;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  mediump vec2 tmpvar_4;
  mediump vec2 tmpvar_5;
  tmpvar_2.x = tmpvar_1.x;
  tmpvar_3.x = tmpvar_1.x;
  tmpvar_4.x = tmpvar_1.x;
  tmpvar_5.x = tmpvar_1.x;
  mediump float cse_6;
  cse_6 = (_offset1 * _MainTex_TexelSize.y);
  tmpvar_2.y = (_glesMultiTexCoord0.y - cse_6);
  tmpvar_3.y = (_glesMultiTexCoord0.y + cse_6);
  mediump float cse_7;
  cse_7 = (_offset2 * _MainTex_TexelSize.y);
  tmpvar_4.y = (_glesMultiTexCoord0.y - cse_7);
  tmpvar_5.y = (_glesMultiTexCoord0.y + cse_7);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD = tmpvar_1;
  xlv_TEXCOORD_1 = tmpvar_2;
  xlv_TEXCOORD_2 = tmpvar_3;
  xlv_TEXCOORD_3 = tmpvar_4;
  xlv_TEXCOORD_4 = tmpvar_5;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _varStrength;
in mediump vec2 xlv_TEXCOORD;
in mediump vec2 xlv_TEXCOORD_1;
in mediump vec2 xlv_TEXCOORD_2;
in mediump vec2 xlv_TEXCOORD_3;
in mediump vec2 xlv_TEXCOORD_4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (((texture (_MainTex, xlv_TEXCOORD) * _varStrength.x) + (
    (texture (_MainTex, xlv_TEXCOORD_1) + texture (_MainTex, xlv_TEXCOORD_2))
   * _varStrength.y)) + ((texture (_MainTex, xlv_TEXCOORD_3) + texture (_MainTex, xlv_TEXCOORD_4)) * _varStrength.z));
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