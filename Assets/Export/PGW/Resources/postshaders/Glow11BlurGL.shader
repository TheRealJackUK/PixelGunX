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
SubProgram "opengl " {
"!!GLSL
#ifdef VERTEX

attribute vec4 xlat_attrib_TEXCOORD;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD0_1;
varying vec4 xlv_TEXCOORD0_2;
varying vec4 xlv_TEXCOORD0_3;
varying vec4 xlv_TEXCOORD0_4;
void main ()
{
  gl_Position = (gl_ModelViewProjectionMatrix * gl_Vertex);
  xlv_TEXCOORD0 = gl_MultiTexCoord0;
  xlv_TEXCOORD0_1 = gl_MultiTexCoord2;
  xlv_TEXCOORD0_2 = gl_MultiTexCoord4;
  xlv_TEXCOORD0_3 = gl_MultiTexCoord6;
  xlv_TEXCOORD0_4 = xlat_attrib_TEXCOORD;
}


#endif
#ifdef FRAGMENT
uniform sampler2D _MainTex;
varying vec4 xlv_TEXCOORD0;
varying vec4 xlv_TEXCOORD0_1;
varying vec4 xlv_TEXCOORD0_2;
varying vec4 xlv_TEXCOORD0_3;
varying vec4 xlv_TEXCOORD0_4;
void main ()
{
  gl_FragData[0] = (((texture2D (_MainTex, xlv_TEXCOORD0.xy) * 0.227027) + (
    (texture2D (_MainTex, xlv_TEXCOORD0_1.xy) + texture2D (_MainTex, xlv_TEXCOORD0_2.xy))
   * 0.316216)) + ((texture2D (_MainTex, xlv_TEXCOORD0_3.xy) + texture2D (_MainTex, xlv_TEXCOORD0_4.xy)) * 0.0702703));
}


#endif
"
}
}
Program "fp" {
SubProgram "opengl " {
"!!GLSL"
}
}
 }
}
Fallback Off
}