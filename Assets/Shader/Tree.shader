Shader "Game/Tree" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _Secondary ("Secondary Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB) Alpha (A)", 2D) = "white" {}
 _Cutoff ("Base Alpha cutoff", Range(0,0.9)) = 0.5
}
SubShader { 
 LOD 600
 Tags { "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
 Pass {
  Tags { "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  Cull Off
  Blend SrcAlpha OneMinusSrcAlpha
  AlphaTest GEqual [_Cutoff]
  SetTexture [_MainTex] { ConstantColor [_Color] combine texture * constant, texture alpha * constant alpha }
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  ZWrite Off
  Cull Off
  Blend SrcAlpha OneMinusSrcAlpha
  AlphaTest Greater 0
  ColorMask RGB
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  mediump vec2 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  shlight_1 = tmpvar_9;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp vec4 c_9;
  c_9.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)
  ) * 2.0));
  c_9.w = tmpvar_4;
  c_1.xyz = (c_9.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  mediump vec2 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  shlight_1 = tmpvar_9;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp vec4 c_9;
  c_9.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)
  ) * 2.0));
  c_9.w = tmpvar_4;
  c_1.xyz = (c_9.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  c_1.w = tmpvar_4;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  c_1.xyz = (tmpvar_3 * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  c_1.xyz = (tmpvar_3 * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz));
  c_1.w = tmpvar_4;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D unity_Lightmap;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  mediump vec3 lm_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_3 * lm_9);
  c_1.xyz = tmpvar_11;
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D unity_Lightmap;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  mediump vec3 lm_9;
  lowp vec3 tmpvar_10;
  tmpvar_10 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_9 = tmpvar_10;
  mediump vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_3 * lm_9);
  c_1.xyz = tmpvar_11;
  c_1.w = tmpvar_4;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  mediump vec2 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  shlight_1 = tmpvar_9;
  tmpvar_4 = shlight_1;
  highp vec3 tmpvar_24;
  tmpvar_24 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosX0 - tmpvar_24.x);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosY0 - tmpvar_24.y);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosZ0 - tmpvar_24.z);
  highp vec4 tmpvar_28;
  tmpvar_28 = (((tmpvar_25 * tmpvar_25) + (tmpvar_26 * tmpvar_26)) + (tmpvar_27 * tmpvar_27));
  highp vec4 tmpvar_29;
  tmpvar_29 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_25 * tmpvar_7.x) + (tmpvar_26 * tmpvar_7.y)) + (tmpvar_27 * tmpvar_7.z))
   * 
    inversesqrt(tmpvar_28)
  )) * (1.0/((1.0 + 
    (tmpvar_28 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_4 + ((
    ((unity_LightColor[0].xyz * tmpvar_29.x) + (unity_LightColor[1].xyz * tmpvar_29.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_29.z)
  ) + (unity_LightColor[3].xyz * tmpvar_29.w)));
  tmpvar_4 = tmpvar_30;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp vec4 c_9;
  c_9.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)
  ) * 2.0));
  c_9.w = tmpvar_4;
  c_1.xyz = (c_9.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  mediump vec2 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  shlight_1 = tmpvar_9;
  tmpvar_4 = shlight_1;
  highp vec3 tmpvar_24;
  tmpvar_24 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosX0 - tmpvar_24.x);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosY0 - tmpvar_24.y);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosZ0 - tmpvar_24.z);
  highp vec4 tmpvar_28;
  tmpvar_28 = (((tmpvar_25 * tmpvar_25) + (tmpvar_26 * tmpvar_26)) + (tmpvar_27 * tmpvar_27));
  highp vec4 tmpvar_29;
  tmpvar_29 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_25 * tmpvar_7.x) + (tmpvar_26 * tmpvar_7.y)) + (tmpvar_27 * tmpvar_7.z))
   * 
    inversesqrt(tmpvar_28)
  )) * (1.0/((1.0 + 
    (tmpvar_28 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_4 + ((
    ((unity_LightColor[0].xyz * tmpvar_29.x) + (unity_LightColor[1].xyz * tmpvar_29.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_29.z)
  ) + (unity_LightColor[3].xyz * tmpvar_29.w)));
  tmpvar_4 = tmpvar_30;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp vec4 c_9;
  c_9.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)
  ) * 2.0));
  c_9.w = tmpvar_4;
  c_1.xyz = (c_9.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  c_1.w = tmpvar_4;
  _glesFragData[0] = c_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  ZWrite Off
  Cull Off
  Fog {
   Color (0,0,0,0)
  }
  Blend SrcAlpha One
  AlphaTest Greater 0
  ColorMask RGB
Program "vp" {
SubProgram "gles " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceLightPos0.xyz - cse_8.xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * cse_8).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6.xyz, (tmpvar_6.xyz * _Color.xyz), vec3((tmpvar_3.y + tmpvar_3.x)));
  tmpvar_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, (tmpvar_6.xyz * _Secondary.xyz), tmpvar_3.xxx);
  tmpvar_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (tmpvar_6.w * _Color.w);
  tmpvar_5 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_12;
  c_12.xyz = ((tmpvar_4 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * texture2D (_LightTexture0, vec2(tmpvar_11)).w) * 2.0));
  c_12.w = tmpvar_5;
  c_1.xyz = c_12.xyz;
  c_1.w = tmpvar_5;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceLightPos0.xyz - cse_8.xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * cse_8).xyz;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6.xyz, (tmpvar_6.xyz * _Color.xyz), vec3((tmpvar_3.y + tmpvar_3.x)));
  tmpvar_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, (tmpvar_6.xyz * _Secondary.xyz), tmpvar_3.xxx);
  tmpvar_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (tmpvar_6.w * _Color.w);
  tmpvar_5 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_12;
  c_12.xyz = ((tmpvar_4 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * texture (_LightTexture0, vec2(tmpvar_11)).w) * 2.0));
  c_12.w = tmpvar_5;
  c_1.xyz = c_12.xyz;
  c_1.w = tmpvar_5;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  tmpvar_3 = tmpvar_7;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6.xyz, (tmpvar_6.xyz * _Color.xyz), vec3((tmpvar_3.y + tmpvar_3.x)));
  tmpvar_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, (tmpvar_6.xyz * _Secondary.xyz), tmpvar_3.xxx);
  tmpvar_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (tmpvar_6.w * _Color.w);
  tmpvar_5 = tmpvar_9;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_10;
  c_10.xyz = ((tmpvar_4 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD1, lightDir_2)
  ) * 2.0));
  c_10.w = tmpvar_5;
  c_1.xyz = c_10.xyz;
  c_1.w = tmpvar_5;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  tmpvar_3 = tmpvar_7;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6.xyz, (tmpvar_6.xyz * _Color.xyz), vec3((tmpvar_3.y + tmpvar_3.x)));
  tmpvar_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, (tmpvar_6.xyz * _Secondary.xyz), tmpvar_3.xxx);
  tmpvar_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (tmpvar_6.w * _Color.w);
  tmpvar_5 = tmpvar_9;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_10;
  c_10.xyz = ((tmpvar_4 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD1, lightDir_2)
  ) * 2.0));
  c_10.w = tmpvar_5;
  c_1.xyz = c_10.xyz;
  c_1.w = tmpvar_5;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceLightPos0.xyz - cse_8.xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * cse_8);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6.xyz, (tmpvar_6.xyz * _Color.xyz), vec3((tmpvar_3.y + tmpvar_3.x)));
  tmpvar_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, (tmpvar_6.xyz * _Secondary.xyz), tmpvar_3.xxx);
  tmpvar_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (tmpvar_6.w * _Color.w);
  tmpvar_5 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_13;
  atten_13 = ((float(
    (xlv_TEXCOORD3.z > 0.0)
  ) * texture2D (_LightTexture0, P_11).w) * texture2D (_LightTextureB0, vec2(tmpvar_12)).w);
  lowp vec4 c_14;
  c_14.xyz = ((tmpvar_4 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * atten_13) * 2.0));
  c_14.w = tmpvar_5;
  c_1.xyz = c_14.xyz;
  c_1.w = tmpvar_5;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceLightPos0.xyz - cse_8.xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * cse_8);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6.xyz, (tmpvar_6.xyz * _Color.xyz), vec3((tmpvar_3.y + tmpvar_3.x)));
  tmpvar_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, (tmpvar_6.xyz * _Secondary.xyz), tmpvar_3.xxx);
  tmpvar_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (tmpvar_6.w * _Color.w);
  tmpvar_5 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_10;
  highp vec2 P_11;
  P_11 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_13;
  atten_13 = ((float(
    (xlv_TEXCOORD3.z > 0.0)
  ) * texture (_LightTexture0, P_11).w) * texture (_LightTextureB0, vec2(tmpvar_12)).w);
  lowp vec4 c_14;
  c_14.xyz = ((tmpvar_4 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * atten_13) * 2.0));
  c_14.w = tmpvar_5;
  c_1.xyz = c_14.xyz;
  c_1.w = tmpvar_5;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceLightPos0.xyz - cse_8.xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * cse_8).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6.xyz, (tmpvar_6.xyz * _Color.xyz), vec3((tmpvar_3.y + tmpvar_3.x)));
  tmpvar_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, (tmpvar_6.xyz * _Secondary.xyz), tmpvar_3.xxx);
  tmpvar_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (tmpvar_6.w * _Color.w);
  tmpvar_5 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_12;
  c_12.xyz = ((tmpvar_4 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * 
    (texture2D (_LightTextureB0, vec2(tmpvar_11)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w)
  ) * 2.0));
  c_12.w = tmpvar_5;
  c_1.xyz = c_12.xyz;
  c_1.w = tmpvar_5;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceLightPos0.xyz - cse_8.xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * cse_8).xyz;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6.xyz, (tmpvar_6.xyz * _Color.xyz), vec3((tmpvar_3.y + tmpvar_3.x)));
  tmpvar_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, (tmpvar_6.xyz * _Secondary.xyz), tmpvar_3.xxx);
  tmpvar_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (tmpvar_6.w * _Color.w);
  tmpvar_5 = tmpvar_9;
  mediump vec3 tmpvar_10;
  tmpvar_10 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_12;
  c_12.xyz = ((tmpvar_4 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * 
    (texture (_LightTextureB0, vec2(tmpvar_11)).w * texture (_LightTexture0, xlv_TEXCOORD3).w)
  ) * 2.0));
  c_12.w = tmpvar_5;
  c_1.xyz = c_12.xyz;
  c_1.w = tmpvar_5;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  tmpvar_3 = tmpvar_7;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6.xyz, (tmpvar_6.xyz * _Color.xyz), vec3((tmpvar_3.y + tmpvar_3.x)));
  tmpvar_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, (tmpvar_6.xyz * _Secondary.xyz), tmpvar_3.xxx);
  tmpvar_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (tmpvar_6.w * _Color.w);
  tmpvar_5 = tmpvar_9;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_10;
  c_10.xyz = ((tmpvar_4 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * texture2D (_LightTexture0, xlv_TEXCOORD3).w) * 2.0));
  c_10.w = tmpvar_5;
  c_1.xyz = c_10.xyz;
  c_1.w = tmpvar_5;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  tmpvar_3 = tmpvar_7;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6.xyz, (tmpvar_6.xyz * _Color.xyz), vec3((tmpvar_3.y + tmpvar_3.x)));
  tmpvar_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, (tmpvar_6.xyz * _Secondary.xyz), tmpvar_3.xxx);
  tmpvar_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (tmpvar_6.w * _Color.w);
  tmpvar_5 = tmpvar_9;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_10;
  c_10.xyz = ((tmpvar_4 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * texture (_LightTexture0, xlv_TEXCOORD3).w) * 2.0));
  c_10.w = tmpvar_5;
  c_1.xyz = c_10.xyz;
  c_1.w = tmpvar_5;
  _glesFragData[0] = c_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "POINT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3"
}
}
 }
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  ColorMask RGB
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  mediump vec2 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  shlight_1 = tmpvar_9;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 c_10;
  c_10.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)
  ) * 2.0));
  c_10.w = tmpvar_4;
  c_1.xyz = (c_10.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  mediump vec2 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  shlight_1 = tmpvar_9;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 c_10;
  c_10.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)
  ) * 2.0));
  c_10.w = tmpvar_4;
  c_1.xyz = (c_10.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  c_1.w = tmpvar_4;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D unity_Lightmap;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  c_1.xyz = (tmpvar_3 * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D unity_Lightmap;
uniform lowp float _Cutoff;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  c_1.xyz = (tmpvar_3 * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz));
  c_1.w = tmpvar_4;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D unity_Lightmap;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  mediump vec3 lm_10;
  lowp vec3 tmpvar_11;
  tmpvar_11 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_10 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_3 * lm_10);
  c_1.xyz = tmpvar_12;
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D unity_Lightmap;
uniform lowp float _Cutoff;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  mediump vec3 lm_10;
  lowp vec3 tmpvar_11;
  tmpvar_11 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_10 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = (tmpvar_3 * lm_10);
  c_1.xyz = tmpvar_12;
  c_1.w = tmpvar_4;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  mediump vec2 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  shlight_1 = tmpvar_9;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp float tmpvar_10;
  mediump float lightShadowDataX_11;
  highp float dist_12;
  lowp float tmpvar_13;
  tmpvar_13 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_12 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_11 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((dist_12 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_11);
  tmpvar_10 = tmpvar_15;
  lowp vec4 c_16;
  c_16.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz))
   * tmpvar_10) * 2.0));
  c_16.w = tmpvar_4;
  c_1.xyz = (c_16.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D unity_Lightmap;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp float tmpvar_10;
  mediump float lightShadowDataX_11;
  highp float dist_12;
  lowp float tmpvar_13;
  tmpvar_13 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_12 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_11 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((dist_12 > 
    (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w)
  )), lightShadowDataX_11);
  tmpvar_10 = tmpvar_15;
  c_1.xyz = (tmpvar_3 * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz), vec3((tmpvar_10 * 2.0))));
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D unity_Lightmap;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp float tmpvar_10;
  mediump float lightShadowDataX_11;
  highp float dist_12;
  lowp float tmpvar_13;
  tmpvar_13 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_12 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_11 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((dist_12 > 
    (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w)
  )), lightShadowDataX_11);
  tmpvar_10 = tmpvar_15;
  mediump vec3 lm_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_16 = tmpvar_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = vec3((tmpvar_10 * 2.0));
  mediump vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_3 * min (lm_16, tmpvar_18));
  c_1.xyz = tmpvar_19;
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  mediump vec2 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  shlight_1 = tmpvar_9;
  tmpvar_4 = shlight_1;
  highp vec3 tmpvar_24;
  tmpvar_24 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosX0 - tmpvar_24.x);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosY0 - tmpvar_24.y);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosZ0 - tmpvar_24.z);
  highp vec4 tmpvar_28;
  tmpvar_28 = (((tmpvar_25 * tmpvar_25) + (tmpvar_26 * tmpvar_26)) + (tmpvar_27 * tmpvar_27));
  highp vec4 tmpvar_29;
  tmpvar_29 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_25 * tmpvar_7.x) + (tmpvar_26 * tmpvar_7.y)) + (tmpvar_27 * tmpvar_7.z))
   * 
    inversesqrt(tmpvar_28)
  )) * (1.0/((1.0 + 
    (tmpvar_28 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_4 + ((
    ((unity_LightColor[0].xyz * tmpvar_29.x) + (unity_LightColor[1].xyz * tmpvar_29.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_29.z)
  ) + (unity_LightColor[3].xyz * tmpvar_29.w)));
  tmpvar_4 = tmpvar_30;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 c_10;
  c_10.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)
  ) * 2.0));
  c_10.w = tmpvar_4;
  c_1.xyz = (c_10.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  mediump vec2 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  shlight_1 = tmpvar_9;
  tmpvar_4 = shlight_1;
  highp vec3 tmpvar_24;
  tmpvar_24 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosX0 - tmpvar_24.x);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosY0 - tmpvar_24.y);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosZ0 - tmpvar_24.z);
  highp vec4 tmpvar_28;
  tmpvar_28 = (((tmpvar_25 * tmpvar_25) + (tmpvar_26 * tmpvar_26)) + (tmpvar_27 * tmpvar_27));
  highp vec4 tmpvar_29;
  tmpvar_29 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_25 * tmpvar_7.x) + (tmpvar_26 * tmpvar_7.y)) + (tmpvar_27 * tmpvar_7.z))
   * 
    inversesqrt(tmpvar_28)
  )) * (1.0/((1.0 + 
    (tmpvar_28 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_4 + ((
    ((unity_LightColor[0].xyz * tmpvar_29.x) + (unity_LightColor[1].xyz * tmpvar_29.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_29.z)
  ) + (unity_LightColor[3].xyz * tmpvar_29.w)));
  tmpvar_4 = tmpvar_30;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp vec4 c_10;
  c_10.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)
  ) * 2.0));
  c_10.w = tmpvar_4;
  c_1.xyz = (c_10.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  c_1.w = tmpvar_4;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  mediump vec2 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  shlight_1 = tmpvar_9;
  tmpvar_4 = shlight_1;
  highp vec4 cse_24;
  cse_24 = (_Object2World * _glesVertex);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosX0 - cse_24.x);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosY0 - cse_24.y);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosZ0 - cse_24.z);
  highp vec4 tmpvar_28;
  tmpvar_28 = (((tmpvar_25 * tmpvar_25) + (tmpvar_26 * tmpvar_26)) + (tmpvar_27 * tmpvar_27));
  highp vec4 tmpvar_29;
  tmpvar_29 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_25 * tmpvar_7.x) + (tmpvar_26 * tmpvar_7.y)) + (tmpvar_27 * tmpvar_7.z))
   * 
    inversesqrt(tmpvar_28)
  )) * (1.0/((1.0 + 
    (tmpvar_28 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_4 + ((
    ((unity_LightColor[0].xyz * tmpvar_29.x) + (unity_LightColor[1].xyz * tmpvar_29.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_29.z)
  ) + (unity_LightColor[3].xyz * tmpvar_29.w)));
  tmpvar_4 = tmpvar_30;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_24);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp float tmpvar_10;
  mediump float lightShadowDataX_11;
  highp float dist_12;
  lowp float tmpvar_13;
  tmpvar_13 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_12 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = _LightShadowData.x;
  lightShadowDataX_11 = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = max (float((dist_12 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_11);
  tmpvar_10 = tmpvar_15;
  lowp vec4 c_16;
  c_16.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz))
   * tmpvar_10) * 2.0));
  c_16.w = tmpvar_4;
  c_1.xyz = (c_16.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  mediump vec2 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  shlight_1 = tmpvar_9;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp float shadow_10;
  lowp float tmpvar_11;
  tmpvar_11 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_12;
  lowp vec4 c_13;
  c_13.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz))
   * shadow_10) * 2.0));
  c_13.w = tmpvar_4;
  c_1.xyz = (c_13.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  mediump vec2 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  shlight_1 = tmpvar_9;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp float shadow_10;
  mediump float tmpvar_11;
  tmpvar_11 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_12;
  tmpvar_12 = tmpvar_11;
  highp float tmpvar_13;
  tmpvar_13 = (_LightShadowData.x + (tmpvar_12 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_13;
  lowp vec4 c_14;
  c_14.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz))
   * shadow_10) * 2.0));
  c_14.w = tmpvar_4;
  c_1.xyz = (c_14.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  c_1.w = tmpvar_4;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D unity_Lightmap;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp float shadow_10;
  lowp float tmpvar_11;
  tmpvar_11 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_12;
  c_1.xyz = (tmpvar_3 * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz), vec3((shadow_10 * 2.0))));
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out highp vec2 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D unity_Lightmap;
uniform lowp float _Cutoff;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in highp vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp float shadow_10;
  mediump float tmpvar_11;
  tmpvar_11 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_12;
  tmpvar_12 = tmpvar_11;
  highp float tmpvar_13;
  tmpvar_13 = (_LightShadowData.x + (tmpvar_12 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_13;
  c_1.xyz = (tmpvar_3 * min ((2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz), vec3((shadow_10 * 2.0))));
  c_1.w = tmpvar_4;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D unity_Lightmap;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp float shadow_10;
  lowp float tmpvar_11;
  tmpvar_11 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_12;
  mediump vec3 lm_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_13 = tmpvar_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = vec3((shadow_10 * 2.0));
  mediump vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_3 * min (lm_13, tmpvar_15));
  c_1.xyz = tmpvar_16;
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out highp vec2 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D unity_Lightmap;
uniform lowp float _Cutoff;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in highp vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp float shadow_10;
  mediump float tmpvar_11;
  tmpvar_11 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_12;
  tmpvar_12 = tmpvar_11;
  highp float tmpvar_13;
  tmpvar_13 = (_LightShadowData.x + (tmpvar_12 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_13;
  mediump vec3 lm_14;
  lowp vec3 tmpvar_15;
  tmpvar_15 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_14 = tmpvar_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = vec3((shadow_10 * 2.0));
  mediump vec3 tmpvar_17;
  tmpvar_17 = (tmpvar_3 * min (lm_14, tmpvar_16));
  c_1.xyz = tmpvar_17;
  c_1.w = tmpvar_4;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

#extension GL_EXT_shadow_samplers : enable
attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  mediump vec2 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  shlight_1 = tmpvar_9;
  tmpvar_4 = shlight_1;
  highp vec4 cse_24;
  cse_24 = (_Object2World * _glesVertex);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosX0 - cse_24.x);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosY0 - cse_24.y);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosZ0 - cse_24.z);
  highp vec4 tmpvar_28;
  tmpvar_28 = (((tmpvar_25 * tmpvar_25) + (tmpvar_26 * tmpvar_26)) + (tmpvar_27 * tmpvar_27));
  highp vec4 tmpvar_29;
  tmpvar_29 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_25 * tmpvar_7.x) + (tmpvar_26 * tmpvar_7.y)) + (tmpvar_27 * tmpvar_7.z))
   * 
    inversesqrt(tmpvar_28)
  )) * (1.0/((1.0 + 
    (tmpvar_28 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_4 + ((
    ((unity_LightColor[0].xyz * tmpvar_29.x) + (unity_LightColor[1].xyz * tmpvar_29.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_29.z)
  ) + (unity_LightColor[3].xyz * tmpvar_29.w)));
  tmpvar_4 = tmpvar_30;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_24);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp float shadow_10;
  lowp float tmpvar_11;
  tmpvar_11 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_12;
  tmpvar_12 = (_LightShadowData.x + (tmpvar_11 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_12;
  lowp vec4 c_13;
  c_13.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz))
   * shadow_10) * 2.0));
  c_13.w = tmpvar_4;
  c_1.xyz = (c_13.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  c_1.w = tmpvar_4;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightAtten0;
uniform highp vec4 unity_LightColor[8];
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  mediump vec2 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2 = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec3 tmpvar_9;
  mediump vec4 normal_10;
  normal_10 = tmpvar_8;
  highp float vC_11;
  mediump vec3 x3_12;
  mediump vec3 x2_13;
  mediump vec3 x1_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHAr, normal_10);
  x1_14.x = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAg, normal_10);
  x1_14.y = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAb, normal_10);
  x1_14.z = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (normal_10.xyzz * normal_10.yzzx);
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHBr, tmpvar_18);
  x2_13.x = tmpvar_19;
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBg, tmpvar_18);
  x2_13.y = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBb, tmpvar_18);
  x2_13.z = tmpvar_21;
  mediump float tmpvar_22;
  tmpvar_22 = ((normal_10.x * normal_10.x) - (normal_10.y * normal_10.y));
  vC_11 = tmpvar_22;
  highp vec3 tmpvar_23;
  tmpvar_23 = (unity_SHC.xyz * vC_11);
  x3_12 = tmpvar_23;
  tmpvar_9 = ((x1_14 + x2_13) + x3_12);
  shlight_1 = tmpvar_9;
  tmpvar_4 = shlight_1;
  highp vec4 cse_24;
  cse_24 = (_Object2World * _glesVertex);
  highp vec4 tmpvar_25;
  tmpvar_25 = (unity_4LightPosX0 - cse_24.x);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosY0 - cse_24.y);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosZ0 - cse_24.z);
  highp vec4 tmpvar_28;
  tmpvar_28 = (((tmpvar_25 * tmpvar_25) + (tmpvar_26 * tmpvar_26)) + (tmpvar_27 * tmpvar_27));
  highp vec4 tmpvar_29;
  tmpvar_29 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_25 * tmpvar_7.x) + (tmpvar_26 * tmpvar_7.y)) + (tmpvar_27 * tmpvar_7.z))
   * 
    inversesqrt(tmpvar_28)
  )) * (1.0/((1.0 + 
    (tmpvar_28 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_30;
  tmpvar_30 = (tmpvar_4 + ((
    ((unity_LightColor[0].xyz * tmpvar_29.x) + (unity_LightColor[1].xyz * tmpvar_29.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_29.z)
  ) + (unity_LightColor[3].xyz * tmpvar_29.w)));
  tmpvar_4 = tmpvar_30;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_24);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  mediump vec4 tmpvar_2;
  tmpvar_2 = xlv_COLOR0;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  lowp float shadow_10;
  mediump float tmpvar_11;
  tmpvar_11 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_12;
  tmpvar_12 = tmpvar_11;
  highp float tmpvar_13;
  tmpvar_13 = (_LightShadowData.x + (tmpvar_12 * (1.0 - _LightShadowData.x)));
  shadow_10 = tmpvar_13;
  lowp vec4 c_14;
  c_14.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz))
   * shadow_10) * 2.0));
  c_14.w = tmpvar_4;
  c_1.xyz = (c_14.xyz + (tmpvar_3 * xlv_TEXCOORD2));
  c_1.w = tmpvar_4;
  _glesFragData[0] = c_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
  ColorMask RGB
