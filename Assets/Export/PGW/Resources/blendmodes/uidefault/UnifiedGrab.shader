Shader "BlendModes/UIDefault/UnifiedGrab" {
Properties {
[PerRendererData]  _MainTex ("Sprite Texture", 2D) = "white" {}
 _Color ("Tint", Color) = (1,1,1,1)
 _StencilComp ("Stencil Comparison", Float) = 8
 _Stencil ("Stencil ID", Float) = 0
 _StencilOp ("Stencil Operation", Float) = 0
 _StencilWriteMask ("Stencil Write Mask", Float) = 255
 _StencilReadMask ("Stencil Read Mask", Float) = 255
 _ColorMask ("Color Mask", Float) = 15
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "PreviewType"="Plane" }
 GrabPass {
  "_BMSharedGT"
 }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "PreviewType"="Plane" }
  ZTest [unity_GUIZTestMode]
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Stencil {
   Ref [_Stencil]
   ReadMask [_StencilReadMask]
   WriteMask [_StencilWriteMask]
   Comp [_StencilComp]
   Pass [_StencilOp]
  }
  Blend SrcAlpha OneMinusSrcAlpha
  ColorMask [_ColorMask]
Program "vp" {
SubProgram "opengl " {
Keywords { "BMDarken" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarken" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMDarken" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarken" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMMultiply" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMMultiply" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMMultiply" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMMultiply" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMColorBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMColorBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMColorBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMColorBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMLinearBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMDarkerColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarkerColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMDarkerColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarkerColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMLighten" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLighten" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMLighten" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLighten" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMScreen" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMScreen" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMScreen" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMScreen" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMColorDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMColorDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMColorDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMColorDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMLinearDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMLighterColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLighterColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMLighterColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLighterColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMOverlay" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMOverlay" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMOverlay" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMOverlay" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMSoftLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMSoftLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMSoftLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMSoftLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMHardLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMHardLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMHardLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMHardLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMVividLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMVividLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMVividLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMVividLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMLinearLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMPinLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMPinLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMPinLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMPinLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMHardMix" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMHardMix" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMHardMix" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMHardMix" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMDifference" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDifference" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMDifference" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDifference" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMExclusion" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMExclusion" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMExclusion" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMExclusion" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMSubtract" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMSubtract" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMSubtract" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMSubtract" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMDivide" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
"!!ARBvp1.0
PARAM c[6] = { program.local[0],
		state.matrix.mvp,
		program.local[5] };
TEMP R0;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MOV result.position, R0;
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDivide" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, -1.00000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4.zwzw
add r0.zw, c6.x, r0.xyxy
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mad oPos.xy, r0.zwzw, c6, r0
dp4 r0.z, v0, c2
dp4 r0.w, v0, c3
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMDivide" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDivide" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "BMDarken" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
SLT R0.w, R1, c[0].z;
MAD R0.y, fragment.texcoord[1].x, R0.x, c[0].x;
MAD R0.z, fragment.texcoord[1].y, R0.x, c[0].x;
MUL R0.x, R0.y, c[0].y;
MUL R0.y, R0.z, c[0];
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
KIL -R0.w;
MIN result.color.xyz, R1, R0;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarken" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, 0.50000000
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r2, r0, v0
add_pp r0.x, r2.w, c0
cmp r1.x, r0, c0.y, c0.z
mov_pp r3, -r1.x
rcp r0.x, t1.w
mad r1.x, t1, r0, c0.z
mad r0.x, t1.y, r0, c0.z
mul r1.x, r1, c0.w
mad r1.y, -r0.x, c0.w, c0.z
texld r0, r1, s1
texkill r3.xyzw
min_pp r0.xyz, r2, r0
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDarken" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedapjgekbbohabmfpfiodojmlbopmkkgkfabaaaaaaniacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcoeabaaaaeaaaaaaahjaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaabaaaaaa
egaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaddaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarken" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedldlmmgmhffecbajdiekpeeicpnhbgiblabaaaaaabaaeaaaaaeaaaaaa
daaaaaaageabaaaafaadaaaanmadaaaaebgpgodjcmabaaaacmabaaaaaaacpppp
aaabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaaka
afaaaaadaaaacpiaaaaaoeiaaaaaoelaagaaaaacacaaaiiaacaapplaafaaaaad
acaaadiaacaappiaacaaoelaaeaaaaaeacaaadiaacaaoeiaaaaamjkaaaaaffka
ebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaabaioekaakaaaaadacaachia
aaaaoeiaabaaoeiaabaaaaacacaaciiaaaaappiaabaaaaacaaaicpiaacaaoeia
ppppaaaafdeieefcoeabaaaaeaaaaaaahjaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaadkbabaaa
abaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egbobaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
adaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaa
abaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaddaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
SLT R0.w, R1, c[0].z;
MAD R0.y, fragment.texcoord[1].x, R0.x, c[0].x;
MAD R0.z, fragment.texcoord[1].y, R0.x, c[0].x;
MUL R0.x, R0.y, c[0].y;
MUL R0.y, R0.z, c[0];
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
KIL -R0.w;
MUL result.color.xyz, R1, R0;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, 0.50000000
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r2, r0, v0
add_pp r0.x, r2.w, c0
cmp r1.x, r0, c0.y, c0.z
mov_pp r3, -r1.x
rcp r0.x, t1.w
mad r1.x, t1, r0, c0.z
mad r0.x, t1.y, r0, c0.z
mul r1.x, r1, c0.w
mad r1.y, -r0.x, c0.w, c0.z
texld r0, r1, s1
texkill r3.xyzw
mul_pp r0.xyz, r2, r0
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedaahigidcgaccembnpekfkhlnngejcbakabaaaaaaniacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcoeabaaaaeaaaaaaahjaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaabaaaaaa
egaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedmehadakfhnlionpbnljpjpaikcnbhfieabaaaaaaaeaeaaaaaeaaaaaa
daaaaaaafiabaaaaeeadaaaanaadaaaaebgpgodjcaabaaaacaabaaaaaaacpppp
peaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaaka
afaaaaadaaaacpiaaaaaoeiaaaaaoelaagaaaaacacaaaiiaacaapplaafaaaaad
acaaadiaacaappiaacaaoelaaeaaaaaeacaaadiaacaaoeiaaaaamjkaaaaaffka
ebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaabaioekaafaaaaadaaaachia
aaaaoeiaabaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcoeabaaaa
eaaaaaaahjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlm
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaa
aaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaaaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaadpdcaaaaakecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaa
aaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaa
abaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
SLT R0.z, R1.w, c[0];
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R0.y, R0, c[0];
MUL R0.x, R0, c[0].y;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.z, R1.z;
MOV result.color.w, R1;
KIL -R0.z;
TEX R0.xyz, R0, texture[1], 2D;
ADD R0.xyz, -R0, c[0].x;
MAD result.color.xyz, -R0, R1, c[0].x;
END
# 16 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, 0.50000000
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r2, r0, v0
add_pp r0.x, r2.w, c0
cmp r1.x, r0, c0.y, c0.z
mov_pp r3, -r1.x
rcp r0.x, t1.w
mad r1.x, t1, r0, c0.z
mad r0.x, t1.y, r0, c0.z
mad r1.y, -r0.x, c0.w, c0.z
mul r1.x, r1, c0.w
rcp_pp r1.z, r2.z
texld r0, r1, s1
texkill r3.xyzw
add_pp r0.xyz, -r0, c0.z
rcp_pp r1.x, r2.x
rcp_pp r1.y, r2.y
mad_pp r0.xyz, -r0, r1, c0.z
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedlhlmdhgikelbapdgjldjlffiknojcjlkabaaaaaadaadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcdmacaaaaeaaaaaaaipaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaabaaaaaa
egaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaalhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaaoaaaaahhcaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaalhccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedefdggigeeaffakbigeiolbaaiidmjfbaabaaaaaajeaeaaaaaeaaaaaa
daaaaaaajaabaaaaneadaaaagaaeaaaaebgpgodjfiabaaaafiabaaaaaaacpppp
cmabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaiadp
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaaka
afaaaaadaaaacpiaaaaaoeiaaaaaoelaagaaaaacacaaaiiaacaapplaafaaaaad
acaaadiaacaappiaacaaoelaaeaaaaaeacaaadiaacaaoeiaaaaamjkaaaaaffka
ebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaabaioekaacaaaaadabaachia
abaaoeibaaaappkaagaaaaacacaaabiaaaaaaaiaagaaaaacacaaaciaaaaaffia
agaaaaacacaaaeiaaaaakkiaaeaaaaaeaaaachiaabaaoeiaacaaoeibaaaappka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcdmacaaaaeaaaaaaaipaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaah
dcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaak
ecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaa
aaaaiadpefaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaalhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaoaaaaahhcaabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaaaaaaaaalhccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
SLT R0.w, R1, c[0].z;
MAD R0.y, fragment.texcoord[1].x, R0.x, c[0].x;
MAD R0.z, fragment.texcoord[1].y, R0.x, c[0].x;
MUL R0.x, R0.y, c[0].y;
MUL R0.y, R0.z, c[0];
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
KIL -R0.w;
ADD R0.xyz, R1, R0;
ADD result.color.xyz, R0, -c[0].x;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, 0.50000000
def c1, -1.00000000, 0, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r2, r0, v0
add_pp r0.x, r2.w, c0
cmp r1.x, r0, c0.y, c0.z
mov_pp r3, -r1.x
rcp r0.x, t1.w
mad r1.x, t1, r0, c0.z
mad r0.x, t1.y, r0, c0.z
mul r1.x, r1, c0.w
mad r1.y, -r0.x, c0.w, c0.z
texld r0, r1, s1
texkill r3.xyzw
add_pp r0.xyz, r2, r0
add_pp r0.xyz, r0, c1.x
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefieceddieoeoiafdbdljfakkfcbkmpmdnnhedmabaaaaaaaiadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbeacaaaaeaaaaaaaifaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaah
dcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaak
ecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaa
aaaaiadpefaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaak
hccabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedhjifplbnbkmegnlgcedjnoknjccphockabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaagmabaaaaiiadaaaabeaeaaaaebgpgodjdeabaaaadeabaaaaaaacpppp
aiabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaialp
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaaka
agaaaaacacaaaiiaacaapplaafaaaaadacaaadiaacaappiaacaaoelaaeaaaaae
acaaadiaacaaoeiaaaaamjkaaaaaffkaebaaaaababaaapiaecaaaaadabaacpia
acaaoeiaabaioekaaeaaaaaeaaaachiaaaaaoeiaaaaaoelaabaaoeiaafaaaaad
abaaciiaaaaappiaaaaapplaacaaaaadabaachiaaaaaoeiaaaaappkaabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefcbeacaaaaeaaaaaaaifaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaah
dcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaak
ecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaa
aaaaiadpefaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaajhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaak
hccabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
hkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[2] = { { 0.29907227, 1, 0.5, 0.58691406 },
		{ 0.11401367, 0.010002136 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0];
SLT R0.z, R1.w, c[1].y;
MAD R0.x, fragment.texcoord[1], R0, c[0].y;
MUL R2.x, R1.y, c[0].w;
MAD R2.x, R1, c[0], R2;
MUL R0.y, R0, c[0].z;
MUL R0.x, R0, c[0].z;
MAD R2.x, R1.z, c[1], R2;
MOV result.color.w, R1;
KIL -R0.z;
TEX R0.xyz, R0, texture[1], 2D;
MUL R0.w, R0.y, c[0];
MAD R0.w, R0.x, c[0].x, R0;
MAD R0.w, R0.z, c[1].x, R0;
ADD R0.w, R0, -R2.x;
CMP result.color.xyz, R0.w, R0, R1;
END
# 19 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, 0.50000000
def c1, 0.58691406, 0.29907227, 0.11401367, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r2, r0, v0
add_pp r0.x, r2.w, c0
cmp r1.x, r0, c0.y, c0.z
mov_pp r3, -r1.x
rcp r0.x, t1.w
mad r1.x, t1, r0, c0.z
mad r0.x, t1.y, r0, c0.z
mul r1.x, r1, c0.w
mad r1.y, -r0.x, c0.w, c0.z
texld r0, r1, s1
texkill r3.xyzw
mul_pp r1.x, r0.y, c1
mad_pp r1.x, r0, c1.y, r1
mul_pp r3.x, r2.y, c1
mad_pp r3.x, r2, c1.y, r3
mad_pp r1.x, r0.z, c1.z, r1
mad_pp r3.x, r2.z, c1.z, r3
add_pp r1.x, r1, -r3
cmp_pp r0.xyz, r1.x, r2, r0
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedmgdmpdlgfngdjioenbalnniijhefceneabaaaaaaemadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcfiacaaaaeaaaaaaajgaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaabaaaaaa
egaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaabaaaaaakicaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaabaaaaaakbcaabaaaacaaaaaaegacbaaaaaaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaadbaaaaahicaabaaaabaaaaaa
dkaabaaaabaaaaaaakaabaaaacaaaaaadhaaaaajhccabaaaaaaaaaaapgapbaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecednfmgodnejlgcmbhlaldjlblnfjfmjoilabaaaaaabeafaaaaaeaaaaaa
daaaaaaapeabaaaafeaeaaaaoaaeaaaaebgpgodjlmabaaaalmabaaaaaaacpppp
jaabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpkcefbgdp
fbaaaaafabaaapkaihbgjjdonfhiojdnaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaiaacaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaadaaaaapiaabaaoela
aaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaakaafaaaaadaaaacpia
aaaaoeiaaaaaoelaagaaaaacacaaaiiaacaapplaafaaaaadacaaadiaacaappia
acaaoelaaeaaaaaeacaaadiaacaaoeiaaaaamjkaaaaaffkaebaaaaababaaapia
ecaaaaadabaacpiaacaaoeiaabaioekaafaaaaadabaaciiaaaaaffiaaaaappka
aeaaaaaeabaaciiaaaaaaaiaabaaaakaabaappiaaeaaaaaeabaaciiaaaaakkia
abaaffkaabaappiaafaaaaadacaacbiaabaaffiaaaaappkaaeaaaaaeacaacbia
abaaaaiaabaaaakaacaaaaiaaeaaaaaeacaacbiaabaakkiaabaaffkaacaaaaia
acaaaaadabaaaiiaabaappibacaaaaiafiaaaaaeaaaachiaabaappiaaaaaoeia
abaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcfiacaaaaeaaaaaaa
jgaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaa
aoaaaaahdcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaak
dcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadp
dcaaaaakecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadp
abeaaaaaaaaaiadpefaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaabaaaaaakicaabaaaabaaaaaaegacbaaaabaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaabaaaaaakbcaabaaaacaaaaaa
egacbaaaaaaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaadbaaaaah
icaabaaaabaaaaaadkaabaaaabaaaaaaakaabaaaacaaaaaadhaaaaajhccabaaa
aaaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
SLT R0.w, R1, c[0].z;
MAD R0.y, fragment.texcoord[1].x, R0.x, c[0].x;
MAD R0.z, fragment.texcoord[1].y, R0.x, c[0].x;
MUL R0.x, R0.y, c[0].y;
MUL R0.y, R0.z, c[0];
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
KIL -R0.w;
MAX result.color.xyz, R1, R0;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, 0.50000000
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r2, r0, v0
add_pp r0.x, r2.w, c0
cmp r1.x, r0, c0.y, c0.z
mov_pp r3, -r1.x
rcp r0.x, t1.w
mad r1.x, t1, r0, c0.z
mad r0.x, t1.y, r0, c0.z
mul r1.x, r1, c0.w
mad r1.y, -r0.x, c0.w, c0.z
texld r0, r1, s1
texkill r3.xyzw
max_pp r0.xyz, r2, r0
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedhpfkglbbekeaocmkbolgnhpjfifkohaaabaaaaaaniacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcoeabaaaaeaaaaaaahjaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaabaaaaaa
egaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadeaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedohhnfnffeoaigkndndcbbkoojkmefadfabaaaaaabaaeaaaaaeaaaaaa
daaaaaaageabaaaafaadaaaanmadaaaaebgpgodjcmabaaaacmabaaaaaaacpppp
aaabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaaka
afaaaaadaaaacpiaaaaaoeiaaaaaoelaagaaaaacacaaaiiaacaapplaafaaaaad
acaaadiaacaappiaacaaoelaaeaaaaaeacaaadiaacaaoeiaaaaamjkaaaaaffka
ebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaabaioekaalaaaaadacaachia
abaaoeiaaaaaoeiaabaaaaacacaaciiaaaaappiaabaaaaacaaaicpiaacaaoeia
ppppaaaafdeieefcoeabaaaaeaaaaaaahjaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaadkbabaaa
abaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egbobaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
adaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaa
abaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadeaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
SLT R0.z, R1.w, c[0];
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R0.y, R0, c[0];
MUL R0.x, R0, c[0].y;
ADD R1.xyz, -R1, c[0].x;
MOV result.color.w, R1;
KIL -R0.z;
TEX R0.xyz, R0, texture[1], 2D;
ADD R0.xyz, -R0, c[0].x;
MAD result.color.xyz, -R0, R1, c[0].x;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, 0.50000000
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r2, r0, v0
add_pp r0.x, r2.w, c0
cmp r1.x, r0, c0.y, c0.z
mov_pp r3, -r1.x
rcp r0.x, t1.w
mad r1.x, t1, r0, c0.z
mad r0.x, t1.y, r0, c0.z
mad r1.y, -r0.x, c0.w, c0.z
mul r1.x, r1, c0.w
texld r0, r1, s1
texkill r3.xyzw
add_pp r1.xyz, -r2, c0.z
add_pp r0.xyz, -r0, c0.z
mad_pp r0.xyz, -r0, r1, c0.z
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedjlmpajojpeajeiajgemefcjimgjiegkjabaaaaaafaadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcfmacaaaaeaaaaaaajhaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaah
dcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaak
ecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaa
aaaaiadpefaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaaaaaaaalhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaanhcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaanhccabaaa
aaaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedfkkdhcobgoigcogjhafepnjikkengmffabaaaaaakeaeaaaaaeaaaaaa
daaaaaaaiaabaaaaoeadaaaahaaeaaaaebgpgodjeiabaaaaeiabaaaaaaacpppp
bmabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaiadp
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaaka
agaaaaacacaaaiiaacaapplaafaaaaadacaaadiaacaappiaacaaoelaaeaaaaae
acaaadiaacaaoeiaaaaamjkaaaaaffkaebaaaaababaaapiaecaaaaadabaacpia
acaaoeiaabaioekaacaaaaadabaachiaabaaoeibaaaappkaaeaaaaaeaaaachia
aaaaoeiaaaaaoelbaaaappkaafaaaaadacaaciiaaaaappiaaaaapplaaeaaaaae
acaachiaabaaoeiaaaaaoeibaaaappkaabaaaaacaaaicpiaacaaoeiappppaaaa
fdeieefcfmacaaaaeaaaaaaajhaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaa
abeaaaaaaknhcdlmdbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
adaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaa
abaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaal
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadcaaaaanhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
egbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaanhccabaaaaaaaaaaaegacbaiaebaaaaaa
abaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
doaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaa
abaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
ADD R1.xyz, -R1, c[0].x;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
SLT R0.z, R1.w, c[0];
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R0.y, R0, c[0];
MUL R0.x, R0, c[0].y;
RCP R1.x, R1.x;
RCP R1.z, R1.z;
RCP R1.y, R1.y;
MOV result.color.w, R1;
KIL -R0.z;
TEX R0.xyz, R0, texture[1], 2D;
MUL result.color.xyz, R0, R1;
END
# 16 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, 0.50000000
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r2, r0, v0
add_pp r0.x, r2.w, c0
cmp r1.x, r0, c0.y, c0.z
mov_pp r3, -r1.x
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0.z
mad r0.y, -r1.x, c0.w, c0.z
add_pp r1.xyz, -r2, c0.z
mad r0.x, t1, r0, c0.z
mul r0.x, r0, c0.w
rcp_pp r1.x, r1.x
rcp_pp r1.z, r1.z
rcp_pp r1.y, r1.y
texld r0, r0, s1
texkill r3.xyzw
mul_pp r0.xyz, r0, r1
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedgnmikpepahglhogiemogcanplcbljgkmabaaaaaaamadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbiacaaaaeaaaaaaaigaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaah
dcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaak
ecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaa
aaaaiadpefaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaanhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
egbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaaaoaaaaahhccabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedddcpggnpamogfkljmdglgkakmbpmoohcabaaaaaahaaeaaaaaeaaaaaa
daaaaaaajaabaaaalaadaaaadmaeaaaaebgpgodjfiabaaaafiabaaaaaaacpppp
cmabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaiadp
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaaka
agaaaaacacaaaiiaacaapplaafaaaaadacaaadiaacaappiaacaaoelaaeaaaaae
acaaadiaacaaoeiaaaaamjkaaaaaffkaebaaaaababaaapiaecaaaaadabaacpia
acaaoeiaabaioekaaeaaaaaeaaaachiaaaaaoeiaaaaaoelbaaaappkaafaaaaad
acaaciiaaaaappiaaaaapplaagaaaaacadaaabiaaaaaaaiaagaaaaacadaaacia
aaaaffiaagaaaaacadaaaeiaaaaakkiaafaaaaadacaachiaabaaoeiaadaaoeia
abaaaaacaaaicpiaacaaoeiappppaaaafdeieefcbiacaaaaeaaaaaaaigaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdbaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaa
aoaaaaahdcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaak
dcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadp
dcaaaaakecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadp
abeaaaaaaaaaiadpefaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadcaaaaanhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaahhccabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
SLT R0.w, R1, c[0].z;
MAD R0.y, fragment.texcoord[1].x, R0.x, c[0].x;
MAD R0.z, fragment.texcoord[1].y, R0.x, c[0].x;
MUL R0.x, R0.y, c[0].y;
MUL R0.y, R0.z, c[0];
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
KIL -R0.w;
ADD result.color.xyz, R1, R0;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, 0.50000000
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r2, r0, v0
add_pp r0.x, r2.w, c0
cmp r1.x, r0, c0.y, c0.z
mov_pp r3, -r1.x
rcp r0.x, t1.w
mad r1.x, t1, r0, c0.z
mad r0.x, t1.y, r0, c0.z
mul r1.x, r1, c0.w
mad r1.y, -r0.x, c0.w, c0.z
texld r0, r1, s1
texkill r3.xyzw
add_pp r0.xyz, r2, r0
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedcjgbkfiagiebbjmcilbhjcgmmbedpokgabaaaaaaoaacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcomabaaaaeaaaaaaahlaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaah
dcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaak
ecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaa
aaaaiadpefaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedilmhefddgoaelmgdkpifkbpicoeelgkkabaaaaaabaaeaaaaaeaaaaaa
daaaaaaafmabaaaafaadaaaanmadaaaaebgpgodjceabaaaaceabaaaaaaacpppp
piaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaaka
agaaaaacacaaaiiaacaapplaafaaaaadacaaadiaacaappiaacaaoelaaeaaaaae
acaaadiaacaaoeiaaaaamjkaaaaaffkaebaaaaababaaapiaecaaaaadabaacpia
acaaoeiaabaioekaaeaaaaaeabaachiaaaaaoeiaaaaaoelaabaaoeiaafaaaaad
abaaciiaaaaappiaaaaapplaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefc
omabaaaaeaaaaaaahlaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
lcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaa
aknhcdlmdbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaabaaaaaabkaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaabaaaaaa
igaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaajhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaadiaaaaah
bcaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaaakaabaaaaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[2] = { { 0.29907227, 1, 0.5, 0.58691406 },
		{ 0.11401367, 0.010002136 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0];
SLT R0.z, R1.w, c[1].y;
MAD R0.x, fragment.texcoord[1], R0, c[0].y;
MUL R2.x, R1.y, c[0].w;
MAD R2.x, R1, c[0], R2;
MUL R0.y, R0, c[0].z;
MUL R0.x, R0, c[0].z;
MAD R2.x, R1.z, c[1], R2;
MOV result.color.w, R1;
KIL -R0.z;
TEX R0.xyz, R0, texture[1], 2D;
MUL R0.w, R0.y, c[0];
MAD R0.w, R0.x, c[0].x, R0;
MAD R0.w, R0.z, c[1].x, R0;
ADD R0.w, R0, -R2.x;
CMP result.color.xyz, -R0.w, R0, R1;
END
# 19 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, 0.50000000
def c1, 0.58691406, 0.29907227, 0.11401367, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r2, r0, v0
add_pp r0.x, r2.w, c0
cmp r1.x, r0, c0.y, c0.z
mov_pp r3, -r1.x
rcp r0.x, t1.w
mad r1.x, t1, r0, c0.z
mad r0.x, t1.y, r0, c0.z
mul r1.x, r1, c0.w
mad r1.y, -r0.x, c0.w, c0.z
texld r0, r1, s1
texkill r3.xyzw
mul_pp r1.x, r0.y, c1
mad_pp r1.x, r0, c1.y, r1
mul_pp r3.x, r2.y, c1
mad_pp r3.x, r2, c1.y, r3
mad_pp r1.x, r0.z, c1.z, r1
mad_pp r3.x, r2.z, c1.z, r3
add_pp r1.x, r1, -r3
cmp_pp r0.xyz, -r1.x, r2, r0
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedbgkcadpmnjdaiaejcbhejngdgjaogjgnabaaaaaaemadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcfiacaaaaeaaaaaaajgaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaabaaaaaa
egaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaabaaaaaakicaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaabaaaaaakbcaabaaaacaaaaaaegacbaaaaaaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaadbaaaaahicaabaaaabaaaaaa
akaabaaaacaaaaaadkaabaaaabaaaaaadhaaaaajhccabaaaaaaaaaaapgapbaaa
abaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedapbckpfhpphblhmhpfajmniefombbkohabaaaaaabeafaaaaaeaaaaaa
daaaaaaapeabaaaafeaeaaaaoaaeaaaaebgpgodjlmabaaaalmabaaaaaaacpppp
jaabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpkcefbgdp
fbaaaaafabaaapkaihbgjjdonfhiojdnaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaiaacaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaadaaaaapiaabaaoela
aaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaakaafaaaaadaaaacpia
aaaaoeiaaaaaoelaagaaaaacacaaaiiaacaapplaafaaaaadacaaadiaacaappia
acaaoelaaeaaaaaeacaaadiaacaaoeiaaaaamjkaaaaaffkaebaaaaababaaapia
ecaaaaadabaacpiaacaaoeiaabaioekaafaaaaadabaaciiaaaaaffiaaaaappka
aeaaaaaeabaaciiaaaaaaaiaabaaaakaabaappiaaeaaaaaeabaaciiaaaaakkia
abaaffkaabaappiaafaaaaadacaacbiaabaaffiaaaaappkaaeaaaaaeacaacbia
abaaaaiaabaaaakaacaaaaiaaeaaaaaeacaacbiaabaakkiaabaaffkaacaaaaia
acaaaaadabaaaiiaabaappiaacaaaaibfiaaaaaeaaaachiaabaappiaaaaaoeia
abaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcfiacaaaaeaaaaaaa
jgaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaahbcaabaaa
abaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaa
aoaaaaahdcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaak
dcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadp
dcaaaaakecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadp
abeaaaaaaaaaiadpefaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaabaaaaaakicaabaaaabaaaaaaegacbaaaabaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaabaaaaaakbcaabaaaacaaaaaa
egacbaaaaaaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaadbaaaaah
icaabaaaabaaaaaaakaabaaaacaaaaaadkaabaaaabaaaaaadhaaaaajhccabaaa
aaaaaaaapgapbaaaabaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 2, 0.010002136 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
SLT R0.z, R1.w, c[0].w;
MAD R0.x, fragment.texcoord[1], R0, c[0];
ADD R3.xyz, -R1, c[0].x;
MUL R0.y, R0, c[0];
MUL R0.x, R0, c[0].y;
MOV result.color.w, R1;
KIL -R0.z;
TEX R0.xyz, R0, texture[1], 2D;
MUL R1.xyz, R1, R0;
ADD R2.xyz, -R0, c[0].x;
MUL R2.xyz, R2, R3;
MAD R2.xyz, -R2, c[0].z, c[0].x;
MUL R1.xyz, R1, c[0].z;
ADD R0.xyz, R0, -c[0].y;
CMP result.color.xyz, -R0, R2, R1;
END
# 19 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, 0.50000000
def c1, 2.00000000, -0.50000000, 1.00000000, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r2, r0, v0
add_pp r0.x, r2.w, c0
cmp r1.x, r0, c0.y, c0.z
mov_pp r3, -r1.x
rcp r0.x, t1.w
mad r1.x, t1, r0, c0.z
mad r0.x, t1.y, r0, c0.z
mad r1.y, -r0.x, c0.w, c0.z
mul r1.x, r1, c0.w
texld r0, r1, s1
texkill r3.xyzw
mul_pp r1.xyz, r2, r0
add_pp r3.xyz, -r2, c0.z
add_pp r2.xyz, -r0, c0.z
mul_pp r2.xyz, r2, r3
mul_pp r1.xyz, r1, c1.x
mad_pp r2.xyz, -r2, c1.x, c1.z
add_pp r0.xyz, r0, c1.y
cmp_pp r0.xyz, -r0, r1, r2
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedjfboikfkoemfeelmniahhpikgmjmobliabaaaaaapaadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpmacaaaaeaaaaaaalpaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaadcaaaaan
hcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaacaaaaaabkaabaiaebaaaaaa
acaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaacaaaaaa
igaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaa
adaaaaaaegacbaiaebaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaaegacbaaaadaaaaaa
dcaaaaanhcaabaaaabaaaaaaegacbaiaebaaaaaaadaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaadbaaaaakhcaabaaaacaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedkboekhlkmjfjfipgbpggilldblphllacabaaaaaajiafaaaaaeaaaaaa
daaaaaaaneabaaaaniaeaaaageafaaaaebgpgodjjmabaaaajmabaaaaaaacpppp
haabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaiadp
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaaka
agaaaaacacaaaiiaacaapplaafaaaaadacaaadiaacaappiaacaaoelaaeaaaaae
acaaadiaacaaoeiaaaaamjkaaaaaffkaebaaaaababaaapiaecaaaaadabaacpia
acaaoeiaabaioekaaeaaaaaeacaachiaaaaaoeiaaaaaoelbaaaappkaafaaaaad
aaaacpiaaaaaoeiaaaaaoelaacaaaaadadaachiaabaaoeibaaaappkaacaaaaad
adaachiaadaaoeiaadaaoeiaaeaaaaaeacaachiaadaaoeiaacaaoeibaaaappka
afaaaaadadaachiaabaaoeiaaaaaoeiaacaaaaadabaaahiaabaaoeibaaaaffka
acaaaaadadaachiaadaaoeiaadaaoeiafiaaaaaeaaaachiaabaaoeiaadaaoeia
acaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcpmacaaaaeaaaaaaa
lpaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaadcaaaaanhcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaegbcbaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaa
egbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaacaaaaaaegaabaaa
acaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaacaaaaaa
bkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaacaaaaaaigaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaalhcaabaaaadaaaaaaegacbaiaebaaaaaaacaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaadaaaaaa
egacbaaaadaaaaaadcaaaaanhcaabaaaabaaaaaaegacbaiaebaaaaaaadaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadbaaaaakhcaabaaa
acaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaacaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheoieaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 0.010002136 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
SLT R0.z, R1.w, c[0];
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R0.y, R0, c[0];
MUL R0.x, R0, c[0].y;
ADD R3.xyz, -R1, c[0].x;
MOV result.color.w, R1;
KIL -R0.z;
TEX R0.xyz, R0, texture[1], 2D;
ADD R2.xyz, -R0, c[0].x;
MAD R3.xyz, -R2, R3, c[0].x;
MUL R3.xyz, R0, R3;
MUL R0.xyz, R2, R0;
MAD result.color.xyz, R1, R0, R3;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, 0.50000000
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r2, r0, v0
add_pp r0.x, r2.w, c0
cmp r1.x, r0, c0.y, c0.z
mov_pp r3, -r1.x
rcp r0.x, t1.w
mad r1.x, t1, r0, c0.z
mad r0.x, t1.y, r0, c0.z
mad r1.y, -r0.x, c0.w, c0.z
mul r1.x, r1, c0.w
texld r0, r1, s1
texkill r3.xyzw
add_pp r1.xyz, -r0, c0.z
add_pp r3.xyz, -r2, c0.z
mad_pp r3.xyz, -r1, r3, c0.z
mul_pp r3.xyz, r0, r3
mul_pp r0.xyz, r1, r0
mad_pp r0.xyz, r2, r0, r3
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedoelmfleladhodkbopkilhdemgheibobgabaaaaaakmadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcliacaaaaeaaaaaaakoaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaadcaaaaan
hcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaacaaaaaabkaabaiaebaaaaaa
acaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaacaaaaaa
igaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaa
adaaaaaaegacbaiaebaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadcaaaaanhcaabaaaabaaaaaaegacbaiaebaaaaaaadaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahhcaabaaa
adaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
adaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedoonjmldngkckphnhcepciallkkkelddfabaaaaaadeafaaaaaeaaaaaa
daaaaaaaleabaaaaheaeaaaaaaafaaaaebgpgodjhmabaaaahmabaaaaaaacpppp
faabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaiadp
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaaka
agaaaaacacaaaiiaacaapplaafaaaaadacaaadiaacaappiaacaaoelaaeaaaaae
acaaadiaacaaoeiaaaaamjkaaaaaffkaebaaaaababaaapiaecaaaaadabaacpia
acaaoeiaabaioekaaeaaaaaeacaachiaaaaaoeiaaaaaoelbaaaappkaafaaaaad
aaaacpiaaaaaoeiaaaaaoelaacaaaaadadaachiaabaaoeibaaaappkaaeaaaaae
acaachiaadaaoeiaacaaoeibaaaappkaafaaaaadadaachiaabaaoeiaadaaoeia
afaaaaadabaachiaabaaoeiaacaaoeiaaeaaaaaeaaaachiaadaaoeiaaaaaoeia
abaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcliacaaaaeaaaaaaa
koaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaadcaaaaanhcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaegbcbaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaa
egbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaacaaaaaaegaabaaa
acaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaacaaaaaa
bkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaacaaaaaaigaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaalhcaabaaaadaaaaaaegacbaiaebaaaaaaacaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadcaaaaanhcaabaaaabaaaaaaegacbaiaebaaaaaa
adaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
diaaaaahhcaabaaaadaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadcaaaaajhccabaaa
aaaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2, 0.010002136 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
SLT R0.w, R1, c[0];
MAD R0.y, fragment.texcoord[1].x, R0.x, c[0];
MAD R0.z, fragment.texcoord[1].y, R0.x, c[0].y;
MUL R0.x, R0.y, c[0];
MUL R0.y, R0.z, c[0].x;
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
KIL -R0.w;
MUL R2.xyz, R1, R0;
ADD R1.xyz, R1, -c[0].x;
MUL R2.xyz, R2, c[0].z;
MAD R3.xyz, -R1, c[0].z, c[0].y;
ADD R0.xyz, -R0, c[0].y;
MAD R0.xyz, -R0, R3, c[0].y;
CMP result.color.xyz, -R1, R0, R2;
END
# 18 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, 0.50000000
def c1, -0.50000000, 2.00000000, 1.00000000, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r2, r0, v0
add_pp r0.x, r2.w, c0
cmp r1.x, r0, c0.y, c0.z
mov_pp r3, -r1.x
rcp r0.x, t1.w
mad r1.x, t1, r0, c0.z
mad r0.x, t1.y, r0, c0.z
mad r1.y, -r0.x, c0.w, c0.z
mul r1.x, r1, c0.w
texld r0, r1, s1
texkill r3.xyzw
add_pp r1.xyz, r2, c1.x
mul_pp r2.xyz, r2, r0
mad_pp r3.xyz, -r1, c1.y, c1.z
add_pp r0.xyz, -r0, c0.z
mad_pp r0.xyz, -r0, r3, c0.z
mul_pp r2.xyz, r2, c1.y
cmp_pp r0.xyz, -r1, r2, r0
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedaglkecpgnkkpjpmdhmceijbopmkplgbiabaaaaaaomadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpiacaaaaeaaaaaaaloaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaabaaaaaadgajbaaa
aaaaaaaadgbjbaaaabaaaaaaaceaaaaaaknhcdlmaaaaaalpaaaaaalpaaaaaalp
diaaaaahpcaabaaaaaaaaaaadgajbaaaaaaaaaaadgbjbaaaabaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaabaocaabaaa
abaaaaaafgaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaaaaaaaaaiadpaaaaiadpaaaaiadpanaaaeadakaabaaa
abaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaa
aaaaaaakdcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaaaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaaadpdcaaaaakecaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaaabeaaaaa
aaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaacaaaaaaigaabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaaadaaaaaaegacbaia
ebaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaah
hcaabaaaacaaaaaajgahbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaadcaaaaanhcaabaaaabaaaaaa
egacbaiaebaaaaaaadaaaaaajgahbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadbaaaaakocaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaadp
aaaaaadpaaaaaadpfgaobaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaakaabaaa
aaaaaaaadhaaaaajhccabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefieceddlffdgdcaeapabglhefkddohidhofklkabaaaaaaleafaaaaaeaaaaaa
daaaaaaapeabaaaapeaeaaaaiaafaaaaebgpgodjlmabaaaalmabaaaaaaacpppp
jaabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaiadp
fbaaaaafabaaapkaaaaaaaeaaaaaiadpaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaiaacaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaadaaaaapiaabaaoela
aaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaakaagaaaaacacaaaiia
acaapplaafaaaaadacaaadiaacaappiaacaaoelaaeaaaaaeacaaadiaacaaoeia
aaaamjkaaaaaffkaebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaabaioeka
acaaaaadacaachiaabaaoeibaaaappkaaeaaaaaeadaachiaaaaaoeiaaaaaoela
aaaakkkaaeaaaaaeadaachiaadaaoeiaabaaaakbabaaffkaaeaaaaaeacaachia
acaaoeiaadaaoeibaaaappkaafaaaaadadaacpiaaaaaoeiaaaaaoelaaeaaaaae
aaaaahiaaaaaoeiaaaaaoelbaaaaffkaafaaaaadabaachiaabaaoeiaadaaoeia
acaaaaadabaachiaabaaoeiaabaaoeiafiaaaaaeadaachiaaaaaoeiaabaaoeia
acaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaafdeieefcpiacaaaaeaaaaaaa
loaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
abaaaaaadgajbaaaaaaaaaaadgbjbaaaabaaaaaaaceaaaaaaknhcdlmaaaaaalp
aaaaaalpaaaaaalpdiaaaaahpcaabaaaaaaaaaaadgajbaaaaaaaaaaadgbjbaaa
abaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
dcaaaabaocaabaaaabaaaaaafgaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaiadpaaaaiadpaaaaiadp
anaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaacaaaaaabkaabaiaebaaaaaa
acaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaacaaaaaa
igaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaa
adaaaaaaegacbaiaebaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadiaaaaahhcaabaaaacaaaaaajgahbaaaaaaaaaaaegacbaaaacaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaadcaaaaan
hcaabaaaabaaaaaaegacbaiaebaaaaaaadaaaaaajgahbaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaakocaabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaadpaaaaaadpaaaaaadpfgaobaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaakaabaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaajgahbaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2, 0.010002136 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
ADD R2.xyz, R1, -c[0].x;
MUL R1.xyz, R1, c[0].z;
MAD R3.xyz, -R2, c[0].z, c[0].y;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0];
SLT R0.z, R1.w, c[0].w;
MAD R0.x, fragment.texcoord[1], R0, c[0].y;
MUL R0.y, R0, c[0].x;
MUL R0.x, R0, c[0];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.z, R1.z;
RCP R3.x, R3.x;
RCP R3.z, R3.z;
RCP R3.y, R3.y;
MOV result.color.w, R1;
KIL -R0.z;
TEX R0.xyz, R0, texture[1], 2D;
ADD R4.xyz, -R0, c[0].y;
MAD R1.xyz, -R4, R1, c[0].y;
MUL R0.xyz, R0, R3;
CMP result.color.xyz, -R2, R0, R1;
END
# 24 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, -0.50000000
def c1, 0.50000000, 1.00000000, 2.00000000, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r1, r0, v0
add_pp r0.x, r1.w, c0
cmp r2.x, r0, c0.y, c0.z
mov_pp r3, -r2.x
rcp r0.x, t1.w
mad r2.x, t1.y, r0, c0.z
mad r0.y, -r2.x, c1.x, c1
add_pp r2.xyz, r1, c0.w
mul_pp r1.xyz, r1, c1.z
mad r0.x, t1, r0, c0.z
mul r0.x, r0, c1
rcp_pp r1.x, r1.x
rcp_pp r1.z, r1.z
rcp_pp r1.y, r1.y
texld r0, r0, s1
texkill r3.xyzw
mad_pp r3.xyz, -r2, c1.z, c1.y
rcp_pp r3.x, r3.x
rcp_pp r3.z, r3.z
rcp_pp r3.y, r3.y
mul_pp r3.xyz, r0, r3
add_pp r0.xyz, -r0, c0.z
mad_pp r0.xyz, -r0, r1, c0.z
cmp_pp r0.xyz, -r2, r0, r3
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefieceddclbdnojopaahdmaklgnaofolnjodpkbabaaaaaaaaaeaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcamadaaaaeaaaaaaamdaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaabaaaaaadgajbaaa
aaaaaaaadgbjbaaaabaaaaaaaceaaaaaaknhcdlmaaaaaalpaaaaaalpaaaaaalp
diaaaaahpcaabaaaaaaaaaaadgajbaaaaaaaaaaadgbjbaaaabaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaabaocaabaaa
abaaaaaafgaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaaaaaaaaaiadpaaaaiadpaaaaiadpanaaaeadakaabaaa
abaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaa
aaaaaaakdcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaaaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaaadpdcaaaaakecaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaaabeaaaaa
aaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaacaaaaaaigaabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaoaaaaahhcaabaaaabaaaaaaegacbaaa
acaaaaaajgahbaaaabaaaaaaaaaaaaalhcaabaaaacaaaaaaegacbaiaebaaaaaa
acaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahhcaabaaa
adaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaaoaaaaahhcaabaaaacaaaaaa
egacbaaaacaaaaaaegacbaaaadaaaaaaaaaaaaalhcaabaaaacaaaaaaegacbaia
ebaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaak
ocaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaadpfgaobaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaakaabaaaaaaaaaaadhaaaaajhccabaaa
aaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedgmgkgecdmblcejmbmakokcbgjfdlafkmabaaaaaabaagaaaaaeaaaaaa
daaaaaaadmacaaaafaafaaaanmafaaaaebgpgodjaeacaaaaaeacaaaaaaacpppp
niabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaiadp
fbaaaaafabaaapkaaaaaaaeaaaaaiadpaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaiaacaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaadaaaaapiaabaaoela
aaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaakaagaaaaacacaaaiia
acaapplaafaaaaadacaaadiaacaappiaacaaoelaaeaaaaaeacaaadiaacaaoeia
aaaamjkaaaaaffkaebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaabaioeka
aeaaaaaeacaachiaaaaaoeiaaaaaoelaaaaakkkaaeaaaaaeacaachiaacaaoeia
abaaaakbabaaffkaagaaaaacadaaabiaacaaaaiaagaaaaacadaaaciaacaaffia
agaaaaacadaaaeiaacaakkiaafaaaaadacaachiaabaaoeiaadaaoeiaacaaaaad
abaachiaabaaoeibaaaappkaafaaaaadadaacpiaaaaaoeiaaaaaoelaaeaaaaae
aaaaahiaaaaaoeiaaaaaoelbaaaaffkaacaaaaadaeaachiaadaaoeiaadaaoeia
agaaaaacafaaabiaaeaaaaiaagaaaaacafaaaciaaeaaffiaagaaaaacafaaaeia
aeaakkiaaeaaaaaeabaachiaabaaoeiaafaaoeibaaaappkafiaaaaaeadaachia
aaaaoeiaabaaoeiaacaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaafdeieefc
amadaaaaeaaaaaaamdaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
lcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaabaaaaaadgajbaaaaaaaaaaadgbjbaaaabaaaaaaaceaaaaa
aknhcdlmaaaaaalpaaaaaalpaaaaaalpdiaaaaahpcaabaaaaaaaaaaadgajbaaa
aaaaaaaadgbjbaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaadcaaaabaocaabaaaabaaaaaafgaobaiaebaaaaaaabaaaaaa
aceaaaaaaaaaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaiadp
aaaaiadpaaaaiadpanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaa
egbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaacaaaaaaegaabaaa
acaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
acaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaacaaaaaa
bkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaacaaaaaaigaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aoaaaaahhcaabaaaabaaaaaaegacbaaaacaaaaaajgahbaaaabaaaaaaaaaaaaal
hcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaaaaaaaaahhcaabaaaadaaaaaajgahbaaaaaaaaaaajgahbaaa
aaaaaaaaaoaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
aaaaaaalhcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadbaaaaakocaabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaadpaaaaaadpaaaaaadpfgaobaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
akaabaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2, 0.010002136 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
SLT R0.w, R1, c[0];
MAD R0.y, fragment.texcoord[1].x, R0.x, c[0];
MAD R0.z, fragment.texcoord[1].y, R0.x, c[0].y;
MUL R0.x, R0.y, c[0];
MUL R0.y, R0.z, c[0].x;
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
KIL -R0.w;
MAD R2.xyz, R1, c[0].z, R0;
ADD R1.xyz, R1, -c[0].x;
ADD R2.xyz, R2, -c[0].y;
MAD R0.xyz, R1, c[0].z, R0;
CMP result.color.xyz, -R1, R0, R2;
END
# 16 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, 0.50000000
def c1, -0.50000000, 2.00000000, -1.00000000, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r2, r0, v0
add_pp r0.x, r2.w, c0
cmp r1.x, r0, c0.y, c0.z
mov_pp r3, -r1.x
rcp r0.x, t1.w
mad r1.x, t1, r0, c0.z
mad r0.x, t1.y, r0, c0.z
mad r1.y, -r0.x, c0.w, c0.z
mul r1.x, r1, c0.w
texld r0, r1, s1
texkill r3.xyzw
add_pp r1.xyz, r2, c1.x
mad_pp r2.xyz, r2, c1.y, r0
mad_pp r0.xyz, r1, c1.y, r0
add_pp r2.xyz, r2, c1.z
cmp_pp r0.xyz, -r1, r2, r0
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecednjbfifcknbbnigjlmamhhooemejnbiegabaaaaaajmadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefckiacaaaaeaaaaaaakkaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaabaaaaaadgajbaaa
aaaaaaaadgbjbaaaabaaaaaaaceaaaaaaknhcdlmaaaaaalpaaaaaalpaaaaaalp
diaaaaahpcaabaaaaaaaaaaadgajbaaaaaaaaaaadgbjbaaaabaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaa
aaaaaaakdcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaaaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaa
aaaaaadpdcaaaaakecaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaaabeaaaaa
aaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaacaaaaaaigaabaaaacaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaamhcaabaaaabaaaaaajgahbaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaacaaaaaa
dcaaaaamhcaabaaaacaaaaaajgahbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaegacbaaaacaaaaaaaaaaaaakhcaabaaaacaaaaaaegacbaaa
acaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadbaaaaakocaabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaadpfgaobaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaakaabaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaa
jgahbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedgkajkehfjeibcoaiokpciakcijbgheemabaaaaaaeeafaaaaaeaaaaaa
daaaaaaaneabaaaaieaeaaaabaafaaaaebgpgodjjmabaaaajmabaaaaaaacpppp
haabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaaaea
fbaaaaafabaaapkaaaaaialpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaiaacaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaadaaaaapiaabaaoela
aaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaakaagaaaaacacaaaiia
acaapplaafaaaaadacaaadiaacaappiaacaaoelaaeaaaaaeacaaadiaacaaoeia
aaaamjkaaaaaffkaebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaabaioeka
aeaaaaaeacaachiaaaaaoeiaaaaaoelaaaaakkkaaeaaaaaeacaachiaacaaoeia
aaaappkaabaaoeiaafaaaaadadaacpiaaaaaoeiaaaaaoelaaeaaaaaeaaaaahia
aaaaoeiaaaaaoelbaaaaffkaaeaaaaaeabaachiaadaaoeiaaaaappkaabaaoeia
acaaaaadabaachiaabaaoeiaabaaaakafiaaaaaeadaachiaaaaaoeiaabaaoeia
acaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaafdeieefckiacaaaaeaaaaaaa
kkaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaa
abaaaaaadgajbaaaaaaaaaaadgbjbaaaabaaaaaaaceaaaaaaknhcdlmaaaaaalp
aaaaaalpaaaaaalpdiaaaaahpcaabaaaaaaaaaaadgajbaaaaaaaaaaadgbjbaaa
abaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaacaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaa
acaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaacaaaaaabkaabaiaebaaaaaa
acaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaacaaaaaa
igaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaamhcaabaaa
abaaaaaajgahbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
egacbaaaacaaaaaadcaaaaamhcaabaaaacaaaaaajgahbaaaaaaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaacaaaaaaaaaaaaakhcaabaaa
acaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
dbaaaaakocaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaadp
fgaobaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaakaabaaaaaaaaaaadhaaaaaj
hccabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
doaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaa
abaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2, 0.010002136 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0];
SLT R0.z, R1.w, c[0].w;
MAD R0.x, fragment.texcoord[1], R0, c[0].y;
ADD R2.xyz, R1, -c[0].x;
MUL R3.xyz, R1, c[0].z;
MUL R0.y, R0, c[0].x;
MUL R0.x, R0, c[0];
MUL R1.xyz, R2, c[0].z;
MOV result.color.w, R1;
KIL -R0.z;
TEX R0.xyz, R0, texture[1], 2D;
MIN R3.xyz, R0, R3;
MAX R0.xyz, R0, R1;
CMP result.color.xyz, -R2, R0, R3;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, 0.50000000
def c1, -0.50000000, 2.00000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r2, r0, v0
add_pp r0.x, r2.w, c0
cmp r1.x, r0, c0.y, c0.z
mov_pp r3, -r1.x
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0.z
mad r0.y, -r1.x, c0.w, c0.z
add_pp r1.xyz, r2, c1.x
mad r0.x, t1, r0, c0.z
mul r0.x, r0, c0.w
mul_pp r2.xyz, r2, c1.y
texld r0, r0, s1
texkill r3.xyzw
mul_pp r3.xyz, r1, c1.y
max_pp r3.xyz, r0, r3
min_pp r0.xyz, r0, r2
cmp_pp r0.xyz, -r1, r0, r3
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedhkploaphgaechggdfknogjehahhhanfjabaaaaaaieadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcjaacaaaaeaaaaaaakeaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaabaaaaaadgajbaaa
aaaaaaaadgbjbaaaabaaaaaaaceaaaaaaknhcdlmaaaaaalpaaaaaalpaaaaaalp
diaaaaahpcaabaaaaaaaaaaadgajbaaaaaaaaaaadgbjbaaaabaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahocaabaaa
abaaaaaafgaobaaaabaaaaaafgaobaaaabaaaaaaanaaaeadakaabaaaabaaaaaa
aoaaaaahdcaabaaaacaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaak
dcaabaaaacaaaaaaegaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaadp
dcaaaaakecaabaaaacaaaaaabkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaaadp
abeaaaaaaaaaiadpefaaaaajpcaabaaaacaaaaaaigaabaaaacaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaadeaaaaahhcaabaaaabaaaaaajgahbaaaabaaaaaa
egacbaaaacaaaaaaaaaaaaahhcaabaaaadaaaaaajgahbaaaaaaaaaaajgahbaaa
aaaaaaaaddaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaa
dbaaaaakocaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaadp
fgaobaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaakaabaaaaaaaaaaadhaaaaaj
hccabaaaaaaaaaaajgahbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedoldonekbcopjjbakdmodbimdhjmbbmgiabaaaaaabmafaaaaaeaaaaaa
daaaaaaameabaaaafmaeaaaaoiaeaaaaebgpgodjimabaaaaimabaaaaaaacpppp
gaabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaaka
agaaaaacacaaaiiaacaapplaafaaaaadacaaadiaacaappiaacaaoelaaeaaaaae
acaaadiaacaaoeiaaaaamjkaaaaaffkaebaaaaababaaapiaecaaaaadabaacpia
acaaoeiaabaioekaaeaaaaaeacaachiaaaaaoeiaaaaaoelaaaaakkkaacaaaaad
acaachiaacaaoeiaacaaoeiaalaaaaadadaachiaabaaoeiaacaaoeiaafaaaaad
acaacpiaaaaaoeiaaaaaoelaaeaaaaaeaaaaahiaaaaaoeiaaaaaoelbaaaaffka
acaaaaadaeaachiaacaaoeiaacaaoeiaakaaaaadafaachiaaeaaoeiaabaaoeia
fiaaaaaeacaachiaaaaaoeiaafaaoeiaadaaoeiaabaaaaacaaaicpiaacaaoeia
ppppaaaafdeieefcjaacaaaaeaaaaaaakeaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
aeaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaampcaabaaaabaaaaaadgajbaaaaaaaaaaadgbjbaaa
abaaaaaaaceaaaaaaknhcdlmaaaaaalpaaaaaalpaaaaaalpdiaaaaahpcaabaaa
aaaaaaaadgajbaaaaaaaaaaadgbjbaaaabaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahocaabaaaabaaaaaafgaobaaa
abaaaaaafgaobaaaabaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaa
acaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaacaaaaaa
egaabaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaacaaaaaaakaabaaaacaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
acaaaaaabkaabaiaebaaaaaaacaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaacaaaaaaigaabaaaacaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadeaaaaahhcaabaaaabaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaa
aaaaaaahhcaabaaaadaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaddaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaadbaaaaakocaabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaadpfgaobaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaaakaabaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaa
jgahbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 0, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
SLT R0.w, R1, c[0];
MAD R0.y, fragment.texcoord[1].x, R0.x, c[0].x;
MAD R0.z, fragment.texcoord[1].y, R0.x, c[0].x;
MUL R0.x, R0.y, c[0].y;
MUL R0.y, R0.z, c[0];
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
KIL -R0.w;
ADD R0.xyz, -R0, c[0].x;
ADD R0.xyz, R1, -R0;
CMP R0.xyz, -R0, c[0].x, c[0].z;
MOV result.color.xyz, R0;
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, 0.50000000
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r2, r0, v0
add_pp r0.x, r2.w, c0
cmp r1.x, r0, c0.y, c0.z
mov_pp r3, -r1.x
rcp r0.x, t1.w
mad r1.x, t1, r0, c0.z
mad r0.x, t1.y, r0, c0.z
mul r1.x, r1, c0.w
mad r1.y, -r0.x, c0.w, c0.z
texld r0, r1, s1
texkill r3.xyzw
add_pp r0.xyz, -r0, c0.z
add_pp r0.xyz, r2, -r0
cmp r0.xyz, -r0, c0.y, c0.z
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedplkkjlidohihpfegmeobhkcfonnainjjabaaaaaacmadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcdiacaaaaeaaaaaaaioaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaabaaaaaa
egaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaalhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaahhcaabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
abaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedlemlpkijejomgfpbobolancaoafmlkfeabaaaaaajiaeaaaaaeaaaaaa
daaaaaaajiabaaaaniadaaaageaeaaaaebgpgodjgaabaaaagaabaaaaaaacpppp
deabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaiadp
fbaaaaafabaaapkaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaabpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaiaacaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaadaaaaapiaabaaoela
aaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaakaagaaaaacacaaaiia
acaapplaafaaaaadacaaadiaacaappiaacaaoelaaeaaaaaeacaaadiaacaaoeia
aaaamjkaaaaaffkaebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaabaioeka
acaaaaadabaachiaabaaoeibaaaappkaaeaaaaaeaaaaahiaaaaaoeiaaaaaoelb
abaaoeiaafaaaaadabaaciiaaaaappiaaaaapplafiaaaaaeabaachiaaaaaoeia
abaaaakaabaaffkaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcdiacaaaa
eaaaaaaaioaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlm
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaa
aaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaaaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaadpdcaaaaakecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaa
aaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaaabaaaaaaegacbaia
ebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaah
hcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaaabaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheoieaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
SLT R0.w, R1, c[0].z;
MAD R0.y, fragment.texcoord[1].x, R0.x, c[0].x;
MAD R0.z, fragment.texcoord[1].y, R0.x, c[0].x;
MUL R0.x, R0.y, c[0].y;
MUL R0.y, R0.z, c[0];
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
KIL -R0.w;
ADD R0.xyz, -R1, R0;
ABS result.color.xyz, R0;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, 0.50000000
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r2, r0, v0
add_pp r0.x, r2.w, c0
cmp r1.x, r0, c0.y, c0.z
mov_pp r3, -r1.x
rcp r0.x, t1.w
mad r1.x, t1, r0, c0.z
mad r0.x, t1.y, r0, c0.z
mul r1.x, r1, c0.w
mad r1.y, -r0.x, c0.w, c0.z
texld r0, r1, s1
texkill r3.xyzw
add_pp r0.xyz, -r2, r0
abs_pp r0.xyz, r0
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedmklnddngfhdjncfllngjkkaijopmamgpabaaaaaapmacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcaiacaaaaeaaaaaaaicaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaah
dcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaak
ecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaa
aaaaiadpefaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
egbcbaaaabaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
dgaaaaaghccabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedaoffalpppapiacpenplpenmhicdadkifabaaaaaadiaeaaaaaeaaaaaa
daaaaaaagiabaaaahiadaaaaaeaeaaaaebgpgodjdaabaaaadaabaaaaaaacpppp
aeabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaaka
agaaaaacacaaaiiaacaapplaafaaaaadacaaadiaacaappiaacaaoelaaeaaaaae
acaaadiaacaaoeiaaaaamjkaaaaaffkaebaaaaababaaapiaecaaaaadabaacpia
acaaoeiaabaioekaaeaaaaaeaaaachiaaaaaoeiaaaaaoelbabaaoeiaafaaaaad
abaaciiaaaaappiaaaaapplacdaaaaacabaachiaaaaaoeiaabaaaaacaaaicpia
abaaoeiappppaaaafdeieefcaiacaaaaeaaaaaaaicaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaa
dkbabaaaabaaaaaaabeaaaaaaknhcdlmdbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaabaaaaaa
egaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaag
hccabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaadoaaaaabejfdeheoieaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 2, 0.010002136 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
SLT R0.w, R1, c[0];
MAD R0.y, fragment.texcoord[1].x, R0.x, c[0].x;
MAD R0.z, fragment.texcoord[1].y, R0.x, c[0].x;
MUL R0.x, R0.y, c[0].y;
MUL R0.y, R0.z, c[0];
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
KIL -R0.w;
ADD R2.xyz, R1, R0;
MUL R0.xyz, R1, R0;
MAD result.color.xyz, -R0, c[0].z, R2;
END
# 14 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, 0.50000000
def c1, 2.00000000, 0, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r2, r0, v0
add_pp r0.x, r2.w, c0
cmp r1.x, r0, c0.y, c0.z
mov_pp r3, -r1.x
rcp r0.x, t1.w
mad r1.x, t1, r0, c0.z
mad r0.x, t1.y, r0, c0.z
mad r1.y, -r0.x, c0.w, c0.z
mul r1.x, r1, c0.w
texld r0, r1, s1
texkill r3.xyzw
add_pp r1.xyz, r2, r0
mul_pp r0.xyz, r2, r0
mad_pp r0.xyz, -r0, c1.x, r1
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedecphhicgmbokbcgppjeohhdbkbbpplpdabaaaaaadaadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcdmacaaaaeaaaaaaaipaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaah
dcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaak
ecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaa
aaaaiadpefaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaajhcaabaaaacaaaaaaegacbaaaaaaaaaaaegbcbaaa
abaaaaaaegacbaaaabaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egbobaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaanhccabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaegacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedblfgmgfdlkcbfhgfkjgajdjaefchgaijabaaaaaaieaeaaaaaeaaaaaa
daaaaaaaiaabaaaameadaaaafaaeaaaaebgpgodjeiabaaaaeiabaaaaaaacpppp
bmabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaaaea
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaaka
agaaaaacacaaaiiaacaapplaafaaaaadacaaadiaacaappiaacaaoelaaeaaaaae
acaaadiaacaaoeiaaaaamjkaaaaaffkaebaaaaababaaapiaecaaaaadabaacpia
acaaoeiaabaioekaaeaaaaaeacaachiaaaaaoeiaaaaaoelaabaaoeiaafaaaaad
aaaacpiaaaaaoeiaaaaaoelaafaaaaadabaachiaabaaoeiaaaaaoeiaaeaaaaae
aaaachiaabaaoeiaaaaappkbacaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcdmacaaaaeaaaaaaaipaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaa
abeaaaaaaknhcdlmdbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaa
adaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaabaaaaaabkaabaia
ebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaa
abaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaanhccabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaacaaaaaa
doaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaa
abaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
SLT R0.w, R1, c[0].z;
MAD R0.y, fragment.texcoord[1].x, R0.x, c[0].x;
MAD R0.z, fragment.texcoord[1].y, R0.x, c[0].x;
MUL R0.x, R0.y, c[0].y;
MUL R0.y, R0.z, c[0];
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
KIL -R0.w;
ADD result.color.xyz, -R1, R0;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, 0.50000000
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r2, r0, v0
add_pp r0.x, r2.w, c0
cmp r1.x, r0, c0.y, c0.z
mov_pp r3, -r1.x
rcp r0.x, t1.w
mad r1.x, t1, r0, c0.z
mad r0.x, t1.y, r0, c0.z
mul r1.x, r1, c0.w
mad r1.y, -r0.x, c0.w, c0.z
texld r0, r1, s1
texkill r3.xyzw
add_pp r0.xyz, -r2, r0
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedjhdpoapeeeaalbophapddbllhkcfkahlabaaaaaaoeacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpaabaaaaeaaaaaaahmaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaah
dcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaa
abaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaa
diaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaak
ecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaa
aaaaiadpefaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaadcaaaaakhccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
egbcbaaaabaaaaaaegacbaaaabaaaaaadiaaaaahbcaabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaakaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedknelkoflncmaainapkbcmednfdepdnamabaaaaaabeaeaaaaaeaaaaaa
daaaaaaafmabaaaafeadaaaaoaadaaaaebgpgodjceabaaaaceabaaaaaaacpppp
piaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaaka
agaaaaacacaaaiiaacaapplaafaaaaadacaaadiaacaappiaacaaoelaaeaaaaae
acaaadiaacaaoeiaaaaamjkaaaaaffkaebaaaaababaaapiaecaaaaadabaacpia
acaaoeiaabaioekaaeaaaaaeabaachiaaaaaoeiaaaaaoelbabaaoeiaafaaaaad
abaaciiaaaaappiaaaaapplaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefc
paabaaaaeaaaaaaahmaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
lcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaa
aknhcdlmdbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaabaaaaaabkaabaiaebaaaaaa
abaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaabaaaaaa
igaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaadcaaaaakhccabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaegbcbaaaabaaaaaaegacbaaaabaaaaaa
diaaaaahbcaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
SLT R0.z, R1.w, c[0];
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R0.y, R0, c[0];
MUL R0.x, R0, c[0].y;
RCP R1.x, R1.x;
RCP R1.z, R1.z;
RCP R1.y, R1.y;
MOV result.color.w, R1;
KIL -R0.z;
TEX R0.xyz, R0, texture[1], 2D;
MUL result.color.xyz, R0, R1;
END
# 15 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.01000214, 0.00000000, 1.00000000, 0.50000000
dcl v0
dcl t0.xy
dcl t1.xyzw
texld r0, t0, s0
mul r2, r0, v0
add_pp r0.x, r2.w, c0
cmp r1.x, r0, c0.y, c0.z
mov_pp r3, -r1.x
rcp r0.x, t1.w
mad r1.x, t1, r0, c0.z
mad r0.x, t1.y, r0, c0.z
mad r1.y, -r0.x, c0.w, c0.z
mul r1.x, r1, c0.w
rcp_pp r1.z, r2.z
texld r0, r1, s1
texkill r3.xyzw
rcp_pp r1.x, r2.x
rcp_pp r1.y, r2.y
mul_pp r0.xyz, r0, r1
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedpnheceeggcdomijdldjollacbflimmfoabaaaaaaniacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcoeabaaaaeaaaaaaahjaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaabaaaaaa
egaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
abaaaaaabkaabaiaebaaaaaaabaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaabaaaaaaigaabaaaabaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaoaaaaahhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedgjdjhlppgojaongbmbggknjennploafnabaaaaaaciaeaaaaaeaaaaaa
daaaaaaahmabaaaagiadaaaapeadaaaaebgpgodjeeabaaaaeeabaaaaaaacpppp
biabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaecaaaaad
aaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaaka
afaaaaadaaaacpiaaaaaoeiaaaaaoelaagaaaaacacaaaiiaacaapplaafaaaaad
acaaadiaacaappiaacaaoelaaeaaaaaeacaaadiaacaaoeiaaaaamjkaaaaaffka
ebaaaaababaaapiaecaaaaadabaacpiaacaaoeiaabaioekaagaaaaacacaaabia
aaaaaaiaagaaaaacacaaaciaaaaaffiaagaaaaacacaaaeiaaaaakkiaafaaaaad
aaaachiaabaaoeiaacaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
oeabaaaaeaaaaaaahjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
lcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaa
aknhcdlmdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegbabaaaadaaaaaapgbpbaaa
adaaaaaaaaaaaaakdcaabaaaabaaaaaaegaabaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaadpdcaaaaakecaabaaaabaaaaaabkaabaiaebaaaaaaabaaaaaa
abeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaabaaaaaaigaabaaa
abaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaoaaaaahhccabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
hkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
}
 }
}
Fallback "UI/Default"
}