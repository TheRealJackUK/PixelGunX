Shader "Hidden/BlendModesOverlay" {
Properties {
 _MainTex ("Screen Blended", 2D) = "" {}
 _Overlay ("Color", 2D) = "grey" {}
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
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_2 = tmpvar_1;
  tmpvar_3 = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD0_1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Overlay;
uniform sampler2D _MainTex;
uniform mediump float _Intensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_Overlay, xlv_TEXCOORD0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0_1);
  gl_FragData[0] = (tmpvar_2 + (tmpvar_1 * _Intensity));
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
out highp vec2 xlv_TEXCOORD0_1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_2 = tmpvar_1;
  tmpvar_3 = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD0_1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _Overlay;
uniform sampler2D _MainTex;
uniform mediump float _Intensity;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD0_1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture (_Overlay, xlv_TEXCOORD0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0_1);
  _glesFragData[0] = (tmpvar_2 + (tmpvar_1 * _Intensity));
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
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_2 = tmpvar_1;
  tmpvar_3 = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD0_1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Overlay;
uniform sampler2D _MainTex;
uniform mediump float _Intensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_Overlay, xlv_TEXCOORD0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0_1);
  gl_FragData[0] = (1.0 - ((1.0 - 
    (tmpvar_1 * _Intensity)
  ) * (1.0 - tmpvar_2)));
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
out highp vec2 xlv_TEXCOORD0_1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_2 = tmpvar_1;
  tmpvar_3 = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD0_1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _Overlay;
uniform sampler2D _MainTex;
uniform mediump float _Intensity;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD0_1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture (_Overlay, xlv_TEXCOORD0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0_1);
  _glesFragData[0] = (1.0 - ((1.0 - 
    (tmpvar_1 * _Intensity)
  ) * (1.0 - tmpvar_2)));
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
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_2 = tmpvar_1;
  tmpvar_3 = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD0_1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Overlay;
uniform sampler2D _MainTex;
uniform mediump float _Intensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_Overlay, xlv_TEXCOORD0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0_1);
  gl_FragData[0] = (tmpvar_2 * (tmpvar_1 * _Intensity));
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
out highp vec2 xlv_TEXCOORD0_1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_2 = tmpvar_1;
  tmpvar_3 = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD0_1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _Overlay;
uniform sampler2D _MainTex;
uniform mediump float _Intensity;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD0_1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture (_Overlay, xlv_TEXCOORD0);
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0_1);
  _glesFragData[0] = (tmpvar_2 * (tmpvar_1 * _Intensity));
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
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_2 = tmpvar_1;
  tmpvar_3 = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD0_1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Overlay;
uniform sampler2D _MainTex;
uniform mediump float _Intensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 check_2;
  mediump vec4 color_3;
  mediump vec4 m_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Overlay, xlv_TEXCOORD0);
  m_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0_1);
  color_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3(float((color_3.x >= 0.5)));
  check_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = mix (color_3.xyz, ((check_2 * 
    (vec3(1.0, 1.0, 1.0) - ((vec3(1.0, 1.0, 1.0) - (2.0 * 
      (color_3.xyz - 0.5)
    )) * (1.0 - m_4.xyz)))
  ) + (
    ((1.0 - check_2) * (2.0 * color_3.xyz))
   * m_4.xyz)), vec3(_Intensity));
  tmpvar_8.w = color_3.w;
  tmpvar_1 = tmpvar_8;
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
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD0_1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_2 = tmpvar_1;
  tmpvar_3 = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD0_1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _Overlay;
uniform sampler2D _MainTex;
uniform mediump float _Intensity;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD0_1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 check_2;
  mediump vec4 color_3;
  mediump vec4 m_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_Overlay, xlv_TEXCOORD0);
  m_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0_1);
  color_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = vec3(float((color_3.x >= 0.5)));
  check_2 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.xyz = mix (color_3.xyz, ((check_2 * 
    (vec3(1.0, 1.0, 1.0) - ((vec3(1.0, 1.0, 1.0) - (2.0 * 
      (color_3.xyz - 0.5)
    )) * (1.0 - m_4.xyz)))
  ) + (
    ((1.0 - check_2) * (2.0 * color_3.xyz))
   * m_4.xyz)), vec3(_Intensity));
  tmpvar_8.w = color_3.w;
  tmpvar_1 = tmpvar_8;
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
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_2 = tmpvar_1;
  tmpvar_3 = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD0_1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Overlay;
uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD0_1;
void main ()
{
  mediump vec4 toAdd_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Overlay, xlv_TEXCOORD0);
  toAdd_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0_1);
  gl_FragData[0] = mix (tmpvar_3, toAdd_1, toAdd_1.wwww);
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
out highp vec2 xlv_TEXCOORD0_1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_2 = tmpvar_1;
  tmpvar_3 = tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD0_1 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _Overlay;
uniform sampler2D _MainTex;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD0_1;
void main ()
{
  mediump vec4 toAdd_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Overlay, xlv_TEXCOORD0);
  toAdd_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0_1);
  _glesFragData[0] = mix (tmpvar_3, toAdd_1, toAdd_1.wwww);
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