Program "vp" {
SubProgram "gles " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceLightPos0.xyz - cse_8.xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * cse_8).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6.xyz, (tmpvar_6.xyz * _Color.xyz), vec3((tmpvar_3.y + tmpvar_3.x)));
  tmpvar_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, (tmpvar_6.xyz * _Secondary.xyz), tmpvar_3.xxx);
  tmpvar_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (tmpvar_6.w * _Color.w);
  tmpvar_5 = tmpvar_9;
  lowp float x_10;
  x_10 = (tmpvar_5 - _Cutoff);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_13;
  c_13.xyz = ((tmpvar_4 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * texture2D (_LightTexture0, vec2(tmpvar_12)).w) * 2.0));
  c_13.w = tmpvar_5;
  c_1.xyz = c_13.xyz;
  c_1.w = tmpvar_5;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceLightPos0.xyz - cse_8.xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * cse_8).xyz;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6.xyz, (tmpvar_6.xyz * _Color.xyz), vec3((tmpvar_3.y + tmpvar_3.x)));
  tmpvar_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, (tmpvar_6.xyz * _Secondary.xyz), tmpvar_3.xxx);
  tmpvar_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (tmpvar_6.w * _Color.w);
  tmpvar_5 = tmpvar_9;
  lowp float x_10;
  x_10 = (tmpvar_5 - _Cutoff);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_13;
  c_13.xyz = ((tmpvar_4 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * texture (_LightTexture0, vec2(tmpvar_12)).w) * 2.0));
  c_13.w = tmpvar_5;
  c_1.xyz = c_13.xyz;
  c_1.w = tmpvar_5;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  tmpvar_3 = tmpvar_7;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6.xyz, (tmpvar_6.xyz * _Color.xyz), vec3((tmpvar_3.y + tmpvar_3.x)));
  tmpvar_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, (tmpvar_6.xyz * _Secondary.xyz), tmpvar_3.xxx);
  tmpvar_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (tmpvar_6.w * _Color.w);
  tmpvar_5 = tmpvar_9;
  lowp float x_10;
  x_10 = (tmpvar_5 - _Cutoff);
  if ((x_10 < 0.0)) {
    discard;
  };
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_11;
  c_11.xyz = ((tmpvar_4 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD1, lightDir_2)
  ) * 2.0));
  c_11.w = tmpvar_5;
  c_1.xyz = c_11.xyz;
  c_1.w = tmpvar_5;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  tmpvar_3 = tmpvar_7;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6.xyz, (tmpvar_6.xyz * _Color.xyz), vec3((tmpvar_3.y + tmpvar_3.x)));
  tmpvar_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, (tmpvar_6.xyz * _Secondary.xyz), tmpvar_3.xxx);
  tmpvar_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (tmpvar_6.w * _Color.w);
  tmpvar_5 = tmpvar_9;
  lowp float x_10;
  x_10 = (tmpvar_5 - _Cutoff);
  if ((x_10 < 0.0)) {
    discard;
  };
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_11;
  c_11.xyz = ((tmpvar_4 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD1, lightDir_2)
  ) * 2.0));
  c_11.w = tmpvar_5;
  c_1.xyz = c_11.xyz;
  c_1.w = tmpvar_5;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceLightPos0.xyz - cse_8.xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * cse_8);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6.xyz, (tmpvar_6.xyz * _Color.xyz), vec3((tmpvar_3.y + tmpvar_3.x)));
  tmpvar_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, (tmpvar_6.xyz * _Secondary.xyz), tmpvar_3.xxx);
  tmpvar_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (tmpvar_6.w * _Color.w);
  tmpvar_5 = tmpvar_9;
  lowp float x_10;
  x_10 = (tmpvar_5 - _Cutoff);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_11;
  highp vec2 P_12;
  P_12 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_14;
  atten_14 = ((float(
    (xlv_TEXCOORD3.z > 0.0)
  ) * texture2D (_LightTexture0, P_12).w) * texture2D (_LightTextureB0, vec2(tmpvar_13)).w);
  lowp vec4 c_15;
  c_15.xyz = ((tmpvar_4 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * atten_14) * 2.0));
  c_15.w = tmpvar_5;
  c_1.xyz = c_15.xyz;
  c_1.w = tmpvar_5;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceLightPos0.xyz - cse_8.xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * cse_8);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6.xyz, (tmpvar_6.xyz * _Color.xyz), vec3((tmpvar_3.y + tmpvar_3.x)));
  tmpvar_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, (tmpvar_6.xyz * _Secondary.xyz), tmpvar_3.xxx);
  tmpvar_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (tmpvar_6.w * _Color.w);
  tmpvar_5 = tmpvar_9;
  lowp float x_10;
  x_10 = (tmpvar_5 - _Cutoff);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_11;
  highp vec2 P_12;
  P_12 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_13;
  tmpvar_13 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_14;
  atten_14 = ((float(
    (xlv_TEXCOORD3.z > 0.0)
  ) * texture (_LightTexture0, P_12).w) * texture (_LightTextureB0, vec2(tmpvar_13)).w);
  lowp vec4 c_15;
  c_15.xyz = ((tmpvar_4 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * atten_14) * 2.0));
  c_15.w = tmpvar_5;
  c_1.xyz = c_15.xyz;
  c_1.w = tmpvar_5;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceLightPos0.xyz - cse_8.xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * cse_8).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6.xyz, (tmpvar_6.xyz * _Color.xyz), vec3((tmpvar_3.y + tmpvar_3.x)));
  tmpvar_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, (tmpvar_6.xyz * _Secondary.xyz), tmpvar_3.xxx);
  tmpvar_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (tmpvar_6.w * _Color.w);
  tmpvar_5 = tmpvar_9;
  lowp float x_10;
  x_10 = (tmpvar_5 - _Cutoff);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_13;
  c_13.xyz = ((tmpvar_4 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * 
    (texture2D (_LightTextureB0, vec2(tmpvar_12)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w)
  ) * 2.0));
  c_13.w = tmpvar_5;
  c_1.xyz = c_13.xyz;
  c_1.w = tmpvar_5;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  highp vec4 cse_8;
  cse_8 = (_Object2World * _glesVertex);
  tmpvar_7 = (_WorldSpaceLightPos0.xyz - cse_8.xyz);
  tmpvar_3 = tmpvar_7;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * cse_8).xyz;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6.xyz, (tmpvar_6.xyz * _Color.xyz), vec3((tmpvar_3.y + tmpvar_3.x)));
  tmpvar_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, (tmpvar_6.xyz * _Secondary.xyz), tmpvar_3.xxx);
  tmpvar_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (tmpvar_6.w * _Color.w);
  tmpvar_5 = tmpvar_9;
  lowp float x_10;
  x_10 = (tmpvar_5 - _Cutoff);
  if ((x_10 < 0.0)) {
    discard;
  };
  mediump vec3 tmpvar_11;
  tmpvar_11 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_13;
  c_13.xyz = ((tmpvar_4 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * 
    (texture (_LightTextureB0, vec2(tmpvar_12)).w * texture (_LightTexture0, xlv_TEXCOORD3).w)
  ) * 2.0));
  c_13.w = tmpvar_5;
  c_1.xyz = c_13.xyz;
  c_1.w = tmpvar_5;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  tmpvar_3 = tmpvar_7;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6.xyz, (tmpvar_6.xyz * _Color.xyz), vec3((tmpvar_3.y + tmpvar_3.x)));
  tmpvar_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, (tmpvar_6.xyz * _Secondary.xyz), tmpvar_3.xxx);
  tmpvar_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (tmpvar_6.w * _Color.w);
  tmpvar_5 = tmpvar_9;
  lowp float x_10;
  x_10 = (tmpvar_5 - _Cutoff);
  if ((x_10 < 0.0)) {
    discard;
  };
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_11;
  c_11.xyz = ((tmpvar_4 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * texture2D (_LightTexture0, xlv_TEXCOORD3).w) * 2.0));
  c_11.w = tmpvar_5;
  c_1.xyz = c_11.xyz;
  c_1.w = tmpvar_5;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  tmpvar_3 = tmpvar_7;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  mediump vec4 tmpvar_3;
  tmpvar_3 = xlv_COLOR0;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_6.xyz, (tmpvar_6.xyz * _Color.xyz), vec3((tmpvar_3.y + tmpvar_3.x)));
  tmpvar_4 = tmpvar_7;
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_4, (tmpvar_6.xyz * _Secondary.xyz), tmpvar_3.xxx);
  tmpvar_4 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = (tmpvar_6.w * _Color.w);
  tmpvar_5 = tmpvar_9;
  lowp float x_10;
  x_10 = (tmpvar_5 - _Cutoff);
  if ((x_10 < 0.0)) {
    discard;
  };
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_11;
  c_11.xyz = ((tmpvar_4 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * texture (_LightTexture0, xlv_TEXCOORD3).w) * 2.0));
  c_11.w = tmpvar_5;
  c_1.xyz = c_11.xyz;
  c_1.w = tmpvar_5;
  _glesFragData[0] = c_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "POINT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3"
}
}
 }
 Pass {
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassBase" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 res_1;
  mediump vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  res_1.xyz = ((xlv_TEXCOORD1 * 0.5) + 0.5);
  res_1.w = 0.0;
  gl_FragData[0] = res_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
void main ()
{
  mediump vec2 tmpvar_1;
  lowp vec3 tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp mat3 tmpvar_4;
  tmpvar_4[0] = _Object2World[0].xyz;
  tmpvar_4[1] = _Object2World[1].xyz;
  tmpvar_4[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_5;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform lowp float _Cutoff;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 res_1;
  mediump vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_6;
  tmpvar_6 = mix (tmpvar_5.xyz, (tmpvar_5.xyz * _Color.xyz), vec3((tmpvar_2.y + tmpvar_2.x)));
  tmpvar_3 = tmpvar_6;
  mediump vec3 tmpvar_7;
  tmpvar_7 = mix (tmpvar_3, (tmpvar_5.xyz * _Secondary.xyz), tmpvar_2.xxx);
  tmpvar_3 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = (tmpvar_5.w * _Color.w);
  tmpvar_4 = tmpvar_8;
  lowp float x_9;
  x_9 = (tmpvar_4 - _Cutoff);
  if ((x_9 < 0.0)) {
    discard;
  };
  res_1.xyz = ((xlv_TEXCOORD1 * 0.5) + 0.5);
  res_1.w = 0.0;
  _glesFragData[0] = res_1;
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
  Name "PREPASS"
  Tags { "LIGHTMODE"="PrePassFinal" "QUEUE"="AlphaTest" "IGNOREPROJECTOR"="true" "RenderType"="TransparentCutout" }
  ZWrite Off
Program "vp" {
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_10;
  mediump vec4 normal_11;
  normal_11 = tmpvar_9;
  highp float vC_12;
  mediump vec3 x3_13;
  mediump vec3 x2_14;
  mediump vec3 x1_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAr, normal_11);
  x1_15.x = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAg, normal_11);
  x1_15.y = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHAb, normal_11);
  x1_15.z = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_11.xyzz * normal_11.yzzx);
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBr, tmpvar_19);
  x2_14.x = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBg, tmpvar_19);
  x2_14.y = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHBb, tmpvar_19);
  x2_14.z = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = ((normal_11.x * normal_11.x) - (normal_11.y * normal_11.y));
  vC_12 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_SHC.xyz * vC_12);
  x3_13 = tmpvar_24;
  tmpvar_10 = ((x1_15 + x2_14) + x3_13);
  tmpvar_2 = tmpvar_10;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D _LightBuffer;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = xlv_COLOR0;
  lowp vec3 tmpvar_5;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_7.xyz, (tmpvar_7.xyz * _Color.xyz), vec3((tmpvar_4.y + tmpvar_4.x)));
  tmpvar_5 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_5, (tmpvar_7.xyz * _Secondary.xyz), tmpvar_4.xxx);
  tmpvar_5 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = (tmpvar_7.w * _Color.w);
  tmpvar_6 = tmpvar_10;
  lowp float x_11;
  x_11 = (tmpvar_6 - _Cutoff);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_13.w;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_14;
  lowp vec4 c_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_5 * light_3.xyz);
  c_15.xyz = tmpvar_16;
  c_15.w = tmpvar_6;
  c_2 = c_15;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_10;
  mediump vec4 normal_11;
  normal_11 = tmpvar_9;
  highp float vC_12;
  mediump vec3 x3_13;
  mediump vec3 x2_14;
  mediump vec3 x1_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAr, normal_11);
  x1_15.x = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAg, normal_11);
  x1_15.y = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHAb, normal_11);
  x1_15.z = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_11.xyzz * normal_11.yzzx);
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBr, tmpvar_19);
  x2_14.x = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBg, tmpvar_19);
  x2_14.y = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHBb, tmpvar_19);
  x2_14.z = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = ((normal_11.x * normal_11.x) - (normal_11.y * normal_11.y));
  vC_12 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_SHC.xyz * vC_12);
  x3_13 = tmpvar_24;
  tmpvar_10 = ((x1_15 + x2_14) + x3_13);
  tmpvar_2 = tmpvar_10;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D _LightBuffer;
