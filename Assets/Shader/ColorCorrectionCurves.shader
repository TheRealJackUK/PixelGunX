Shader "Hidden/ColorCorrectionCurves" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "" {}
 _RgbTex ("_RgbTex (RGB)", 2D) = "" {}
 _ZCurve ("_ZCurve (RGB)", 2D) = "" {}
 _RgbDepthTex ("_RgbDepthTex (RGB)", 2D) = "" {}
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
uniform highp vec4 _CameraDepthTexture_ST;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _CameraDepthTexture_ST.xy) + _CameraDepthTexture_ST.zw);
}



#endif
#ifdef FRAGMENT

uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _RgbTex;
uniform sampler2D _ZCurve;
uniform sampler2D _RgbDepthTex;
uniform lowp float _Saturation;
varying highp vec2 xlv_TEXCOORD0;
varying highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump float lum_1;
  mediump vec3 depthBlue_2;
  mediump vec3 depthGreen_3;
  mediump vec3 depthRed_4;
  mediump float zval_5;
  mediump float theDepth_6;
  mediump vec3 blue_7;
  mediump vec3 green_8;
  mediump vec3 red_9;
  mediump vec4 color_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture2D (_MainTex, xlv_TEXCOORD0);
  color_10 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = color_10.x;
  tmpvar_12.y = 0.125;
  lowp vec3 tmpvar_13;
  tmpvar_13 = (texture2D (_RgbTex, tmpvar_12).xyz * vec3(1.0, 0.0, 0.0));
  red_9 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = color_10.y;
  tmpvar_14.y = 0.375;
  lowp vec3 tmpvar_15;
  tmpvar_15 = (texture2D (_RgbTex, tmpvar_14).xyz * vec3(0.0, 1.0, 0.0));
  green_8 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = color_10.z;
  tmpvar_16.y = 0.625;
  lowp vec3 tmpvar_17;
  tmpvar_17 = (texture2D (_RgbTex, tmpvar_16).xyz * vec3(0.0, 0.0, 1.0));
  blue_7 = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = texture2D (_CameraDepthTexture, xlv_TEXCOORD1).x;
  theDepth_6 = tmpvar_18;
  highp float z_19;
  z_19 = theDepth_6;
  highp vec2 tmpvar_20;
  tmpvar_20.y = 0.5;
  tmpvar_20.x = (1.0/(((_ZBufferParams.x * z_19) + _ZBufferParams.y)));
  lowp float tmpvar_21;
  tmpvar_21 = texture2D (_ZCurve, tmpvar_20).x;
  zval_5 = tmpvar_21;
  mediump vec2 tmpvar_22;
  tmpvar_22.x = color_10.x;
  tmpvar_22.y = 0.125;
  lowp vec3 tmpvar_23;
  tmpvar_23 = (texture2D (_RgbDepthTex, tmpvar_22).xyz * vec3(1.0, 0.0, 0.0));
  depthRed_4 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24.x = color_10.y;
  tmpvar_24.y = 0.375;
  lowp vec3 tmpvar_25;
  tmpvar_25 = (texture2D (_RgbDepthTex, tmpvar_24).xyz * vec3(0.0, 1.0, 0.0));
  depthGreen_3 = tmpvar_25;
  mediump vec2 tmpvar_26;
  tmpvar_26.x = color_10.z;
  tmpvar_26.y = 0.625;
  lowp vec3 tmpvar_27;
  tmpvar_27 = (texture2D (_RgbDepthTex, tmpvar_26).xyz * vec3(0.0, 0.0, 1.0));
  depthBlue_2 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28.xyz = mix (((red_9 + green_8) + blue_7), ((depthRed_4 + depthBlue_2) + depthGreen_3), vec3(zval_5));
  tmpvar_28.w = color_10.w;
  color_10.w = tmpvar_28.w;
  lowp vec3 c_29;
  c_29 = tmpvar_28.xyz;
  lowp float tmpvar_30;
  tmpvar_30 = dot (c_29, vec3(0.22, 0.707, 0.071));
  lum_1 = tmpvar_30;
  color_10.xyz = mix (vec3(lum_1), tmpvar_28.xyz, vec3(_Saturation));
  gl_FragData[0] = color_10;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesMultiTexCoord0;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _CameraDepthTexture_ST;
