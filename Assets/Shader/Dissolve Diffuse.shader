Shader "TestBed/Dissolve/Dissolve Diffuse" {
Properties {
 _Burn ("Burn Amount", Range(-0.25,1.25)) = 0
 _LineWidth ("Burn Line Size", Range(0,0.2)) = 0.1
 _BurnColor ("Burn Color", Color) = (1,0,0,1)
 _MainTex ("Main Texture", 2D) = "white" {}
 _BurnMap ("Burn Map", 2D) = "white" {}
}
SubShader { 
 Tags { "QUEUE"="Transparent" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "SHADOWSUPPORT"="true" "QUEUE"="Transparent" }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
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
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  mediump vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.xy = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_2.zw = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
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
  shlight_1 = tmpvar_10;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 clear_4;
  mediump vec4 burn_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_5 = tmpvar_7;
  highp float cse_8;
  cse_8 = (_Burn + _LineWidth);
  highp vec4 tmpvar_9;
  tmpvar_9 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_5.x - cse_8) + 0.99))
  ))));
  clear_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6.xyz, clear_4.xyz, vec3(max (0.0, float(
    int(((burn_5.x - _Burn) + 0.99))
  ))));
  tmpvar_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = mix (1.0, 0.0, float(int(
    ((burn_5.x - cse_8) + 0.99)
  )));
  tmpvar_3 = tmpvar_11;
  lowp vec4 c_12;
  c_12.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)
  ) * 2.0));
  c_12.w = tmpvar_3;
  c_1.w = c_12.w;
  c_1.xyz = (c_12.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
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
uniform highp vec4 _BurnMap_ST;
out mediump vec4 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  mediump vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.xy = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_2.zw = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
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
  shlight_1 = tmpvar_10;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
in mediump vec4 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 clear_4;
  mediump vec4 burn_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_BurnMap, xlv_TEXCOORD0.zw);
  burn_5 = tmpvar_7;
  highp float cse_8;
  cse_8 = (_Burn + _LineWidth);
  highp vec4 tmpvar_9;
  tmpvar_9 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_5.x - cse_8) + 0.99))
  ))));
  clear_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6.xyz, clear_4.xyz, vec3(max (0.0, float(
    int(((burn_5.x - _Burn) + 0.99))
  ))));
  tmpvar_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = mix (1.0, 0.0, float(int(
    ((burn_5.x - cse_8) + 0.99)
  )));
  tmpvar_3 = tmpvar_11;
  lowp vec4 c_12;
  c_12.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)
  ) * 2.0));
  c_12.w = tmpvar_3;
  c_1.w = c_12.w;
  c_1.xyz = (c_12.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D unity_Lightmap;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 clear_4;
  mediump vec4 burn_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_5 = tmpvar_7;
  highp float cse_8;
  cse_8 = (_Burn + _LineWidth);
  highp vec4 tmpvar_9;
  tmpvar_9 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_5.x - cse_8) + 0.99))
  ))));
  clear_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6.xyz, clear_4.xyz, vec3(max (0.0, float(
    int(((burn_5.x - _Burn) + 0.99))
  ))));
  tmpvar_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = mix (1.0, 0.0, float(int(
    ((burn_5.x - cse_8) + 0.99)
  )));
  tmpvar_3 = tmpvar_11;
  c_1.xyz = (tmpvar_2 * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
out mediump vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D unity_Lightmap;
in mediump vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 clear_4;
  mediump vec4 burn_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_BurnMap, xlv_TEXCOORD0.zw);
  burn_5 = tmpvar_7;
  highp float cse_8;
  cse_8 = (_Burn + _LineWidth);
  highp vec4 tmpvar_9;
  tmpvar_9 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_5.x - cse_8) + 0.99))
  ))));
  clear_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6.xyz, clear_4.xyz, vec3(max (0.0, float(
    int(((burn_5.x - _Burn) + 0.99))
  ))));
  tmpvar_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = mix (1.0, 0.0, float(int(
    ((burn_5.x - cse_8) + 0.99)
  )));
  tmpvar_3 = tmpvar_11;
  c_1.xyz = (tmpvar_2 * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz));
  c_1.w = tmpvar_3;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D unity_Lightmap;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 clear_4;
  mediump vec4 burn_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_5 = tmpvar_7;
  highp float cse_8;
  cse_8 = (_Burn + _LineWidth);
  highp vec4 tmpvar_9;
  tmpvar_9 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_5.x - cse_8) + 0.99))
  ))));
  clear_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6.xyz, clear_4.xyz, vec3(max (0.0, float(
    int(((burn_5.x - _Burn) + 0.99))
  ))));
  tmpvar_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = mix (1.0, 0.0, float(int(
    ((burn_5.x - cse_8) + 0.99)
  )));
  tmpvar_3 = tmpvar_11;
  mediump vec3 lm_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_12 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_2 * lm_12);
  c_1.xyz = tmpvar_14;
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
out mediump vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D unity_Lightmap;
in mediump vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 clear_4;
  mediump vec4 burn_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_BurnMap, xlv_TEXCOORD0.zw);
  burn_5 = tmpvar_7;
  highp float cse_8;
  cse_8 = (_Burn + _LineWidth);
  highp vec4 tmpvar_9;
  tmpvar_9 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_5.x - cse_8) + 0.99))
  ))));
  clear_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6.xyz, clear_4.xyz, vec3(max (0.0, float(
    int(((burn_5.x - _Burn) + 0.99))
  ))));
  tmpvar_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = mix (1.0, 0.0, float(int(
    ((burn_5.x - cse_8) + 0.99)
  )));
  tmpvar_3 = tmpvar_11;
  mediump vec3 lm_12;
  lowp vec3 tmpvar_13;
  tmpvar_13 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_12 = tmpvar_13;
  mediump vec3 tmpvar_14;
  tmpvar_14 = (tmpvar_2 * lm_12);
  c_1.xyz = tmpvar_14;
  c_1.w = tmpvar_3;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
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
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  mediump vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.xy = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_2.zw = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
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
  shlight_1 = tmpvar_10;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
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
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 clear_4;
  mediump vec4 burn_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_5 = tmpvar_7;
  highp float cse_8;
  cse_8 = (_Burn + _LineWidth);
  highp vec4 tmpvar_9;
  tmpvar_9 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_5.x - cse_8) + 0.99))
  ))));
  clear_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6.xyz, clear_4.xyz, vec3(max (0.0, float(
    int(((burn_5.x - _Burn) + 0.99))
  ))));
  tmpvar_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = mix (1.0, 0.0, float(int(
    ((burn_5.x - cse_8) + 0.99)
  )));
  tmpvar_3 = tmpvar_11;
  lowp float tmpvar_12;
  mediump float lightShadowDataX_13;
  highp float dist_14;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_14 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((dist_14 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_13);
  tmpvar_12 = tmpvar_17;
  lowp vec4 c_18;
  c_18.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz))
   * tmpvar_12) * 2.0));
  c_18.w = tmpvar_3;
  c_1.w = c_18.w;
  c_1.xyz = (c_18.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D unity_Lightmap;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 clear_4;
  mediump vec4 burn_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_5 = tmpvar_7;
  highp float cse_8;
  cse_8 = (_Burn + _LineWidth);
  highp vec4 tmpvar_9;
  tmpvar_9 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_5.x - cse_8) + 0.99))
  ))));
  clear_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6.xyz, clear_4.xyz, vec3(max (0.0, float(
    int(((burn_5.x - _Burn) + 0.99))
  ))));
  tmpvar_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = mix (1.0, 0.0, float(int(
    ((burn_5.x - cse_8) + 0.99)
  )));
  tmpvar_3 = tmpvar_11;
  lowp float tmpvar_12;
  mediump float lightShadowDataX_13;
  highp float dist_14;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_14 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((dist_14 > 
    (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w)
  )), lightShadowDataX_13);
  tmpvar_12 = tmpvar_17;
  c_1.xyz = (tmpvar_2 * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz), vec3((tmpvar_12 * 2.0))));
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _LightShadowData;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D unity_Lightmap;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 clear_4;
  mediump vec4 burn_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_5 = tmpvar_7;
  highp float cse_8;
  cse_8 = (_Burn + _LineWidth);
  highp vec4 tmpvar_9;
  tmpvar_9 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_5.x - cse_8) + 0.99))
  ))));
  clear_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6.xyz, clear_4.xyz, vec3(max (0.0, float(
    int(((burn_5.x - _Burn) + 0.99))
  ))));
  tmpvar_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = mix (1.0, 0.0, float(int(
    ((burn_5.x - cse_8) + 0.99)
  )));
  tmpvar_3 = tmpvar_11;
  lowp float tmpvar_12;
  mediump float lightShadowDataX_13;
  highp float dist_14;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD2).x;
  dist_14 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((dist_14 > 
    (xlv_TEXCOORD2.z / xlv_TEXCOORD2.w)
  )), lightShadowDataX_13);
  tmpvar_12 = tmpvar_17;
  mediump vec3 lm_18;
  lowp vec3 tmpvar_19;
  tmpvar_19 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_18 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = vec3((tmpvar_12 * 2.0));
  mediump vec3 tmpvar_21;
  tmpvar_21 = (tmpvar_2 * min (lm_18, tmpvar_20));
  c_1.xyz = tmpvar_21;
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
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
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  mediump vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.xy = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_2.zw = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
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
  shlight_1 = tmpvar_10;
  tmpvar_4 = shlight_1;
  highp vec3 tmpvar_25;
  tmpvar_25 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosX0 - tmpvar_25.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - tmpvar_25.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_25.z);
  highp vec4 tmpvar_29;
  tmpvar_29 = (((tmpvar_26 * tmpvar_26) + (tmpvar_27 * tmpvar_27)) + (tmpvar_28 * tmpvar_28));
  highp vec4 tmpvar_30;
  tmpvar_30 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_26 * tmpvar_8.x) + (tmpvar_27 * tmpvar_8.y)) + (tmpvar_28 * tmpvar_8.z))
   * 
    inversesqrt(tmpvar_29)
  )) * (1.0/((1.0 + 
    (tmpvar_29 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_4 + ((
    ((unity_LightColor[0].xyz * tmpvar_30.x) + (unity_LightColor[1].xyz * tmpvar_30.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_30.z)
  ) + (unity_LightColor[3].xyz * tmpvar_30.w)));
  tmpvar_4 = tmpvar_31;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 clear_4;
  mediump vec4 burn_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_5 = tmpvar_7;
  highp float cse_8;
  cse_8 = (_Burn + _LineWidth);
  highp vec4 tmpvar_9;
  tmpvar_9 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_5.x - cse_8) + 0.99))
  ))));
  clear_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6.xyz, clear_4.xyz, vec3(max (0.0, float(
    int(((burn_5.x - _Burn) + 0.99))
  ))));
  tmpvar_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = mix (1.0, 0.0, float(int(
    ((burn_5.x - cse_8) + 0.99)
  )));
  tmpvar_3 = tmpvar_11;
  lowp vec4 c_12;
  c_12.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)
  ) * 2.0));
  c_12.w = tmpvar_3;
  c_1.w = c_12.w;
  c_1.xyz = (c_12.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
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
uniform highp vec4 _BurnMap_ST;
out mediump vec4 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 shlight_1;
  mediump vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.xy = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_2.zw = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
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
  shlight_1 = tmpvar_10;
  tmpvar_4 = shlight_1;
  highp vec3 tmpvar_25;
  tmpvar_25 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosX0 - tmpvar_25.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - tmpvar_25.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - tmpvar_25.z);
  highp vec4 tmpvar_29;
  tmpvar_29 = (((tmpvar_26 * tmpvar_26) + (tmpvar_27 * tmpvar_27)) + (tmpvar_28 * tmpvar_28));
  highp vec4 tmpvar_30;
  tmpvar_30 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_26 * tmpvar_8.x) + (tmpvar_27 * tmpvar_8.y)) + (tmpvar_28 * tmpvar_8.z))
   * 
    inversesqrt(tmpvar_29)
  )) * (1.0/((1.0 + 
    (tmpvar_29 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_4 + ((
    ((unity_LightColor[0].xyz * tmpvar_30.x) + (unity_LightColor[1].xyz * tmpvar_30.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_30.z)
  ) + (unity_LightColor[3].xyz * tmpvar_30.w)));
  tmpvar_4 = tmpvar_31;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
in mediump vec4 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 clear_4;
  mediump vec4 burn_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_BurnMap, xlv_TEXCOORD0.zw);
  burn_5 = tmpvar_7;
  highp float cse_8;
  cse_8 = (_Burn + _LineWidth);
  highp vec4 tmpvar_9;
  tmpvar_9 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_5.x - cse_8) + 0.99))
  ))));
  clear_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6.xyz, clear_4.xyz, vec3(max (0.0, float(
    int(((burn_5.x - _Burn) + 0.99))
  ))));
  tmpvar_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = mix (1.0, 0.0, float(int(
    ((burn_5.x - cse_8) + 0.99)
  )));
  tmpvar_3 = tmpvar_11;
  lowp vec4 c_12;
  c_12.xyz = ((tmpvar_2 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz)
  ) * 2.0));
  c_12.w = tmpvar_3;
  c_1.w = c_12.w;
  c_1.xyz = (c_12.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
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
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  mediump vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.xy = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_2.zw = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
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
  shlight_1 = tmpvar_10;
  tmpvar_4 = shlight_1;
  highp vec4 cse_25;
  cse_25 = (_Object2World * _glesVertex);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosX0 - cse_25.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - cse_25.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - cse_25.z);
  highp vec4 tmpvar_29;
  tmpvar_29 = (((tmpvar_26 * tmpvar_26) + (tmpvar_27 * tmpvar_27)) + (tmpvar_28 * tmpvar_28));
  highp vec4 tmpvar_30;
  tmpvar_30 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_26 * tmpvar_8.x) + (tmpvar_27 * tmpvar_8.y)) + (tmpvar_28 * tmpvar_8.z))
   * 
    inversesqrt(tmpvar_29)
  )) * (1.0/((1.0 + 
    (tmpvar_29 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_4 + ((
    ((unity_LightColor[0].xyz * tmpvar_30.x) + (unity_LightColor[1].xyz * tmpvar_30.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_30.z)
  ) + (unity_LightColor[3].xyz * tmpvar_30.w)));
  tmpvar_4 = tmpvar_31;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_25);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 clear_4;
  mediump vec4 burn_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_5 = tmpvar_7;
  highp float cse_8;
  cse_8 = (_Burn + _LineWidth);
  highp vec4 tmpvar_9;
  tmpvar_9 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_5.x - cse_8) + 0.99))
  ))));
  clear_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6.xyz, clear_4.xyz, vec3(max (0.0, float(
    int(((burn_5.x - _Burn) + 0.99))
  ))));
  tmpvar_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = mix (1.0, 0.0, float(int(
    ((burn_5.x - cse_8) + 0.99)
  )));
  tmpvar_3 = tmpvar_11;
  lowp float tmpvar_12;
  mediump float lightShadowDataX_13;
  highp float dist_14;
  lowp float tmpvar_15;
  tmpvar_15 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x;
  dist_14 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = _LightShadowData.x;
  lightShadowDataX_13 = tmpvar_16;
  highp float tmpvar_17;
  tmpvar_17 = max (float((dist_14 > 
    (xlv_TEXCOORD3.z / xlv_TEXCOORD3.w)
  )), lightShadowDataX_13);
  tmpvar_12 = tmpvar_17;
  lowp vec4 c_18;
  c_18.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz))
   * tmpvar_12) * 2.0));
  c_18.w = tmpvar_3;
  c_1.w = c_18.w;
  c_1.xyz = (c_18.xyz + (tmpvar_2 * xlv_TEXCOORD2));
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
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  mediump vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.xy = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_2.zw = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
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
  shlight_1 = tmpvar_10;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
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
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 clear_4;
  mediump vec4 burn_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_5 = tmpvar_7;
  highp float cse_8;
  cse_8 = (_Burn + _LineWidth);
  highp vec4 tmpvar_9;
  tmpvar_9 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_5.x - cse_8) + 0.99))
  ))));
  clear_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6.xyz, clear_4.xyz, vec3(max (0.0, float(
    int(((burn_5.x - _Burn) + 0.99))
  ))));
  tmpvar_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = mix (1.0, 0.0, float(int(
    ((burn_5.x - cse_8) + 0.99)
  )));
  tmpvar_3 = tmpvar_11;
  lowp float shadow_12;
  lowp float tmpvar_13;
  tmpvar_13 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_14;
  tmpvar_14 = (_LightShadowData.x + (tmpvar_13 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_14;
  lowp vec4 c_15;
  c_15.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz))
   * shadow_12) * 2.0));
  c_15.w = tmpvar_3;
  c_1.w = c_15.w;
  c_1.xyz = (c_15.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
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
uniform highp vec4 _BurnMap_ST;
out mediump vec4 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  mediump vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.xy = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_2.zw = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
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
  shlight_1 = tmpvar_10;
  tmpvar_4 = shlight_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
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
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
in mediump vec4 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 clear_4;
  mediump vec4 burn_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_BurnMap, xlv_TEXCOORD0.zw);
  burn_5 = tmpvar_7;
  highp float cse_8;
  cse_8 = (_Burn + _LineWidth);
  highp vec4 tmpvar_9;
  tmpvar_9 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_5.x - cse_8) + 0.99))
  ))));
  clear_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6.xyz, clear_4.xyz, vec3(max (0.0, float(
    int(((burn_5.x - _Burn) + 0.99))
  ))));
  tmpvar_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = mix (1.0, 0.0, float(int(
    ((burn_5.x - cse_8) + 0.99)
  )));
  tmpvar_3 = tmpvar_11;
  lowp float shadow_12;
  mediump float tmpvar_13;
  tmpvar_13 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_14;
  tmpvar_14 = tmpvar_13;
  highp float tmpvar_15;
  tmpvar_15 = (_LightShadowData.x + (tmpvar_14 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_15;
  lowp vec4 c_16;
  c_16.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz))
   * shadow_12) * 2.0));
  c_16.w = tmpvar_3;
  c_1.w = c_16.w;
  c_1.xyz = (c_16.xyz + (tmpvar_2 * xlv_TEXCOORD2));
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D unity_Lightmap;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 clear_4;
  mediump vec4 burn_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_5 = tmpvar_7;
  highp float cse_8;
  cse_8 = (_Burn + _LineWidth);
  highp vec4 tmpvar_9;
  tmpvar_9 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_5.x - cse_8) + 0.99))
  ))));
  clear_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6.xyz, clear_4.xyz, vec3(max (0.0, float(
    int(((burn_5.x - _Burn) + 0.99))
  ))));
  tmpvar_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = mix (1.0, 0.0, float(int(
    ((burn_5.x - cse_8) + 0.99)
  )));
  tmpvar_3 = tmpvar_11;
  lowp float shadow_12;
  lowp float tmpvar_13;
  tmpvar_13 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_14;
  tmpvar_14 = (_LightShadowData.x + (tmpvar_13 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_14;
  c_1.xyz = (tmpvar_2 * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz), vec3((shadow_12 * 2.0))));
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
out mediump vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D unity_Lightmap;
in mediump vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 clear_4;
  mediump vec4 burn_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_BurnMap, xlv_TEXCOORD0.zw);
  burn_5 = tmpvar_7;
  highp float cse_8;
  cse_8 = (_Burn + _LineWidth);
  highp vec4 tmpvar_9;
  tmpvar_9 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_5.x - cse_8) + 0.99))
  ))));
  clear_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6.xyz, clear_4.xyz, vec3(max (0.0, float(
    int(((burn_5.x - _Burn) + 0.99))
  ))));
  tmpvar_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = mix (1.0, 0.0, float(int(
    ((burn_5.x - cse_8) + 0.99)
  )));
  tmpvar_3 = tmpvar_11;
  lowp float shadow_12;
  mediump float tmpvar_13;
  tmpvar_13 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_14;
  tmpvar_14 = tmpvar_13;
  highp float tmpvar_15;
  tmpvar_15 = (_LightShadowData.x + (tmpvar_14 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_15;
  c_1.xyz = (tmpvar_2 * min ((2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz), vec3((shadow_12 * 2.0))));
  c_1.w = tmpvar_3;
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D unity_Lightmap;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 clear_4;
  mediump vec4 burn_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_5 = tmpvar_7;
  highp float cse_8;
  cse_8 = (_Burn + _LineWidth);
  highp vec4 tmpvar_9;
  tmpvar_9 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_5.x - cse_8) + 0.99))
  ))));
  clear_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6.xyz, clear_4.xyz, vec3(max (0.0, float(
    int(((burn_5.x - _Burn) + 0.99))
  ))));
  tmpvar_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = mix (1.0, 0.0, float(int(
    ((burn_5.x - cse_8) + 0.99)
  )));
  tmpvar_3 = tmpvar_11;
  lowp float shadow_12;
  lowp float tmpvar_13;
  tmpvar_13 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  highp float tmpvar_14;
  tmpvar_14 = (_LightShadowData.x + (tmpvar_13 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_14;
  mediump vec3 lm_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_15 = tmpvar_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = vec3((shadow_12 * 2.0));
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_2 * min (lm_15, tmpvar_17));
  c_1.xyz = tmpvar_18;
  c_1.w = tmpvar_3;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp mat4 unity_World2Shadow[4];
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
out mediump vec4 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec4 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_2;
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = (unity_World2Shadow[0] * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _LightShadowData;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D unity_Lightmap;
in mediump vec4 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec4 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 clear_4;
  mediump vec4 burn_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_BurnMap, xlv_TEXCOORD0.zw);
  burn_5 = tmpvar_7;
  highp float cse_8;
  cse_8 = (_Burn + _LineWidth);
  highp vec4 tmpvar_9;
  tmpvar_9 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_5.x - cse_8) + 0.99))
  ))));
  clear_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6.xyz, clear_4.xyz, vec3(max (0.0, float(
    int(((burn_5.x - _Burn) + 0.99))
  ))));
  tmpvar_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = mix (1.0, 0.0, float(int(
    ((burn_5.x - cse_8) + 0.99)
  )));
  tmpvar_3 = tmpvar_11;
  lowp float shadow_12;
  mediump float tmpvar_13;
  tmpvar_13 = texture (_ShadowMapTexture, xlv_TEXCOORD2.xyz);
  lowp float tmpvar_14;
  tmpvar_14 = tmpvar_13;
  highp float tmpvar_15;
  tmpvar_15 = (_LightShadowData.x + (tmpvar_14 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_15;
  mediump vec3 lm_16;
  lowp vec3 tmpvar_17;
  tmpvar_17 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz);
  lm_16 = tmpvar_17;
  lowp vec3 tmpvar_18;
  tmpvar_18 = vec3((shadow_12 * 2.0));
  mediump vec3 tmpvar_19;
  tmpvar_19 = (tmpvar_2 * min (lm_16, tmpvar_18));
  c_1.xyz = tmpvar_19;
  c_1.w = tmpvar_3;
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
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  mediump vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.xy = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_2.zw = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
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
  shlight_1 = tmpvar_10;
  tmpvar_4 = shlight_1;
  highp vec4 cse_25;
  cse_25 = (_Object2World * _glesVertex);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosX0 - cse_25.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - cse_25.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - cse_25.z);
  highp vec4 tmpvar_29;
  tmpvar_29 = (((tmpvar_26 * tmpvar_26) + (tmpvar_27 * tmpvar_27)) + (tmpvar_28 * tmpvar_28));
  highp vec4 tmpvar_30;
  tmpvar_30 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_26 * tmpvar_8.x) + (tmpvar_27 * tmpvar_8.y)) + (tmpvar_28 * tmpvar_8.z))
   * 
    inversesqrt(tmpvar_29)
  )) * (1.0/((1.0 + 
    (tmpvar_29 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_4 + ((
    ((unity_LightColor[0].xyz * tmpvar_30.x) + (unity_LightColor[1].xyz * tmpvar_30.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_30.z)
  ) + (unity_LightColor[3].xyz * tmpvar_30.w)));
  tmpvar_4 = tmpvar_31;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_25);
}



#endif
#ifdef FRAGMENT

#extension GL_EXT_shadow_samplers : enable
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 clear_4;
  mediump vec4 burn_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_5 = tmpvar_7;
  highp float cse_8;
  cse_8 = (_Burn + _LineWidth);
  highp vec4 tmpvar_9;
  tmpvar_9 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_5.x - cse_8) + 0.99))
  ))));
  clear_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6.xyz, clear_4.xyz, vec3(max (0.0, float(
    int(((burn_5.x - _Burn) + 0.99))
  ))));
  tmpvar_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = mix (1.0, 0.0, float(int(
    ((burn_5.x - cse_8) + 0.99)
  )));
  tmpvar_3 = tmpvar_11;
  lowp float shadow_12;
  lowp float tmpvar_13;
  tmpvar_13 = shadow2DEXT (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  highp float tmpvar_14;
  tmpvar_14 = (_LightShadowData.x + (tmpvar_13 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_14;
  lowp vec4 c_15;
  c_15.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz))
   * shadow_12) * 2.0));
  c_15.w = tmpvar_3;
  c_1.w = c_15.w;
  c_1.xyz = (c_15.xyz + (tmpvar_2 * xlv_TEXCOORD2));
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_NATIVE" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "VERTEXLIGHT_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
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
uniform highp vec4 _BurnMap_ST;
out mediump vec4 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out lowp vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  highp vec3 shlight_1;
  mediump vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_2.xy = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_2.zw = tmpvar_6;
  highp mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_8;
  tmpvar_8 = (tmpvar_7 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_8;
  highp vec4 tmpvar_9;
  tmpvar_9.w = 1.0;
  tmpvar_9.xyz = tmpvar_8;
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
  shlight_1 = tmpvar_10;
  tmpvar_4 = shlight_1;
  highp vec4 cse_25;
  cse_25 = (_Object2World * _glesVertex);
  highp vec4 tmpvar_26;
  tmpvar_26 = (unity_4LightPosX0 - cse_25.x);
  highp vec4 tmpvar_27;
  tmpvar_27 = (unity_4LightPosY0 - cse_25.y);
  highp vec4 tmpvar_28;
  tmpvar_28 = (unity_4LightPosZ0 - cse_25.z);
  highp vec4 tmpvar_29;
  tmpvar_29 = (((tmpvar_26 * tmpvar_26) + (tmpvar_27 * tmpvar_27)) + (tmpvar_28 * tmpvar_28));
  highp vec4 tmpvar_30;
  tmpvar_30 = (max (vec4(0.0, 0.0, 0.0, 0.0), (
    (((tmpvar_26 * tmpvar_8.x) + (tmpvar_27 * tmpvar_8.y)) + (tmpvar_28 * tmpvar_8.z))
   * 
    inversesqrt(tmpvar_29)
  )) * (1.0/((1.0 + 
    (tmpvar_29 * unity_4LightAtten0)
  ))));
  highp vec3 tmpvar_31;
  tmpvar_31 = (tmpvar_4 + ((
    ((unity_LightColor[0].xyz * tmpvar_30.x) + (unity_LightColor[1].xyz * tmpvar_30.y))
   + 
    (unity_LightColor[2].xyz * tmpvar_30.z)
  ) + (unity_LightColor[3].xyz * tmpvar_30.w)));
  tmpvar_4 = tmpvar_31;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = tmpvar_3;
  xlv_TEXCOORD2 = tmpvar_4;
  xlv_TEXCOORD3 = (unity_World2Shadow[0] * cse_25);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _LightShadowData;
uniform lowp vec4 _LightColor0;
uniform lowp sampler2DShadow _ShadowMapTexture;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
in mediump vec4 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in lowp vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 tmpvar_2;
  lowp float tmpvar_3;
  mediump vec4 clear_4;
  mediump vec4 burn_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_BurnMap, xlv_TEXCOORD0.zw);
  burn_5 = tmpvar_7;
  highp float cse_8;
  cse_8 = (_Burn + _LineWidth);
  highp vec4 tmpvar_9;
  tmpvar_9 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_5.x - cse_8) + 0.99))
  ))));
  clear_4 = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = mix (tmpvar_6.xyz, clear_4.xyz, vec3(max (0.0, float(
    int(((burn_5.x - _Burn) + 0.99))
  ))));
  tmpvar_2 = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = mix (1.0, 0.0, float(int(
    ((burn_5.x - cse_8) + 0.99)
  )));
  tmpvar_3 = tmpvar_11;
  lowp float shadow_12;
  mediump float tmpvar_13;
  tmpvar_13 = texture (_ShadowMapTexture, xlv_TEXCOORD3.xyz);
  lowp float tmpvar_14;
  tmpvar_14 = tmpvar_13;
  highp float tmpvar_15;
  tmpvar_15 = (_LightShadowData.x + (tmpvar_14 * (1.0 - _LightShadowData.x)));
  shadow_12 = tmpvar_15;
  lowp vec4 c_16;
  c_16.xyz = ((tmpvar_2 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, _WorldSpaceLightPos0.xyz))
   * shadow_12) * 2.0));
  c_16.w = tmpvar_3;
  c_1.w = c_16.w;
  c_1.xyz = (c_16.xyz + (tmpvar_2 * xlv_TEXCOORD2));
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
  Tags { "LIGHTMODE"="ForwardAdd" "QUEUE"="Transparent" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
Program "vp" {
SubProgram "gles " {
Keywords { "POINT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  tmpvar_8 = (_WorldSpaceLightPos0.xyz - cse_9.xyz);
  tmpvar_3 = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * cse_9).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 clear_5;
  mediump vec4 burn_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_6 = tmpvar_8;
  highp float cse_9;
  cse_9 = (_Burn + _LineWidth);
  highp vec4 tmpvar_10;
  tmpvar_10 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_6.x - cse_9) + 0.99))
  ))));
  clear_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_7.xyz, clear_5.xyz, vec3(max (0.0, float(
    int(((burn_6.x - _Burn) + 0.99))
  ))));
  tmpvar_3 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = mix (1.0, 0.0, float(int(
    ((burn_6.x - cse_9) + 0.99)
  )));
  tmpvar_4 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_15;
  c_15.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * texture2D (_LightTexture0, vec2(tmpvar_14)).w) * 2.0));
  c_15.w = tmpvar_4;
  c_1.xyz = c_15.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
