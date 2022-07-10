Shader "MADFINGER/Environment/Scroll 2 Layers Multiplicative - SphereSkybox" {
Properties {
 _MainTex ("Base layer (RGB)", 2D) = "white" {}
 _DetailTex ("2nd layer (RGB)", 2D) = "white" {}
 _ScrollX ("Base layer Scroll speed X", Float) = 1
 _ScrollY ("Base layer Scroll speed Y", Float) = 0
 _Scroll2X ("2nd layer Scroll speed X", Float) = 1
 _Scroll2Y ("2nd layer Scroll speed Y", Float) = 0
 _AMultiplier ("Layer Multiplier", Float) = 0.5
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="Geometry+10" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Geometry+10" "RenderType"="Transparent" }
  ZWrite Off
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailTex_ST;
uniform highp float _ScrollX;
uniform highp float _ScrollY;
uniform highp float _Scroll2X;
uniform highp float _Scroll2Y;
uniform highp float _AMultiplier;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = _ScrollX;
  tmpvar_2.y = _ScrollY;
  highp vec2 tmpvar_3;
  tmpvar_3.x = _Scroll2X;
  tmpvar_3.y = _Scroll2Y;
  highp vec4 tmpvar_4;
  tmpvar_4.x = _AMultiplier;
  tmpvar_4.y = _AMultiplier;
  tmpvar_4.z = _AMultiplier;
  tmpvar_4.w = _AMultiplier;
  tmpvar_1 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + fract((tmpvar_2 * _Time.xy)));
  xlv_TEXCOORD1 = (((_glesMultiTexCoord0.xy * _DetailTex_ST.xy) + _DetailTex_ST.zw) + fract((tmpvar_3 * _Time.xy)));
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = ((texture2D (_MainTex, xlv_TEXCOORD0) * texture2D (_DetailTex, xlv_TEXCOORD1)) * xlv_TEXCOORD2);
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailTex_ST;
uniform highp float _ScrollX;
uniform highp float _ScrollY;
uniform highp float _Scroll2X;
uniform highp float _Scroll2Y;
uniform highp float _AMultiplier;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out lowp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = _ScrollX;
  tmpvar_2.y = _ScrollY;
  highp vec2 tmpvar_3;
  tmpvar_3.x = _Scroll2X;
  tmpvar_3.y = _Scroll2Y;
  highp vec4 tmpvar_4;
  tmpvar_4.x = _AMultiplier;
  tmpvar_4.y = _AMultiplier;
  tmpvar_4.z = _AMultiplier;
  tmpvar_4.w = _AMultiplier;
  tmpvar_1 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + fract((tmpvar_2 * _Time.xy)));
  xlv_TEXCOORD1 = (((_glesMultiTexCoord0.xy * _DetailTex_ST.xy) + _DetailTex_ST.zw) + fract((tmpvar_3 * _Time.xy)));
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in lowp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = ((texture (_MainTex, xlv_TEXCOORD0) * texture (_DetailTex, xlv_TEXCOORD1)) * xlv_TEXCOORD2);
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailTex_ST;
uniform highp float _ScrollX;
uniform highp float _ScrollY;
uniform highp float _Scroll2X;
uniform highp float _Scroll2Y;
uniform highp float _AMultiplier;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = _ScrollX;
  tmpvar_2.y = _ScrollY;
  highp vec2 tmpvar_3;
  tmpvar_3.x = _Scroll2X;
  tmpvar_3.y = _Scroll2Y;
  highp vec4 tmpvar_4;
  tmpvar_4.x = _AMultiplier;
  tmpvar_4.y = _AMultiplier;
  tmpvar_4.z = _AMultiplier;
  tmpvar_4.w = _AMultiplier;
  tmpvar_1 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + fract((tmpvar_2 * _Time.xy)));
  xlv_TEXCOORD1 = (((_glesMultiTexCoord0.xy * _DetailTex_ST.xy) + _DetailTex_ST.zw) + fract((tmpvar_3 * _Time.xy)));
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying lowp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = ((texture2D (_MainTex, xlv_TEXCOORD0) * texture2D (_DetailTex, xlv_TEXCOORD1)) * xlv_TEXCOORD2);
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _DetailTex_ST;
uniform highp float _ScrollX;
uniform highp float _ScrollY;
uniform highp float _Scroll2X;
uniform highp float _Scroll2Y;
uniform highp float _AMultiplier;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out lowp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2.x = _ScrollX;
  tmpvar_2.y = _ScrollY;
  highp vec2 tmpvar_3;
  tmpvar_3.x = _Scroll2X;
  tmpvar_3.y = _Scroll2Y;
  highp vec4 tmpvar_4;
  tmpvar_4.x = _AMultiplier;
  tmpvar_4.y = _AMultiplier;
  tmpvar_4.z = _AMultiplier;
  tmpvar_4.w = _AMultiplier;
  tmpvar_1 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw) + fract((tmpvar_2 * _Time.xy)));
  xlv_TEXCOORD1 = (((_glesMultiTexCoord0.xy * _DetailTex_ST.xy) + _DetailTex_ST.zw) + fract((tmpvar_3 * _Time.xy)));
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _DetailTex;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in lowp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = ((texture (_MainTex, xlv_TEXCOORD0) * texture (_DetailTex, xlv_TEXCOORD1)) * xlv_TEXCOORD2);
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" }
"!!GLES3"
}
}
 }
}
}