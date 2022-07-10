Shader "MADFINGER/Transparent/GodRays" {
Properties {
 _MainTex ("Base texture", 2D) = "white" {}
 _FadeOutDistNear ("Near fadeout dist", Float) = 10
 _FadeOutDistFar ("Far fadeout dist", Float) = 10000
 _Multiplier ("Multiplier", Float) = 1
 _ContractionAmount ("Near contraction amount", Float) = 5
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp float _FadeOutDistNear;
uniform highp float _FadeOutDistFar;
uniform highp float _Multiplier;
uniform highp float _ContractionAmount;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 vpos_1;
  lowp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp float tmpvar_4;
  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
  highp float tmpvar_5;
  tmpvar_5 = clamp ((tmpvar_4 / _FadeOutDistNear), 0.0, 1.0);
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - clamp ((
    max ((tmpvar_4 - _FadeOutDistFar), 0.0)
   * 0.2), 0.0, 1.0));
  highp float tmpvar_7;
  tmpvar_7 = (tmpvar_5 * tmpvar_5);
  highp float tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * tmpvar_7) * (tmpvar_6 * tmpvar_6));
  vpos_1.w = _glesVertex.w;
  vpos_1.xyz = (_glesVertex.xyz - ((
    (normalize(_glesNormal) * clamp ((1.0 - tmpvar_8), 0.0, 1.0))
   * _glesColor.w) * _ContractionAmount));
  highp vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_8 * _glesColor) * _Multiplier);
  tmpvar_2 = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * vpos_1);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture2D (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD1);
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp float _FadeOutDistNear;
uniform highp float _FadeOutDistFar;
uniform highp float _Multiplier;
uniform highp float _ContractionAmount;
out highp vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 vpos_1;
  lowp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  tmpvar_3 = (glstate_matrix_modelview0 * _glesVertex).xyz;
  highp float tmpvar_4;
  tmpvar_4 = sqrt(dot (tmpvar_3, tmpvar_3));
  highp float tmpvar_5;
  tmpvar_5 = clamp ((tmpvar_4 / _FadeOutDistNear), 0.0, 1.0);
  highp float tmpvar_6;
  tmpvar_6 = (1.0 - clamp ((
    max ((tmpvar_4 - _FadeOutDistFar), 0.0)
   * 0.2), 0.0, 1.0));
  highp float tmpvar_7;
  tmpvar_7 = (tmpvar_5 * tmpvar_5);
  highp float tmpvar_8;
  tmpvar_8 = ((tmpvar_7 * tmpvar_7) * (tmpvar_6 * tmpvar_6));
  vpos_1.w = _glesVertex.w;
  vpos_1.xyz = (_glesVertex.xyz - ((
    (normalize(_glesNormal) * clamp ((1.0 - tmpvar_8), 0.0, 1.0))
   * _glesColor.w) * _ContractionAmount));
  highp vec4 tmpvar_9;
  tmpvar_9 = ((tmpvar_8 * _glesColor) * _Multiplier);
  tmpvar_2 = tmpvar_9;
  gl_Position = (glstate_matrix_mvp * vpos_1);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
in highp vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (texture (_MainTex, xlv_TEXCOORD0) * xlv_TEXCOORD1);
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
}