out highp vec2 xlv_TEXCOORD0;
out highp vec2 xlv_TEXCOORD1;
void main ()
{
  highp vec2 tmpvar_1;
  mediump vec2 tmpvar_2;
  tmpvar_2 = _glesMultiTexCoord0.xy;
  tmpvar_1 = tmpvar_2;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = ((_glesMultiTexCoord0.xy * _CameraDepthTexture_ST.xy) + _CameraDepthTexture_ST.zw);
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform highp vec4 _ZBufferParams;
uniform sampler2D _MainTex;
uniform sampler2D _CameraDepthTexture;
uniform sampler2D _RgbTex;
uniform sampler2D _ZCurve;
uniform sampler2D _RgbDepthTex;
uniform lowp float _Saturation;
in highp vec2 xlv_TEXCOORD0;
in highp vec2 xlv_TEXCOORD1;
void main ()
{
  mediump float lum_1;
  mediump vec3 depthBlue_2;
  mediump vec3 depthGreen_3;
  mediump vec3 depthRed_4;
  mediump float zval_5;
  mediump float theDepth_6;
  mediump vec3 blue_7;
  mediump vec3 green_8;
  mediump vec3 red_9;
  mediump vec4 color_10;
  lowp vec4 tmpvar_11;
  tmpvar_11 = texture (_MainTex, xlv_TEXCOORD0);
  color_10 = tmpvar_11;
  mediump vec2 tmpvar_12;
  tmpvar_12.x = color_10.x;
  tmpvar_12.y = 0.125;
  lowp vec3 tmpvar_13;
  tmpvar_13 = (texture (_RgbTex, tmpvar_12).xyz * vec3(1.0, 0.0, 0.0));
  red_9 = tmpvar_13;
  mediump vec2 tmpvar_14;
  tmpvar_14.x = color_10.y;
  tmpvar_14.y = 0.375;
  lowp vec3 tmpvar_15;
  tmpvar_15 = (texture (_RgbTex, tmpvar_14).xyz * vec3(0.0, 1.0, 0.0));
  green_8 = tmpvar_15;
  mediump vec2 tmpvar_16;
  tmpvar_16.x = color_10.z;
  tmpvar_16.y = 0.625;
  lowp vec3 tmpvar_17;
  tmpvar_17 = (texture (_RgbTex, tmpvar_16).xyz * vec3(0.0, 0.0, 1.0));
  blue_7 = tmpvar_17;
  lowp float tmpvar_18;
  tmpvar_18 = texture (_CameraDepthTexture, xlv_TEXCOORD1).x;
  theDepth_6 = tmpvar_18;
  highp float z_19;
  z_19 = theDepth_6;
  highp vec2 tmpvar_20;
  tmpvar_20.y = 0.5;
  tmpvar_20.x = (1.0/(((_ZBufferParams.x * z_19) + _ZBufferParams.y)));
  lowp float tmpvar_21;
  tmpvar_21 = texture (_ZCurve, tmpvar_20).x;
  zval_5 = tmpvar_21;
  mediump vec2 tmpvar_22;
  tmpvar_22.x = color_10.x;
  tmpvar_22.y = 0.125;
  lowp vec3 tmpvar_23;
  tmpvar_23 = (texture (_RgbDepthTex, tmpvar_22).xyz * vec3(1.0, 0.0, 0.0));
  depthRed_4 = tmpvar_23;
  mediump vec2 tmpvar_24;
  tmpvar_24.x = color_10.y;
  tmpvar_24.y = 0.375;
  lowp vec3 tmpvar_25;
  tmpvar_25 = (texture (_RgbDepthTex, tmpvar_24).xyz * vec3(0.0, 1.0, 0.0));
  depthGreen_3 = tmpvar_25;
  mediump vec2 tmpvar_26;
  tmpvar_26.x = color_10.z;
  tmpvar_26.y = 0.625;
  lowp vec3 tmpvar_27;
  tmpvar_27 = (texture (_RgbDepthTex, tmpvar_26).xyz * vec3(0.0, 0.0, 1.0));
  depthBlue_2 = tmpvar_27;
  mediump vec4 tmpvar_28;
  tmpvar_28.xyz = mix (((red_9 + green_8) + blue_7), ((depthRed_4 + depthBlue_2) + depthGreen_3), vec3(zval_5));
  tmpvar_28.w = color_10.w;
  color_10.w = tmpvar_28.w;
  lowp vec3 c_29;
  c_29 = tmpvar_28.xyz;
  lowp float tmpvar_30;
  tmpvar_30 = dot (c_29, vec3(0.22, 0.707, 0.071));
  lum_1 = tmpvar_30;
  color_10.xyz = mix (vec3(lum_1), tmpvar_28.xyz, vec3(_Saturation));
  _glesFragData[0] = color_10;
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