out mediump vec4 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  tmpvar_8 = (_WorldSpaceLightPos0.xyz - cse_9.xyz);
  tmpvar_3 = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * cse_9).xyz;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
in mediump vec4 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 clear_5;
  mediump vec4 burn_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_BurnMap, xlv_TEXCOORD0.zw);
  burn_6 = tmpvar_8;
  highp float cse_9;
  cse_9 = (_Burn + _LineWidth);
  highp vec4 tmpvar_10;
  tmpvar_10 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_6.x - cse_9) + 0.99))
  ))));
  clear_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_7.xyz, clear_5.xyz, vec3(max (0.0, float(
    int(((burn_6.x - _Burn) + 0.99))
  ))));
  tmpvar_3 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = mix (1.0, 0.0, float(int(
    ((burn_6.x - cse_9) + 0.99)
  )));
  tmpvar_4 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_15;
  c_15.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * texture (_LightTexture0, vec2(tmpvar_14)).w) * 2.0));
  c_15.w = tmpvar_4;
  c_1.xyz = c_15.xyz;
  c_1.w = 0.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  tmpvar_3 = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 clear_5;
  mediump vec4 burn_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_6 = tmpvar_8;
  highp float cse_9;
  cse_9 = (_Burn + _LineWidth);
  highp vec4 tmpvar_10;
  tmpvar_10 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_6.x - cse_9) + 0.99))
  ))));
  clear_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_7.xyz, clear_5.xyz, vec3(max (0.0, float(
    int(((burn_6.x - _Burn) + 0.99))
  ))));
  tmpvar_3 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = mix (1.0, 0.0, float(int(
    ((burn_6.x - cse_9) + 0.99)
  )));
  tmpvar_4 = tmpvar_12;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_13;
  c_13.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD1, lightDir_2)
  ) * 2.0));
  c_13.w = tmpvar_4;
  c_1.xyz = c_13.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
