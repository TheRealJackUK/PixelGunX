Shader "Hidden/SunShaftsComposite" {
Properties {
 _MainTex ("Base", 2D) = "" {}
 _ColorBuffer ("Color", 2D) = "" {}
 _Skybox ("Skybox", 2D) = "" {}
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _ColorBuffer;
uniform mediump vec4 _SunColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 colorB_1;
  mediump vec4 colorA_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  colorA_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ColorBuffer, xlv_TEXCOORD0);
  colorB_1 = tmpvar_4;
  gl_FragData[0] = (1.0 - ((1.0 - colorA_2) * (1.0 - 
    clamp ((colorB_1 * _SunColor), 0.0, 1.0)
  )));
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _ColorBuffer;
uniform mediump vec4 _SunColor;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 colorB_1;
  mediump vec4 colorA_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  colorA_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_ColorBuffer, xlv_TEXCOORD0);
  colorB_1 = tmpvar_4;
  _glesFragData[0] = (1.0 - ((1.0 - colorA_2) * (1.0 - 
    clamp ((colorB_1 * _SunColor), 0.0, 1.0)
  )));
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
uniform mediump vec4 _BlurRadius4;
uniform mediump vec4 _SunPosition;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = ((_SunPosition.xy - _glesMultiTexCoord0.xy) * _BlurRadius4.xy);
  tmpvar_2 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec4 color_2;
  mediump vec4 tmpColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_MainTex, xlv_TEXCOORD0);
  tmpColor_3 = tmpvar_4;
  tmpvar_1 = (xlv_TEXCOORD0 + xlv_TEXCOORD1);
  mediump vec4 tmpColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, tmpvar_1);
  tmpColor_5 = tmpvar_6;
  color_2 = (tmpColor_3 + tmpColor_5);
  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
  mediump vec4 tmpColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (_MainTex, tmpvar_1);
  tmpColor_7 = tmpvar_8;
  color_2 = (color_2 + tmpColor_7);
  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
  mediump vec4 tmpColor_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (_MainTex, tmpvar_1);
  tmpColor_9 = tmpvar_10;
  color_2 = (color_2 + tmpColor_9);
  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
  mediump vec4 tmpColor_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (_MainTex, tmpvar_1);
  tmpColor_11 = tmpvar_12;
  color_2 = (color_2 + tmpColor_11);
  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
  mediump vec4 tmpColor_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture2D (_MainTex, tmpvar_1);
  tmpColor_13 = tmpvar_14;
  color_2 = (color_2 + tmpColor_13);
  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
  gl_FragData[0] = (color_2 / 6.0);
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform mediump vec4 _BlurRadius4;
uniform mediump vec4 _SunPosition;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  highp vec2 tmpvar_2;
  mediump vec2 tmpvar_3;
  tmpvar_3 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_3;
  mediump vec2 tmpvar_4;
  tmpvar_4 = ((_SunPosition.xy - _glesMultiTexCoord0.xy) * _BlurRadius4.xy);
  tmpvar_2 = tmpvar_4;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec4 color_2;
  mediump vec4 tmpColor_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_MainTex, xlv_TEXCOORD0);
  tmpColor_3 = tmpvar_4;
  tmpvar_1 = (xlv_TEXCOORD0 + xlv_TEXCOORD1);
  mediump vec4 tmpColor_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, tmpvar_1);
  tmpColor_5 = tmpvar_6;
  color_2 = (tmpColor_3 + tmpColor_5);
  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
  mediump vec4 tmpColor_7;
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture (_MainTex, tmpvar_1);
  tmpColor_7 = tmpvar_8;
  color_2 = (color_2 + tmpColor_7);
  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
  mediump vec4 tmpColor_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture (_MainTex, tmpvar_1);
  tmpColor_9 = tmpvar_10;
  color_2 = (color_2 + tmpColor_9);
  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
  mediump vec4 tmpColor_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture (_MainTex, tmpvar_1);
  tmpColor_11 = tmpvar_12;
  color_2 = (color_2 + tmpColor_11);
  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
  mediump vec4 tmpColor_13;
  lowp vec4 tmpvar_14;
  tmpvar_14 = texture (_MainTex, tmpvar_1);
  tmpColor_13 = tmpvar_14;
  color_2 = (color_2 + tmpColor_13);
  tmpvar_1 = (tmpvar_1 + xlv_TEXCOORD1);
  _glesFragData[0] = (color_2 / 6.0);
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform sampler2D _CameraDepthTexture;
uniform mediump float _NoSkyBoxMask;
uniform mediump vec4 _SunPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 outColor_1;
  mediump vec2 vec_2;
  mediump vec4 tex_3;
  highp float depthSample_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture2D (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depthSample_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(((_ZBufferParams.x * depthSample_4) + _ZBufferParams.y)));
  depthSample_4 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = (_SunPosition.xy - xlv_TEXCOORD0);
  vec_2 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = clamp ((_SunPosition.w - sqrt(
    dot (vec_2, vec_2)
  )), 0.0, 1.0);
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((tmpvar_7 > 0.99)) {
    outColor_1 = vec4((max (tex_3.w, (_NoSkyBoxMask * 
      dot (tex_3.xyz, vec3(0.59, 0.3, 0.11))
    )) * tmpvar_9));
  };
  gl_FragData[0] = outColor_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform sampler2D _CameraDepthTexture;
