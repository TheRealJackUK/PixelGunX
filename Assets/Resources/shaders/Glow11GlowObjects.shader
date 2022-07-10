Shader "Hidden/Glow 11/GlowObjects" {
Properties {
 _GlowStrength ("Glow Strength", Float) = 1
 _GlowColor ("Glow Color", Color) = (1,1,1,1)
}
SubShader { 
 Tags { "RenderType"="Glow11" "RenderEffect"="Glow11" }
 Pass {
  Name "OPAQUEGLOW"
  Tags { "RenderType"="Glow11" "RenderEffect"="Glow11" }
  Fog { Mode Off }
Program "vp" {
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * _GlowStrength);
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * _GlowStrength);
  tmpvar_1 = tmpvar_3;
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * _GlowColor);
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * _GlowColor);
  tmpvar_1 = tmpvar_3;
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
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
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * xlv_COLOR);
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
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
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * xlv_COLOR);
  tmpvar_1 = tmpvar_3;
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
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
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w);
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
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
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w);
  tmpvar_1 = tmpvar_3;
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_Illum, xlv_TEXCOORD2);
  highp vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w);
  tmpvar_1 = tmpvar_4;
  gl_FragData[0] = tmpvar_4;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  tmpvar_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_Illum, xlv_TEXCOORD2);
  highp vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w);
  tmpvar_1 = tmpvar_4;
  _glesFragData[0] = tmpvar_4;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * _GlowStrength);
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * tmpvar_3.w);
  tmpvar_1 = tmpvar_4;
  gl_FragData[0] = tmpvar_4;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * _GlowStrength);
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * tmpvar_3.w);
  tmpvar_1 = tmpvar_4;
  _glesFragData[0] = tmpvar_4;
}



#endif"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  highp vec4 tmpvar_2;
  tmpvar_2 = (tmpvar_1 * _GlowStrength);
  tmpvar_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
out highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  highp vec4 tmpvar_2;
  tmpvar_2 = (tmpvar_1 * _GlowStrength);
  tmpvar_1 = tmpvar_2;
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
uniform lowp vec4 _Color;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  highp vec4 tmpvar_2;
  tmpvar_2 = ((tmpvar_1 * _GlowStrength) * _GlowColor);
  tmpvar_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
out highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
uniform lowp vec4 _Color;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  highp vec4 tmpvar_2;
  tmpvar_2 = ((tmpvar_1 * _GlowStrength) * _GlowColor);
  tmpvar_1 = tmpvar_2;
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_COLOR;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  highp vec4 tmpvar_2;
  tmpvar_2 = ((tmpvar_1 * _GlowStrength) * xlv_COLOR);
  tmpvar_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
out highp vec4 xlv_COLOR;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
in highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  highp vec4 tmpvar_2;
  tmpvar_2 = ((tmpvar_1 * _GlowStrength) * xlv_COLOR);
  tmpvar_1 = tmpvar_2;
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_COLOR;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  highp vec4 tmpvar_2;
  tmpvar_2 = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w);
  tmpvar_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
out highp vec4 xlv_COLOR;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
in highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  highp vec4 tmpvar_2;
  tmpvar_2 = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w);
  tmpvar_1 = tmpvar_2;
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Illum;
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Illum, xlv_TEXCOORD2);
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * tmpvar_2.w);
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Illum, xlv_TEXCOORD2);
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * tmpvar_2.w);
  tmpvar_1 = tmpvar_3;
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * tmpvar_2.w);
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * tmpvar_2.w);
  tmpvar_1 = tmpvar_3;
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_GLOWTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _GlowTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * _GlowStrength);
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _GlowTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * _GlowStrength);
  tmpvar_1 = tmpvar_3;
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _GlowTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * _GlowColor);
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _GlowTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * _GlowColor);
  tmpvar_1 = tmpvar_3;
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_GLOWTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _GlowTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * xlv_COLOR);
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _GlowTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * xlv_COLOR);
  tmpvar_1 = tmpvar_3;
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _GlowTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w);
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _GlowTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w);
  tmpvar_1 = tmpvar_3;
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _GlowTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _GlowTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_Illum, xlv_TEXCOORD2);
  highp vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w);
  tmpvar_1 = tmpvar_4;
  gl_FragData[0] = tmpvar_4;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _GlowTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _GlowTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_Illum, xlv_TEXCOORD2);
  highp vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w);
  tmpvar_1 = tmpvar_4;
  _glesFragData[0] = tmpvar_4;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _GlowTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w);
  tmpvar_1 = tmpvar_4;
  gl_FragData[0] = tmpvar_4;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _GlowTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w);
  tmpvar_1 = tmpvar_4;
  _glesFragData[0] = tmpvar_4;
}