uniform lowp float _Cutoff;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = xlv_COLOR0;
  lowp vec3 tmpvar_5;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_7.xyz, (tmpvar_7.xyz * _Color.xyz), vec3((tmpvar_4.y + tmpvar_4.x)));
  tmpvar_5 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_5, (tmpvar_7.xyz * _Secondary.xyz), tmpvar_4.xxx);
  tmpvar_5 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = (tmpvar_7.w * _Color.w);
  tmpvar_6 = tmpvar_10;
  lowp float x_11;
  x_11 = (tmpvar_6 - _Cutoff);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_13.w;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_14;
  lowp vec4 c_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_5 * light_3.xyz);
  c_15.xyz = tmpvar_16;
  c_15.w = tmpvar_6;
  c_2 = c_15;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_2.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = xlv_COLOR0;
  lowp vec3 tmpvar_8;
  lowp float tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_10.xyz, (tmpvar_10.xyz * _Color.xyz), vec3((tmpvar_7.y + tmpvar_7.x)));
  tmpvar_8 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_8, (tmpvar_10.xyz * _Secondary.xyz), tmpvar_7.xxx);
  tmpvar_8 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (tmpvar_10.w * _Color.w);
  tmpvar_9 = tmpvar_13;
  lowp float x_14;
  x_14 = (tmpvar_9 - _Cutoff);
  if ((x_14 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_16.w;
  highp float tmpvar_17;
  tmpvar_17 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_19;
  light_6.xyz = (tmpvar_16.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_8 * light_6.xyz);
  c_20.xyz = tmpvar_21;
  c_20.w = tmpvar_9;
  c_2 = c_20;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_2.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
uniform lowp float _Cutoff;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = xlv_COLOR0;
  lowp vec3 tmpvar_8;
  lowp float tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_10.xyz, (tmpvar_10.xyz * _Color.xyz), vec3((tmpvar_7.y + tmpvar_7.x)));
  tmpvar_8 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_8, (tmpvar_10.xyz * _Secondary.xyz), tmpvar_7.xxx);
  tmpvar_8 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (tmpvar_10.w * _Color.w);
  tmpvar_9 = tmpvar_13;
  lowp float x_14;
  x_14 = (tmpvar_9 - _Cutoff);
  if ((x_14 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_15;
  tmpvar_15 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_16.w;
  highp float tmpvar_17;
  tmpvar_17 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_19;
  light_6.xyz = (tmpvar_16.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_8 * light_6.xyz);
  c_20.xyz = tmpvar_21;
  c_20.w = tmpvar_9;
  c_2 = c_20;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = xlv_COLOR0;
  lowp vec3 tmpvar_5;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_7.xyz, (tmpvar_7.xyz * _Color.xyz), vec3((tmpvar_4.y + tmpvar_4.x)));
  tmpvar_5 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_5, (tmpvar_7.xyz * _Secondary.xyz), tmpvar_4.xxx);
  tmpvar_5 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = (tmpvar_7.w * _Color.w);
  tmpvar_6 = tmpvar_10;
  lowp float x_11;
  x_11 = (tmpvar_6 - _Cutoff);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_12;
  mediump vec3 lm_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_13 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = lm_13;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (-(log2(
    max (light_3, vec4(0.001, 0.001, 0.001, 0.001))
  )) + tmpvar_15);
  light_3 = tmpvar_16;
  lowp vec4 c_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_5 * tmpvar_16.xyz);
  c_17.xyz = tmpvar_18;
  c_17.w = tmpvar_6;
  c_2 = c_17;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform lowp float _Cutoff;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = xlv_COLOR0;
  lowp vec3 tmpvar_5;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_7.xyz, (tmpvar_7.xyz * _Color.xyz), vec3((tmpvar_4.y + tmpvar_4.x)));
  tmpvar_5 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_5, (tmpvar_7.xyz * _Secondary.xyz), tmpvar_4.xxx);
  tmpvar_5 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = (tmpvar_7.w * _Color.w);
  tmpvar_6 = tmpvar_10;
  lowp float x_11;
  x_11 = (tmpvar_6 - _Cutoff);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_12;
  mediump vec3 lm_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_13 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = lm_13;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (-(log2(
    max (light_3, vec4(0.001, 0.001, 0.001, 0.001))
  )) + tmpvar_15);
  light_3 = tmpvar_16;
  lowp vec4 c_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_5 * tmpvar_16.xyz);
  c_17.xyz = tmpvar_18;
  c_17.w = tmpvar_6;
  c_2 = c_17;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_10;
  mediump vec4 normal_11;
  normal_11 = tmpvar_9;
  highp float vC_12;
  mediump vec3 x3_13;
  mediump vec3 x2_14;
  mediump vec3 x1_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAr, normal_11);
  x1_15.x = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAg, normal_11);
  x1_15.y = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHAb, normal_11);
  x1_15.z = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_11.xyzz * normal_11.yzzx);
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBr, tmpvar_19);
  x2_14.x = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBg, tmpvar_19);
  x2_14.y = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHBb, tmpvar_19);
  x2_14.z = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = ((normal_11.x * normal_11.x) - (normal_11.y * normal_11.y));
  vC_12 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_SHC.xyz * vC_12);
  x3_13 = tmpvar_24;
  tmpvar_10 = ((x1_15 + x2_14) + x3_13);
  tmpvar_2 = tmpvar_10;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D _LightBuffer;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = xlv_COLOR0;
  lowp vec3 tmpvar_5;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_7.xyz, (tmpvar_7.xyz * _Color.xyz), vec3((tmpvar_4.y + tmpvar_4.x)));
  tmpvar_5 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_5, (tmpvar_7.xyz * _Secondary.xyz), tmpvar_4.xxx);
  tmpvar_5 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = (tmpvar_7.w * _Color.w);
  tmpvar_6 = tmpvar_10;
  lowp float x_11;
  x_11 = (tmpvar_6 - _Cutoff);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_13.w;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_14;
  lowp vec4 c_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_5 * light_3.xyz);
  c_15.xyz = tmpvar_16;
  c_15.w = tmpvar_6;
  c_2 = c_15;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHC;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  highp mat3 tmpvar_8;
  tmpvar_8[0] = _Object2World[0].xyz;
  tmpvar_8[1] = _Object2World[1].xyz;
  tmpvar_8[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = (tmpvar_8 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_10;
  mediump vec4 normal_11;
  normal_11 = tmpvar_9;
  highp float vC_12;
  mediump vec3 x3_13;
  mediump vec3 x2_14;
  mediump vec3 x1_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHAr, normal_11);
  x1_15.x = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAg, normal_11);
  x1_15.y = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHAb, normal_11);
  x1_15.z = tmpvar_18;
  mediump vec4 tmpvar_19;
  tmpvar_19 = (normal_11.xyzz * normal_11.yzzx);
  highp float tmpvar_20;
  tmpvar_20 = dot (unity_SHBr, tmpvar_19);
  x2_14.x = tmpvar_20;
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBg, tmpvar_19);
  x2_14.y = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHBb, tmpvar_19);
  x2_14.z = tmpvar_22;
  mediump float tmpvar_23;
  tmpvar_23 = ((normal_11.x * normal_11.x) - (normal_11.y * normal_11.y));
  vC_12 = tmpvar_23;
  highp vec3 tmpvar_24;
  tmpvar_24 = (unity_SHC.xyz * vC_12);
  x3_13 = tmpvar_24;
  tmpvar_10 = ((x1_15 + x2_14) + x3_13);
  tmpvar_2 = tmpvar_10;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D _LightBuffer;
