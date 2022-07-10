Shader "MobileWater/MobileWater" {
Properties {
 _Color ("Water Colour", Color) = (1,1,1,1)
 _MainTex ("Water Texture", 2D) = "" {}
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "gles " {
"!!GLES
#ifndef SHADER_API_GLES
    #define SHADER_API_GLES 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
#line 14
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 14
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

        varying mediump vec2 uv;
                     
        

#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform highp mat4 glstate_matrix_mvp;
#define gl_Vertex _glesVertex
attribute vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
attribute vec4 _glesMultiTexCoord0;

        uniform mediump vec4 _MainTex_ST;
        void main() {
   gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
            uv = gl_MultiTexCoord0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        }
  
#endif
#ifdef FRAGMENT

        uniform lowp sampler2D _MainTex;
        uniform lowp vec4 _Color;
        void main() {
            gl_FragColor = texture2D(_MainTex, uv) * _Color;
        }

        
#endif"
}
SubProgram "gles3 " {
"!!GLES3#version 300 es
#ifndef SHADER_API_GLES3
    #define SHADER_API_GLES3 1
#endif
#ifndef SHADER_API_MOBILE
    #define SHADER_API_MOBILE 1
#endif
// version 300 es
#line 14
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

#line 14
#ifdef DUMMY_PREPROCESSOR_TO_WORK_AROUND_HLSL_COMPILER_LINE_HANDLING
#endif

        varying mediump vec2 uv;
                     
        

#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform highp mat4 glstate_matrix_mvp;
#define gl_Vertex _glesVertex
in vec4 _glesVertex;
#define gl_MultiTexCoord0 _glesMultiTexCoord0
in vec4 _glesMultiTexCoord0;

        uniform mediump vec4 _MainTex_ST;
        void main() {
   gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
            uv = gl_MultiTexCoord0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
        }
  
#endif
#ifdef FRAGMENT
#define gl_FragColor _glesFragData[0]
#define gl_FragData _glesFragData
layout(location = 0) out mediump vec4 _glesFragData[4];

        uniform lowp sampler2D _MainTex;
        uniform lowp vec4 _Color;
        void main() {
            gl_FragColor = texture(_MainTex, uv) * _Color;
        }

        
#endif"
}
}
 }
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
  SetTexture [_MainTex] { ConstantColor [_Color] combine texture * constant }
 }
}
}