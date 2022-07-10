Shader "Hidden/Unlit/Premultiplied Colored 2" {
Properties {
 _MainTex ("Base (RGB), Alpha (A)", 2D) = "black" {}
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend One OneMinusSrcAlpha
  ColorMask RGB
  Offset -1, -1
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ClipRange0;
uniform highp vec4 _ClipRange1;
uniform highp vec4 _ClipArgs1;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = ((_glesVertex.xy * _ClipRange0.zw) + _ClipRange0.xy);
  highp vec2 ret_2;
  ret_2.x = ((_glesVertex.x * _ClipArgs1.w) - (_glesVertex.y * _ClipArgs1.z));
  ret_2.y = ((_glesVertex.x * _ClipArgs1.z) + (_glesVertex.y * _ClipArgs1.w));
  tmpvar_1.zw = ((ret_2 * _ClipRange1.zw) + _ClipRange1.xy);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp vec4 _ClipArgs0;
uniform highp vec4 _ClipArgs1;
varying mediump vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD1.xy)) * _ClipArgs0.xy);
  highp vec2 tmpvar_3;
  tmpvar_3 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD1.zw)) * _ClipArgs1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * xlv_COLOR);
  highp float tmpvar_6;
  tmpvar_6 = clamp (min (min (tmpvar_2.x, tmpvar_2.y), min (tmpvar_3.x, tmpvar_3.y)), 0.0, 1.0);
  highp float tmpvar_7;
  tmpvar_7 = (tmpvar_5.w * tmpvar_6);
  col_1.w = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (vec3(0.0, 0.0, 0.0), tmpvar_5.xyz, vec3(tmpvar_6));
  col_1.xyz = tmpvar_8;
  gl_FragData[0] = col_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _ClipRange0;
uniform highp vec4 _ClipRange1;
uniform highp vec4 _ClipArgs1;
out mediump vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1.xy = ((_glesVertex.xy * _ClipRange0.zw) + _ClipRange0.xy);
  highp vec2 ret_2;
  ret_2.x = ((_glesVertex.x * _ClipArgs1.w) - (_glesVertex.y * _ClipArgs1.z));
  ret_2.y = ((_glesVertex.x * _ClipArgs1.z) + (_glesVertex.y * _ClipArgs1.w));
  tmpvar_1.zw = ((ret_2 * _ClipRange1.zw) + _ClipRange1.xy);
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp vec4 _ClipArgs0;
uniform highp vec4 _ClipArgs1;
in mediump vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 col_1;
  highp vec2 tmpvar_2;
  tmpvar_2 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD1.xy)) * _ClipArgs0.xy);
  highp vec2 tmpvar_3;
  tmpvar_3 = ((vec2(1.0, 1.0) - abs(xlv_TEXCOORD1.zw)) * _ClipArgs1.xy);
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD0);
  mediump vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * xlv_COLOR);
  highp float tmpvar_6;
  tmpvar_6 = clamp (min (min (tmpvar_2.x, tmpvar_2.y), min (tmpvar_3.x, tmpvar_3.y)), 0.0, 1.0);
  highp float tmpvar_7;
  tmpvar_7 = (tmpvar_5.w * tmpvar_6);
  col_1.w = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = mix (vec3(0.0, 0.0, 0.0), tmpvar_5.xyz, vec3(tmpvar_6));
  col_1.xyz = tmpvar_8;
  _glesFragData[0] = col_1;
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
Fallback "Unlit/Premultiplied Colored"
}