out mediump vec4 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  tmpvar_3 = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
in mediump vec4 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 clear_5;
  mediump vec4 burn_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_BurnMap, xlv_TEXCOORD0.zw);
  burn_6 = tmpvar_8;
  highp float cse_9;
  cse_9 = (_Burn + _LineWidth);
  highp vec4 tmpvar_10;
  tmpvar_10 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_6.x - cse_9) + 0.99))
  ))));
  clear_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_7.xyz, clear_5.xyz, vec3(max (0.0, float(
    int(((burn_6.x - _Burn) + 0.99))
  ))));
  tmpvar_3 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = mix (1.0, 0.0, float(int(
    ((burn_6.x - cse_9) + 0.99)
  )));
  tmpvar_4 = tmpvar_12;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_13;
  c_13.xyz = ((tmpvar_3 * _LightColor0.xyz) * (max (0.0, 
    dot (xlv_TEXCOORD1, lightDir_2)
  ) * 2.0));
  c_13.w = tmpvar_4;
  c_1.xyz = c_13.xyz;
  c_1.w = 0.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SPOT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  tmpvar_8 = (_WorldSpaceLightPos0.xyz - cse_9.xyz);
  tmpvar_3 = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * cse_9);
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 clear_5;
  mediump vec4 burn_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_6 = tmpvar_8;
  highp float cse_9;
  cse_9 = (_Burn + _LineWidth);
  highp vec4 tmpvar_10;
  tmpvar_10 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_6.x - cse_9) + 0.99))
  ))));
  clear_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_7.xyz, clear_5.xyz, vec3(max (0.0, float(
    int(((burn_6.x - _Burn) + 0.99))
  ))));
  tmpvar_3 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = mix (1.0, 0.0, float(int(
    ((burn_6.x - cse_9) + 0.99)
  )));
  tmpvar_4 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_16;
  atten_16 = ((float(
    (xlv_TEXCOORD3.z > 0.0)
  ) * texture2D (_LightTexture0, P_14).w) * texture2D (_LightTextureB0, vec2(tmpvar_15)).w);
  lowp vec4 c_17;
  c_17.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * atten_16) * 2.0));
  c_17.w = tmpvar_4;
  c_1.xyz = c_17.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SPOT" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
