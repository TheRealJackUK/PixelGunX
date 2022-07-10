Shader "Hidden/Highlighted/Composite" {
Properties {
 _MainTex ("", 2D) = "" {}
 _BlurTex ("", 2D) = "" {}
 _StencilTex ("", 2D) = "" {}
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
uniform highp vec4 _MainTex_TexelSize;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD0_1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2 = tmpvar_1;
  if ((_MainTex_TexelSize.y < 0.0)) {
    tmpvar_2.y = (1.0 - _glesMultiTexCoord0.y);
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD0_1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _BlurTex;
uniform sampler2D _StencilTex;
varying mediump vec2 xlv_TEXCOORD0;
varying mediump vec2 xlv_TEXCOORD0_1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_StencilTex, xlv_TEXCOORD0_1);
  if (any(bvec3(tmpvar_3.xyz))) {
    tmpvar_1 = tmpvar_2;
  } else {
    lowp vec4 color_4;
    lowp vec4 tmpvar_5;
    tmpvar_5 = texture2D (_BlurTex, xlv_TEXCOORD0_1);
    color_4.xyz = mix (tmpvar_2.xyz, tmpvar_5.xyz, vec3(clamp ((tmpvar_5.w - tmpvar_3.w), 0.0, 1.0)));
    color_4.w = tmpvar_2.w;
    tmpvar_1 = color_4;
  };
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_TexelSize;
out mediump vec2 xlv_TEXCOORD0;
out mediump vec2 xlv_TEXCOORD0_1;
void main ()
{
  mediump vec2 tmpvar_1;
  tmpvar_1 = _glesMultiTexCoord0.xy;
  mediump vec2 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (glstate_matrix_mvp * _glesVertex);
  tmpvar_2 = tmpvar_1;
  if ((_MainTex_TexelSize.y < 0.0)) {
    tmpvar_2.y = (1.0 - _glesMultiTexCoord0.y);
  };
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD0_1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _BlurTex;
uniform sampler2D _StencilTex;
in mediump vec2 xlv_TEXCOORD0;
in mediump vec2 xlv_TEXCOORD0_1;
void main ()
{
  lowp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_StencilTex, xlv_TEXCOORD0_1);
  if (any(bvec3(tmpvar_3.xyz))) {
    tmpvar_1 = tmpvar_2;
  } else {
    lowp vec4 color_4;
    lowp vec4 tmpvar_5;
    tmpvar_5 = texture (_BlurTex, xlv_TEXCOORD0_1);
    color_4.xyz = mix (tmpvar_2.xyz, tmpvar_5.xyz, vec3(clamp ((tmpvar_5.w - tmpvar_3.w), 0.0, 1.0)));
    color_4.w = tmpvar_2.w;
    tmpvar_1 = color_4;
  };
  _glesFragData[0] = tmpvar_1;
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
SubShader { 
 Pass {
  SetTexture [_MainTex] { combine texture, texture alpha }
 }
}
Fallback Off
}