#endif"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * _GlowStrength);
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * _GlowStrength);
  tmpvar_1 = tmpvar_3;
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Illum;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * _GlowColor);
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * _GlowColor);
  tmpvar_1 = tmpvar_3;
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * xlv_COLOR);
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * xlv_COLOR);
  tmpvar_1 = tmpvar_3;
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w);
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w);
  tmpvar_1 = tmpvar_3;
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * _GlowStrength);
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * tmpvar_3.w);
  tmpvar_1 = tmpvar_4;
  gl_FragData[0] = tmpvar_4;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (tmpvar_1 * _GlowStrength);
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * tmpvar_3.w);
  tmpvar_1 = tmpvar_4;
  _glesFragData[0] = tmpvar_4;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w);
  tmpvar_1 = tmpvar_4;
  gl_FragData[0] = tmpvar_4;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_4;
  tmpvar_4 = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w);
  tmpvar_1 = tmpvar_4;
  _glesFragData[0] = tmpvar_4;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  highp vec4 tmpvar_2;
  tmpvar_2 = (tmpvar_1 * _GlowStrength);
  tmpvar_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
out highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  highp vec4 tmpvar_2;
  tmpvar_2 = (tmpvar_1 * _GlowStrength);
  tmpvar_1 = tmpvar_2;
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  highp vec4 tmpvar_2;
  tmpvar_2 = ((tmpvar_1 * _GlowStrength) * _GlowColor);
  tmpvar_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
out highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  highp vec4 tmpvar_2;
  tmpvar_2 = ((tmpvar_1 * _GlowStrength) * _GlowColor);
  tmpvar_1 = tmpvar_2;
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_COLOR;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  highp vec4 tmpvar_2;
  tmpvar_2 = ((tmpvar_1 * _GlowStrength) * xlv_COLOR);
  tmpvar_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
out highp vec4 xlv_COLOR;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  highp vec4 tmpvar_2;
  tmpvar_2 = ((tmpvar_1 * _GlowStrength) * xlv_COLOR);
  tmpvar_1 = tmpvar_2;
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_COLOR;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  highp vec4 tmpvar_2;
  tmpvar_2 = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w);
  tmpvar_1 = tmpvar_2;
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
out highp vec4 xlv_COLOR;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  highp vec4 tmpvar_2;
  tmpvar_2 = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w);
  tmpvar_1 = tmpvar_2;
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Illum;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Illum, xlv_TEXCOORD2);
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * tmpvar_2.w);
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Illum, xlv_TEXCOORD2);
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * tmpvar_2.w);
  tmpvar_1 = tmpvar_3;
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * tmpvar_2.w);
  tmpvar_1 = tmpvar_3;
  gl_FragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
uniform highp mat4 glstate_matrix_mvp;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec2 tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_3;
  tmpvar_3 = ((tmpvar_1 * _GlowStrength) * tmpvar_2.w);
  tmpvar_1 = tmpvar_3;
  _glesFragData[0] = tmpvar_3;
}