out mediump vec4 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  tmpvar_8 = (_WorldSpaceLightPos0.xyz - cse_9.xyz);
  tmpvar_3 = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * cse_9);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
in mediump vec4 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec4 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 clear_5;
  mediump vec4 burn_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_BurnMap, xlv_TEXCOORD0.zw);
  burn_6 = tmpvar_8;
  highp float cse_9;
  cse_9 = (_Burn + _LineWidth);
  highp vec4 tmpvar_10;
  tmpvar_10 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_6.x - cse_9) + 0.99))
  ))));
  clear_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_7.xyz, clear_5.xyz, vec3(max (0.0, float(
    int(((burn_6.x - _Burn) + 0.99))
  ))));
  tmpvar_3 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = mix (1.0, 0.0, float(int(
    ((burn_6.x - cse_9) + 0.99)
  )));
  tmpvar_4 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_13;
  highp vec2 P_14;
  P_14 = ((xlv_TEXCOORD3.xy / xlv_TEXCOORD3.w) + 0.5);
  highp float tmpvar_15;
  tmpvar_15 = dot (xlv_TEXCOORD3.xyz, xlv_TEXCOORD3.xyz);
  lowp float atten_16;
  atten_16 = ((float(
    (xlv_TEXCOORD3.z > 0.0)
  ) * texture (_LightTexture0, P_14).w) * texture (_LightTextureB0, vec2(tmpvar_15)).w);
  lowp vec4 c_17;
  c_17.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * atten_16) * 2.0));
  c_17.w = tmpvar_4;
  c_1.xyz = c_17.xyz;
  c_1.w = 0.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "POINT_COOKIE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  tmpvar_8 = (_WorldSpaceLightPos0.xyz - cse_9.xyz);
  tmpvar_3 = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * cse_9).xyz;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 clear_5;
  mediump vec4 burn_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_6 = tmpvar_8;
  highp float cse_9;
  cse_9 = (_Burn + _LineWidth);
  highp vec4 tmpvar_10;
  tmpvar_10 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_6.x - cse_9) + 0.99))
  ))));
  clear_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_7.xyz, clear_5.xyz, vec3(max (0.0, float(
    int(((burn_6.x - _Burn) + 0.99))
  ))));
  tmpvar_3 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = mix (1.0, 0.0, float(int(
    ((burn_6.x - cse_9) + 0.99)
  )));
  tmpvar_4 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_15;
  c_15.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * 
    (texture2D (_LightTextureB0, vec2(tmpvar_14)).w * textureCube (_LightTexture0, xlv_TEXCOORD3).w)
  ) * 2.0));
  c_15.w = tmpvar_4;
  c_1.xyz = c_15.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "POINT_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
