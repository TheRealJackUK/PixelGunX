Shader "Hidden/MobileBloom" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _Bloom ("Bloom (RGB)", 2D) = "black" {}
}
SubShader { 
 Pass {
  ZTest False
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
uniform sampler2D _Bloom;
varying mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) + texture2D (_Bloom, xlv_TEXCOORD0));
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
uniform sampler2D _Bloom;
in mediump vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture (_MainTex, xlv_TEXCOORD0) + texture (_Bloom, xlv_TEXCOORD0));
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
  ZTest False
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
uniform mediump vec4 _OffsetsA;
uniform mediump vec4 _OffsetsB;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_glesMultiTexCoord0.xy + _OffsetsA.xy);
  xlv_TEXCOORD2 = (_glesMultiTexCoord0.xy + _OffsetsA.zw);
  xlv_TEXCOORD3 = (_glesMultiTexCoord0.xy + _OffsetsB.xy);
  xlv_TEXCOORD4 = (_glesMultiTexCoord0.xy + _OffsetsB.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp vec4 _Parameter;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
varying mediump vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (clamp ((
    max (max (max (max (texture2D (_MainTex, xlv_TEXCOORD0), texture2D (_MainTex, xlv_TEXCOORD1)), texture2D (_MainTex, xlv_TEXCOORD2)), texture2D (_MainTex, xlv_TEXCOORD3)), texture2D (_MainTex, xlv_TEXCOORD4))
   - _Parameter.z), 0.0, 1.0) * _Parameter.w);
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
uniform mediump vec4 _OffsetsA;
uniform mediump vec4 _OffsetsB;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out mediump vec2 xlv_TEXCOORD3;
out mediump vec2 xlv_TEXCOORD4;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (_glesMultiTexCoord0.xy + _OffsetsA.xy);
  xlv_TEXCOORD2 = (_glesMultiTexCoord0.xy + _OffsetsA.zw);
  xlv_TEXCOORD3 = (_glesMultiTexCoord0.xy + _OffsetsB.xy);
  xlv_TEXCOORD4 = (_glesMultiTexCoord0.xy + _OffsetsB.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp vec4 _Parameter;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in mediump vec2 xlv_TEXCOORD3;
in mediump vec2 xlv_TEXCOORD4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (clamp ((
    max (max (max (max (texture (_MainTex, xlv_TEXCOORD0), texture (_MainTex, xlv_TEXCOORD1)), texture (_MainTex, xlv_TEXCOORD2)), texture (_MainTex, xlv_TEXCOORD3)), texture (_MainTex, xlv_TEXCOORD4))
   - _Parameter.z), 0.0, 1.0) * _Parameter.w);
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
  ZTest False
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
uniform mediump vec4 _OffsetsA;
uniform mediump vec4 _OffsetsB;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_glesMultiTexCoord0.xy + _OffsetsA.xy);
  xlv_TEXCOORD1 = (_glesMultiTexCoord0.xy + _OffsetsA.zw);
  xlv_TEXCOORD2 = (_glesMultiTexCoord0.xy + _OffsetsB.xy);
  xlv_TEXCOORD3 = (_glesMultiTexCoord0.xy + _OffsetsB.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD2;
varying mediump vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (((
    (texture2D (_MainTex, xlv_TEXCOORD0) + texture2D (_MainTex, xlv_TEXCOORD1))
   + texture2D (_MainTex, xlv_TEXCOORD2)) + texture2D (_MainTex, xlv_TEXCOORD3)) * 0.25);
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
uniform mediump vec4 _OffsetsA;
uniform mediump vec4 _OffsetsB;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD2;
out mediump vec2 xlv_TEXCOORD3;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_glesMultiTexCoord0.xy + _OffsetsA.xy);
  xlv_TEXCOORD1 = (_glesMultiTexCoord0.xy + _OffsetsA.zw);
  xlv_TEXCOORD2 = (_glesMultiTexCoord0.xy + _OffsetsB.xy);
  xlv_TEXCOORD3 = (_glesMultiTexCoord0.xy + _OffsetsB.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD2;
in mediump vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (((
    (texture (_MainTex, xlv_TEXCOORD0) + texture (_MainTex, xlv_TEXCOORD1))
   + texture (_MainTex, xlv_TEXCOORD2)) + texture (_MainTex, xlv_TEXCOORD3)) * 0.25);
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