uniform mediump float _NoSkyBoxMask;
uniform mediump vec4 _SunPosition;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 outColor_1;
  mediump vec2 vec_2;
  mediump vec4 tex_3;
  highp float depthSample_4;
  lowp float tmpvar_5;
  tmpvar_5 = texture (_CameraDepthTexture, xlv_TEXCOORD0).x;
  depthSample_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  tex_3 = tmpvar_6;
  highp float tmpvar_7;
  tmpvar_7 = (1.0/(((_ZBufferParams.x * depthSample_4) + _ZBufferParams.y)));
  depthSample_4 = tmpvar_7;
  highp vec2 tmpvar_8;
  tmpvar_8 = (_SunPosition.xy - xlv_TEXCOORD0);
  vec_2 = tmpvar_8;
  mediump float tmpvar_9;
  tmpvar_9 = clamp ((_SunPosition.w - sqrt(
    dot (vec_2, vec_2)
  )), 0.0, 1.0);
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  if ((tmpvar_7 > 0.99)) {
    outColor_1 = vec4((max (tex_3.w, (_NoSkyBoxMask * 
      dot (tex_3.xyz, vec3(0.59, 0.3, 0.11))
    )) * tmpvar_9));
  };
  _glesFragData[0] = outColor_1;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _Skybox;
uniform mediump float _NoSkyBoxMask;
uniform mediump vec4 _SunPosition;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 outColor_1;
  mediump vec2 vec_2;
  highp vec4 tex_3;
  highp vec4 sky_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture2D (_Skybox, xlv_TEXCOORD0);
  sky_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (_MainTex, xlv_TEXCOORD0);
  tex_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (_SunPosition.xy - xlv_TEXCOORD0);
  vec_2 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = clamp ((_SunPosition.w - sqrt(
    dot (vec_2, vec_2)
  )), 0.0, 1.0);
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec3 tmpvar_9;
  tmpvar_9 = abs((sky_4.xyz - tex_3.xyz));
  lowp vec3 c_10;
  c_10 = tmpvar_9;
  lowp float tmpvar_11;
  tmpvar_11 = dot (c_10, vec3(0.22, 0.707, 0.071));
  if ((tmpvar_11 < 0.2)) {
    mediump vec4 skyboxValue_12;
    skyboxValue_12 = sky_4;
    outColor_1 = vec4((max (skyboxValue_12.w, (_NoSkyBoxMask * 
      dot (skyboxValue_12.xyz, vec3(0.59, 0.3, 0.11))
    )) * tmpvar_8));
  };
  gl_FragData[0] = outColor_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _Skybox;
uniform mediump float _NoSkyBoxMask;
uniform mediump vec4 _SunPosition;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 outColor_1;
  mediump vec2 vec_2;
  highp vec4 tex_3;
  highp vec4 sky_4;
  lowp vec4 tmpvar_5;
  tmpvar_5 = texture (_Skybox, xlv_TEXCOORD0);
  sky_4 = tmpvar_5;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture (_MainTex, xlv_TEXCOORD0);
  tex_3 = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = (_SunPosition.xy - xlv_TEXCOORD0);
  vec_2 = tmpvar_7;
  mediump float tmpvar_8;
  tmpvar_8 = clamp ((_SunPosition.w - sqrt(
    dot (vec_2, vec_2)
  )), 0.0, 1.0);
  outColor_1 = vec4(0.0, 0.0, 0.0, 0.0);
  highp vec3 tmpvar_9;
  tmpvar_9 = abs((sky_4.xyz - tex_3.xyz));
  lowp vec3 c_10;
  c_10 = tmpvar_9;
  lowp float tmpvar_11;
  tmpvar_11 = dot (c_10, vec3(0.22, 0.707, 0.071));
  if ((tmpvar_11 < 0.2)) {
    mediump vec4 skyboxValue_12;
    skyboxValue_12 = sky_4;
    outColor_1 = vec4((max (skyboxValue_12.w, (_NoSkyBoxMask * 
      dot (skyboxValue_12.xyz, vec3(0.59, 0.3, 0.11))
    )) * tmpvar_8));
  };
  _glesFragData[0] = outColor_1;
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
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
uniform sampler2D _ColorBuffer;
uniform mediump vec4 _SunColor;
varying highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 colorB_1;
  mediump vec4 colorA_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture2D (_MainTex, xlv_TEXCOORD0);
  colorA_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture2D (_ColorBuffer, xlv_TEXCOORD0);
  colorB_1 = tmpvar_4;
  gl_FragData[0] = (colorA_2 + clamp ((colorB_1 * _SunColor), 0.0, 1.0));
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
out highp vec2 xlv_TEXCOORD0;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
uniform sampler2D _ColorBuffer;
uniform mediump vec4 _SunColor;
in highp vec2 xlv_TEXCOORD0;
void main ()
{
  mediump vec4 colorB_1;
  mediump vec4 colorA_2;
  lowp vec4 tmpvar_3;
  tmpvar_3 = texture (_MainTex, xlv_TEXCOORD0);
  colorA_2 = tmpvar_3;
  lowp vec4 tmpvar_4;
  tmpvar_4 = texture (_ColorBuffer, xlv_TEXCOORD0);
  colorB_1 = tmpvar_4;
  _glesFragData[0] = (colorA_2 + clamp ((colorB_1 * _SunColor), 0.0, 1.0));
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