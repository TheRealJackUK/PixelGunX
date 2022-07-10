Shader "Hidden/Noise Shader RGB" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _GrainTex ("Base (RGB)", 2D) = "gray" {}
 _ScratchTex ("Base (RGB)", 2D) = "gray" {}
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
uniform highp mat4 glstate_matrix_texture0;
uniform highp vec4 _GrainOffsetScale;
uniform highp vec4 _ScratchOffsetScale;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 inUV_2;
  inUV_2 = tmpvar_1;
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = inUV_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (glstate_matrix_texture0 * tmpvar_3).xy;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GrainOffsetScale.zw) + _GrainOffsetScale.xy);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _ScratchOffsetScale.zw) + _ScratchOffsetScale.xy);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _GrainTex;
uniform sampler2D _ScratchTex;
uniform lowp vec4 _Intensity;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  col_1.w = tmpvar_2.w;
  col_1.xyz = (tmpvar_2.xyz + ((
    (texture2D (_GrainTex, xlv_TEXCOORD1).xyz * 2.0)
   - 1.0) * _Intensity.x));
  col_1.xyz = (col_1.xyz + ((
    (texture2D (_ScratchTex, xlv_TEXCOORD2).xyz * 2.0)
   - 1.0) * _Intensity.y));
  gl_FragData[0] = col_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_texture0;
uniform highp vec4 _GrainOffsetScale;
uniform highp vec4 _ScratchOffsetScale;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  highp vec2 inUV_2;
  inUV_2 = tmpvar_1;
  highp vec4 tmpvar_3;
  tmpvar_3.zw = vec2(0.0, 0.0);
  tmpvar_3.xy = inUV_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = (glstate_matrix_texture0 * tmpvar_3).xy;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GrainOffsetScale.zw) + _GrainOffsetScale.xy);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _ScratchOffsetScale.zw) + _ScratchOffsetScale.xy);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _GrainTex;
uniform sampler2D _ScratchTex;
uniform lowp vec4 _Intensity;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 col_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  col_1.w = tmpvar_2.w;
  col_1.xyz = (tmpvar_2.xyz + ((
    (texture (_GrainTex, xlv_TEXCOORD1).xyz * 2.0)
   - 1.0) * _Intensity.x));
  col_1.xyz = (col_1.xyz + ((
    (texture (_ScratchTex, xlv_TEXCOORD2).xyz * 2.0)
   - 1.0) * _Intensity.y));
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
Fallback Off
}