#endif"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_COLOR;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (xlv_COLOR * _GlowStrength);
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
out highp vec4 xlv_COLOR;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = (xlv_COLOR * _GlowStrength);
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_COLOR;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = ((xlv_COLOR * _GlowStrength) * _GlowColor);
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
out highp vec4 xlv_COLOR;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = ((xlv_COLOR * _GlowStrength) * _GlowColor);
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_COLOR;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = ((xlv_COLOR * _GlowStrength) * xlv_COLOR);
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
out highp vec4 xlv_COLOR;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = ((xlv_COLOR * _GlowStrength) * xlv_COLOR);
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_COLOR;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT

uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = ((xlv_COLOR * _GlowStrength) * xlv_COLOR.w);
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
out highp vec4 xlv_COLOR;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = ((xlv_COLOR * _GlowStrength) * xlv_COLOR.w);
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_Illum, xlv_TEXCOORD2);
  highp vec4 tmpvar_2;
  tmpvar_2 = ((xlv_COLOR * _GlowStrength) * tmpvar_1.w);
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture (_Illum, xlv_TEXCOORD2);
  highp vec4 tmpvar_2;
  tmpvar_2 = ((xlv_COLOR * _GlowStrength) * tmpvar_1.w);
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture2D (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_2;
  tmpvar_2 = ((xlv_COLOR * _GlowStrength) * tmpvar_1.w);
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
uniform highp mat4 glstate_matrix_mvp;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = texture (_MainTex, xlv_TEXCOORD0);
  highp vec4 tmpvar_2;
  tmpvar_2 = ((xlv_COLOR * _GlowStrength) * tmpvar_1.w);
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_GLOWTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_GLOWTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3"
}
}
 }
}
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Glow11Transparent" "RenderEffect"="Glow11Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Glow11Transparent" "RenderEffect"="Glow11Transparent" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  tmpvar_2.xyz = (tmpvar_2 * _GlowStrength).xyz;
  tmpvar_2.w = alpha_1;
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  tmpvar_2.xyz = (tmpvar_2 * _GlowStrength).xyz;
  tmpvar_2.w = alpha_1;
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  tmpvar_2.xyz = ((tmpvar_2 * _GlowStrength) * _GlowColor).xyz;
  tmpvar_2.w = alpha_1;
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  tmpvar_2.xyz = ((tmpvar_2 * _GlowStrength) * _GlowColor).xyz;
  tmpvar_2.w = alpha_1;
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
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
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  tmpvar_2.xyz = ((tmpvar_2 * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_2.w = alpha_1;
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
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
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  tmpvar_2.xyz = ((tmpvar_2 * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_2.w = alpha_1;
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
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
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  tmpvar_2.xyz = ((tmpvar_2 * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_2.w = alpha_1;
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
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
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  tmpvar_2.xyz = ((tmpvar_2 * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_2.w = alpha_1;
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_2.xyz = ((tmpvar_2 * _GlowStrength) * tmpvar_5.w).xyz;
  tmpvar_2.w = alpha_1;
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_2.xyz = ((tmpvar_2 * _GlowStrength) * tmpvar_5.w).xyz;
  tmpvar_2.w = alpha_1;
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * _GlowStrength);
  tmpvar_2.xyz = (tmpvar_5 * tmpvar_5.w).xyz;
  tmpvar_2.w = alpha_1;
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * _GlowStrength);
  tmpvar_2.xyz = (tmpvar_5 * tmpvar_5.w).xyz;
  tmpvar_2.w = alpha_1;
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = (tmpvar_1 * _GlowStrength).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = (tmpvar_1 * _GlowStrength).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * _GlowColor).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
uniform lowp vec4 _Color;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * _GlowColor).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_MAINCOLOR" }
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
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_MAINCOLOR" }
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
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
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
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
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
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_3;
  tmpvar_3 = tmpvar_2.w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_2.w).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_3;
  tmpvar_3 = tmpvar_2.w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_2.w).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_GLOWTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = (tmpvar_1 * _GlowStrength).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = (tmpvar_1 * _GlowStrength).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * _GlowColor).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * _GlowColor).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_GLOWTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_4.w).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0).w;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_4.w).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = tmpvar_3.w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w).xyz;
  tmpvar_1.w = tmpvar_4;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = tmpvar_3.w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w).xyz;
  tmpvar_1.w = tmpvar_4;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = (tmpvar_1 * _GlowStrength).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = (tmpvar_1 * _GlowStrength).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * _GlowColor).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * _GlowColor).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_1 * _GlowStrength);
  tmpvar_1.xyz = (tmpvar_4 * tmpvar_4.w).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0).w;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_1 * _GlowStrength);
  tmpvar_1.xyz = (tmpvar_4 * tmpvar_4.w).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = tmpvar_3.w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w).xyz;
  tmpvar_1.w = tmpvar_4;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = tmpvar_3.w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w).xyz;
  tmpvar_1.w = tmpvar_4;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = (tmpvar_1 * _GlowStrength).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = (tmpvar_1 * _GlowStrength).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * _GlowColor).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * _GlowColor).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
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
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
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
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
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
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
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
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_3;
  tmpvar_3 = tmpvar_2.w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_2.w).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_3;
  tmpvar_3 = tmpvar_2.w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_2.w).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
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
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = (xlv_COLOR * _GlowStrength).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
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
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = (xlv_COLOR * _GlowStrength).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
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
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((xlv_COLOR * _GlowStrength) * _GlowColor).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
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
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((xlv_COLOR * _GlowStrength) * _GlowColor).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
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
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((xlv_COLOR * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
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
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((xlv_COLOR * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
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
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((xlv_COLOR * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
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
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((xlv_COLOR * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1.xyz = ((xlv_COLOR * _GlowStrength) * tmpvar_3.w).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1.xyz = ((xlv_COLOR * _GlowStrength) * tmpvar_3.w).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
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
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_3;
  tmpvar_3 = tmpvar_2.w;
  tmpvar_1.xyz = ((xlv_COLOR * _GlowStrength) * tmpvar_2.w).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
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
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_3;
  tmpvar_3 = tmpvar_2.w;
  tmpvar_1.xyz = ((xlv_COLOR * _GlowStrength) * tmpvar_2.w).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_GLOWTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_GLOWTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3"
}
}
 }
}
SubShader { 
 Tags { "QUEUE"="AlphaTest" "RenderType"="Glow11TransparentCutout" "RenderEffect"="Glow11TransparentCutout" }
 Pass {
  Tags { "QUEUE"="AlphaTest" "RenderType"="Glow11TransparentCutout" "RenderEffect"="Glow11TransparentCutout" }
  Fog { Mode Off }
  AlphaTest Greater [_Cutoff]
Program "vp" {
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  tmpvar_2.xyz = (tmpvar_2 * _GlowStrength).xyz;
  tmpvar_2.w = alpha_1;
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  tmpvar_2.xyz = (tmpvar_2 * _GlowStrength).xyz;
  tmpvar_2.w = alpha_1;
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  tmpvar_2.xyz = ((tmpvar_2 * _GlowStrength) * _GlowColor).xyz;
  tmpvar_2.w = alpha_1;
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  tmpvar_2.xyz = ((tmpvar_2 * _GlowStrength) * _GlowColor).xyz;
  tmpvar_2.w = alpha_1;
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
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
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  tmpvar_2.xyz = ((tmpvar_2 * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_2.w = alpha_1;
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
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
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  tmpvar_2.xyz = ((tmpvar_2 * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_2.w = alpha_1;
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
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
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  tmpvar_2.xyz = ((tmpvar_2 * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_2.w = alpha_1;
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
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
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  tmpvar_2.xyz = ((tmpvar_2 * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_2.w = alpha_1;
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_2.xyz = ((tmpvar_2 * _GlowStrength) * tmpvar_5.w).xyz;
  tmpvar_2.w = alpha_1;
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_2.xyz = ((tmpvar_2 * _GlowStrength) * tmpvar_5.w).xyz;
  tmpvar_2.w = alpha_1;
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * _GlowStrength);
  tmpvar_2.xyz = (tmpvar_5 * tmpvar_5.w).xyz;
  tmpvar_2.w = alpha_1;
  gl_FragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  lowp float alpha_1;
  highp vec4 tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  tmpvar_2 = tmpvar_3;
  highp float tmpvar_4;
  tmpvar_4 = tmpvar_2.w;
  alpha_1 = tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_2 * _GlowStrength);
  tmpvar_2.xyz = (tmpvar_5 * tmpvar_5.w).xyz;
  tmpvar_2.w = alpha_1;
  _glesFragData[0] = tmpvar_2;
}



#endif"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = (tmpvar_1 * _GlowStrength).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = (tmpvar_1 * _GlowStrength).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * _GlowColor).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
uniform lowp vec4 _Color;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * _GlowColor).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_MAINCOLOR" }
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
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_MAINCOLOR" }
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
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
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
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
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
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_3;
  tmpvar_3 = tmpvar_2.w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_2.w).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _Color;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _Color;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_3;
  tmpvar_3 = tmpvar_2.w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_2.w).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_GLOWTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = (tmpvar_1 * _GlowStrength).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = (tmpvar_1 * _GlowStrength).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * _GlowColor).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * _GlowColor).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_GLOWTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_4.w).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0).w;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_4.w).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = tmpvar_3.w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w).xyz;
  tmpvar_1.w = tmpvar_4;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _GlowTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _GlowTex_ST.xy) + _GlowTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _GlowTex;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_GlowTex, xlv_TEXCOORD1);
  tmpvar_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = tmpvar_3.w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w).xyz;
  tmpvar_1.w = tmpvar_4;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = (tmpvar_1 * _GlowStrength).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = (tmpvar_1 * _GlowStrength).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * _GlowColor).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * _GlowColor).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_1 * _GlowStrength);
  tmpvar_1.xyz = (tmpvar_4 * tmpvar_4.w).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp float tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0).w;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_1 * _GlowStrength);
  tmpvar_1.xyz = (tmpvar_4 * tmpvar_4.w).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = tmpvar_3.w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w).xyz;
  tmpvar_1.w = tmpvar_4;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1 = tmpvar_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_4;
  tmpvar_4 = tmpvar_3.w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w).xyz;
  tmpvar_1.w = tmpvar_4;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = (tmpvar_1 * _GlowStrength).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = (tmpvar_1 * _GlowStrength).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * _GlowColor).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * _GlowColor).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
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
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
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
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
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
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
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
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_3.w).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_3;
  tmpvar_3 = tmpvar_2.w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_2.w).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = tmpvar_1;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  tmpvar_1 = _GlowColor;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_3;
  tmpvar_3 = tmpvar_2.w;
  tmpvar_1.xyz = ((tmpvar_1 * _GlowStrength) * tmpvar_2.w).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
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
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = (xlv_COLOR * _GlowStrength).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
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
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = (xlv_COLOR * _GlowStrength).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
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
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((xlv_COLOR * _GlowStrength) * _GlowColor).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
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
uniform highp float _GlowStrength;
uniform lowp vec4 _GlowColor;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((xlv_COLOR * _GlowStrength) * _GlowColor).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
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
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((xlv_COLOR * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
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
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((xlv_COLOR * _GlowStrength) * xlv_COLOR).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
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
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((xlv_COLOR * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
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
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  tmpvar_1.xyz = ((xlv_COLOR * _GlowStrength) * xlv_COLOR.w).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_Illum, xlv_TEXCOORD2);
  tmpvar_1.xyz = ((xlv_COLOR * _GlowStrength) * tmpvar_3.w).xyz;
  tmpvar_1.w = tmpvar_2;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _MainTex_ST;
uniform highp vec4 _Illum_ST;
out highp vec4 xlv_COLOR;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD2;
void main ()
{
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_COLOR = _glesColor;
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xy * _MainTex_ST.xy) + _MainTex_ST.zw);
  xlv_TEXCOORD2 = ((_glesMultiTexCoord0.xy * _Illum_ST.xy) + _Illum_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Illum;
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD2;
void main ()
{
  highp vec4 tmpvar_1;
  lowp float tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0).w;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_Illum, xlv_TEXCOORD2);
  tmpvar_1.xyz = ((xlv_COLOR * _GlowStrength) * tmpvar_3.w).xyz;
  tmpvar_1.w = tmpvar_2;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
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
uniform highp float _GlowStrength;
varying highp vec4 xlv_COLOR;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture2D (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_3;
  tmpvar_3 = tmpvar_2.w;
  tmpvar_1.xyz = ((xlv_COLOR * _GlowStrength) * tmpvar_2.w).xyz;
  tmpvar_1.w = tmpvar_3;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
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
uniform highp float _GlowStrength;
in highp vec4 xlv_COLOR;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec4 tmpvar_1;
  lowp vec4 tmpvar_2;
  tmpvar_2 = texture (_MainTex, xlv_TEXCOORD0);
  lowp float tmpvar_3;
  tmpvar_3 = tmpvar_2.w;
  tmpvar_1.xyz = ((xlv_COLOR * _GlowStrength) * tmpvar_2.w).xyz;
  tmpvar_1.w = tmpvar_3;
  _glesFragData[0] = tmpvar_1;
}



#endif"
}
}
Program "fp" {
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "NO_MULTIPLY" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_VERT_ALPHA" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_MAINTEX" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_MAINCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_GLOWTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_GLOWTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_GLOWTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_ILLUMTEX" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "NO_MULTIPLY" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_GLOWCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_VERT_ALPHA" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_GLOW_GLOWCOLOR" "GLOW11_MULTIPLY_MAINTEX_ALPHA" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "NO_MULTIPLY" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_GLOWCOLOR" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_VERT_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_ILLUMTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3"
}
SubProgram "gles " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES"
}
SubProgram "gles3 " {
Keywords { "GLOW11_MULTIPLY_MAINTEX_ALPHA" "GLOW11_GLOW_VERTEXCOLOR" }
"!!GLES3"
}
}
 }
}
SubShader { 
 Tags { "RenderType"="Opaque" }
 Pass {
  Tags { "RenderType"="Opaque" }
  Fog { Mode Off }
 }
}
SubShader { 
 Tags { "RenderType"="TreeOpaque" }
 Pass {
  Tags { "RenderType"="TreeOpaque" }
  Fog { Mode Off }
 }
}
SubShader { 
 Tags { "QUEUE"="AlphaTest" "RenderType"="TransparentCutout" }
 Pass {
  Tags { "QUEUE"="AlphaTest" "RenderType"="TransparentCutout" }
  Cull Off
  Fog { Mode Off }
  AlphaTest Greater [_Cutoff]
  SetTexture [_MainTex] { ConstantColor (0,0,0,0) combine constant, texture alpha }
 }
}
SubShader { 
 Tags { "QUEUE"="AlphaTest" "RenderType"="TreeTransparentCutout" }
 Pass {
  Tags { "QUEUE"="AlphaTest" "RenderType"="TreeTransparentCutout" }
  Cull Off
  Fog { Mode Off }
  AlphaTest Greater [_Cutoff]
  SetTexture [_MainTex] { ConstantColor (0,0,0,0) combine constant, texture alpha }
 }
}
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZWrite Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
  SetTexture [_MainTex] { ConstantColor (0,0,0,0) combine constant, texture alpha }
 }
}
Fallback Off
}