out mediump vec4 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec3 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  highp vec4 cse_9;
  cse_9 = (_Object2World * _glesVertex);
  tmpvar_8 = (_WorldSpaceLightPos0.xyz - cse_9.xyz);
  tmpvar_3 = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * cse_9).xyz;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform lowp vec4 _LightColor0;
uniform lowp samplerCube _LightTexture0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
in mediump vec4 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec3 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 clear_5;
  mediump vec4 burn_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_BurnMap, xlv_TEXCOORD0.zw);
  burn_6 = tmpvar_8;
  highp float cse_9;
  cse_9 = (_Burn + _LineWidth);
  highp vec4 tmpvar_10;
  tmpvar_10 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_6.x - cse_9) + 0.99))
  ))));
  clear_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_7.xyz, clear_5.xyz, vec3(max (0.0, float(
    int(((burn_6.x - _Burn) + 0.99))
  ))));
  tmpvar_3 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = mix (1.0, 0.0, float(int(
    ((burn_6.x - cse_9) + 0.99)
  )));
  tmpvar_4 = tmpvar_12;
  mediump vec3 tmpvar_13;
  tmpvar_13 = normalize(xlv_TEXCOORD2);
  lightDir_2 = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (xlv_TEXCOORD3, xlv_TEXCOORD3);
  lowp vec4 c_15;
  c_15.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * 
    (texture (_LightTextureB0, vec2(tmpvar_14)).w * texture (_LightTexture0, xlv_TEXCOORD3).w)
  ) * 2.0));
  c_15.w = tmpvar_4;
  c_1.xyz = c_15.xyz;
  c_1.w = 0.0;
  _glesFragData[0] = c_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  tmpvar_3 = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

