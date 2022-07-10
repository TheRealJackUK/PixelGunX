Shader "MADFINGER/FX/Anim texture" {
Properties {
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _NumTexTiles ("Num tex tiles", Vector) = (4,4,0,0)
 _ReplaySpeed ("Replay speed - FPS", Float) = 4
 _Color ("Color", Color) = (1,1,1,1)
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
Program "vp" {
SubProgram "gles " {
"!!GLES


#ifdef VERTEX

attribute vec4 _glesVertex;
attribute vec4 _glesColor;
attribute vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Color;
uniform highp vec4 _NumTexTiles;
uniform highp float _ReplaySpeed;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tile_1;
  lowp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (((_glesColor.w * 60.0) + _Time.y) * _ReplaySpeed);
  highp float tmpvar_4;
  tmpvar_4 = floor(tmpvar_3);
  highp float tmpvar_5;
  tmpvar_5 = (tmpvar_4 + 1.0);
  highp float tmpvar_6;
  tmpvar_6 = (tmpvar_3 - tmpvar_4);
  highp vec2 tmpvar_7;
  tmpvar_7 = (1.0/(_NumTexTiles.xy));
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_4;
  tmpvar_8.y = floor((tmpvar_4 / _NumTexTiles.x));
  tile_1.xy = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_5;
  tmpvar_9.y = floor((tmpvar_5 / _NumTexTiles.x));
  tile_1.zw = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tile_1 / _NumTexTiles.xyxy);
  highp vec4 tmpvar_11;
  tmpvar_11 = (fract(abs(tmpvar_10)) * _NumTexTiles.xyxy);
  highp float tmpvar_12;
  if ((tmpvar_10.x >= 0.0)) {
    tmpvar_12 = tmpvar_11.x;
  } else {
    tmpvar_12 = -(tmpvar_11.x);
  };
  highp float tmpvar_13;
  if ((tmpvar_10.y >= 0.0)) {
    tmpvar_13 = tmpvar_11.y;
  } else {
    tmpvar_13 = -(tmpvar_11.y);
  };
  highp float tmpvar_14;
  if ((tmpvar_10.z >= 0.0)) {
    tmpvar_14 = tmpvar_11.z;
  } else {
    tmpvar_14 = -(tmpvar_11.z);
  };
  highp float tmpvar_15;
  if ((tmpvar_10.w >= 0.0)) {
    tmpvar_15 = tmpvar_11.w;
  } else {
    tmpvar_15 = -(tmpvar_11.w);
  };
  highp vec4 tmpvar_16;
  tmpvar_16.x = tmpvar_12;
  tmpvar_16.y = tmpvar_13;
  tmpvar_16.z = tmpvar_14;
  tmpvar_16.w = tmpvar_15;
  tile_1 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (_Color.xyz * _glesColor.xyz);
  tmpvar_17.w = tmpvar_6;
  tmpvar_2 = tmpvar_17;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xyxy + tmpvar_16) * tmpvar_7.xyxy);
  xlv_COLOR = tmpvar_2;
}



#endif
#ifdef FRAGMENT

uniform sampler2D _MainTex;
varying highp vec4 xlv_TEXCOORD0;
varying lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (mix (texture2D (_MainTex, xlv_TEXCOORD0.xy), texture2D (_MainTex, xlv_TEXCOORD0.zw), xlv_COLOR.wwww) * xlv_COLOR);
  gl_FragData[0] = tmpvar_1;
}



#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es


#ifdef VERTEX


in vec4 _glesVertex;
in vec4 _glesColor;
in vec4 _glesMultiTexCoord0;
uniform highp vec4 _Time;
uniform highp mat4 glstate_matrix_mvp;
uniform highp vec4 _Color;
uniform highp vec4 _NumTexTiles;
uniform highp float _ReplaySpeed;
out highp vec4 xlv_TEXCOORD0;
out lowp vec4 xlv_COLOR;
void main ()
{
  highp vec4 tile_1;
  lowp vec4 tmpvar_2;
  highp float tmpvar_3;
  tmpvar_3 = (((_glesColor.w * 60.0) + _Time.y) * _ReplaySpeed);
  highp float tmpvar_4;
  tmpvar_4 = floor(tmpvar_3);
  highp float tmpvar_5;
  tmpvar_5 = (tmpvar_4 + 1.0);
  highp float tmpvar_6;
  tmpvar_6 = (tmpvar_3 - tmpvar_4);
  highp vec2 tmpvar_7;
  tmpvar_7 = (1.0/(_NumTexTiles.xy));
  highp vec2 tmpvar_8;
  tmpvar_8.x = tmpvar_4;
  tmpvar_8.y = floor((tmpvar_4 / _NumTexTiles.x));
  tile_1.xy = tmpvar_8;
  highp vec2 tmpvar_9;
  tmpvar_9.x = tmpvar_5;
  tmpvar_9.y = floor((tmpvar_5 / _NumTexTiles.x));
  tile_1.zw = tmpvar_9;
  highp vec4 tmpvar_10;
  tmpvar_10 = (tile_1 / _NumTexTiles.xyxy);
  highp vec4 tmpvar_11;
  tmpvar_11 = (fract(abs(tmpvar_10)) * _NumTexTiles.xyxy);
  highp float tmpvar_12;
  if ((tmpvar_10.x >= 0.0)) {
    tmpvar_12 = tmpvar_11.x;
  } else {
    tmpvar_12 = -(tmpvar_11.x);
  };
  highp float tmpvar_13;
  if ((tmpvar_10.y >= 0.0)) {
    tmpvar_13 = tmpvar_11.y;
  } else {
    tmpvar_13 = -(tmpvar_11.y);
  };
  highp float tmpvar_14;
  if ((tmpvar_10.z >= 0.0)) {
    tmpvar_14 = tmpvar_11.z;
  } else {
    tmpvar_14 = -(tmpvar_11.z);
  };
  highp float tmpvar_15;
  if ((tmpvar_10.w >= 0.0)) {
    tmpvar_15 = tmpvar_11.w;
  } else {
    tmpvar_15 = -(tmpvar_11.w);
  };
  highp vec4 tmpvar_16;
  tmpvar_16.x = tmpvar_12;
  tmpvar_16.y = tmpvar_13;
  tmpvar_16.z = tmpvar_14;
  tmpvar_16.w = tmpvar_15;
  tile_1 = tmpvar_16;
  highp vec4 tmpvar_17;
  tmpvar_17.xyz = (_Color.xyz * _glesColor.xyz);
  tmpvar_17.w = tmpvar_6;
  tmpvar_2 = tmpvar_17;
  gl_Position = (glstate_matrix_mvp * _glesVertex);
  xlv_TEXCOORD0 = ((_glesMultiTexCoord0.xyxy + tmpvar_16) * tmpvar_7.xyxy);
  xlv_COLOR = tmpvar_2;
}



#endif
#ifdef FRAGMENT


layout(location=0) out mediump vec4 _glesFragData[4];
uniform sampler2D _MainTex;
in highp vec4 xlv_TEXCOORD0;
in lowp vec4 xlv_COLOR;
void main ()
{
  lowp vec4 tmpvar_1;
  tmpvar_1 = (mix (texture (_MainTex, xlv_TEXCOORD0.xy), texture (_MainTex, xlv_TEXCOORD0.zw), xlv_COLOR.wwww) * xlv_COLOR);
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
}