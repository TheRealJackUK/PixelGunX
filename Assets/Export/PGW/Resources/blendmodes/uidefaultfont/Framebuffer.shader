Shader "BlendModes/UIDefaultFont/Framebuffer" {
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
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, fragment.color.primary.w, R0.w;
SLT R0.y, R0.x, c[0];
MIN result.color.xyz, fragment.color.primary, c[0].x;
MOV result.color.w, R0.x;
KIL -R0.y;
END
# 6 instructions, 1 R-regs
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
min_pp r1.xyz, v0, c0.z
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "BMDarken" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedopaiglbceciaoimlgeodlidanlhlkjpgabaaaaaapiabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbmabaaaaeaaaaaaa
ehaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaaddaaaaakhccabaaaaaaaaaaaegbcbaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarken" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecediailmjpmldcegnbmbaoelmbmhnoldeblabaaaaaamiacaaaaaeaaaaaa
daaaaaaapmaaaaaacaacaaaajeacaaaaebgpgodjmeaaaaaameaaaaaaaaacpppp
jmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaacplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappia
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiaakaaaaad
aaaachiaaaaaoelaaaaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
bmabaaaaeaaaaaaaehaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaadkbabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
ccaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaabkaabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaaddaaaaakhccabaaaaaaaaaaa
egbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab
ejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
gcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 0.010002136 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, fragment.color.primary.w, R0.w;
SLT R0.y, R0.x, c[0].x;
MOV result.color.xyz, fragment.color.primary;
MOV result.color.w, R0.x;
KIL -R0.y;
END
# 6 instructions, 1 R-regs
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
mov_pp r1.xyz, v0
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedhlpbanedlbkgohkjkdahfjkndfddodifabaaaaaaoeabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaiabaaaaeaaaaaaa
ecaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaadgaaaaafhccabaaaaaaaaaaaegbcbaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedmhhkmogpabmhcieenlkdijbaioekjaooabaaaaaalaacaaaaaeaaaaaa
daaaaaaapiaaaaaaaiacaaaahmacaaaaebgpgodjmaaaaaaamaaaaaaaaaacpppp
jiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaacplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappia
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiaabaaaaac
aaaachiaaaaaoelaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcaiabaaaa
eaaaaaaaecaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
dkbabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
bkaabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaaaaaaaaadgaaaaafhccabaaaaaaaaaaaegbcbaaa
abaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
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
MUL R0.x, fragment.color.primary.w, R0.w;
SLT R0.y, R0.x, c[0];
MOV result.color.xyz, c[0].x;
MOV result.color.w, R0.x;
KIL -R0.y;
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
mov_pp r1.xyz, c0.z
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedpmkekpdhgdnfoaijcmnebpmoeebfcjblabaaaaaapaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbeabaaaaeaaaaaaa
efaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedpamaipeaeigpigoieoicebmgpiffinneabaaaaaalmacaaaaaeaaaaaa
daaaaaaapiaaaaaabeacaaaaiiacaaaaebgpgodjmaaaaaaamaaaaaaaaaacpppp
jiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaacplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappia
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiaabaaaaac
aaaachiaaaaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcbeabaaaa
eaaaaaaaefaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
dkbabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaa
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
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, fragment.color.primary.w, R0.w;
SLT R0.y, R0.x, c[0].x;
MOV result.color.xyz, fragment.color.primary;
MOV result.color.w, R0.x;
KIL -R0.y;
END
# 6 instructions, 1 R-regs
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
mov_pp r1.xyz, v0
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedhlpbanedlbkgohkjkdahfjkndfddodifabaaaaaaoeabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaiabaaaaeaaaaaaa
ecaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaadgaaaaafhccabaaaaaaaaaaaegbcbaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedmhhkmogpabmhcieenlkdijbaioekjaooabaaaaaalaacaaaaaeaaaaaa
daaaaaaapiaaaaaaaiacaaaahmacaaaaebgpgodjmaaaaaaamaaaaaaaaaacpppp
jiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaacplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappia
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiaabaaaaac
aaaachiaaaaaoelaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcaiabaaaa
eaaaaaaaecaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
dkbabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaa
aaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
bkaabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaaaaanaaaeadakaabaaaaaaaaaaadgaaaaafhccabaaaaaaaaaaaegbcbaaa
abaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
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
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, fragment.color.primary.w, R0.w;
SLT R0.y, R0.x, c[1].x;
MOV result.color.w, R0.x;
KIL -R0.y;
MUL R0.y, fragment.color.primary, c[0].z;
MAD R0.y, fragment.color.primary.x, c[0], R0;
MAD R0.y, fragment.color.primary.z, c[0].w, R0;
ADD R0.y, -R0, c[0].x;
CMP result.color.xyz, R0.y, c[0].x, fragment.color.primary;
END
# 10 instructions, 1 R-regs
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
mul_pp r1.x, v0.y, c0.w
mad_pp r1.x, v0, c1, r1
mad_pp r1.x, v0.z, c1.y, r1
add_pp r1.x, -r1, c0.z
cmp_pp r1.xyz, r1.x, v0, c0.z
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedlnhepaejbjakefglmedcemcccccinafeabaaaaaaeeacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgiabaaaaeaaaaaaa
fkaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaabaaaaaakbcaabaaaaaaaaaaaegbcbaaaabaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaadbaaaaahbcaabaaaaaaaaaaa
abeaaaaaaaaaiadpakaabaaaaaaaaaaadhaaaaamhccabaaaaaaaaaaaagaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaegbcbaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedogameddombhjohcinllainlbfmkiebjdabaaaaaahiadaaaaaeaaaaaa
daaaaaaagaabaaaanaacaaaaeeadaaaaebgpgodjciabaaaaciabaaaaaaacpppp
aaabaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmkcefbgdpihbgjjdonfhiojdnfbaaaaaf
abaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacpla
bpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapia
abaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappiaaaaaaakaafaaaaad
aaaaciiaaaaappiaaaaapplaebaaaaababaaapiaafaaaaadabaacbiaaaaaffla
aaaaffkaaeaaaaaeabaacbiaaaaaaalaaaaakkkaabaaaaiaaeaaaaaeabaacbia
aaaakklaaaaappkaabaaaaiaacaaaaadabaaabiaabaaaaibabaaaakafiaaaaae
aaaachiaabaaaaiaaaaaoelaabaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcgiabaaaaeaaaaaaafkaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaadkbabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlm
diaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaabaaaaaakbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
dbaaaaahbcaabaaaaaaaaaaaabeaaaaaaaaaiadpakaabaaaaaaaaaaadhaaaaam
hccabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaegbcbaaaabaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaa
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
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, fragment.color.primary.w, R0.w;
SLT R0.y, R0.x, c[0];
MAX result.color.xyz, fragment.color.primary, c[0].x;
MOV result.color.w, R0.x;
KIL -R0.y;
END
# 6 instructions, 1 R-regs
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
max_pp r1.xyz, v0, c0.z
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedlojmibgmiapkibpglplldpcfhdekchkaabaaaaaapiabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbmabaaaaeaaaaaaa
ehaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaadeaaaaakhccabaaaaaaaaaaaegbcbaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecednhiipljmpmnjjbmcacjlngaopcoeaimmabaaaaaamiacaaaaaeaaaaaa
daaaaaaapmaaaaaacaacaaaajeacaaaaebgpgodjmeaaaaaameaaaaaaaaacpppp
jmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaacplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappia
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiaalaaaaad
aaaachiaaaaaffkaaaaaoelaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
bmabaaaaeaaaaaaaehaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaadkbabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
ccaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaabkaabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaadeaaaaakhccabaaaaaaaaaaa
egbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab
ejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
gcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.010002136 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, fragment.color.primary.w, R0.w;
SLT R0.y, R0.x, c[0];
MOV result.color.xyz, c[0].x;
MOV result.color.w, R0.x;
KIL -R0.y;
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
mov_pp r1.xyz, c0.z
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedpmkekpdhgdnfoaijcmnebpmoeebfcjblabaaaaaapaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbeabaaaaeaaaaaaa
efaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedpamaipeaeigpigoieoicebmgpiffinneabaaaaaalmacaaaaaeaaaaaa
daaaaaaapiaaaaaabeacaaaaiiacaaaaebgpgodjmaaaaaaamaaaaaaaaaacpppp
jiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaacplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappia
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiaabaaaaac
aaaachiaaaaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcbeabaaaa
eaaaaaaaefaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
dkbabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaa
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
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, fragment.color.primary.w, R0.w;
SLT R0.y, R0.x, c[0];
MOV result.color.w, R0.x;
KIL -R0.y;
ADD R0.yzw, -fragment.color.primary.xxyz, c[0].x;
RCP result.color.x, R0.y;
RCP result.color.y, R0.z;
RCP result.color.z, R0.w;
END
# 9 instructions, 1 R-regs
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
mov_pp r0.w, r0.x
texkill r1.xyzw
add_pp r1.xyz, -v0, c0.z
rcp_pp r0.x, r1.x
rcp_pp r0.z, r1.z
rcp_pp r0.y, r1.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecednhmhjoodbpmogolohkcellkaabgjipgaabaaaaaaceacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceiabaaaaeaaaaaaa
fcaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaaaaaaaaalhcaabaaaaaaaaaaaegbcbaiaebaaaaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaoaaaaakhccabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedapegnhjkgefanhonkoklmdohgkgplmciabaaaaaabiadaaaaaeaaaaaa
daaaaaaacaabaaaahaacaaaaoeacaaaaebgpgodjoiaaaaaaoiaaaaaaaaacpppp
maaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaacplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappia
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiaacaaaaad
abaachiaaaaaoelbaaaaffkaagaaaaacaaaacbiaabaaaaiaagaaaaacaaaaccia
abaaffiaagaaaaacaaaaceiaabaakkiaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefceiabaaaaeaaaaaaafcaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaadkbabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlm
diaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaaaaaaaaalhcaabaaa
aaaaaaaaegbcbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaaoaaaaakhccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpegacbaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.010002136 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, fragment.color.primary.w, R0.w;
SLT R0.y, R0.x, c[0];
ADD result.color.xyz, fragment.color.primary, c[0].x;
MOV result.color.w, R0.x;
KIL -R0.y;
END
# 6 instructions, 1 R-regs
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
add_pp r1.xyz, v0, c0.z
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedghdfkidegoapjdphmjfgcnbfkmcbfoaiabaaaaaapiabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbmabaaaaeaaaaaaa
ehaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaaaaaaaaakhccabaaaaaaaaaaaegbcbaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedcjlefclpgapmfeifajkjojolobbemkgmabaaaaaamiacaaaaaeaaaaaa
daaaaaaapmaaaaaacaacaaaajeacaaaaebgpgodjmeaaaaaameaaaaaaaaacpppp
jmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaacplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappia
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiaacaaaaad
aaaachiaaaaaoelaaaaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
bmabaaaaeaaaaaaaehaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaadkbabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
ccaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaabkaabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaaaaaaaaakhccabaaaaaaaaaaa
egbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab
ejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
gcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[2] = { { 1, 0.29907227, 0.58691406, 0.11401367 },
		{ 0.010002136 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, fragment.color.primary.w, R0.w;
SLT R0.y, R0.x, c[1].x;
MOV result.color.w, R0.x;
KIL -R0.y;
MUL R0.y, fragment.color.primary, c[0].z;
MAD R0.y, fragment.color.primary.x, c[0], R0;
MAD R0.y, fragment.color.primary.z, c[0].w, R0;
ADD R0.y, -R0, c[0].x;
CMP result.color.xyz, -R0.y, c[0].x, fragment.color.primary;
END
# 10 instructions, 1 R-regs
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
mul_pp r1.x, v0.y, c0.w
mad_pp r1.x, v0, c1, r1
mad_pp r1.x, v0.z, c1.y, r1
add_pp r1.x, -r1, c0.z
cmp_pp r1.xyz, -r1.x, v0, c0.z
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedlphpifcdikophopldemobjockldajbblabaaaaaaeeacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgiabaaaaeaaaaaaa
fkaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaabaaaaaakbcaabaaaaaaaaaaaegbcbaaaabaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaadbaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaiadpdhaaaaamhccabaaaaaaaaaaaagaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaegbcbaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedcgpcilfgofoijjmjnhhjmbmgpgcpmnpdabaaaaaahiadaaaaaeaaaaaa
daaaaaaagaabaaaanaacaaaaeeadaaaaebgpgodjciabaaaaciabaaaaaaacpppp
aaabaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmkcefbgdpihbgjjdonfhiojdnfbaaaaaf
abaaapkaaaaaialpaaaaiadpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacpla
bpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapia
abaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappiaaaaaaakaafaaaaad
aaaaciiaaaaappiaaaaapplaebaaaaababaaapiaafaaaaadabaacbiaaaaaffla
aaaaffkaaeaaaaaeabaacbiaaaaaaalaaaaakkkaabaaaaiaaeaaaaaeabaacbia
aaaakklaaaaappkaabaaaaiaacaaaaadabaaabiaabaaaaiaabaaaakafiaaaaae
aaaachiaabaaaaiaaaaaoelaabaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcgiabaaaaeaaaaaaafkaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaadkbabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlm
diaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaabaaaaaakbcaabaaa
aaaaaaaaegbcbaaaabaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
dbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaiadpdhaaaaam
hccabaaaaaaaaaaaagaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaegbcbaaaabaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaa
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
MUL R0.x, fragment.color.primary.w, R0.w;
SLT R0.y, R0.x, c[0];
MOV result.color.xyz, c[0].x;
MOV result.color.w, R0.x;
KIL -R0.y;
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
mov_pp r1.xyz, c0.z
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedpmkekpdhgdnfoaijcmnebpmoeebfcjblabaaaaaapaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbeabaaaaeaaaaaaa
efaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedpamaipeaeigpigoieoicebmgpiffinneabaaaaaalmacaaaaaeaaaaaa
daaaaaaapiaaaaaabeacaaaaiiacaaaaebgpgodjmaaaaaaamaaaaaaaaaacpppp
jiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaacplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappia
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiaabaaaaac
aaaachiaaaaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcbeabaaaa
eaaaaaaaefaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
dkbabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaa
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
MUL R0.x, fragment.color.primary.w, R0.w;
SLT R0.y, R0.x, c[0];
MOV result.color.xyz, c[0].x;
MOV result.color.w, R0.x;
KIL -R0.y;
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
mov_pp r1.xyz, c0.z
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedpmkekpdhgdnfoaijcmnebpmoeebfcjblabaaaaaapaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbeabaaaaeaaaaaaa
efaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedpamaipeaeigpigoieoicebmgpiffinneabaaaaaalmacaaaaaeaaaaaa
daaaaaaapiaaaaaabeacaaaaiiacaaaaebgpgodjmaaaaaaamaaaaaaaaaacpppp
jiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaacplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappia
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiaabaaaaac
aaaachiaaaaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcbeabaaaa
eaaaaaaaefaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaa
dkbabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaa
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
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.w, fragment.color.primary, R0;
SLT R0.x, R0.w, c[0].w;
ADD R1.xyz, fragment.color.primary, -c[0].x;
MOV result.color.w, R0;
KIL -R0.x;
MUL R0.xyz, fragment.color.primary, c[0].z;
CMP result.color.xyz, -R1, c[0].y, R0;
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
add_pp r2.xyz, v0, c1.x
texkill r1.xyzw
mul_pp r1.xyz, v0, c0.w
cmp_pp r1.xyz, -r2, r1, c0.z
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedmegfbbpikahihelnhnbhhlmdimhbccoiabaaaaaaeeacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgiabaaaaeaaaaaaa
fkaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaadbaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaaegbcbaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaa
egbcbaaaabaaaaaaegbcbaaaabaaaaaadhaaaaamhccabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaegacbaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecednhmfhddagblacnhmckbcpjbhbbclmjanabaaaaaadiadaaaaaeaaaaaa
daaaaaaacaabaaaajaacaaaaaeadaaaaebgpgodjoiaaaaaaoiaaaaaaaaacpppp
maaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaiadpaaaaaaaabpaaaaac
aaaaaaiaaaaacplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappia
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiaacaaaaad
abaaahiaaaaaoelbaaaaffkaacaaaaadacaachiaaaaaoelaaaaaoelafiaaaaae
aaaachiaabaaoeiaacaaoeiaaaaakkkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcgiabaaaaeaaaaaaafkaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaadkbabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlm
diaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaadbaaaaakhcaabaaa
aaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegbcbaaaabaaaaaa
aaaaaaahhcaabaaaabaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaadhaaaaam
hccabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 2, 1, 0.010002136 } };
TEMP R0;
TEMP R1;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.w, fragment.color.primary, R0;
SLT R0.x, R0.w, c[0].w;
ADD R1.xyz, fragment.color.primary, -c[0].x;
MOV result.color.w, R0;
KIL -R0.x;
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
add_pp r2.xyz, v0, c0.w
texkill r1.xyzw
mad_pp r1.xyz, -r2, c1.x, c1.y
rcp_pp r1.x, r1.x
rcp_pp r1.z, r1.z
rcp_pp r1.y, r1.y
cmp_pp r1.xyz, -r2, c0.z, r1
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedlcfmnmnnjdhbebiicdcckfihamhenkkmabaaaaaaliacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnmabaaaaeaaaaaaa
hhaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegbcbaaaabaaaaaa
aceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaadcaaaabahcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaoaaaaakhcaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadbaaaaak
hcaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegbcbaaa
abaaaaaadhaaaaamhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedpmdkeicpnpjppemlanfjgboomgiaaffhabaaaaaapmadaaaaaeaaaaaa
daaaaaaahaabaaaafeadaaaamiadaaaaebgpgodjdiabaaaadiabaaaaaaacpppp
baabaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaiadpfbaaaaaf
abaaapkaaaaaaaeaaaaaiadpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacpla
bpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapia
abaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappiaaaaaaakaafaaaaad
aaaaciiaaaaappiaaaaapplaebaaaaababaaapiaacaaaaadabaaahiaaaaaoelb
aaaaffkaacaaaaadacaachiaaaaaoelaaaaakkkaaeaaaaaeacaachiaacaaoeia
abaaaakbabaaffkaagaaaaacadaacbiaacaaaaiaagaaaaacadaacciaacaaffia
agaaaaacadaaceiaacaakkiafiaaaaaeaaaachiaabaaoeiaaaaappkaadaaoeia
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcnmabaaaaeaaaaaaahhaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaaabaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaaaaaaaaaa
dbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaa
aaaaaalpaaaaaalpaaaaaalpaaaaaaaadcaaaabahcaabaaaaaaaaaaaegacbaia
ebaaaaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaaoaaaaakhcaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadbaaaaakhcaabaaa
abaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegbcbaaaabaaaaaa
dhaaaaamhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2, 0.010002136 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.w, fragment.color.primary, R0;
SLT R0.x, R0.w, c[0].w;
MUL R1.xyz, fragment.color.primary, c[0].z;
MOV result.color.w, R0;
KIL -R0.x;
ADD R0.xyz, fragment.color.primary, -c[0].x;
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
mul_pp r2.xyz, v0, c1.x
texkill r1.xyzw
add_pp r1.xyz, v0, c0.w
mad_pp r3.xyz, r1, c1.x, c1.y
cmp_pp r1.xyz, -r1, r2, r3
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedfpnbcfibnjblokdolegmobeiilcagelcabaaaaaajmacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmaabaaaaeaaaaaaa
haaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegbcbaaaabaaaaaa
aceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaadcaaaaaphcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaakhcaabaaaabaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaegbcbaaaabaaaaaaaaaaaaahhcaabaaa
acaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaadhaaaaajhccabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedigmmhfkhlgjpmbmcllholachfienlnjcabaaaaaammadaaaaaeaaaaaa
daaaaaaafmabaaaaceadaaaajiadaaaaebgpgodjceabaaaaceabaaaaaaacpppp
pmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaaaaafbaaaaaf
abaaapkaaaaaaaeaaaaaiadpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacpla
bpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapia
abaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappiaaaaaaakaafaaaaad
aaaaciiaaaaappiaaaaapplaebaaaaababaaapiaacaaaaadabaachiaaaaaoela
aaaakkkaaeaaaaaeabaachiaabaaoeiaabaaaakaabaaffkaacaaaaadacaaahia
aaaaoelbaaaaffkaacaaaaadadaachiaaaaaoelaaaaaoelafiaaaaaeaaaachia
acaaoeiaadaaoeiaabaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
maabaaaaeaaaaaaahaaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaadkbabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
ccaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaabkaabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egbcbaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaadcaaaaap
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaakhcaabaaa
abaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegbcbaaaabaaaaaa
aaaaaaahhcaabaaaacaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaadhaaaaaj
hccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
doaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2, 0.010002136 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.w, fragment.color.primary, R0;
SLT R0.x, R0.w, c[0].w;
MUL R2.xyz, fragment.color.primary, c[0].z;
MIN R2.xyz, R2, c[0].y;
MOV result.color.w, R0;
KIL -R0.x;
ADD R0.xyz, fragment.color.primary, -c[0].x;
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
mul_pp r2.xyz, v0, c1.x
min_pp r2.xyz, r2, c0.z
texkill r1.xyzw
add_pp r1.xyz, v0, c0.w
mul_pp r3.xyz, r1, c1.x
max_pp r3.xyz, r3, c0.z
cmp_pp r1.xyz, -r1, r2, r3
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedcpkdombldbhcllgnkccibgdbkblhcngdabaaaaaammacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpaabaaaaeaaaaaaa
hmaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegbcbaaaabaaaaaa
aceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaadeaaaaakhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahhcaabaaa
abaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaaddaaaaakhcaabaaaabaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaak
hcaabaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegbcbaaa
abaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedccijiekfbhfhgjdjniijcfhamecodppbabaaaaaaaaaeaaaaaeaaaaaa
daaaaaaagaabaaaafiadaaaammadaaaaebgpgodjciabaaaaciabaaaaaaacpppp
aaabaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaadpaaaaaalpaaaaiadpbpaaaaac
aaaaaaiaaaaacplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappia
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiaacaaaaad
abaachiaaaaaoelaaaaakkkaacaaaaadabaachiaabaaoeiaabaaoeiaalaaaaad
acaachiaaaaappkaabaaoeiaacaaaaadabaachiaaaaaoelaaaaaoelaakaaaaad
adaachiaabaaoeiaaaaappkaacaaaaadabaaahiaaaaaoelbaaaaffkafiaaaaae
aaaachiaabaaoeiaadaaoeiaacaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefcpaabaaaaeaaaaaaahmaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaadkbabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlm
diaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaaaaaaaaakhcaabaaa
aaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadeaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaaaaaaaahhcaabaaaabaaaaaaegbcbaaaabaaaaaaegbcbaaaabaaaaaa
ddaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadbaaaaakhcaabaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaaegbcbaaaabaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheogmaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0, 0.010002136 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, fragment.color.primary.w, R0.w;
SLT R0.y, R0.x, c[0].z;
MOV result.color.w, R0.x;
KIL -R0.y;
CMP R0.yzw, -fragment.color.primary.xxyz, c[0].x, c[0].y;
MOV result.color.xyz, R0.yzww;
END
# 7 instructions, 1 R-regs
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
cmp r1.xyz, -v0, c0.y, c0.z
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedbplihjpajmdagkogmdbdkllbakcmcbjkabaaaaaacaacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceeabaaaaeaaaaaaa
fbaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaadbaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegbcbaaaabaaaaaaabaaaaakhccabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedmkpmfbiidkgffdkjoobfahhflbbpakakabaaaaaapeacaaaaaeaaaaaa
daaaaaaaaaabaaaaemacaaaamaacaaaaebgpgodjmiaaaaaamiaaaaaaaaacpppp
kaaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaaaaaaaaiadpaaaaaaaabpaaaaac
aaaaaaiaaaaacplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappia
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiafiaaaaae
aaaachiaaaaaoelbaaaaffkaaaaakkkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefceeabaaaaeaaaaaaafbaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
bcaabaaaaaaaaaaadkbabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlm
diaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaadbaaaaakhcaabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegbcbaaaabaaaaaa
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
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, fragment.color.primary.w, R0.w;
SLT R0.y, R0.x, c[0];
MOV result.color.w, R0.x;
KIL -R0.y;
ADD R0.yzw, -fragment.color.primary.xxyz, c[0].x;
ABS result.color.xyz, R0.yzww;
END
# 7 instructions, 1 R-regs
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
add_pp r1.xyz, -v0, c0.z
abs_pp r1.xyz, r1
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedmkpnhiginahimjhnmmcioolbcdjhlnemabaaaaaabeacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdiabaaaaeaaaaaaa
eoaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaaaaaaaaalhcaabaaaaaaaaaaaegbcbaiaebaaaaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadgaaaaaghccabaaa
aaaaaaaaegacbaiaibaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedmikdhpnnfomofmhamelfkfkpioblajbhabaaaaaapaacaaaaaeaaaaaa
daaaaaaaaiabaaaaeiacaaaalmacaaaaebgpgodjnaaaaaaanaaaaaaaaaacpppp
kiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaacplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappia
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiaacaaaaad
abaachiaaaaaoelbaaaaffkacdaaaaacaaaachiaabaaoeiaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcdiabaaaaeaaaaaaaeoaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaaabaaaaaadkaabaaaaaaaaaaa
abeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaaaaaaaaaadbaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaa
aaaaaaalhcaabaaaaaaaaaaaegbcbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadgaaaaaghccabaaaaaaaaaaaegacbaiaibaaaaaa
aaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 2, 1, 0.010002136 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, fragment.color.primary.w, R0.w;
SLT R0.y, R0.x, c[0].z;
MOV result.color.w, R0.x;
KIL -R0.y;
MAD R0.yzw, -fragment.color.primary.xxyz, c[0].x, fragment.color.primary.xxyz;
ADD result.color.xyz, R0.yzww, c[0].y;
END
# 7 instructions, 1 R-regs
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
mad_pp r1.xyz, -v0, c0.w, v0
add_pp r1.xyz, r1, c0.z
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedhgdcbghibkocjjpdkcmoaanmhcpljnikabaaaaaacmacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfaabaaaaeaaaaaaa
feaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegbcbaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaanhccabaaaaaaaaaaa
egbcbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedagcbmlfgcolibldidkjmhoiiodhhnpagabaaaaaabaadaaaaaeaaaaaa
daaaaaaabaabaaaagiacaaaanmacaaaaebgpgodjniaaaaaaniaaaaaaaaacpppp
laaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaiadpaaaaaaeaaaaaaaaabpaaaaac
aaaaaaiaaaaacplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappia
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiaacaaaaad
abaachiaaaaaoelaaaaaffkaaeaaaaaeaaaachiaaaaaoelaaaaakkkbabaaoeia
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcfaabaaaaeaaaaaaafeaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaaabaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaaaaaaaaaa
dbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaanhccabaaaaaaaaaaaegbcbaia
ebaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaa
aaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.010002136 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, fragment.color.primary.w, R0.w;
SLT R0.y, R0.x, c[0];
ADD result.color.xyz, -fragment.color.primary, c[0].x;
MOV result.color.w, R0.x;
KIL -R0.y;
END
# 6 instructions, 1 R-regs
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
texkill r1.xyzw
add_pp r1.xyz, -v0, c0.z
mov_pp r1.w, r0.x
mov_pp oC0, r1
"
}
SubProgram "d3d11 " {
Keywords { "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedlgcckllfjaghjlfliedoggjcbmfpfpeiabaaaaaapmabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefccaabaaaaeaaaaaaa
eiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaaaaaaaaalhccabaaaaaaaaaaaegbcbaiaebaaaaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefieceddagfpckbcogfkhlaejmllndgkglggnhgabaaaaaammacaaaaaeaaaaaa
daaaaaaapmaaaaaaceacaaaajiacaaaaebgpgodjmeaaaaaameaaaaaaaaacpppp
jmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaacplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappia
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiaacaaaaad
aaaachiaaaaaoelbaaaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
caabaaaaeaaaaaaaeiaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaa
aaaaaaaadkbabaaaabaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaah
ccaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaabkaabaaaaaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaaaaanaaaeadakaabaaaaaaaaaaaaaaaaaalhccabaaaaaaaaaaa
egbcbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
doaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 0.010002136 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MUL R0.x, fragment.color.primary.w, R0.w;
SLT R0.y, R0.x, c[0].x;
MOV result.color.w, R0.x;
RCP result.color.x, fragment.color.primary.x;
RCP result.color.y, fragment.color.primary.y;
RCP result.color.z, fragment.color.primary.z;
KIL -R0.y;
END
# 8 instructions, 1 R-regs
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
mul_pp r0.x, v0.w, r0.w
add_pp r1.x, r0, c0
mov_pp r0.w, r0.x
cmp r1.x, r1, c0.y, c0.z
mov_pp r1, -r1.x
rcp_pp r0.x, v0.x
rcp_pp r0.z, v0.z
rcp_pp r0.y, v0.y
mov_pp oC0, r0
texkill r1.xyzw
"
}
SubProgram "d3d11 " {
Keywords { "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedkijmghkehhojmcfjpcmnkciimdafhopdabaaaaaapiabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbmabaaaaeaaaaaaa
ehaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaa
abaaaaaadkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaa
aaaaaaaadbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaa
anaaaeadakaabaaaaaaaaaaaaoaaaaakhccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegbcbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedfkhenhbbalkhpecbbkbmipldfioppppaabaaaaaanmacaaaaaeaaaaaa
daaaaaaabaabaaaadeacaaaakiacaaaaebgpgodjniaaaaaaniaaaaaaaaacpppp
laaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaknhcdlmaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaacplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaacpiaaaaapplaaaaappia
aaaaaakaafaaaaadaaaaciiaaaaappiaaaaapplaebaaaaababaaapiaagaaaaac
aaaacbiaaaaaaalaagaaaaacaaaacciaaaaafflaagaaaaacaaaaceiaaaaakkla
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcbmabaaaaeaaaaaaaehaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaajbcaabaaaaaaaaaaadkbabaaaabaaaaaa
dkaabaaaaaaaaaaaabeaaaaaaknhcdlmdiaaaaahccaabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaabkaabaaaaaaaaaaa
dbaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaaaaanaaaead
akaabaaaaaaaaaaaaoaaaaakhccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpegbcbaaaabaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "UI/Default Font"
}