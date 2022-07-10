Shader "Hidden/Glow 11/BlurEffectConeTap" {
Properties {
 _MainTex ("", any) = "" {}
 _Strength ("Strength", Float) = 1
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
uniform mediump vec4 _BlurOffsets;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD1_1;
varying mediump vec2 xlv_TEXCOORD1_2;
varying mediump vec2 xlv_TEXCOORD1_3;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = (_glesMultiTexCoord0.xy - (_BlurOffsets.xy * _MainTex_TexelSize.xy));
  mediump vec2 cse_2;
  cse_2 = (_MainTex_TexelSize.xy * _BlurOffsets.xy);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_1 + cse_2);
  xlv_TEXCOORD1_1 = (tmpvar_1 - cse_2);
  xlv_TEXCOORD1_2 = (tmpvar_1 + (cse_2 * vec2(1.0, -1.0)));
  xlv_TEXCOORD1_3 = (tmpvar_1 - (cse_2 * vec2(1.0, -1.0)));
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp float _Strength;
varying mediump vec2 xlv_TEXCOORD1;
varying mediump vec2 xlv_TEXCOORD1_1;
varying mediump vec2 xlv_TEXCOORD1_2;
varying mediump vec2 xlv_TEXCOORD1_3;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD1);
  color_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD1_1);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD1_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD1_3);
  mediump vec4 tmpvar_6;
  tmpvar_6 = (((color_1 + tmpvar_3) + tmpvar_4) + tmpvar_5);
  color_1 = tmpvar_6;
  gl_FragData[0] = (tmpvar_6 * _Strength);
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
uniform mediump vec4 _BlurOffsets;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD1;
out mediump vec2 xlv_TEXCOORD1_1;
out mediump vec2 xlv_TEXCOORD1_2;
out mediump vec2 xlv_TEXCOORD1_3;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = (_glesMultiTexCoord0.xy - (_BlurOffsets.xy * _MainTex_TexelSize.xy));
  mediump vec2 cse_2;
  cse_2 = (_MainTex_TexelSize.xy * _BlurOffsets.xy);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = (tmpvar_1 + cse_2);
  xlv_TEXCOORD1_1 = (tmpvar_1 - cse_2);
  xlv_TEXCOORD1_2 = (tmpvar_1 + (cse_2 * vec2(1.0, -1.0)));
  xlv_TEXCOORD1_3 = (tmpvar_1 - (cse_2 * vec2(1.0, -1.0)));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp float _Strength;
in mediump vec2 xlv_TEXCOORD1;
in mediump vec2 xlv_TEXCOORD1_1;
in mediump vec2 xlv_TEXCOORD1_2;
in mediump vec2 xlv_TEXCOORD1_3;
void main ()
{
  mediump vec4 color_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD1);
  color_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD1_1);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD1_2);
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD1_3);
  mediump vec4 tmpvar_6;
  tmpvar_6 = (((color_1 + tmpvar_3) + tmpvar_4) + tmpvar_5);
  color_1 = tmpvar_6;
  _glesFragData[0] = (tmpvar_6 * _Strength);
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