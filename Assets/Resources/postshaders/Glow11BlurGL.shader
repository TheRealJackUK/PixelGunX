Shader "Hidden/Glow 11/Blur GL" {
Properties {
 _MainTex ("", 2D) = "" {}
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  ColorMask RGB
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesMultiTexCoord2;
attribute vec4 _glesMultiTexCoord4;
attribute vec4 _glesMultiTexCoord6;
uniform highp mat4 glstate_matrix_mvp;
attribute mediump vec4 xlat_attrib_TEXCOORD;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD0_3;
varying mediump vec4 xlv_TEXCOORD0_4;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = _glesMultiTexCoord0;
  xlv_TEXCOORD0_1 = _glesMultiTexCoord2;
  xlv_TEXCOORD0_2 = _glesMultiTexCoord4;
  xlv_TEXCOORD0_3 = _glesMultiTexCoord6;
  xlv_TEXCOORD0_4 = xlat_attrib_TEXCOORD;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
varying mediump vec4 xlv_TEXCOORD0;
varying mediump vec4 xlv_TEXCOORD0_1;
varying mediump vec4 xlv_TEXCOORD0_2;
varying mediump vec4 xlv_TEXCOORD0_3;
varying mediump vec4 xlv_TEXCOORD0_4;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (((texture2D (_MainTex, xlv_TEXCOORD0.xy) * 0.227027) + (
    (texture2D (_MainTex, xlv_TEXCOORD0_1.xy) + texture2D (_MainTex, xlv_TEXCOORD0_2.xy))
   * 0.316216)) + ((texture2D (_MainTex, xlv_TEXCOORD0_3.xy) + texture2D (_MainTex, xlv_TEXCOORD0_4.xy)) * 0.0702703));
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
"!!GLES"
}
}
 }
}
Fallback Off
}