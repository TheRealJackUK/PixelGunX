Shader "Hidden/Glow 11/Blur" {
Properties {
 _MainTex ("", 2D) = "" {}
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
Float 5 [_offset1]
Float 6 [_offset2]
Vector 7 [_MainTex_TexelSize]
"!!ARBvp1.0
PARAM c[8] = { program.local[0],
		state.matrix.mvp,
		program.local[5..7] };
TEMP R0;
MOV R0.x, c[7];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
MAD result.texcoord[1].x, R0, -c[5], vertex.texcoord[0];
MOV result.texcoord[1].y, vertex.texcoord[0];
MAD result.texcoord[2].x, R0, c[5], vertex.texcoord[0];
MOV result.texcoord[2].y, vertex.texcoord[0];
MAD result.texcoord[3].x, R0, -c[6], vertex.texcoord[0];
MOV result.texcoord[3].y, vertex.texcoord[0];
MAD result.texcoord[4].x, R0, c[6], vertex.texcoord[0];
MOV result.texcoord[4].y, vertex.texcoord[0];
END
# 14 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Float 4 [_offset1]
Float 5 [_offset2]
Vector 6 [_MainTex_TexelSize]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.x, c4
mad oT1.x, c6, -r0, v1
mov r0.x, c4
mad oT2.x, c6, r0, v1
mov r0.x, c5
mad oT3.x, c6, -r0, v1
mov r0.x, c5
mov oT0.xy, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oT1.y, v1
mov oT2.y, v1
mov oT3.y, v1
mad oT4.x, c6, r0, v1
mov oT4.y, v1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Float 16 [_offset1]
Float 20 [_offset2]
Vector 32 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedkjfggdghgddhjfiobkbbedekcojidpmiabaaaaaafiadaaaaadaaaaaa
cmaaaaaaiaaaaaaadiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklfdeieefcbiacaaaa
eaaaabaaigaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaaddccabaaaafaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
dcaaaaamdcaabaaaaaaaaaaaegiacaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaa
aaaaaaaaacaaaaaaagbabaaaabaaaaaadgaaaaafecaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafdccabaaaacaaaaaaigaabaaaaaaaaaaadgaaaaafdccabaaa
aeaaaaaajgafbaaaaaaaaaaadcaaaaaldcaabaaaaaaaaaaaegiacaaaaaaaaaaa
abaaaaaaagiacaaaaaaaaaaaacaaaaaaagbabaaaabaaaaaadgaaaaafecaabaaa
aaaaaaaabkbabaaaabaaaaaadgaaaaafdccabaaaadaaaaaaigaabaaaaaaaaaaa
dgaaaaafdccabaaaafaaaaaajgafbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Float 16 [_offset1]
Float 20 [_offset2]
Vector 32 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedjchbjgbffnemkildeffbmhcghgacdifnabaaaaaaliaeaaaaaeaaaaaa
daaaaaaaimabaaaakmadaaaaaaaeaaaaebgpgodjfeabaaaafeabaaaaaaacpopp
beabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacaaaaadoaabaaoejaabaaaaacaaaaadiaabaaoekaaeaaaaaeabaaadia
aaaaoeiaacaaaakbabaaaajaabaaaaacabaaaeiaabaaffjaabaaaaacabaaadoa
abaaoiiaabaaaaacadaaadoaabaaojiaaeaaaaaeaaaaadiaaaaaoeiaacaaaaka
abaaaajaabaaaaacaaaaaeiaabaaffjaabaaaaacacaaadoaaaaaoiiaabaaaaac
aeaaadoaaaaaojiappppaaaafdeieefcbiacaaaaeaaaabaaigaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaaddccabaaaafaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaadcaaaaamdcaabaaaaaaaaaaa
egiacaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaacaaaaaaagbabaaa
abaaaaaadgaaaaafecaabaaaaaaaaaaabkbabaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaigaabaaaaaaaaaaadgaaaaafdccabaaaaeaaaaaajgafbaaaaaaaaaaa
dcaaaaaldcaabaaaaaaaaaaaegiacaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaa
acaaaaaaagbabaaaabaaaaaadgaaaaafecaabaaaaaaaaaaabkbabaaaabaaaaaa
dgaaaaafdccabaaaadaaaaaaigaabaaaaaaaaaaadgaaaaafdccabaaaafaaaaaa
jgafbaaaaaaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 0.22702703, 0.31621623, 0.07027027 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R3, fragment.texcoord[3], texture[0], 2D;
TEX R4, fragment.texcoord[4], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[2], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[0], 2D;
ADD R1, R1, R2;
MUL R1, R1, c[0].y;
MAD R0, R0, c[0].x, R1;
ADD R1, R3, R4;
MAD result.color, R1, c[0].z, R0;
END
# 10 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 0.31621623, 0.22702703, 0.07027027, 0
dcl t0.xy
dcl t1.xy
dcl t2.xy
dcl t3.xy
dcl t4.xy
texld r1, t3, s0
texld r0, t4, s0
texld r4, t0, s0
texld r2, t2, s0
texld r3, t1, s0
add r2, r3, r2
mul r2, r2, c0.x
mad r2, r4, c0.y, r2
add r0, r1, r0
mad r0, r0, c0.z, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedbcjahbkkcbjfcnfbialkpfcegjnabjoiabaaaaaaamadaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcomabaaaa
eaaaaaaahlaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
dcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaaddcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaabiohkbdobiohkbdobiohkbdobiohkbdo
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaamghjgido
mghjgidomghjgidomghjgidoegaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaampccabaaa
aaaaaaaaegaobaaaabaaaaaaaceaaaaanmojipdnnmojipdnnmojipdnnmojipdn
egaobaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedmopognnmlaidadafinalepepmikkdnkpabaaaaaafmaeaaaaaeaaaaaa
daaaaaaahmabaaaahaadaaaaciaeaaaaebgpgodjeeabaaaaeeabaaaaaaacpppp
bmabaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkabiohkbdomghjgidonmojipdnaaaaaaaabpaaaaac
aaaaaaiaaaaacdlabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaiaacaacdla
bpaaaaacaaaaaaiaadaacdlabpaaaaacaaaaaaiaaeaacdlabpaaaaacaaaaaaja
aaaiapkaecaaaaadaaaaapiaabaaoelaaaaioekaecaaaaadabaaapiaacaaoela
aaaioekaecaaaaadacaaapiaaaaaoelaaaaioekaecaaaaadadaaapiaadaaoela
aaaioekaecaaaaadaeaaapiaaeaaoelaaaaioekaacaaaaadaaaaapiaaaaaoeia
abaaoeiaafaaaaadaaaaapiaaaaaoeiaaaaaaakaaeaaaaaeaaaaapiaacaaoeia
aaaaffkaaaaaoeiaacaaaaadabaaapiaadaaoeiaaeaaoeiaaeaaaaaeaaaacpia
abaaoeiaaaaakkkaaaaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
omabaaaaeaaaaaaahlaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaaddcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaaddcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaak
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaabiohkbdobiohkbdobiohkbdo
biohkbdoefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaa
mghjgidomghjgidomghjgidomghjgidoegaobaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaam
pccabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaanmojipdnnmojipdnnmojipdn
nmojipdnegaobaaaaaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaa
keaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
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
Float 5 [_offset1]
Float 6 [_offset2]
Vector 7 [_MainTex_TexelSize]
"!!ARBvp1.0
PARAM c[8] = { program.local[0],
		state.matrix.mvp,
		program.local[5..7] };
TEMP R0;
MOV R0.x, c[7].y;
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
MAD result.texcoord[1].y, R0.x, -c[5].x, vertex.texcoord[0];
MOV result.texcoord[1].x, vertex.texcoord[0];
MAD result.texcoord[2].y, R0.x, c[5].x, vertex.texcoord[0];
MOV result.texcoord[2].x, vertex.texcoord[0];
MAD result.texcoord[3].y, R0.x, -c[6].x, vertex.texcoord[0];
MOV result.texcoord[3].x, vertex.texcoord[0];
MAD result.texcoord[4].y, R0.x, c[6].x, vertex.texcoord[0];
MOV result.texcoord[4].x, vertex.texcoord[0];
END
# 14 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Float 4 [_offset1]
Float 5 [_offset2]
Vector 6 [_MainTex_TexelSize]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.x, c4
mad oT1.y, c6, -r0.x, v1
mov r0.x, c4
mad oT2.y, c6, r0.x, v1
mov r0.x, c5
mad oT3.y, c6, -r0.x, v1
mov r0.x, c5
mov oT0.xy, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oT1.x, v1
mov oT2.x, v1
mov oT3.x, v1
mad oT4.y, c6, r0.x, v1
mov oT4.x, v1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Float 16 [_offset1]
Float 20 [_offset2]
Vector 32 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefieceddcopjplljjamilipmahbokiddclakdhkabaaaaaafiadaaaaadaaaaaa
cmaaaaaaiaaaaaaadiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklfdeieefcbiacaaaa
eaaaabaaigaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaaddccabaaaafaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
dcaaaaamdcaabaaaaaaaaaaaegiacaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaa
aaaaaaaaacaaaaaafgbfbaaaabaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaa
abaaaaaadgaaaaafdccabaaaacaaaaaacgakbaaaaaaaaaaadgaaaaafdccabaaa
aeaaaaaaggakbaaaaaaaaaaadcaaaaaldcaabaaaaaaaaaaaegiacaaaaaaaaaaa
abaaaaaafgifcaaaaaaaaaaaacaaaaaafgbfbaaaabaaaaaadgaaaaafecaabaaa
aaaaaaaaakbabaaaabaaaaaadgaaaaafdccabaaaadaaaaaacgakbaaaaaaaaaaa
dgaaaaafdccabaaaafaaaaaaggakbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Float 16 [_offset1]
Float 20 [_offset2]
Vector 32 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedafamnldkdmpffdkboppedbgfacnajdclabaaaaaaliaeaaaaaeaaaaaa
daaaaaaaimabaaaakmadaaaaaaaeaaaaebgpgodjfeabaaaafeabaaaaaaacpopp
beabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacaaaaadoaabaaoejaabaaaaacaaaaadiaabaaoekaaeaaaaaeabaaadia
aaaaoeiaacaaffkbabaaffjaabaaaaacabaaaeiaabaaaajaabaaaaacabaaadoa
abaaociaabaaaaacadaaadoaabaaogiaaeaaaaaeaaaaadiaaaaaoeiaacaaffka
abaaffjaabaaaaacaaaaaeiaabaaaajaabaaaaacacaaadoaaaaaociaabaaaaac
aeaaadoaaaaaogiappppaaaafdeieefcbiacaaaaeaaaabaaigaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaaddccabaaaafaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaadcaaaaamdcaabaaaaaaaaaaa
egiacaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaacaaaaaafgbfbaaa
abaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaabaaaaaadgaaaaafdccabaaa
acaaaaaacgakbaaaaaaaaaaadgaaaaafdccabaaaaeaaaaaaggakbaaaaaaaaaaa
dcaaaaaldcaabaaaaaaaaaaaegiacaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaa
acaaaaaafgbfbaaaabaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaabaaaaaa
dgaaaaafdccabaaaadaaaaaacgakbaaaaaaaaaaadgaaaaafdccabaaaafaaaaaa
ggakbaaaaaaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 0.22702703, 0.31621623, 0.07027027 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R3, fragment.texcoord[3], texture[0], 2D;
TEX R4, fragment.texcoord[4], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[2], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[0], 2D;
ADD R1, R1, R2;
MUL R1, R1, c[0].y;
MAD R0, R0, c[0].x, R1;
ADD R1, R3, R4;
MAD result.color, R1, c[0].z, R0;
END
# 10 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 0.31621623, 0.22702703, 0.07027027, 0
dcl t0.xy
dcl t1.xy
dcl t2.xy
dcl t3.xy
dcl t4.xy
texld r1, t3, s0
texld r0, t4, s0
texld r4, t0, s0
texld r2, t2, s0
texld r3, t1, s0
add r2, r3, r2
mul r2, r2, c0.x
mad r2, r4, c0.y, r2
add r0, r1, r0
mad r0, r0, c0.z, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedbcjahbkkcbjfcnfbialkpfcegjnabjoiabaaaaaaamadaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcomabaaaa
eaaaaaaahlaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
dcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaaddcbabaaaafaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaabiohkbdobiohkbdobiohkbdobiohkbdo
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaamghjgido
mghjgidomghjgidomghjgidoegaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaampccabaaa
aaaaaaaaegaobaaaabaaaaaaaceaaaaanmojipdnnmojipdnnmojipdnnmojipdn
egaobaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedmopognnmlaidadafinalepepmikkdnkpabaaaaaafmaeaaaaaeaaaaaa
daaaaaaahmabaaaahaadaaaaciaeaaaaebgpgodjeeabaaaaeeabaaaaaaacpppp
bmabaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkabiohkbdomghjgidonmojipdnaaaaaaaabpaaaaac
aaaaaaiaaaaacdlabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaiaacaacdla
bpaaaaacaaaaaaiaadaacdlabpaaaaacaaaaaaiaaeaacdlabpaaaaacaaaaaaja
aaaiapkaecaaaaadaaaaapiaabaaoelaaaaioekaecaaaaadabaaapiaacaaoela
aaaioekaecaaaaadacaaapiaaaaaoelaaaaioekaecaaaaadadaaapiaadaaoela
aaaioekaecaaaaadaeaaapiaaeaaoelaaaaioekaacaaaaadaaaaapiaaaaaoeia
abaaoeiaafaaaaadaaaaapiaaaaaoeiaaaaaaakaaeaaaaaeaaaaapiaacaaoeia
aaaaffkaaaaaoeiaacaaaaadabaaapiaadaaoeiaaeaaoeiaaeaaaaaeaaaacpia
abaaoeiaaaaakkkaaaaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
omabaaaaeaaaaaaahlaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaaddcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaaddcbabaaa
afaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaadiaaaaak
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaabiohkbdobiohkbdobiohkbdo
biohkbdoefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaampcaabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaa
mghjgidomghjgidomghjgidomghjgidoegaobaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaam
pccabaaaaaaaaaaaegaobaaaabaaaaaaaceaaaaanmojipdnnmojipdnnmojipdn
nmojipdnegaobaaaaaaaaaaadoaaaaabejfdeheolaaaaaaaagaaaaaaaiaaaaaa
jiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaa
keaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaa
aaaaaaaaadaaaaaaafaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
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
Float 5 [_offset1]
Float 6 [_offset2]
Vector 7 [_MainTex_TexelSize]
"!!ARBvp1.0
PARAM c[8] = { program.local[0],
		state.matrix.mvp,
		program.local[5..7] };
TEMP R0;
MOV R0.x, c[7];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
MAD result.texcoord[1].x, R0, -c[5], vertex.texcoord[0];
MOV result.texcoord[1].y, vertex.texcoord[0];
MAD result.texcoord[2].x, R0, c[5], vertex.texcoord[0];
MOV result.texcoord[2].y, vertex.texcoord[0];
MAD result.texcoord[3].x, R0, -c[6], vertex.texcoord[0];
MOV result.texcoord[3].y, vertex.texcoord[0];
MAD result.texcoord[4].x, R0, c[6], vertex.texcoord[0];
MOV result.texcoord[4].y, vertex.texcoord[0];
END
# 14 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Float 4 [_offset1]
Float 5 [_offset2]
Vector 6 [_MainTex_TexelSize]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.x, c4
mad oT1.x, c6, -r0, v1
mov r0.x, c4
mad oT2.x, c6, r0, v1
mov r0.x, c5
mad oT3.x, c6, -r0, v1
mov r0.x, c5
mov oT0.xy, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oT1.y, v1
mov oT2.y, v1
mov oT3.y, v1
mad oT4.x, c6, r0, v1
mov oT4.y, v1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Float 16 [_offset1]
Float 20 [_offset2]
Vector 32 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedkjfggdghgddhjfiobkbbedekcojidpmiabaaaaaafiadaaaaadaaaaaa
cmaaaaaaiaaaaaaadiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklfdeieefcbiacaaaa
eaaaabaaigaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaaddccabaaaafaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
dcaaaaamdcaabaaaaaaaaaaaegiacaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaa
aaaaaaaaacaaaaaaagbabaaaabaaaaaadgaaaaafecaabaaaaaaaaaaabkbabaaa
abaaaaaadgaaaaafdccabaaaacaaaaaaigaabaaaaaaaaaaadgaaaaafdccabaaa
aeaaaaaajgafbaaaaaaaaaaadcaaaaaldcaabaaaaaaaaaaaegiacaaaaaaaaaaa
abaaaaaaagiacaaaaaaaaaaaacaaaaaaagbabaaaabaaaaaadgaaaaafecaabaaa
aaaaaaaabkbabaaaabaaaaaadgaaaaafdccabaaaadaaaaaaigaabaaaaaaaaaaa
dgaaaaafdccabaaaafaaaaaajgafbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Float 16 [_offset1]
Float 20 [_offset2]
Vector 32 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedjchbjgbffnemkildeffbmhcghgacdifnabaaaaaaliaeaaaaaeaaaaaa
daaaaaaaimabaaaakmadaaaaaaaeaaaaebgpgodjfeabaaaafeabaaaaaaacpopp
beabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacaaaaadoaabaaoejaabaaaaacaaaaadiaabaaoekaaeaaaaaeabaaadia
aaaaoeiaacaaaakbabaaaajaabaaaaacabaaaeiaabaaffjaabaaaaacabaaadoa
abaaoiiaabaaaaacadaaadoaabaaojiaaeaaaaaeaaaaadiaaaaaoeiaacaaaaka
abaaaajaabaaaaacaaaaaeiaabaaffjaabaaaaacacaaadoaaaaaoiiaabaaaaac
aeaaadoaaaaaojiappppaaaafdeieefcbiacaaaaeaaaabaaigaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaaddccabaaaafaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaadcaaaaamdcaabaaaaaaaaaaa
egiacaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaacaaaaaaagbabaaa
abaaaaaadgaaaaafecaabaaaaaaaaaaabkbabaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaigaabaaaaaaaaaaadgaaaaafdccabaaaaeaaaaaajgafbaaaaaaaaaaa
dcaaaaaldcaabaaaaaaaaaaaegiacaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaa
acaaaaaaagbabaaaabaaaaaadgaaaaafecaabaaaaaaaaaaabkbabaaaabaaaaaa
dgaaaaafdccabaaaadaaaaaaigaabaaaaaaaaaaadgaaaaafdccabaaaafaaaaaa
jgafbaaaaaaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_varStrength]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { program.local[0] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R3, fragment.texcoord[3], texture[0], 2D;
TEX R4, fragment.texcoord[4], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[2], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[0], 2D;
ADD R1, R1, R2;
MUL R1, R1, c[0].y;
MAD R0, R0, c[0].x, R1;
ADD R1, R3, R4;
MAD result.color, R1, c[0].z, R0;
END
# 10 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_varStrength]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl t0.xy
dcl t1.xy
dcl t2.xy
dcl t3.xy
dcl t4.xy
texld r1, t3, s0
texld r0, t4, s0
texld r4, t0, s0
texld r2, t2, s0
texld r3, t1, s0
add r2, r3, r2
mul r2, r2, c0.y
mad r2, r4, c0.x, r2
add r0, r1, r0
mad r0, r0, c0.z, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 48 [_varStrength]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlmpabpoaihndaodhbcoiikjemhpmdaodabaaaaaaaeadaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoeabaaaa
eaaaaaaahjaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaaddcbabaaa
aeaaaaaagcbaaaaddcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaafgifcaaa
aaaaaaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaa
agiacaaaaaaaaaaaadaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaa
aaaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaadaaaaaaegaobaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 48 [_varStrength]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedkenpjaplnoecbnnpplpkfaghbgfbnnhnabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaahaabaaaafmadaaaabeaeaaaaebgpgodjdiabaaaadiabaaaaaaacpppp
aeabaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaadaaabaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaaaaacdlabpaaaaac
aaaaaaiaabaacdlabpaaaaacaaaaaaiaacaacdlabpaaaaacaaaaaaiaadaacdla
bpaaaaacaaaaaaiaaeaacdlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapia
abaaoelaaaaioekaecaaaaadabaaapiaacaaoelaaaaioekaecaaaaadacaaapia
aaaaoelaaaaioekaecaaaaadadaaapiaadaaoelaaaaioekaecaaaaadaeaaapia
aeaaoelaaaaioekaacaaaaadaaaaapiaaaaaoeiaabaaoeiaafaaaaadaaaaapia
aaaaoeiaaaaaffkaaeaaaaaeaaaaapiaacaaoeiaaaaaaakaaaaaoeiaacaaaaad
abaaapiaadaaoeiaaeaaoeiaaeaaaaaeaaaacpiaabaaoeiaaaaakkkaaaaaoeia
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcoeabaaaaeaaaaaaahjaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaad
dcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaafgifcaaaaaaaaaaaadaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaaagiacaaaaaaaaaaa
adaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
afaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaa
abaaaaaakgikcaaaaaaaaaaaadaaaaaaegaobaaaaaaaaaaadoaaaaabejfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
adadaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadadaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
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
Float 5 [_offset1]
Float 6 [_offset2]
Vector 7 [_MainTex_TexelSize]
"!!ARBvp1.0
PARAM c[8] = { program.local[0],
		state.matrix.mvp,
		program.local[5..7] };
TEMP R0;
MOV R0.x, c[7].y;
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
MAD result.texcoord[1].y, R0.x, -c[5].x, vertex.texcoord[0];
MOV result.texcoord[1].x, vertex.texcoord[0];
MAD result.texcoord[2].y, R0.x, c[5].x, vertex.texcoord[0];
MOV result.texcoord[2].x, vertex.texcoord[0];
MAD result.texcoord[3].y, R0.x, -c[6].x, vertex.texcoord[0];
MOV result.texcoord[3].x, vertex.texcoord[0];
MAD result.texcoord[4].y, R0.x, c[6].x, vertex.texcoord[0];
MOV result.texcoord[4].x, vertex.texcoord[0];
END
# 14 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Float 4 [_offset1]
Float 5 [_offset2]
Vector 6 [_MainTex_TexelSize]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.x, c4
mad oT1.y, c6, -r0.x, v1
mov r0.x, c4
mad oT2.y, c6, r0.x, v1
mov r0.x, c5
mad oT3.y, c6, -r0.x, v1
mov r0.x, c5
mov oT0.xy, v1
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
mov oT1.x, v1
mov oT2.x, v1
mov oT3.x, v1
mad oT4.y, c6, r0.x, v1
mov oT4.x, v1
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Float 16 [_offset1]
Float 20 [_offset2]
Vector 32 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefieceddcopjplljjamilipmahbokiddclakdhkabaaaaaafiadaaaaadaaaaaa
cmaaaaaaiaaaaaaadiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklfdeieefcbiacaaaa
eaaaabaaigaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaa
gfaaaaaddccabaaaafaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaa
dcaaaaamdcaabaaaaaaaaaaaegiacaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaa
aaaaaaaaacaaaaaafgbfbaaaabaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaa
abaaaaaadgaaaaafdccabaaaacaaaaaacgakbaaaaaaaaaaadgaaaaafdccabaaa
aeaaaaaaggakbaaaaaaaaaaadcaaaaaldcaabaaaaaaaaaaaegiacaaaaaaaaaaa
abaaaaaafgifcaaaaaaaaaaaacaaaaaafgbfbaaaabaaaaaadgaaaaafecaabaaa
aaaaaaaaakbabaaaabaaaaaadgaaaaafdccabaaaadaaaaaacgakbaaaaaaaaaaa
dgaaaaafdccabaaaafaaaaaaggakbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Float 16 [_offset1]
Float 20 [_offset2]
Vector 32 [_MainTex_TexelSize]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedafamnldkdmpffdkboppedbgfacnajdclabaaaaaaliaeaaaaaeaaaaaa
daaaaaaaimabaaaakmadaaaaaaaeaaaaebgpgodjfeabaaaafeabaaaaaaacpopp
beabaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacaaaaadoaabaaoejaabaaaaacaaaaadiaabaaoekaaeaaaaaeabaaadia
aaaaoeiaacaaffkbabaaffjaabaaaaacabaaaeiaabaaaajaabaaaaacabaaadoa
abaaociaabaaaaacadaaadoaabaaogiaaeaaaaaeaaaaadiaaaaaoeiaacaaffka
abaaffjaabaaaaacaaaaaeiaabaaaajaabaaaaacacaaadoaaaaaociaabaaaaac
aeaaadoaaaaaogiappppaaaafdeieefcbiacaaaaeaaaabaaigaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
dccabaaaadaaaaaagfaaaaaddccabaaaaeaaaaaagfaaaaaddccabaaaafaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafdccabaaaabaaaaaaegbabaaaabaaaaaadcaaaaamdcaabaaaaaaaaaaa
egiacaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaacaaaaaafgbfbaaa
abaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaabaaaaaadgaaaaafdccabaaa
acaaaaaacgakbaaaaaaaaaaadgaaaaafdccabaaaaeaaaaaaggakbaaaaaaaaaaa
dcaaaaaldcaabaaaaaaaaaaaegiacaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaa
acaaaaaafgbfbaaaabaaaaaadgaaaaafecaabaaaaaaaaaaaakbabaaaabaaaaaa
dgaaaaafdccabaaaadaaaaaacgakbaaaaaaaaaaadgaaaaafdccabaaaafaaaaaa
ggakbaaaaaaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
keaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaakeaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadamaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadamaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_varStrength]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { program.local[0] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R3, fragment.texcoord[3], texture[0], 2D;
TEX R4, fragment.texcoord[4], texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, fragment.texcoord[2], texture[0], 2D;
TEX R1, fragment.texcoord[1], texture[0], 2D;
ADD R1, R1, R2;
MUL R1, R1, c[0].y;
MAD R0, R0, c[0].x, R1;
ADD R1, R3, R4;
MAD result.color, R1, c[0].z, R0;
END
# 10 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_varStrength]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl t0.xy
dcl t1.xy
dcl t2.xy
dcl t3.xy
dcl t4.xy
texld r1, t3, s0
texld r0, t4, s0
texld r4, t0, s0
texld r2, t2, s0
texld r3, t1, s0
add r2, r3, r2
mul r2, r2, c0.y
mad r2, r4, c0.x, r2
add r0, r1, r0
mad r0, r0, c0.z, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 48 [_varStrength]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlmpabpoaihndaodhbcoiikjemhpmdaodabaaaaaaaeadaaaaadaaaaaa
cmaaaaaaoeaaaaaabiabaaaaejfdeheolaaaaaaaagaaaaaaaiaaaaaajiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaakeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaakeaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaakeaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaakeaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaakeaaaaaaaeaaaaaaaaaaaaaa
adaaaaaaafaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcoeabaaaa
eaaaaaaahjaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaaddcbabaaa
aeaaaaaagcbaaaaddcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaafgifcaaa
aaaaaaaaadaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaa
agiacaaaaaaaaaaaadaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaafaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaa
aaaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaadaaaaaaegaobaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 64
Vector 48 [_varStrength]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedkenpjaplnoecbnnpplpkfaghbgfbnnhnabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaahaabaaaafmadaaaabeaeaaaaebgpgodjdiabaaaadiabaaaaaaacpppp
aeabaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaadaaabaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaaaaacdlabpaaaaac
aaaaaaiaabaacdlabpaaaaacaaaaaaiaacaacdlabpaaaaacaaaaaaiaadaacdla
bpaaaaacaaaaaaiaaeaacdlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapia
abaaoelaaaaioekaecaaaaadabaaapiaacaaoelaaaaioekaecaaaaadacaaapia
aaaaoelaaaaioekaecaaaaadadaaapiaadaaoelaaaaioekaecaaaaadaeaaapia
aeaaoelaaaaioekaacaaaaadaaaaapiaaaaaoeiaabaaoeiaafaaaaadaaaaapia
aaaaoeiaaaaaffkaaeaaaaaeaaaaapiaacaaoeiaaaaaaakaaaaaoeiaacaaaaad
abaaapiaadaaoeiaaeaaoeiaaeaaaaaeaaaacpiaabaaoeiaaaaakkkaaaaaoeia
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcoeabaaaaeaaaaaaahjaaaaaa
fjaaaaaeegiocaaaaaaaaaaaaeaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaaddcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagcbaaaad
dcbabaaaafaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegaobaaaabaaaaaa
diaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaafgifcaaaaaaaaaaaadaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaaagiacaaaaaaaaaaa
adaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
afaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaa
abaaaaaakgikcaaaaaaaaaaaadaaaaaaegaobaaaaaaaaaaadoaaaaabejfdeheo
laaaaaaaagaaaaaaaiaaaaaajiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaakeaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaakeaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaakeaaaaaaacaaaaaaaaaaaaaa
adaaaaaaadaaaaaaadadaaaakeaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaa
adadaaaakeaaaaaaaeaaaaaaaaaaaaaaadaaaaaaafaaaaaaadadaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}