uniform lowp vec4 _LightColor0;
uniform sampler2D _LightTexture0;
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
varying mediump vec4 xlv_TEXCOORD0;
varying lowp vec3 xlv_TEXCOORD1;
varying mediump vec3 xlv_TEXCOORD2;
varying highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 clear_5;
  mediump vec4 burn_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_6 = tmpvar_8;
  highp float cse_9;
  cse_9 = (_Burn + _LineWidth);
  highp vec4 tmpvar_10;
  tmpvar_10 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_6.x - cse_9) + 0.99))
  ))));
  clear_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_7.xyz, clear_5.xyz, vec3(max (0.0, float(
    int(((burn_6.x - _Burn) + 0.99))
  ))));
  tmpvar_3 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = mix (1.0, 0.0, float(int(
    ((burn_6.x - cse_9) + 0.99)
  )));
  tmpvar_4 = tmpvar_12;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_13;
  c_13.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * texture2D (_LightTexture0, xlv_TEXCOORD3).w) * 2.0));
  c_13.w = tmpvar_4;
  c_1.xyz = c_13.xyz;
  c_1.w = 0.0;
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
out mediump vec4 xlv_TEXCOORD0;
out lowp vec3 xlv_TEXCOORD1;
out mediump vec3 xlv_TEXCOORD2;
out highp vec2 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec3 tmpvar_2;
  mediump vec3 tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_5;
  highp mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_2 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = _WorldSpaceLightPos0.xyz;
  tmpvar_3 = tmpvar_8;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
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
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
in mediump vec4 xlv_TEXCOORD0;
in lowp vec3 xlv_TEXCOORD1;
in mediump vec3 xlv_TEXCOORD2;
in highp vec2 xlv_TEXCOORD3;
void main ()
{
  lowp vec4 c_1;
  lowp vec3 lightDir_2;
  lowp vec3 tmpvar_3;
  lowp float tmpvar_4;
  mediump vec4 clear_5;
  mediump vec4 burn_6;
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_BurnMap, xlv_TEXCOORD0.zw);
  burn_6 = tmpvar_8;
  highp float cse_9;
  cse_9 = (_Burn + _LineWidth);
  highp vec4 tmpvar_10;
  tmpvar_10 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_6.x - cse_9) + 0.99))
  ))));
  clear_5 = tmpvar_10;
  highp vec3 tmpvar_11;
  tmpvar_11 = mix (tmpvar_7.xyz, clear_5.xyz, vec3(max (0.0, float(
    int(((burn_6.x - _Burn) + 0.99))
  ))));
  tmpvar_3 = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = mix (1.0, 0.0, float(int(
    ((burn_6.x - cse_9) + 0.99)
  )));
  tmpvar_4 = tmpvar_12;
  lightDir_2 = xlv_TEXCOORD2;
  lowp vec4 c_13;
  c_13.xyz = ((tmpvar_3 * _LightColor0.xyz) * ((
    max (0.0, dot (xlv_TEXCOORD1, lightDir_2))
   * texture (_LightTexture0, xlv_TEXCOORD3).w) * 2.0));
  c_13.w = tmpvar_4;
  c_1.xyz = c_13.xyz;
  c_1.w = 0.0;
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
  Tags { "LIGHTMODE"="PrePassBase" "QUEUE"="Transparent" }
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
varying lowp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  res_1.xyz = ((xlv_TEXCOORD0 * 0.5) + 0.5);
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
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_Scale;
out lowp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec3 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize(_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
in lowp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res_1;
  res_1.xyz = ((xlv_TEXCOORD0 * 0.5) + 0.5);
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
  Tags { "LIGHTMODE"="PrePassFinal" "QUEUE"="Transparent" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
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
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_5;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (tmpvar_9 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_11;
  mediump vec4 normal_12;
  normal_12 = tmpvar_10;
  highp float vC_13;
  mediump vec3 x3_14;
  mediump vec3 x2_15;
  mediump vec3 x1_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAr, normal_12);
  x1_16.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHAg, normal_12);
  x1_16.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHAb, normal_12);
  x1_16.z = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_12.xyzz * normal_12.yzzx);
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBr, tmpvar_20);
  x2_15.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHBg, tmpvar_20);
  x2_15.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHBb, tmpvar_20);
  x2_15.z = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y));
  vC_13 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_SHC.xyz * vC_13);
  x3_14 = tmpvar_25;
  tmpvar_11 = ((x1_16 + x2_15) + x3_14);
  tmpvar_2 = tmpvar_11;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = o_6;
  xlv_TEXCOORD2 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D _LightBuffer;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 clear_6;
  mediump vec4 burn_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_7 = tmpvar_9;
  highp float cse_10;
  cse_10 = (_Burn + _LineWidth);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_7.x - cse_10) + 0.99))
  ))));
  clear_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_8.xyz, clear_6.xyz, vec3(max (0.0, float(
    int(((burn_7.x - _Burn) + 0.99))
  ))));
  tmpvar_4 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, 0.0, float(int(
    ((burn_7.x - cse_10) + 0.99)
  )));
  tmpvar_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_15.w;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_16;
  lowp vec4 c_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_4 * light_3.xyz);
  c_17.xyz = tmpvar_18;
  c_17.w = tmpvar_5;
  c_2 = c_17;
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
uniform highp vec4 _BurnMap_ST;
out mediump vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_5;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (tmpvar_9 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_11;
  mediump vec4 normal_12;
  normal_12 = tmpvar_10;
  highp float vC_13;
  mediump vec3 x3_14;
  mediump vec3 x2_15;
  mediump vec3 x1_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAr, normal_12);
  x1_16.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHAg, normal_12);
  x1_16.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHAb, normal_12);
  x1_16.z = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_12.xyzz * normal_12.yzzx);
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBr, tmpvar_20);
  x2_15.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHBg, tmpvar_20);
  x2_15.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHBb, tmpvar_20);
  x2_15.z = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y));
  vC_13 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_SHC.xyz * vC_13);
  x3_14 = tmpvar_25;
  tmpvar_11 = ((x1_16 + x2_15) + x3_14);
  tmpvar_2 = tmpvar_11;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = o_6;
  xlv_TEXCOORD2 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D _LightBuffer;
