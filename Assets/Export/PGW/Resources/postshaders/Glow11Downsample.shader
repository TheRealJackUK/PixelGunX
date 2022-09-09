Shader "Hidden/Glow 11/Downsample" {
Properties {
 _MainTex ("MainTex", 2D) = "white" {}
 _Strength ("Strength", Float) = 0.25
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  ColorMask RGB
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 9 [_MainTex_TexelSize]
"!!ARBvp1.0
PARAM c[10] = { { 0, 1 },
		state.matrix.mvp,
		state.matrix.texture[0],
		program.local[9] };
TEMP R0;
TEMP R1;
MOV R1.zw, c[0].x;
MOV R0.zw, c[0].x;
MOV R0.xy, vertex.texcoord[0];
DP4 R1.y, R0, c[6];
DP4 R1.x, R0, c[5];
MOV R0.xy, -c[9];
MOV R0.zw, c[0].xyxy;
ADD result.texcoord[0], R1, R0;
MOV R0.zw, c[0].xyxy;
MOV R0.x, c[9];
MOV R0.y, -c[9];
ADD result.texcoord[1], R1, R0;
MOV R0.xy, c[9];
MOV R0.zw, c[0].xyxy;
ADD result.texcoord[2], R1, R0;
MOV R0.zw, c[0].xyxy;
MOV R0.x, -c[9];
MOV R0.y, c[9];
ADD result.texcoord[3], R1, R0;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 23 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [glstate_matrix_texture0]
Vector 8 [_MainTex_TexelSize]
"vs_2_0
def c9, 0.00000000, 2.00000000, 1.00000000, 0
dcl_position0 v0
dcl_texcoord0 v1
mov r1.zw, c9.x
mov r0.zw, c9.x
mov r0.xy, v1
dp4 r1.y, r0, c5
dp4 r0.y, r0, c4
mov r1.x, c8.y
mad r1.y, c9, r1.x, r1
mov r0.x, c8
mad r1.x, c9.y, r0, r0.y
mov r0.xy, -c8
mov r0.zw, c9.xyxz
add oT0, r1, r0
mov r0.zw, c9.xyxz
mov r0.x, c8
mov r0.y, -c8
add oT1, r1, r0
mov r0.xy, c8
mov r0.zw, c9.xyxz
add oT2, r1, r0
mov r0.zw, c9.xyxz
mov r0.x, -c8
mov r0.y, c8
add oT3, r1, r0
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
ConstBuffer "UnityPerDrawTexMatrices" 768
Matrix 512 [glstate_matrix_texture0]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityPerDrawTexMatrices" 2
"vs_4_0
eefiecedppghceommpbjahbnjahdaknlbbjclpclabaaaaaaaiaeaaaaadaaaaaa
cmaaaaaaiaaaaaaacaabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaapaaaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl
fdeieefcoaacaaaaeaaaabaaliaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafjaaaaaeegiocaaaacaaaaaaccaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaimccabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdiaaaaaidcaabaaa
aaaaaaaafgbfbaaaabaaaaaaegiacaaaacaaaaaacbaaaaaadcaaaaakdcaabaaa
aaaaaaaaegiacaaaacaaaaaacaaaaaaaagbabaaaabaaaaaaegaabaaaaaaaaaaa
aaaaaaajdccabaaaabaaaaaaegaabaaaaaaaaaaaegiacaiaebaaaaaaaaaaaaaa
abaaaaaadcaaaaandccabaaaacaaaaaaegiacaaaaaaaaaaaabaaaaaaaceaaaaa
aaaaiadpaaaaialpaaaaaaaaaaaaaaaaegaabaaaaaaaaaaadgaaaaaimccabaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdiaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaiadpdgaaaaagkcaabaaa
abaaaaaafgifcaaaaaaaaaaaabaaaaaaaaaaaaahdccabaaaadaaaaaaegaabaaa
aaaaaaaaegaabaaaabaaaaaadgaaaaaimccabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaiadpdgaaaaahecaabaaaabaaaaaaakiacaiaebaaaaaa
aaaaaaaaabaaaaaaaaaaaaahdccabaaaaeaaaaaaegaabaaaaaaaaaaaogakbaaa
abaaaaaadgaaaaaimccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
ConstBuffer "UnityPerDrawTexMatrices" 768
Matrix 512 [glstate_matrix_texture0]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
BindCB  "UnityPerDrawTexMatrices" 2
"vs_4_0_level_9_1
eefiecedpbjdiinbgbhbofinpdmfoegcnkdlpnmeabaaaaaalmafaaaaaeaaaaaa
daaaaaaaoaabaaaamiaeaaaabmafaaaaebgpgodjkiabaaaakiabaaaaaaacpopp
fmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaacaacaaaacaaagaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafaiaaapkaaaaaialpaaaaaaaaaaaaiadpaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaafaaaaadaaaaadia
abaaffjaahaaoekaaeaaaaaeaaaaadiaagaaoekaabaaaajaaaaaoeiaabaaaaac
abaaafiaaiaaoekaaeaaaaaeaaaaadoaabaaoekaabaaaaiaaaaaoeiaabaaaaac
aaaaamoaaiaajekaaeaaaaaeabaaadoaabaaoekaabaaociaaaaaoeiaabaaaaac
abaaamoaaiaajekaabaaaaacaaaaamiaabaaeekaacaaaaadacaaadoaaaaaooia
aaaaoeiaaeaaaaaeadaaadoaabaaoekaabaaoiiaaaaaoeiaabaaaaacacaaamoa
aiaajekaabaaaaacadaaamoaaiaajekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiappppaaaa
fdeieefcoaacaaaaeaaaabaaliaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafjaaaaaeegiocaaaacaaaaaaccaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagfaaaaadpccabaaaaeaaaaaagiaaaaacacaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaaimccabaaa
abaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdiaaaaaidcaabaaa
aaaaaaaafgbfbaaaabaaaaaaegiacaaaacaaaaaacbaaaaaadcaaaaakdcaabaaa
aaaaaaaaegiacaaaacaaaaaacaaaaaaaagbabaaaabaaaaaaegaabaaaaaaaaaaa
aaaaaaajdccabaaaabaaaaaaegaabaaaaaaaaaaaegiacaiaebaaaaaaaaaaaaaa
abaaaaaadcaaaaandccabaaaacaaaaaaegiacaaaaaaaaaaaabaaaaaaaceaaaaa
aaaaiadpaaaaialpaaaaaaaaaaaaaaaaegaabaaaaaaaaaaadgaaaaaimccabaaa
acaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaiadpdiaaaaaibcaabaaa
abaaaaaaakiacaaaaaaaaaaaabaaaaaaabeaaaaaaaaaiadpdgaaaaagkcaabaaa
abaaaaaafgifcaaaaaaaaaaaabaaaaaaaaaaaaahdccabaaaadaaaaaaegaabaaa
aaaaaaaaegaabaaaabaaaaaadgaaaaaimccabaaaadaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaiadpdgaaaaahecaabaaaabaaaaaaakiacaiaebaaaaaa
aaaaaaaaabaaaaaaaaaaaaahdccabaaaaeaaaaaaegaabaaaaaaaaaaaogakbaaa
abaaaaaadgaaaaaimccabaaaaeaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaiadpdoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklklepfdeheo
jiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaimaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaaimaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
apaaaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Strength]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { program.local[0] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R3, fragment.texcoord[3], texture[0], 2D;
TEX R2, fragment.texcoord[2], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
ADD R0, R0, R1;
ADD R0, R0, R2;
ADD R0, R0, R3;
MUL result.color, R0, c[0].x;
END
# 8 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Strength]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl t0.xy
dcl t1.xy
dcl t2.xy
dcl t3.xy
texld r0, t3, s0
texld r1, t2, s0
texld r2, t1, s0
texld r3, t0, s0
add_pp r2, r3, r2
add_pp r1, r2, r1
add_pp r0, r1, r0
mul_pp r0, r0, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_Strength]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkhagodmkdobpbbnammhegmfhmdaegioiabaaaaaaiiacaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaapadaaaafdfgfpfagphdgjhegjgpgoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefciaabaaaaeaaaaaaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gcbaaaaddcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaa
abaaaaaadiaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
acaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_Strength]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedlmmfjhmknimmhlgckjjianjeondfipghabaaaaaajiadaaaaaeaaaaaa
daaaaaaadmabaaaameacaaaageadaaaaebgpgodjaeabaaaaaeabaaaaaaacpppp
naaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaacaaabaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaaaaacplabpaaaaac
aaaaaaiaabaacplabpaaaaacaaaaaaiaacaacplabpaaaaacaaaaaaiaadaacpla
bpaaaaacaaaaaajaaaaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaecaaaaad
abaaapiaabaaoelaaaaioekaecaaaaadacaaapiaacaaoelaaaaioekaecaaaaad
adaaapiaadaaoelaaaaioekaacaaaaadaaaacpiaaaaaoeiaabaaoeiaacaaaaad
aaaacpiaacaaoeiaaaaaoeiaacaaaaadaaaacpiaadaaoeiaaaaaoeiaafaaaaad
aaaacpiaaaaaoeiaaaaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
iaabaaaaeaaaaaaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaad
dcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaipccabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaacaaaaaa
doaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapadaaaaimaaaaaa
acaaaaaaaaaaaaaaadaaaaaaadaaaaaaapadaaaaimaaaaaaadaaaaaaaaaaaaaa
adaaaaaaaeaaaaaaapadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  ColorMask RGB
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
"!!ARBvp1.0
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 5 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
mov oT0.xy, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedgcclnnbgpijgpddakojponflfpghdgniabaaaaaaoeabaaaaadaaaaaa
cmaaaaaaiaaaaaaaniaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklfdeieefcaeabaaaa
eaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0_level_9_1
eefiecedmldjmmohbhmjmnnblgkeoagbliecmmbkabaaaaaalmacaaaaaeaaaaaa
daaaaaaaaeabaaaabaacaaaageacaaaaebgpgodjmmaaaaaammaaaaaaaaacpopp
jiaaaaaadeaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaabaadaaaaaaaaaaa
aeaaabaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaac
afaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaacaaoekaaeaaaaaeaaaaapia
abaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaadaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaaeaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaadoaabaaoeja
ppppaaaafdeieefcaeabaaaaeaaaabaaebaaaaaafjaaaaaeegiocaaaaaaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
aaaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaa
abaaaaaaegbabaaaabaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaa
diaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfc
eeaaklklepfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Strength]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { program.local[0] };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL result.color, R0, c[0].x;
END
# 2 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Strength]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl t0.xy
texld r0, t0, s0
mul_pp r0, r0, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_Strength]
BindCB  "$Globals" 0
"ps_4_0
eefiecedfkoioomefdemcbpojefoakbcdgkhngfbabaaaaaafmabaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjmaaaaaa
eaaaaaaachaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipccabaaa
aaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 32 [_Strength]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecednimkkbendfbpalmagjbajgifacobmlggabaaaaaaoiabaaaaaeaaaaaa
daaaaaaaliaaaaaafmabaaaaleabaaaaebgpgodjiaaaaaaaiaaaaaaaaaacpppp
emaaaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaacaaabaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaaaaacdlabpaaaaac
aaaaaajaaaaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaafaaaaadaaaacpia
aaaaoeiaaaaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcjmaaaaaa
eaaaaaaachaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipccabaaa
aaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaacaaaaaadoaaaaabejfdeheo
faaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaeeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}