uniform lowp float _Cutoff;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = xlv_COLOR0;
  lowp vec3 tmpvar_5;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_7.xyz, (tmpvar_7.xyz * _Color.xyz), vec3((tmpvar_4.y + tmpvar_4.x)));
  tmpvar_5 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_5, (tmpvar_7.xyz * _Secondary.xyz), tmpvar_4.xxx);
  tmpvar_5 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = (tmpvar_7.w * _Color.w);
  tmpvar_6 = tmpvar_10;
  lowp float x_11;
  x_11 = (tmpvar_6 - _Cutoff);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_13.w;
  highp vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_13.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_14;
  lowp vec4 c_15;
  mediump vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_5 * light_3.xyz);
  c_15.xyz = tmpvar_16;
  c_15.w = tmpvar_6;
  c_2 = c_15;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_2.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = xlv_COLOR0;
  lowp vec3 tmpvar_8;
  lowp float tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_10.xyz, (tmpvar_10.xyz * _Color.xyz), vec3((tmpvar_7.y + tmpvar_7.x)));
  tmpvar_8 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_8, (tmpvar_10.xyz * _Secondary.xyz), tmpvar_7.xxx);
  tmpvar_8 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (tmpvar_10.w * _Color.w);
  tmpvar_9 = tmpvar_13;
  lowp float x_14;
  x_14 = (tmpvar_9 - _Cutoff);
  if ((x_14 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_15;
  tmpvar_15 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_16.w;
  highp float tmpvar_17;
  tmpvar_17 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_19;
  light_6.xyz = (tmpvar_16.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_8 * light_6.xyz);
  c_20.xyz = tmpvar_21;
  c_20.w = tmpvar_9;
  c_2 = c_20;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_4;
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_3.zw;
  tmpvar_2.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_2.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
uniform lowp float _Cutoff;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec3 lmIndirect_3;
  mediump vec3 lmFull_4;
  mediump float lmFade_5;
  mediump vec4 light_6;
  mediump vec4 tmpvar_7;
  tmpvar_7 = xlv_COLOR0;
  lowp vec3 tmpvar_8;
  lowp float tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_10.xyz, (tmpvar_10.xyz * _Color.xyz), vec3((tmpvar_7.y + tmpvar_7.x)));
  tmpvar_8 = tmpvar_11;
  mediump vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_8, (tmpvar_10.xyz * _Secondary.xyz), tmpvar_7.xxx);
  tmpvar_8 = tmpvar_12;
  mediump float tmpvar_13;
  tmpvar_13 = (tmpvar_10.w * _Color.w);
  tmpvar_9 = tmpvar_13;
  lowp float x_14;
  x_14 = (tmpvar_9 - _Cutoff);
  if ((x_14 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_15;
  tmpvar_15 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_15;
  mediump vec4 tmpvar_16;
  tmpvar_16 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_16.w;
  highp float tmpvar_17;
  tmpvar_17 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_19;
  light_6.xyz = (tmpvar_16.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_20;
  mediump vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_8 * light_6.xyz);
  c_20.xyz = tmpvar_21;
  c_20.w = tmpvar_9;
  c_2 = c_20;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform lowp float _Cutoff;
varying mediump vec2 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = xlv_COLOR0;
  lowp vec3 tmpvar_5;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_7.xyz, (tmpvar_7.xyz * _Color.xyz), vec3((tmpvar_4.y + tmpvar_4.x)));
  tmpvar_5 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_5, (tmpvar_7.xyz * _Secondary.xyz), tmpvar_4.xxx);
  tmpvar_5 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = (tmpvar_7.w * _Color.w);
  tmpvar_6 = tmpvar_10;
  lowp float x_11;
  x_11 = (tmpvar_6 - _Cutoff);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_12;
  mediump vec3 lm_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_13 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = lm_13;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_15);
  light_3 = tmpvar_16;
  lowp vec4 c_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_5 * tmpvar_16.xyz);
  c_17.xyz = tmpvar_18;
  c_17.w = tmpvar_6;
  c_2 = c_17;
  tmpvar_1 = c_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
