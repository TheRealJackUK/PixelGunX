Shader "MADFINGER/Environment/Cube env map (Supports Lightmap)" {
Properties {
 _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
 _EnvTex ("Cube env tex", CUBE) = "black" {}
 _Spread ("Spread", Range(0.1,0.5)) = 0.5
}
SubShader { 
 LOD 100
 Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
 Pass {
  Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec3 _glesNormal;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  highp vec3 I_5;
  I_5 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_4 = (I_5 - (2.0 * (
    dot (tmpvar_3, I_5)
   * tmpvar_3)));
  tmpvar_1.yz = tmpvar_4.yz;
  tmpvar_1.x = -(tmpvar_4.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
uniform sampler2D unity_Lightmap;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD1).xyz));
  c_1.xyz = (c_1.xyz + (textureCube (_EnvTex, xlv_TEXCOORD2) * tmpvar_2.w).xyz);
  gl_FragData[0] = c_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec3 _glesNormal;
in vec4 _glesMultiTexCoord0;
in vec4 _glesMultiTexCoord1;
uniform highp vec3 _WorldSpaceCameraPos;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 _Object2World;
uniform highp vec4 unity_LightmapST;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec3 xlv_TEXCOORD2;
void main ()
{
  highp vec3 tmpvar_1;
  highp mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * normalize(_glesNormal));
  highp vec3 tmpvar_4;
  highp vec3 I_5;
  I_5 = ((_Object2World * _glesVertex).xyz - _WorldSpaceCameraPos);
  tmpvar_4 = (I_5 - (2.0 * (
    dot (tmpvar_3, I_5)
   * tmpvar_3)));
  tmpvar_1.yz = tmpvar_4.yz;
  tmpvar_1.x = -(tmpvar_4.x);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD2 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform lowp samplerCube _EnvTex;
uniform sampler2D unity_Lightmap;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec3 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 c_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  c_1.w = tmpvar_2.w;
  c_1.xyz = (tmpvar_2.xyz * (2.0 * texture (unity_Lightmap, xlv_TEXCOORD1).xyz));
  c_1.xyz = (c_1.xyz + (texture (_EnvTex, xlv_TEXCOORD2) * tmpvar_2.w).xyz);
  _glesFragData[0] = c_1;
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