in mediump vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 clear_6;
  mediump vec4 burn_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_BurnMap, xlv_TEXCOORD0.zw);
  burn_7 = tmpvar_9;
  highp float cse_10;
  cse_10 = (_Burn + _LineWidth);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_7.x - cse_10) + 0.99))
  ))));
  clear_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_8.xyz, clear_6.xyz, vec3(max (0.0, float(
    int(((burn_7.x - _Burn) + 0.99))
  ))));
  tmpvar_4 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, 0.0, float(int(
    ((burn_7.x - cse_10) + 0.99)
  )));
  tmpvar_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = -(log2(max (light_3, vec4(0.001, 0.001, 0.001, 0.001))));
  light_3.w = tmpvar_15.w;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_16;
  lowp vec4 c_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_4 * light_3.xyz);
  c_17.xyz = tmpvar_18;
  c_17.w = tmpvar_5;
  c_2 = c_17;
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_5;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_2.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = o_6;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
varying mediump vec4 xlv_TEXCOORD0;
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
  lowp vec3 tmpvar_7;
  lowp float tmpvar_8;
  mediump vec4 clear_9;
  mediump vec4 burn_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_10 = tmpvar_12;
  highp float cse_13;
  cse_13 = (_Burn + _LineWidth);
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_10.x - cse_13) + 0.99))
  ))));
  clear_9 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = mix (tmpvar_11.xyz, clear_9.xyz, vec3(max (0.0, float(
    int(((burn_10.x - _Burn) + 0.99))
  ))));
  tmpvar_7 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = mix (1.0, 0.0, float(int(
    ((burn_10.x - cse_13) + 0.99)
  )));
  tmpvar_8 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_18.w;
  highp float tmpvar_19;
  tmpvar_19 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_21;
  light_6.xyz = (tmpvar_18.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_7 * light_6.xyz);
  c_22.xyz = tmpvar_23;
  c_22.w = tmpvar_8;
  c_2 = c_22;
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
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
out mediump vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_5;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_2.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = o_6;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
in mediump vec4 xlv_TEXCOORD0;
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
  lowp vec3 tmpvar_7;
  lowp float tmpvar_8;
  mediump vec4 clear_9;
  mediump vec4 burn_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture (_BurnMap, xlv_TEXCOORD0.zw);
  burn_10 = tmpvar_12;
  highp float cse_13;
  cse_13 = (_Burn + _LineWidth);
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_10.x - cse_13) + 0.99))
  ))));
  clear_9 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = mix (tmpvar_11.xyz, clear_9.xyz, vec3(max (0.0, float(
    int(((burn_10.x - _Burn) + 0.99))
  ))));
  tmpvar_7 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = mix (1.0, 0.0, float(int(
    ((burn_10.x - cse_13) + 0.99)
  )));
  tmpvar_8 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = -(log2(max (light_6, vec4(0.001, 0.001, 0.001, 0.001))));
  light_6.w = tmpvar_18.w;
  highp float tmpvar_19;
  tmpvar_19 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_21;
  light_6.xyz = (tmpvar_18.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_7 * light_6.xyz);
  c_22.xyz = tmpvar_23;
  c_22.w = tmpvar_8;
  c_2 = c_22;
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_4;
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 clear_6;
  mediump vec4 burn_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_7 = tmpvar_9;
  highp float cse_10;
  cse_10 = (_Burn + _LineWidth);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_7.x - cse_10) + 0.99))
  ))));
  clear_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_8.xyz, clear_6.xyz, vec3(max (0.0, float(
    int(((burn_7.x - _Burn) + 0.99))
  ))));
  tmpvar_4 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, 0.0, float(int(
    ((burn_7.x - cse_10) + 0.99)
  )));
  tmpvar_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_14;
  mediump vec3 lm_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_15 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = lm_15;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (-(log2(
    max (light_3, vec4(0.001, 0.001, 0.001, 0.001))
  )) + tmpvar_17);
  light_3 = tmpvar_18;
  lowp vec4 c_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_4 * tmpvar_18.xyz);
  c_19.xyz = tmpvar_20;
  c_19.w = tmpvar_5;
  c_2 = c_19;
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
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
out mediump vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_4;
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
in mediump vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 clear_6;
  mediump vec4 burn_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_BurnMap, xlv_TEXCOORD0.zw);
  burn_7 = tmpvar_9;
  highp float cse_10;
  cse_10 = (_Burn + _LineWidth);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_7.x - cse_10) + 0.99))
  ))));
  clear_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_8.xyz, clear_6.xyz, vec3(max (0.0, float(
    int(((burn_7.x - _Burn) + 0.99))
  ))));
  tmpvar_4 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, 0.0, float(int(
    ((burn_7.x - cse_10) + 0.99)
  )));
  tmpvar_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_14;
  mediump vec3 lm_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_15 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = lm_15;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (-(log2(
    max (light_3, vec4(0.001, 0.001, 0.001, 0.001))
  )) + tmpvar_17);
  light_3 = tmpvar_18;
  lowp vec4 c_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_4 * tmpvar_18.xyz);
  c_19.xyz = tmpvar_20;
  c_19.w = tmpvar_5;
  c_2 = c_19;
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
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_5;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (tmpvar_9 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_11;
  mediump vec4 normal_12;
  normal_12 = tmpvar_10;
  highp float vC_13;
  mediump vec3 x3_14;
  mediump vec3 x2_15;
  mediump vec3 x1_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAr, normal_12);
  x1_16.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHAg, normal_12);
  x1_16.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHAb, normal_12);
  x1_16.z = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_12.xyzz * normal_12.yzzx);
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBr, tmpvar_20);
  x2_15.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHBg, tmpvar_20);
  x2_15.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHBb, tmpvar_20);
  x2_15.z = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y));
  vC_13 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_SHC.xyz * vC_13);
  x3_14 = tmpvar_25;
  tmpvar_11 = ((x1_16 + x2_15) + x3_14);
  tmpvar_2 = tmpvar_11;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = o_6;
  xlv_TEXCOORD2 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D _LightBuffer;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 clear_6;
  mediump vec4 burn_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_7 = tmpvar_9;
  highp float cse_10;
  cse_10 = (_Burn + _LineWidth);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_7.x - cse_10) + 0.99))
  ))));
  clear_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_8.xyz, clear_6.xyz, vec3(max (0.0, float(
    int(((burn_7.x - _Burn) + 0.99))
  ))));
  tmpvar_4 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, 0.0, float(int(
    ((burn_7.x - cse_10) + 0.99)
  )));
  tmpvar_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_15.w;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_16;
  lowp vec4 c_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_4 * light_3.xyz);
  c_17.xyz = tmpvar_18;
  c_17.w = tmpvar_5;
  c_2 = c_17;
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
uniform highp vec4 _BurnMap_ST;
out mediump vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec3 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_5;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  highp mat3 tmpvar_9;
  tmpvar_9[0] = _Object2World[0].xyz;
  tmpvar_9[1] = _Object2World[1].xyz;
  tmpvar_9[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_10;
  tmpvar_10.w = 1.0;
  tmpvar_10.xyz = (tmpvar_9 * (normalize(_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_11;
  mediump vec4 normal_12;
  normal_12 = tmpvar_10;
  highp float vC_13;
  mediump vec3 x3_14;
  mediump vec3 x2_15;
  mediump vec3 x1_16;
  highp float tmpvar_17;
  tmpvar_17 = dot (unity_SHAr, normal_12);
  x1_16.x = tmpvar_17;
  highp float tmpvar_18;
  tmpvar_18 = dot (unity_SHAg, normal_12);
  x1_16.y = tmpvar_18;
  highp float tmpvar_19;
  tmpvar_19 = dot (unity_SHAb, normal_12);
  x1_16.z = tmpvar_19;
  mediump vec4 tmpvar_20;
  tmpvar_20 = (normal_12.xyzz * normal_12.yzzx);
  highp float tmpvar_21;
  tmpvar_21 = dot (unity_SHBr, tmpvar_20);
  x2_15.x = tmpvar_21;
  highp float tmpvar_22;
  tmpvar_22 = dot (unity_SHBg, tmpvar_20);
  x2_15.y = tmpvar_22;
  highp float tmpvar_23;
  tmpvar_23 = dot (unity_SHBb, tmpvar_20);
  x2_15.z = tmpvar_23;
  mediump float tmpvar_24;
  tmpvar_24 = ((normal_12.x * normal_12.x) - (normal_12.y * normal_12.y));
  vC_13 = tmpvar_24;
  highp vec3 tmpvar_25;
  tmpvar_25 = (unity_SHC.xyz * vC_13);
  x3_14 = tmpvar_25;
  tmpvar_11 = ((x1_16 + x2_15) + x3_14);
  tmpvar_2 = tmpvar_11;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = o_6;
  xlv_TEXCOORD2 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D _LightBuffer;
in mediump vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 clear_6;
  mediump vec4 burn_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_BurnMap, xlv_TEXCOORD0.zw);
  burn_7 = tmpvar_9;
  highp float cse_10;
  cse_10 = (_Burn + _LineWidth);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_7.x - cse_10) + 0.99))
  ))));
  clear_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_8.xyz, clear_6.xyz, vec3(max (0.0, float(
    int(((burn_7.x - _Burn) + 0.99))
  ))));
  tmpvar_4 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, 0.0, float(int(
    ((burn_7.x - cse_10) + 0.99)
  )));
  tmpvar_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_14;
  mediump vec4 tmpvar_15;
  tmpvar_15 = max (light_3, vec4(0.001, 0.001, 0.001, 0.001));
  light_3.w = tmpvar_15.w;
  highp vec3 tmpvar_16;
  tmpvar_16 = (tmpvar_15.xyz + xlv_TEXCOORD2);
  light_3.xyz = tmpvar_16;
  lowp vec4 c_17;
  mediump vec3 tmpvar_18;
  tmpvar_18 = (tmpvar_4 * light_3.xyz);
  c_17.xyz = tmpvar_18;
  c_17.w = tmpvar_5;
  c_2 = c_17;
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_5;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_2.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = o_6;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
varying mediump vec4 xlv_TEXCOORD0;
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
  lowp vec3 tmpvar_7;
  lowp float tmpvar_8;
  mediump vec4 clear_9;
  mediump vec4 burn_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_10 = tmpvar_12;
  highp float cse_13;
  cse_13 = (_Burn + _LineWidth);
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_10.x - cse_13) + 0.99))
  ))));
  clear_9 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = mix (tmpvar_11.xyz, clear_9.xyz, vec3(max (0.0, float(
    int(((burn_10.x - _Burn) + 0.99))
  ))));
  tmpvar_7 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = mix (1.0, 0.0, float(int(
    ((burn_10.x - cse_13) + 0.99)
  )));
  tmpvar_8 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_18.w;
  highp float tmpvar_19;
  tmpvar_19 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = (2.0 * texture2D (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_21;
  light_6.xyz = (tmpvar_18.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_7 * light_6.xyz);
  c_22.xyz = tmpvar_23;
  c_22.w = tmpvar_8;
  c_2 = c_22;
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
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
out mediump vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
out highp vec4 xlv_TEXCOORD3;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_5;
  highp vec4 o_6;
  highp vec4 tmpvar_7;
  tmpvar_7 = (tmpvar_3 * 0.5);
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_7.x;
  tmpvar_8.y = (tmpvar_7.y * _ProjectionParams.x);
  o_6.xy = (tmpvar_8 + tmpvar_7.w);
  o_6.zw = tmpvar_3.zw;
  tmpvar_2.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_2.w = (-((glstate_matrix_modelview0 * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = o_6;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
in mediump vec4 xlv_TEXCOORD0;
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
  lowp vec3 tmpvar_7;
  lowp float tmpvar_8;
  mediump vec4 clear_9;
  mediump vec4 burn_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture (_BurnMap, xlv_TEXCOORD0.zw);
  burn_10 = tmpvar_12;
  highp float cse_13;
  cse_13 = (_Burn + _LineWidth);
  highp vec4 tmpvar_14;
  tmpvar_14 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_10.x - cse_13) + 0.99))
  ))));
  clear_9 = tmpvar_14;
  highp vec3 tmpvar_15;
  tmpvar_15 = mix (tmpvar_11.xyz, clear_9.xyz, vec3(max (0.0, float(
    int(((burn_10.x - _Burn) + 0.99))
  ))));
  tmpvar_7 = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = mix (1.0, 0.0, float(int(
    ((burn_10.x - cse_13) + 0.99)
  )));
  tmpvar_8 = tmpvar_16;
  lowp vec4 tmpvar_17;
  tmpvar_17 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_6 = tmpvar_17;
  mediump vec4 tmpvar_18;
  tmpvar_18 = max (light_6, vec4(0.001, 0.001, 0.001, 0.001));
  light_6.w = tmpvar_18.w;
  highp float tmpvar_19;
  tmpvar_19 = ((sqrt(
    dot (xlv_TEXCOORD3, xlv_TEXCOORD3)
  ) * unity_LightmapFade.z) + unity_LightmapFade.w);
  lmFade_5 = tmpvar_19;
  lowp vec3 tmpvar_20;
  tmpvar_20 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lmFull_4 = tmpvar_20;
  lowp vec3 tmpvar_21;
  tmpvar_21 = (2.0 * texture (unity_LightmapInd, xlv_TEXCOORD2).xyz);
  lmIndirect_3 = tmpvar_21;
  light_6.xyz = (tmpvar_18.xyz + mix (lmIndirect_3, lmFull_4, vec3(clamp (lmFade_5, 0.0, 1.0))));
  lowp vec4 c_22;
  mediump vec3 tmpvar_23;
  tmpvar_23 = (tmpvar_7 * light_6.xyz);
  c_22.xyz = tmpvar_23;
  c_22.w = tmpvar_8;
  c_2 = c_22;
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
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_4;
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
varying mediump vec4 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 clear_6;
  mediump vec4 burn_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (_BurnMap, xlv_TEXCOORD0.zw);
  burn_7 = tmpvar_9;
  highp float cse_10;
  cse_10 = (_Burn + _LineWidth);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_7.x - cse_10) + 0.99))
  ))));
  clear_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_8.xyz, clear_6.xyz, vec3(max (0.0, float(
    int(((burn_7.x - _Burn) + 0.99))
  ))));
  tmpvar_4 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, 0.0, float(int(
    ((burn_7.x - cse_10) + 0.99)
  )));
  tmpvar_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2DProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_14;
  mediump vec3 lm_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_15 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = lm_15;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_17);
  light_3 = tmpvar_18;
  lowp vec4 c_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_4 * tmpvar_18.xyz);
  c_19.xyz = tmpvar_20;
  c_19.w = tmpvar_5;
  c_2 = c_19;
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
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 unity_LightmapST;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _BurnMap_ST;
out mediump vec4 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec2 tmpvar_3;
  tmpvar_3 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  tmpvar_1.xy = tmpvar_3;
  highp vec2 tmpvar_4;
  tmpvar_4 = ((_glesMultiTexCoord0.xy * _BurnMap_ST.xy) + _BurnMap_ST.zw);
  tmpvar_1.zw = tmpvar_4;
  highp vec4 o_5;
  highp vec4 tmpvar_6;
  tmpvar_6 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_7;
  tmpvar_7.x = tmpvar_6.x;
  tmpvar_7.y = (tmpvar_6.y * _ProjectionParams.x);
  o_5.xy = (tmpvar_7 + tmpvar_6.w);
  o_5.zw = tmpvar_2.zw;
  gl_Position = tmpvar_2;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = o_5;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _BurnMap;
