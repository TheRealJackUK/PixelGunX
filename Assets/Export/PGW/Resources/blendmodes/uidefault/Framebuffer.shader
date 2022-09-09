Shader "BlendModes/UIDefault/Framebuffer" {
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c5
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "BMDarken" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
SLT R1.x, R0.w, c[0].y;
MOV result.color.w, R0;
MIN result.color.xyz, R0, c[0].x;
KIL -R1.x;
END
# 6 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarken" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r1.x, r0.w, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
min_pp r0.xyz, r0, c0.z
mov_pp oC0, r0
texkill r1.xyzw
"
}
SubProgram "d3d11 " {
Keywords { "BMDarken" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefieceddcofeoabmnichnonojhhikhilmicngnbabaaaaaapiabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbmabaaaaeaaaaaaa
ehaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaddaaaaakhccabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarken" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedhhgolnhechifimhdmmdefgakicpbmhgbabaaaaaaneacaaaaaeaaaaaa
daaaaaaaaiabaaaacmacaaaakaacaaaaebgpgodjnaaaaaaanaaaaaaaaaacpppp
kiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaappla
aaaaaakaafaaaaadaaaacpiaaaaaoeiaaaaaoelaebaaaaababaaapiaakaaaaad
abaachiaaaaaoeiaaaaaffkaabaaaaacabaaciiaaaaappiaabaaaaacaaaicpia
abaaoeiappppaaaafdeieefcbmabaaaaeaaaaaaaehaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaa
abeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaa
abaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaaddaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
SLT R1.x, R0.w, c[0];
MOV result.color, R0;
KIL -R1.x;
END
# 5 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r1.x, r0.w, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
mov_pp oC0, r0
texkill r1.xyzw
"
}
SubProgram "d3d11 " {
Keywords { "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedadjklaodokopfkdpcdjdnfjcmecoolmiabaaaaaanaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpeaaaaaaeaaaaaaa
dnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedknhlffangbeofgmlphegcaoljljppkdiabaaaaaajaacaaaaaeaaaaaa
daaaaaaaomaaaaaaoiabaaaafmacaaaaebgpgodjleaaaaaaleaaaaaaaaacpppp
imaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaappla
aaaaaakaafaaaaadaaaacpiaaaaaoeiaaaaaoelaabaaaaacaaaicpiaaaaaoeia
ebaaaaababaaapiappppaaaafdeieefcpeaaaaaaeaaaaaaadnaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaadkbabaaa
abaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egbobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaah
bcaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
aaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.010002136 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.w, R0, fragment.color.primary;
SLT R0.x, R0.w, c[0].y;
KIL -R0.x;
MOV R0.xyz, c[0].x;
MOV result.color, R0;
END
# 6 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, 0
dcl v0.xyzw
dcl t0.xy
texld r0, t0, s0
mul r0.w, r0, v0
add_pp r0.x, r0.w, c0
cmp r0.x, r0, c0.y, c0.z
mov_pp r1, -r0.x
mov_pp r0.xyz, c0.z
mov_pp oC0, r0
texkill r1.xyzw
"
}
SubProgram "d3d11 " {
Keywords { "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedigodbdoaddhgnojphmncdeilopgnpjcfabaaaaaapaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbeabaaaaeaaaaaaa
efaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedhafidaamkdbijhmfnlfknofpicjekjchabaaaaaalmacaaaaaeaaaaaa
daaaaaaapiaaaaaabeacaaaaiiacaaaaebgpgodjmaaaaaaamaaaaaaaaaacpppp
jiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaappla
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiaabaaaaac
aaaachiaaaaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcbeabaaaa
eaaaaaaaefaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
bkaabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
SLT R1.x, R0.w, c[0];
MOV result.color, R0;
KIL -R1.x;
END
# 5 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r1.x, r0.w, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
mov_pp oC0, r0
texkill r1.xyzw
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedadjklaodokopfkdpcdjdnfjcmecoolmiabaaaaaanaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpeaaaaaaeaaaaaaa
dnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedknhlffangbeofgmlphegcaoljljppkdiabaaaaaajaacaaaaaeaaaaaa
daaaaaaaomaaaaaaoiabaaaafmacaaaaebgpgodjleaaaaaaleaaaaaaaaacpppp
imaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaappla
aaaaaakaafaaaaadaaaacpiaaaaaoeiaaaaaoelaabaaaaacaaaicpiaaaaaoeia
ebaaaaababaaapiappppaaaafdeieefcpeaaaaaaeaaaaaaadnaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaadkbabaaa
abaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egbobaaaabaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadbaaaaah
bcaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
aaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[2] = { { 1, 0.29907227, 0.58691406, 0.11401367 },
		{ 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
SLT R1.x, R0.w, c[1];
MOV result.color.w, R0;
KIL -R1.x;
MUL R1.x, R0.y, c[0].z;
MAD R1.x, R0, c[0].y, R1;
MAD R1.x, R0.z, c[0].w, R1;
ADD R1.x, -R1, c[0];
CMP result.color.xyz, R1.x, c[0].x, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, 0.58691406
def c1, 0.29907227, 0.11401367, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r1.x, r0.w, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
mul_pp r1.x, r0.y, c0.w
mad_pp r1.x, r0, c1, r1
mad_pp r1.x, r0.z, c1.y, r1
add_pp r1.x, -r1, c0.z
cmp_pp r0.xyz, r1.x, r0, c0.z
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedmebofliheladojggajojglacjnjgaffhabaaaaaaeeacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgiabaaaaeaaaaaaa
fkaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaakbcaabaaa
abaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
dbaaaaahbcaabaaaabaaaaaaabeaaaaaaaaaiadpakaabaaaabaaaaaadhaaaaam
hccabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedajhijbgjgfhndlgbfifmphiaikplmaegabaaaaaahiadaaaaaeaaaaaa
daaaaaaagaabaaaanaacaaaaeeadaaaaebgpgodjciabaaaaciabaaaaaaacpppp
aaabaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmkcefbgdpihbgjjdonfhiojdnfbaaaaaf
abaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapia
abaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaakaafaaaaad
aaaacpiaaaaaoeiaaaaaoelaebaaaaababaaapiaafaaaaadabaacbiaaaaaffia
aaaaffkaaeaaaaaeabaacbiaaaaaaaiaaaaakkkaabaaaaiaaeaaaaaeabaacbia
aaaakkiaaaaappkaabaaaaiaacaaaaadabaaabiaabaaaaibabaaaakafiaaaaae
aaaachiaabaaaaiaaaaaoeiaabaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcgiabaaaaeaaaaaaafkaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlm
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaabaaaaaakbcaabaaaabaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaadbaaaaahbcaabaaaabaaaaaaabeaaaaaaaaaiadp
akaabaaaabaaaaaadhaaaaamhccabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
SLT R1.x, R0.w, c[0].y;
MOV result.color.w, R0;
MAX result.color.xyz, R0, c[0].x;
KIL -R1.x;
END
# 6 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r1.x, r0.w, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
max_pp r0.xyz, r0, c0.z
mov_pp oC0, r0
texkill r1.xyzw
"
}
SubProgram "d3d11 " {
Keywords { "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedpdjbonedkpknghakigmmnpolmkkjfiooabaaaaaapiabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbmabaaaaeaaaaaaa
ehaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaadeaaaaakhccabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedlfglkfoegieoaddmclfebpepdemlbhagabaaaaaaneacaaaaaeaaaaaa
daaaaaaaaiabaaaacmacaaaakaacaaaaebgpgodjnaaaaaaanaaaaaaaaaacpppp
kiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaappla
aaaaaakaafaaaaadaaaacpiaaaaaoeiaaaaaoelaebaaaaababaaapiaalaaaaad
abaachiaaaaaffkaaaaaoeiaabaaaaacabaaciiaaaaappiaabaaaaacaaaicpia
abaaoeiappppaaaafdeieefcbmabaaaaeaaaaaaaehaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaa
abeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaa
abaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaadeaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.010002136 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.w, R0, fragment.color.primary;
SLT R0.x, R0.w, c[0].y;
KIL -R0.x;
MOV R0.xyz, c[0].x;
MOV result.color, R0;
END
# 6 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, 0
dcl v0.xyzw
dcl t0.xy
texld r0, t0, s0
mul r0.w, r0, v0
add_pp r0.x, r0.w, c0
cmp r0.x, r0, c0.y, c0.z
mov_pp r1, -r0.x
mov_pp r0.xyz, c0.z
mov_pp oC0, r0
texkill r1.xyzw
"
}
SubProgram "d3d11 " {
Keywords { "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedigodbdoaddhgnojphmncdeilopgnpjcfabaaaaaapaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbeabaaaaeaaaaaaa
efaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedhafidaamkdbijhmfnlfknofpicjekjchabaaaaaalmacaaaaaeaaaaaa
daaaaaaapiaaaaaabeacaaaaiiacaaaaebgpgodjmaaaaaaamaaaaaaaaaacpppp
jiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaappla
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiaabaaaaac
aaaachiaaaaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcbeabaaaa
eaaaaaaaefaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
bkaabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
ADD R0.xyz, -R0, c[0].x;
SLT R1.x, R0.w, c[0].y;
MOV result.color.w, R0;
RCP result.color.x, R0.x;
RCP result.color.y, R0.y;
RCP result.color.z, R0.z;
KIL -R1.x;
END
# 9 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r0.xyz, -r0, c0.z
add_pp r1.x, r0.w, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mov_pp oC0, r0
texkill r1.xyzw
"
}
SubProgram "d3d11 " {
Keywords { "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedcapcgdgeonfflkmpibhehlokejoodcgfabaaaaaacmacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfaabaaaaeaaaaaaa
feaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaadcaaaaan
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
aoaaaaakhccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedolgkiddalnadfcopbgfngkkcfgbejnobabaaaaaaceadaaaaaeaaaaaa
daaaaaaaceabaaaahmacaaaapaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpppp
meaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaappla
aaaaaakaebaaaaababaaapiaafaaaaadabaaciiaaaaappiaaaaapplaaeaaaaae
aaaachiaaaaaoeiaaaaaoelbaaaaffkaagaaaaacabaacbiaaaaaaaiaagaaaaac
abaacciaaaaaffiaagaaaaacabaaceiaaaaakkiaabaaaaacaaaicpiaabaaoeia
ppppaaaafdeieefcfaabaaaaeaaaaaaafeaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaa
aknhcdlmdbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaadcaaaaanhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaakhccabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadoaaaaabejfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
SLT R1.x, R0.w, c[0].y;
MOV result.color.w, R0;
ADD result.color.xyz, R0, c[0].x;
KIL -R1.x;
END
# 6 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r1.x, r0.w, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
add_pp r0.xyz, r0, c0.z
mov_pp oC0, r0
texkill r1.xyzw
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedidkpedhmdimhpchglcdoimmdajnohlldabaaaaaanaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpeaaaaaaeaaaaaaa
dnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdcaaaaampccabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedhkggblepbbkecckfajflhjdfcfhbpkjgabaaaaaakmacaaaaaeaaaaaa
daaaaaaaaiabaaaaaeacaaaahiacaaaaebgpgodjnaaaaaaanaaaaaaaaaacpppp
kiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaaaaaaaaaaaaaaaaaaaafbaaaaaf
abaaapkaaaaaiadpaaaaiadpaaaaiadpaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapia
abaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaakaaeaaaaae
aaaacpiaaaaaoeiaaaaaoelaabaaoekaabaaaaacaaaicpiaaaaaoeiaebaaaaab
abaaapiappppaaaafdeieefcpeaaaaaaeaaaaaaadnaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaa
abeaaaaaaknhcdlmdcaaaaampccabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaahbcaabaaa
aaaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaa
doaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[2] = { { 1, 0.29907227, 0.58691406, 0.11401367 },
		{ 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
SLT R1.x, R0.w, c[1];
MOV result.color.w, R0;
KIL -R1.x;
MUL R1.x, R0.y, c[0].z;
MAD R1.x, R0, c[0].y, R1;
MAD R1.x, R0.z, c[0].w, R1;
ADD R1.x, -R1, c[0];
CMP result.color.xyz, -R1.x, c[0].x, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, 0.58691406
def c1, 0.29907227, 0.11401367, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r1.x, r0.w, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
mul_pp r1.x, r0.y, c0.w
mad_pp r1.x, r0, c1, r1
mad_pp r1.x, r0.z, c1.y, r1
add_pp r1.x, -r1, c0.z
cmp_pp r0.xyz, -r1.x, r0, c0.z
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedebjkgmndbabdlfikgmpcncoennpoemaoabaaaaaaeeacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgiabaaaaeaaaaaaa
fkaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaabaaaaaakbcaabaaa
abaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaam
hccabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedfhncajmjcjnpccehkpegacmgappcedhbabaaaaaahiadaaaaaeaaaaaa
daaaaaaagaabaaaanaacaaaaeeadaaaaebgpgodjciabaaaaciabaaaaaaacpppp
aaabaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmkcefbgdpihbgjjdonfhiojdnfbaaaaaf
abaaapkaaaaaialpaaaaiadpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapia
abaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaakaafaaaaad
aaaacpiaaaaaoeiaaaaaoelaebaaaaababaaapiaafaaaaadabaacbiaaaaaffia
aaaaffkaaeaaaaaeabaacbiaaaaaaaiaaaaakkkaabaaaaiaaeaaaaaeabaacbia
aaaakkiaaaaappkaabaaaaiaacaaaaadabaaabiaabaaaaiaabaaaakafiaaaaae
aaaachiaabaaaaiaaaaaoeiaabaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcgiabaaaaeaaaaaaafkaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlm
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaabaaaaaakbcaabaaaabaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaiadpdhaaaaamhccabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.010002136 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.w, R0, fragment.color.primary;
SLT R0.x, R0.w, c[0].y;
KIL -R0.x;
MOV R0.xyz, c[0].x;
MOV result.color, R0;
END
# 6 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, 0
dcl v0.xyzw
dcl t0.xy
texld r0, t0, s0
mul r0.w, r0, v0
add_pp r0.x, r0.w, c0
cmp r0.x, r0, c0.y, c0.z
mov_pp r1, -r0.x
mov_pp r0.xyz, c0.z
mov_pp oC0, r0
texkill r1.xyzw
"
}
SubProgram "d3d11 " {
Keywords { "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedigodbdoaddhgnojphmncdeilopgnpjcfabaaaaaapaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbeabaaaaeaaaaaaa
efaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedhafidaamkdbijhmfnlfknofpicjekjchabaaaaaalmacaaaaaeaaaaaa
daaaaaaapiaaaaaabeacaaaaiiacaaaaebgpgodjmaaaaaaamaaaaaaaaaacpppp
jiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaappla
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiaabaaaaac
aaaachiaaaaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcbeabaaaa
eaaaaaaaefaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
bkaabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.010002136 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.w, R0, fragment.color.primary;
SLT R0.x, R0.w, c[0].y;
KIL -R0.x;
MOV R0.xyz, c[0].x;
MOV result.color, R0;
END
# 6 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, 0
dcl v0.xyzw
dcl t0.xy
texld r0, t0, s0
mul r0.w, r0, v0
add_pp r0.x, r0.w, c0
cmp r0.x, r0, c0.y, c0.z
mov_pp r1, -r0.x
mov_pp r0.xyz, c0.z
mov_pp oC0, r0
texkill r1.xyzw
"
}
SubProgram "d3d11 " {
Keywords { "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedigodbdoaddhgnojphmncdeilopgnpjcfabaaaaaapaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbeabaaaaeaaaaaaa
efaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedhafidaamkdbijhmfnlfknofpicjekjchabaaaaaalmacaaaaaeaaaaaa
daaaaaaapiaaaaaabeacaaaaiiacaaaaebgpgodjmaaaaaaamaaaaaaaaaacpppp
jiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaappla
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiaabaaaaac
aaaachiaaaaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcbeabaaaa
eaaaaaaaefaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
bkaabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
SLT R1.x, R0.w, c[0].w;
MOV result.color.w, R0;
KIL -R1.x;
MUL R1.xyz, R0, c[0].z;
ADD R0.xyz, R0, -c[0].x;
CMP result.color.xyz, -R0, c[0].y, R1;
END
# 8 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, 2.00000000
def c1, -0.50000000, 0, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r1.x, r0.w, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
mul_pp r1.xyz, r0, c0.w
add_pp r0.xyz, r0, c1.x
cmp_pp r0.xyz, -r0, r1, c0.z
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedmjobjfdpnonjffkdinahkcognfdmpddhabaaaaaaeeacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgiabaaaaeaaaaaaa
fkaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaadbaaaaakhcaabaaa
abaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaaaaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadhaaaaamhccabaaaaaaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedcoggmoklefilkobipjbpikcfkloldljmabaaaaaadmadaaaaaeaaaaaa
daaaaaaaceabaaaajeacaaaaaiadaaaaebgpgodjomaaaaaaomaaaaaaaaacpppp
meaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaiadpaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaappla
aaaaaakaebaaaaababaaapiaaeaaaaaeabaaahiaaaaaoeiaaaaaoelbaaaaffka
afaaaaadaaaacpiaaaaaoeiaaaaaoelaacaaaaadacaachiaaaaaoeiaaaaaoeia
fiaaaaaeaaaachiaabaaoeiaacaaoeiaaaaakkkaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcgiabaaaaeaaaaaaafkaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaa
aknhcdlmdiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaabaaaaaadbaaaaakhcaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaaegacbaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
dhaaaaamhccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 2, 1, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
SLT R1.x, R0.w, c[0].w;
MOV result.color.w, R0;
KIL -R1.x;
ADD R1.xyz, R0, -c[0].x;
MAD R0.xyz, -R1, c[0].y, c[0].z;
RCP R0.x, R0.x;
RCP R0.z, R0.z;
RCP R0.y, R0.y;
CMP result.color.xyz, -R1, R0, c[0].z;
END
# 11 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, -0.50000000
def c1, 2.00000000, 1.00000000, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r1.x, r0.w, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
add_pp r1.xyz, r0, c0.w
mad_pp r0.xyz, -r1, c1.x, c1.y
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
cmp_pp r0.xyz, -r1, c0.z, r0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedgmeafbppohlfopffiabjngpffdiglcagabaaaaaajmacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmaabaaaaeaaaaaaa
haaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaabaaaaaadgajbaaa
aaaaaaaadgbjbaaaabaaaaaaaceaaaaaaknhcdlmaaaaaalpaaaaaalpaaaaaalp
diaaaaahpcaabaaaaaaaaaaadgajbaaaaaaaaaaadgbjbaaaabaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaabaocaabaaa
abaaaaaafgaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaceaaaaaaaaaaaaaaaaaiadpaaaaiadpaaaaiadpaoaaaaakocaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpfgaobaaaabaaaaaa
anaaaeadakaabaaaabaaaaaadbaaaaakocaabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaadpaaaaaadpaaaaaadpfgaobaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
akaabaaaaaaaaaaadhaaaaamhccabaaaaaaaaaaajgahbaaaaaaaaaaajgahbaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefieceddfldjiebaonmjnlmfgpfjajfhgiokgnnabaaaaaaoiadaaaaaeaaaaaa
daaaaaaahiabaaaaeaadaaaaleadaaaaebgpgodjeaabaaaaeaabaaaaaaacpppp
biabaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaiadpfbaaaaaf
abaaapkaaaaaaaeaaaaaiadpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapia
abaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaakaebaaaaab
abaaapiaaeaaaaaeabaaahiaaaaaoeiaaaaaoelbaaaaffkaaeaaaaaeaaaachia
aaaaoeiaaaaaoelaaaaakkkaafaaaaadacaaciiaaaaappiaaaaapplaaeaaaaae
aaaachiaaaaaoeiaabaaaakbabaaffkaagaaaaacadaacbiaaaaaaaiaagaaaaac
adaacciaaaaaffiaagaaaaacadaaceiaaaaakkiafiaaaaaeacaachiaabaaoeia
aaaappkaadaaoeiaabaaaaacaaaicpiaacaaoeiappppaaaafdeieefcmaabaaaa
eaaaaaaahaaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaabaaaaaa
dgajbaaaaaaaaaaadgbjbaaaabaaaaaaaceaaaaaaknhcdlmaaaaaalpaaaaaalp
aaaaaalpdiaaaaahpcaabaaaaaaaaaaadgajbaaaaaaaaaaadgbjbaaaabaaaaaa
dbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaba
ocaabaaaabaaaaaafgaobaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaiadpaaaaiadpaaaaiadpaoaaaaak
ocaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpfgaobaaa
abaaaaaaanaaaeadakaabaaaabaaaaaadbaaaaakocaabaaaaaaaaaaaaceaaaaa
aaaaaaaaaaaaaadpaaaaaadpaaaaaadpfgaobaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaaakaabaaaaaaaaaaadhaaaaamhccabaaaaaaaaaaajgahbaaaaaaaaaaa
jgahbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab
ejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
gcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2, 0.010002136 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
SLT R0.x, R1.w, c[0].w;
MOV result.color.w, R1;
KIL -R0.x;
ADD R0.xyz, R1, -c[0].x;
MUL R1.xyz, R1, c[0].z;
MAD R2.xyz, R0, c[0].z, c[0].y;
CMP result.color.xyz, -R0, R2, R1;
END
# 9 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, -0.50000000
def c1, 2.00000000, 1.00000000, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r1.x, r0.w, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
add_pp r1.xyz, r0, c0.w
mad_pp r2.xyz, r1, c1.x, c1.y
mul_pp r0.xyz, r0, c1.x
cmp_pp r0.xyz, -r1, r0, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedifbipejagkahhdfkoinjpkkkjippimhjabaaaaaaiaacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckeabaaaaeaaaaaaa
gjaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaabaaaaaadgajbaaa
aaaaaaaadgbjbaaaabaaaaaaaceaaaaaaknhcdlmaaaaaalpaaaaaalpaaaaaalp
diaaaaahpcaabaaaaaaaaaaadgajbaaaaaaaaaaadgbjbaaaabaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaapocaabaaa
abaaaaaafgaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aceaaaaaaaaaaaaaaaaaiadpaaaaiadpaaaaiadpanaaaeadakaabaaaabaaaaaa
dbaaaaakhcaabaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
jgahbaaaaaaaaaaaaaaaaaahocaabaaaaaaaaaaafgaobaaaaaaaaaaafgaobaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaaakaabaaaaaaaaaaadhaaaaajhccabaaa
aaaaaaaaegacbaaaacaaaaaajgahbaaaabaaaaaajgahbaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedhlepphpdgkajllinfckegjgjdiehhiecabaaaaaaliadaaaaaeaaaaaa
daaaaaaageabaaaabaadaaaaieadaaaaebgpgodjcmabaaaacmabaaaaaaacpppp
aeabaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaaaaafbaaaaaf
abaaapkaaaaaaaeaaaaaiadpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapia
abaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaakaebaaaaab
abaaapiaaeaaaaaeabaachiaaaaaoeiaaaaaoelaaaaakkkaaeaaaaaeabaachia
abaaoeiaabaaaakaabaaffkaaeaaaaaeacaaahiaaaaaoeiaaaaaoelbaaaaffka
afaaaaadaaaacpiaaaaaoeiaaaaaoelaacaaaaadadaachiaaaaaoeiaaaaaoeia
fiaaaaaeaaaachiaacaaoeiaadaaoeiaabaaoeiaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefckeabaaaaeaaaaaaagjaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaampcaabaaaabaaaaaadgajbaaaaaaaaaaadgbjbaaaabaaaaaaaceaaaaa
aknhcdlmaaaaaalpaaaaaalpaaaaaalpdiaaaaahpcaabaaaaaaaaaaadgajbaaa
aaaaaaaadgbjbaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaadcaaaaapocaabaaaabaaaaaafgaobaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaceaaaaaaaaaaaaaaaaaiadpaaaaiadp
aaaaiadpanaaaeadakaabaaaabaaaaaadbaaaaakhcaabaaaacaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaajgahbaaaaaaaaaaaaaaaaaahocaabaaa
aaaaaaaafgaobaaaaaaaaaaafgaobaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
akaabaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaajgahbaaa
abaaaaaajgahbaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2, 0.010002136 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
SLT R0.x, R1.w, c[0].w;
MUL R2.xyz, R1, c[0].z;
MIN R2.xyz, R2, c[0].y;
MOV result.color.w, R1;
KIL -R0.x;
ADD R0.xyz, R1, -c[0].x;
MUL R1.xyz, R0, c[0].z;
MAX R1.xyz, R1, c[0].y;
CMP result.color.xyz, -R0, R1, R2;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, -0.50000000
def c1, 2.00000000, 0, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r1.x, r0.w, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
add_pp r1.xyz, r0, c0.w
mul_pp r2.xyz, r1, c1.x
mul_pp r0.xyz, r0, c1.x
max_pp r2.xyz, r2, c0.z
min_pp r0.xyz, r0, c0.z
cmp_pp r0.xyz, -r1, r0, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedfoipnnnkdjmclafpnidnjodeipknimbaabaaaaaalaacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcneabaaaaeaaaaaaa
hfaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaabaaaaaadgajbaaa
aaaaaaaadgbjbaaaabaaaaaaaceaaaaaaknhcdlmaaaaaalpaaaaaalpaaaaaalp
diaaaaahpcaabaaaaaaaaaaadgajbaaaaaaaaaaadgbjbaaaabaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaaaaaaaahocaabaaa
abaaaaaafgaobaaaabaaaaaafgaobaaaabaaaaaadeaaaaakocaabaaaabaaaaaa
fgaobaaaabaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaiadpaaaaiadpanaaaead
akaabaaaabaaaaaaaaaaaaahhcaabaaaacaaaaaajgahbaaaaaaaaaaajgahbaaa
aaaaaaaaddaaaaakhcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadbaaaaakocaabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaadpaaaaaadpaaaaaadpfgaobaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
akaabaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaajgahbaaaaaaaaaaajgahbaaa
abaaaaaaegacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedgagjeppldlppcaceoebfkfapgbdakhnjabaaaaaaomadaaaaaeaaaaaa
daaaaaaagiabaaaaeeadaaaaliadaaaaebgpgodjdaabaaaadaabaaaaaaacpppp
aiabaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaiadpbpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaappla
aaaaaakaebaaaaababaaapiaaeaaaaaeabaachiaaaaaoeiaaaaaoelaaaaakkka
acaaaaadabaachiaabaaoeiaabaaoeiaalaaaaadacaachiaaaaappkaabaaoeia
afaaaaadabaacpiaaaaaoeiaaaaaoelaaeaaaaaeaaaaahiaaaaaoeiaaaaaoelb
aaaaffkaacaaaaadadaachiaabaaoeiaabaaoeiaakaaaaadaeaachiaadaaoeia
aaaappkafiaaaaaeabaachiaaaaaoeiaaeaaoeiaacaaoeiaabaaaaacaaaicpia
abaaoeiappppaaaafdeieefcneabaaaaeaaaaaaahfaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaampcaabaaaabaaaaaadgajbaaaaaaaaaaadgbjbaaaabaaaaaa
aceaaaaaaknhcdlmaaaaaalpaaaaaalpaaaaaalpdiaaaaahpcaabaaaaaaaaaaa
dgajbaaaaaaaaaaadgbjbaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaaaaaaaahocaabaaaabaaaaaafgaobaaaabaaaaaa
fgaobaaaabaaaaaadeaaaaakocaabaaaabaaaaaafgaobaaaabaaaaaaaceaaaaa
aaaaaaaaaaaaiadpaaaaiadpaaaaiadpanaaaeadakaabaaaabaaaaaaaaaaaaah
hcaabaaaacaaaaaajgahbaaaaaaaaaaajgahbaaaaaaaaaaaddaaaaakhcaabaaa
acaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
dbaaaaakocaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaadpaaaaaadpaaaaaadp
fgaobaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaaakaabaaaaaaaaaaadhaaaaaj
hccabaaaaaaaaaaajgahbaaaaaaaaaaajgahbaaaabaaaaaaegacbaaaacaaaaaa
doaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
SLT R1.x, R0.w, c[0].z;
CMP R0.xyz, -R0, c[0].x, c[0].y;
MOV result.color.w, R0;
MOV result.color.xyz, R0;
KIL -R1.x;
END
# 7 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r1.x, r0.w, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
cmp r0.xyz, -r0, c0.y, c0.z
mov_pp oC0, r0
texkill r1.xyzw
"
}
SubProgram "d3d11 " {
Keywords { "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedjihfiemagikjkhjodihajgoifjcngjkfabaaaaaacaacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceeabaaaaeaaaaaaa
fbaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaadbaaaaakhcaabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaabaaaaakhccabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedlnfahbopeeedaclaaiciboleokilplnoabaaaaaapeacaaaaaeaaaaaa
daaaaaaaaaabaaaaemacaaaamaacaaaaebgpgodjmiaaaaaamiaaaaaaaaacpppp
kaaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaaaaaaaaiadpaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaappla
aaaaaakaafaaaaadaaaacpiaaaaaoeiaaaaaoelaebaaaaababaaapiafiaaaaae
aaaachiaaaaaoeibaaaaffkaaaaakkkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefceeabaaaaeaaaaaaafbaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
bcaabaaaabaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlm
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaa
abaaaaaadbaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
abaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
SLT R1.x, R0.w, c[0].y;
ADD R0.xyz, -R0, c[0].x;
MOV result.color.w, R0;
ABS result.color.xyz, R0;
KIL -R1.x;
END
# 7 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r1.x, r0.w, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
add_pp r0.xyz, -r0, c0.z
abs_pp r0.xyz, r0
mov_pp oC0, r0
texkill r1.xyzw
"
}
SubProgram "d3d11 " {
Keywords { "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedonlgacndeeadpbbpnjmgbdacibkcnpbfabaaaaaabmacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceaabaaaaeaaaaaaa
faaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaadcaaaaan
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
dgaaaaaghccabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedeeodipgnglplmfdafemaegidnnhnndgfabaaaaaapmacaaaaaeaaaaaa
daaaaaaaamabaaaafeacaaaamiacaaaaebgpgodjneaaaaaaneaaaaaaaaacpppp
kmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaappla
aaaaaakaebaaaaababaaapiaaeaaaaaeaaaachiaaaaaoeiaaaaaoelbaaaaffka
afaaaaadabaaciiaaaaappiaaaaapplacdaaaaacabaachiaaaaaoeiaabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefceaabaaaaeaaaaaaafaaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaadkbabaaa
abaaaaaaabeaaaaaaknhcdlmdbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaadcaaaaanhcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaaghccabaaa
aaaaaaaaegacbaiaibaaaaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 2, 1, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
SLT R1.x, R0.w, c[0].z;
MAD R0.xyz, -R0, c[0].x, R0;
MOV result.color.w, R0;
ADD result.color.xyz, R0, c[0].y;
KIL -R1.x;
END
# 7 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, 2.00000000
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r1.x, r0.w, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
mad_pp r0.xyz, -r0, c0.w, r0
add_pp r0.xyz, r0, c0.z
mov_pp oC0, r0
texkill r1.xyzw
"
}
SubProgram "d3d11 " {
Keywords { "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedjfkikoailpocikdogifmpjfjdbkabedgabaaaaaabaacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdeabaaaaeaaaaaaa
enaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaabaaaaaadgajbaaa
aaaaaaaadgbjbaaaabaaaaaaaceaaaaaaknhcdlmaaaaiadpaaaaiadpaaaaiadp
diaaaaahpcaabaaaaaaaaaaadgajbaaaaaaaaaaadgbjbaaaabaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaanhccabaaa
aaaaaaaajgahbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaajgahbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaakaabaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedfahgfboibnobagpfnfeajgabjlnefelpabaaaaaapiacaaaaaeaaaaaa
daaaaaaabeabaaaafaacaaaameacaaaaebgpgodjnmaaaaaanmaaaaaaaaacpppp
leaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaiadpaaaaaaeaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaappla
aaaaaakaebaaaaababaaapiaaeaaaaaeabaachiaaaaaoeiaaaaaoelaaaaaffka
afaaaaadaaaacpiaaaaaoeiaaaaaoelaaeaaaaaeaaaachiaaaaaoeiaaaaakkkb
abaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcdeabaaaaeaaaaaaa
enaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaabaaaaaadgajbaaa
aaaaaaaadgbjbaaaabaaaaaaaceaaaaaaknhcdlmaaaaiadpaaaaiadpaaaaiadp
diaaaaahpcaabaaaaaaaaaaadgajbaaaaaaaaaaadgbjbaaaabaaaaaadbaaaaah
bcaabaaaabaaaaaaakaabaaaabaaaaaaabeaaaaaaaaaaaaadcaaaaanhccabaaa
aaaaaaaajgahbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaajgahbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaakaabaaaaaaaaaaa
anaaaeadakaabaaaabaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
SLT R1.x, R0.w, c[0].y;
MOV result.color.w, R0;
ADD result.color.xyz, -R0, c[0].x;
KIL -R1.x;
END
# 6 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r1.x, r0.w, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
add_pp r0.xyz, -r0, c0.z
mov_pp oC0, r0
texkill r1.xyzw
"
}
SubProgram "d3d11 " {
Keywords { "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedibpekaeepialijldnlkmggepejlhfmjhabaaaaaapiabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbmabaaaaeaaaaaaa
ehaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadcaaaaappccabaaaaaaaaaaaegaobaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaiadpaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecednahhciplpacieandjgaogghalanjocjjabaaaaaaaiadaaaaaeaaaaaa
daaaaaaadmabaaaagaacaaaaneacaaaaebgpgodjaeabaaaaaeabaaaaaaacpppp
nmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaaaaaaaaaaaaaaaaaaaafbaaaaaf
abaaapkaaaaaialpaaaaialpaaaaialpaaaaiadpfbaaaaafacaaapkaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaabpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaia
abaacdlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapiaabaaoelaaaaioeka
aeaaaaaeabaacpiaaaaappiaaaaapplaaaaaaakaafaaaaadaaaacpiaaaaaoeia
aaaaoelaabaaaaacacaaapiaabaaoekaaeaaaaaeaaaacpiaaaaaoeiaacaaoeia
acaaoekaabaaaaacaaaicpiaaaaaoeiaebaaaaababaaapiappppaaaafdeieefc
bmabaaaaeaaaaaaaehaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaa
abaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaadcaaaaappccabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaiadp
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaahbcaabaaaaaaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaadoaaaaab
ejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
gcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
SLT R1.x, R0.w, c[0];
MOV result.color.w, R0;
RCP result.color.x, R0.x;
RCP result.color.y, R0.y;
RCP result.color.z, R0.z;
KIL -R1.x;
END
# 8 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.01000214, 0.00000000, 1.00000000, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r1.x, r0.w, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mov_pp oC0, r0
texkill r1.xyzw
"
}
SubProgram "d3d11 " {
Keywords { "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedfacmpoegfnfdgoiiikkamgffbmfcaocaabaaaaaapiabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbmabaaaaeaaaaaaa
ehaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaa
abaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaakhccabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedhjbohacekmnoebepccpfkdammppdlohaabaaaaaanmacaaaaaeaaaaaa
daaaaaaabaabaaaadeacaaaakiacaaaaebgpgodjniaaaaaaniaaaaaaaaacpppp
laaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaappiaaaaappla
aaaaaakaafaaaaadaaaacpiaaaaaoeiaaaaaoelaebaaaaababaaapiaagaaaaac
aaaacbiaaaaaaaiaagaaaaacaaaacciaaaaaffiaagaaaaacaaaaceiaaaaakkia
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcbmabaaaaeaaaaaaaehaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaabaaaaaadkaabaaaaaaaaaaa
dkbabaaaabaaaaaaabeaaaaaaknhcdlmdiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaabaaaaaaaoaaaaakhccabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "UI/Default"
}