out mediump vec2 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1 = tmpvar_3;
  highp vec4 o_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_4.xy = (tmpvar_6 + tmpvar_5.w);
  o_4.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_COLOR0 = _glesColor;
  xlv_TEXCOORD1 = o_4;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform mediump vec4 _Color;
uniform mediump vec4 _Secondary;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform lowp float _Cutoff;
in mediump vec2 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  mediump vec4 tmpvar_4;
  tmpvar_4 = xlv_COLOR0;
  lowp vec3 tmpvar_5;
  lowp float tmpvar_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec3 tmpvar_8;
  tmpvar_8 = mix (tmpvar_7.xyz, (tmpvar_7.xyz * _Color.xyz), vec3((tmpvar_4.y + tmpvar_4.x)));
  tmpvar_5 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = mix (tmpvar_5, (tmpvar_7.xyz * _Secondary.xyz), tmpvar_4.xxx);
  tmpvar_5 = tmpvar_9;
  mediump float tmpvar_10;
  tmpvar_10 = (tmpvar_7.w * _Color.w);
  tmpvar_6 = tmpvar_10;
  lowp float x_11;
  x_11 = (tmpvar_6 - _Cutoff);
  if ((x_11 < 0.0)) {
    discard;
  };
  lowp vec4 tmpvar_12;
  tmpvar_12 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_12;
  mediump vec3 lm_13;
  lowp vec3 tmpvar_14;
  tmpvar_14 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_13 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15.w = 0.0;
  tmpvar_15.xyz = lm_13;
  mediump vec4 tmpvar_16;
  tmpvar_16 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_15);
  light_3 = tmpvar_16;
  lowp vec4 c_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_5 * tmpvar_16.xyz);
  c_17.xyz = tmpvar_18;
  c_17.w = tmpvar_6;
  c_2 = c_17;
  tmpvar_1 = c_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES3"
}
}
 }
}
Fallback "Transparent/Cutout/VertexLit"
}