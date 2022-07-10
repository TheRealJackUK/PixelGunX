Shader "Particles/Additive_Always" {
Properties {
 _TintColor ("Tint Color", Color) = (0.5,0.5,0.5,0.5)
 _MainTex ("Particle Texture", 2D) = "white" {}
 _InvFade ("Soft Particles Factor", Range(0.01,3)) = 1
}
SubShader { 
 Tags { "QUEUE"="Transparent+1" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent+1" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  BindChannels {
   Bind "vertex", Vertex
   Bind "color", Color
   Bind "texcoord", TexCoord
  }
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha One
  AlphaTest Greater 0.01
  ColorMask RGB
Program "vp" {
SubProgram "gles " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp vec4 _TintColor;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_1 = (((2.0 * xlv_COLOR) * _TintColor) * tmpvar_2);
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp vec4 _TintColor;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  tmpvar_1 = (((2.0 * xlv_COLOR) * _TintColor) * tmpvar_2);
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform highp vec4 _TintColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2DProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_4;
  z_4 = tmpvar_3.x;
  tmpvar_2.w = (xlv_COLOR.w * clamp ((_InvFade * 
    ((1.0/(((_ZBufferParams.z * z_4) + _ZBufferParams.w))) - xlv_TEXCOORD1.z)
  ), 0.0, 1.0));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_1 = (((2.0 * tmpvar_2) * _TintColor) * tmpvar_5);
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 glstate_matrix_mvp;
uniform highp mat4 glstate_matrix_modelview0;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec4 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2 = (glstate_matrix_mvp * _glesVertex);
  highp vec4 o_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_2 * 0.5);
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_3.xy = (tmpvar_5 + tmpvar_4.w);
  o_3.zw = tmpvar_2.zw;
  tmpvar_1.xyw = o_3.xyw;
  tmpvar_1.z = -((glstate_matrix_modelview0 * _glesVertex).z);
  gl_Position = tmpvar_2;
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform highp vec4 _TintColor;
uniform sampler2D _CameraDepthTexture;
uniform highp float _InvFade;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec4 xlv_TEXCOORD1;
void main ()
{
  mediump vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_2.xyz = xlv_COLOR.xyz;
  lowp vec4 tmpvar_3;
  tmpvar_3 = textureProj (_CameraDepthTexture, xlv_TEXCOORD1);
  highp float z_4;
  z_4 = tmpvar_3.x;
  tmpvar_2.w = (xlv_COLOR.w * clamp ((_InvFade * 
    ((1.0/(((_ZBufferParams.z * z_4) + _ZBufferParams.w))) - xlv_TEXCOORD1.z)
  ), 0.0, 1.0));
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_MainTex, xlv_TEXCOORD0);
  tmpvar_1 = (((2.0 * tmpvar_2) * _TintColor) * tmpvar_5);
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_OFF" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "SOFTPARTICLES_ON" }
"!!GLES3"
}
}
 }
}
SubShader { 
 Tags { "QUEUE"="Transparent+1" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent+1" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  BindChannels {
   Bind "vertex", Vertex
   Bind "color", Color
   Bind "texcoord", TexCoord
  }
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha One
  AlphaTest Greater 0.01
  ColorMask RGB
  SetTexture [_MainTex] { ConstantColor [_TintColor] combine constant * primary }
  SetTexture [_MainTex] { combine texture * previous double }
 }
}
SubShader { 
 Tags { "QUEUE"="Transparent+1" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent+1" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  BindChannels {
   Bind "vertex", Vertex
   Bind "color", Color
   Bind "texcoord", TexCoord
  }
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha One
  AlphaTest Greater 0.01
  ColorMask RGB
  SetTexture [_MainTex] { combine texture * primary }
 }
}
}