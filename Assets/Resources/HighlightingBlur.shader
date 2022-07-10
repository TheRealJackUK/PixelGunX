Shader "Hidden/Highlighted/Blur" {
Properties {
 _MainTex ("", 2D) = "" {}
 _Intensity ("", Range(0.25,0.5)) = 0.3
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
uniform mediump vec4 _MainTex_TexelSize;
uniform mediump float _OffsetScale;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD0_1;
varying mediump vec2 xlv_TEXCOORD0_2;
varying mediump vec2 xlv_TEXCOORD0_3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = (_MainTex_TexelSize.xy * _OffsetScale);
  tmpvar_1.x = (_glesMultiTexCoord0.x + tmpvar_3.x);
  tmpvar_1.y = (_glesMultiTexCoord0.y - tmpvar_3.y);
  tmpvar_2.x = (_glesMultiTexCoord0.x - tmpvar_3.x);
  tmpvar_2.y = (_glesMultiTexCoord0.y + tmpvar_3.y);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_glesMultiTexCoord0.xy - tmpvar_3);
  xlv_TEXCOORD0_1 = tmpvar_1;
  xlv_TEXCOORD0_2 = (_glesMultiTexCoord0.xy + tmpvar_3);
  xlv_TEXCOORD0_3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp float _Intensity;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD0_1;
varying mediump vec2 xlv_TEXCOORD0_2;
varying mediump vec2 xlv_TEXCOORD0_3;
void main ()
{
  lowp vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0_1);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0_3);
  color_1.xyz = max (tmpvar_2.xyz, tmpvar_3.xyz);
  color_1.xyz = max (color_1.xyz, tmpvar_4.xyz);
  color_1.xyz = max (color_1.xyz, tmpvar_5.xyz);
  color_1.w = (((
    (tmpvar_2.w + tmpvar_3.w)
   + tmpvar_4.w) + tmpvar_5.w) * _Intensity);
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
uniform mediump vec4 _MainTex_TexelSize;
uniform mediump float _OffsetScale;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD0_1;
out mediump vec2 xlv_TEXCOORD0_2;
out mediump vec2 xlv_TEXCOORD0_3;
void main ()
{
  mediump vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = (_MainTex_TexelSize.xy * _OffsetScale);
  tmpvar_1.x = (_glesMultiTexCoord0.x + tmpvar_3.x);
  tmpvar_1.y = (_glesMultiTexCoord0.y - tmpvar_3.y);
  tmpvar_2.x = (_glesMultiTexCoord0.x - tmpvar_3.x);
  tmpvar_2.y = (_glesMultiTexCoord0.y + tmpvar_3.y);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (_glesMultiTexCoord0.xy - tmpvar_3);
  xlv_TEXCOORD0_1 = tmpvar_1;
  xlv_TEXCOORD0_2 = (_glesMultiTexCoord0.xy + tmpvar_3);
  xlv_TEXCOORD0_3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp float _Intensity;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD0_1;
in mediump vec2 xlv_TEXCOORD0_2;
in mediump vec2 xlv_TEXCOORD0_3;
void main ()
{
  lowp vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0_1);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD0_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0_3);
  color_1.xyz = max (tmpvar_2.xyz, tmpvar_3.xyz);
  color_1.xyz = max (color_1.xyz, tmpvar_4.xyz);
  color_1.xyz = max (color_1.xyz, tmpvar_5.xyz);
  color_1.w = (((
    (tmpvar_2.w + tmpvar_3.w)
   + tmpvar_4.w) + tmpvar_5.w) * _Intensity);
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