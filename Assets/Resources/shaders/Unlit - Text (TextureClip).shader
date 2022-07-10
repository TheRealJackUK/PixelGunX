Shader "Hidden/Unlit/Text (TextureClip)" {
Properties {
 _MainTex ("Alpha (A)", 2D) = "white" {}
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
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
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (((
    (_glesVertex.xy * _ClipRange0.zw)
   + _ClipRange0.xy) * 0.5) + vec2(0.5, 0.5));
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _ClipTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 col_1;
  col_1.xyz = xlv_COLOR.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_ClipTex, xlv_TEXCOORD1);
  col_1.w = (xlv_COLOR.w * (tmpvar_2.w * tmpvar_3.w));
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
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out mediump vec4 xlv_COLOR;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0.xy;
  xlv_TEXCOORD1 = (((
    (_glesVertex.xy * _ClipRange0.zw)
   + _ClipRange0.xy) * 0.5) + vec2(0.5, 0.5));
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _ClipTex;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in mediump vec4 xlv_COLOR;
void main ()
{
  mediump vec4 col_1;
  col_1.xyz = xlv_COLOR.xyz;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_ClipTex, xlv_TEXCOORD1);
  col_1.w = (xlv_COLOR.w * (tmpvar_2.w * tmpvar_3.w));
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
Fallback "Unlit/Text"
}