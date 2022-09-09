Shader "Hidden/Highlighted/StencilOpaqueZ" {
SubShader { 
 Pass {
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
"!!ARBvp1.0
PARAM c[5] = { program.local[0],
		state.matrix.mvp };
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 4 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Matrix 0 [glstate_matrix_mvp]
"vs_2_0
dcl_position0 v0
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0
eefiecedefmnijgohikialhmhnlmkmdmphjbnkfmabaaaaaaheabaaaaadaaaaaa
cmaaaaaagaaaaaaajeaaaaaaejfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafaepfdejfeejepeoaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfagphdgjhegjgpgoaafdeieefcniaaaaaaeaaaabaa
dgaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "UnityPerDraw" 0
"vs_4_0_level_9_1
eefiecedhombkmcdjajmidkobkbmjcojnpaenoddabaaaaaadeacaaaaaeaaaaaa
daaaaaaaomaaaaaammabaaaaaaacaaaaebgpgodjleaaaaaaleaaaaaaaaacpopp
iaaaaaaadeaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaabaadaaaaaaaaaaa
aeaaabaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjaafaaaaad
aaaaapiaaaaaffjaacaaoekaaeaaaaaeaaaaapiaabaaoekaaaaaaajaaaaaoeia
aeaaaaaeaaaaapiaadaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaac
aaaaammaaaaaoeiappppaaaafdeieefcniaaaaaaeaaaabaadgaaaaaafjaaaaae
egiocaaaaaaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
aaaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaaaaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaaaaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadoaaaaabejfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafaepfdejfeejepeoaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfagphdgjhegjgpgoaa"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_Outline]
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { program.local[0] };
MOV result.color, c[0];
END
# 1 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_Outline]
"ps_2_0
mov_pp oC0, c0
"
}
SubProgram "d3d11 " {
ConstBuffer "$Globals" 64
Vector 16 [_Outline]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmofdpjlapkogelljhlcoiomgfpkbhlpbabaaaaaaliaaaaaaadaaaaaa
cmaaaaaadmaaaaaahaaaaaaaejfdeheoaiaaaaaaaaaaaaaaaiaaaaaaepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefceaaaaaaaeaaaaaaabaaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaagfaaaaadpccabaaaaaaaaaaadgaaaaag
pccabaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
ConstBuffer "$Globals" 64
Vector 16 [_Outline]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedpjnobdcpndejfiphbplapgbcnagajkjbabaaaaaaaiabaaaaaeaaaaaa
daaaaaaahmaaaaaameaaaaaaneaaaaaaebgpgodjeeaaaaaaeeaaaaaaaaacpppp
beaaaaaadaaaaaaaabaaceaaaaaadaaaaaaadaaaaaaaceaaaaaadaaaaaaaabaa
abaaaaaaaaaaaaaaaaacppppabaaaaacaaaicpiaaaaaoekappppaaaafdeieefc
eaaaaaaaeaaaaaaabaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaadgaaaaagpccabaaaaaaaaaaaegiocaaaaaaaaaaaabaaaaaa
doaaaaabejfdeheoaiaaaaaaaaaaaaaaaiaaaaaaepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}