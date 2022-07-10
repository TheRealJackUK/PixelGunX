Shader "AngryBots/FX/LaserScope" {
Properties {
 _MainTex ("MainTex", 2D) = "white" {}
 _NoiseTex ("NoiseTex", 2D) = "white" {}
}
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" "Reflection"="LaserScope" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" "Reflection"="LaserScope" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha One
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _NoiseTex_ST;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  tmpvar_1.zw = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
varying mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0.xy) * texture2D (_NoiseTex, xlv_TEXCOORD0.zw));
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
uniform mediump vec4 _MainTex_ST;
uniform mediump vec4 _NoiseTex_ST;
out mediump vec4 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _NoiseTex_ST.xy) + _NoiseTex_ST.zw);
  tmpvar_1.zw = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _NoiseTex;
in mediump vec4 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture (_MainTex, xlv_TEXCOORD0.xy) * texture (_NoiseTex, xlv_TEXCOORD0.zw));
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