uniform highp vec4 _BurnColor;
uniform highp float _LineWidth;
uniform highp float _Burn;
uniform sampler2D _LightBuffer;
uniform sampler2D unity_Lightmap;
in mediump vec4 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c_2;
  mediump vec4 light_3;
  lowp vec3 tmpvar_4;
  lowp float tmpvar_5;
  mediump vec4 clear_6;
  mediump vec4 burn_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MainTex, xlv_TEXCOORD0.xy);
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture (_BurnMap, xlv_TEXCOORD0.zw);
  burn_7 = tmpvar_9;
  highp float cse_10;
  cse_10 = (_Burn + _LineWidth);
  highp vec4 tmpvar_11;
  tmpvar_11 = mix (_BurnColor, vec4(0.0, 0.0, 0.0, 0.0), vec4(max (0.0, float(
    int(((burn_7.x - cse_10) + 0.99))
  ))));
  clear_6 = tmpvar_11;
  highp vec3 tmpvar_12;
  tmpvar_12 = mix (tmpvar_8.xyz, clear_6.xyz, vec3(max (0.0, float(
    int(((burn_7.x - _Burn) + 0.99))
  ))));
  tmpvar_4 = tmpvar_12;
  highp float tmpvar_13;
  tmpvar_13 = mix (1.0, 0.0, float(int(
    ((burn_7.x - cse_10) + 0.99)
  )));
  tmpvar_5 = tmpvar_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = textureProj (_LightBuffer, xlv_TEXCOORD1);
  light_3 = tmpvar_14;
  mediump vec3 lm_15;
  lowp vec3 tmpvar_16;
  tmpvar_16 = (2.0 * texture (unity_Lightmap, xlv_TEXCOORD2).xyz);
  lm_15 = tmpvar_16;
  mediump vec4 tmpvar_17;
  tmpvar_17.w = 0.0;
  tmpvar_17.xyz = lm_15;
  mediump vec4 tmpvar_18;
  tmpvar_18 = (max (light_3, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_17);
  light_3 = tmpvar_18;
  lowp vec4 c_19;
  mediump vec3 tmpvar_20;
  tmpvar_20 = (tmpvar_4 * tmpvar_18.xyz);
  c_19.xyz = tmpvar_20;
  c_19.w = tmpvar_5;
  c_2 = c_19;
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
Fallback "VertexLit"
}