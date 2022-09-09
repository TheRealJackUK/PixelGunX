Shader "Hidden/Glow 11/Advanced Blur" {
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R0.z, c[8].x;
MAD R0.x, R0.z, -c[1], fragment.texcoord[0];
MOV R0.y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R0.z, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD result.color, R0, c[5].x, R2;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c5.x, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjboolgdbbflamckifmmemigkoaindhpdabaaaaaafiacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjiabaaaa
eaaaaaaaggaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaadcaaaaalbcaabaaaaaaaaaaa
bkiacaaaaaaaaaaaabaaaaaaakiacaaaaaaaaaaaajaaaaaaakbabaaaabaaaaaa
dgaaaaafkcaabaaaaaaaaaaafgbfbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamecaabaaa
aaaaaaaabkiacaiaebaaaaaaaaaaaaaaabaaaaaaakiacaaaaaaaaaaaajaaaaaa
akbabaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaogakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaafgifcaaa
aaaaaaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaaabaaaaaa
agiacaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R0.z, c[8].y;
MAD R0.y, R0.z, -c[1].x, fragment.texcoord[0];
MOV R0.x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R0.z, c[1].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD result.color, R0, c[5].x, R2;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c5.x, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedeicdjimdifhmbodpjlmmcnpikehpfpbaabaaaaaafiacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjiabaaaa
eaaaaaaaggaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaadcaaaaalccaabaaaaaaaaaaa
bkiacaaaaaaaaaaaabaaaaaabkiacaaaaaaaaaaaajaaaaaabkbabaaaabaaaaaa
dgaaaaaffcaabaaaaaaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamicaabaaa
aaaaaaaabkiacaiaebaaaaaaaaaaaaaaabaaaaaabkiacaaaaaaaaaaaajaaaaaa
bkbabaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaogakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaafgifcaaa
aaaaaaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaaabaaaaaa
agiacaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8];
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[2], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD result.color, R0, c[6].x, R2;
END
# 19 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c6.x, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhcjnhheleppkbhhhjiaofmdikhkcbmfdabaaaaaapiacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdiacaaaa
eaaaaaaaioaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaldcaabaaa
abaaaaaajgifcaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaafecaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaigaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaajgafbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamdcaabaaaadaaaaaajgifcaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaa
aaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaafecaabaaaadaaaaaabkbabaaa
abaaaaaaefaaaaajpcaabaaaaeaaaaaaigaabaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaajgafbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
aeaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaa
afaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
afaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaaabaaaaaa
kgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8].y;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[2].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD result.color, R0, c[6].x, R2;
END
# 19 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c6.x, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbjkidjmkhkhpmbmeifcenhbmlpeoemejabaaaaaapiacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdiacaaaa
eaaaaaaaioaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaldcaabaaa
abaaaaaajgifcaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaacgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaggakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamdcaabaaaadaaaaaajgifcaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaa
aaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaafecaabaaaadaaaaaaakbabaaa
abaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
aeaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaa
afaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
afaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaaabaaaaaa
kgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8];
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[2], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD result.color, R0, c[7].x, R2;
END
# 27 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c7.x, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecednabbbfkaihnbjiffapnbkcknchhppclfabaaaaaaieadaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmeacaaaa
eaaaaaaalbaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaangafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
doaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8].y;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[2].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD result.color, R0, c[7].x, R2;
END
# 27 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c7.x, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedgpbihemimhfoehgkkjelllolnknkldenabaaaaaaieadaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmeacaaaa
eaaaaaaalbaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaahgapbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
lgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
doaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8];
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[2], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.y, fragment.texcoord[0];
MAD R1.x, R3, c[0].y, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[4].y, R2;
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c4.y, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedghjigegpedblfbolphgcafmkokpficpgabaaaaaaiaaeaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmaadaaaa
eaaaaaaapaaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaangafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaaacaaaaaaakiacaaaaaaaaaaa
ajaaaaaaakbabaaaabaaaaaadgaaaaafkcaabaaaabaaaaaafgbfbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamecaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaacaaaaaa
akiacaaaaaaaaaaaajaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaa
egaobaaaabaaaaaaagiacaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadoaaaaab
"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8].y;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[2].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.x, fragment.texcoord[0];
MAD R1.y, R3.x, c[0], fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[4].y, R2;
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c4.y, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedphbcfjmlbepjglhaemmbdkaghopcaaloabaaaaaaiaaeaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmaadaaaa
eaaaaaaapaaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaahgapbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
lgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalccaabaaaabaaaaaaakiacaaaaaaaaaaaacaaaaaabkiacaaaaaaaaaaa
ajaaaaaabkbabaaaabaaaaaadgaaaaaffcaabaaaabaaaaaaagbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamicaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaacaaaaaa
bkiacaaaaaaaaaaaajaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaa
egaobaaaabaaaaaaagiacaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadoaaaaab
"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8];
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[2], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.y, fragment.texcoord[0];
MAD R1.x, R3, c[1].y, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[5].y, R2;
END
# 43 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c5.y, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedadnhenpanegghllldcijgpbpglfpclkbabaaaaaacaafaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgaaeaaaa
eaaaaaaabiabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaangafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaaldcaabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaafecaabaaaabaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaigaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaajgafbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamdcaabaaaadaaaaaaegiacaiaebaaaaaaaaaaaaaa
acaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaafecaabaaa
adaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaigaabaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaajgafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
agiacaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egaobaaaabaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadoaaaaab
"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8].y;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[2].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.x, fragment.texcoord[0];
MAD R1.y, R3.x, c[1], fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[5].y, R2;
END
# 43 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c5.y, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbaihddmjpcmhhkkeiakmeafdgjcmgkfgabaaaaaacaafaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgaaeaaaa
eaaaaaaabiabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaahgapbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
lgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaaldcaabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaacgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamdcaabaaaadaaaaaaegiacaiaebaaaaaaaaaaaaaa
acaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaafecaabaaa
adaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
agiacaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egaobaaaabaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadoaaaaab
"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8];
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[2], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.y, fragment.texcoord[0];
MAD R1.x, R3, c[1].y, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD R2, R0, c[5].y, R2;
ADD R0.z, R2.x, c[2].y;
MAD R0.x, -R0.z, c[8], fragment.texcoord[0];
MOV R0.y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R0.z, c[8], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD result.color, R0, c[6].y, R2;
END
# 52 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.y, r2
add_pp r0.z, r2.x, c2.y
mad_pp r0.x, -r0.z, c8, v0
mov_pp r0.y, v0
texld r1, r0, s0
mov_pp r0.y, v0
mad_pp r0.x, r0.z, c8, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c6.y, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedcajpdilgbgdjpnidijjpnjbjlglijgoeabaaaaaadeagaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcheafaaaa
eaaaaaaafnabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaangafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaaldcaabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaafecaabaaaabaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaigaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaajgafbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamdcaabaaaadaaaaaaegiacaiaebaaaaaaaaaaaaaa
acaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaafecaabaaa
adaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaigaabaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaajgafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
agiacaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaaaaaaaaai
bcaabaaaabaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaadcaaaaak
bcaabaaaacaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaajaaaaaaakbabaaa
abaaaaaadcaaaaalecaabaaaacaaaaaaakaabaiaebaaaaaaabaaaaaaakiacaaa
aaaaaaaaajaaaaaaakbabaaaabaaaaaadgaaaaafkcaabaaaacaaaaaafgbfbaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaaabaaaaaakgikcaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8].y;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[2].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.x, fragment.texcoord[0];
MAD R1.y, R3.x, c[1], fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD R2, R0, c[5].y, R2;
ADD R0.z, R2.x, c[2].y;
MAD R0.y, -R0.z, c[8], fragment.texcoord[0];
MOV R0.x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R0.z, c[8], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD result.color, R0, c[6].y, R2;
END
# 52 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.y, r2
add_pp r0.z, r2.x, c2.y
mad_pp r0.y, -r0.z, c8, v0
mov_pp r0.x, v0
texld r1, r0, s0
mov_pp r0.x, v0
mad_pp r0.y, r0.z, c8, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c6.y, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedddfakgnamnjgghoifhemehacnhbbfagpabaaaaaadeagaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcheafaaaa
eaaaaaaafnabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaahgapbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
lgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaaldcaabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaacgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamdcaabaaaadaaaaaaegiacaiaebaaaaaaaaaaaaaa
acaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaafecaabaaa
adaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
agiacaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaaaaaaaaai
bcaabaaaabaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaadcaaaaak
ccaabaaaacaaaaaaakaabaaaabaaaaaabkiacaaaaaaaaaaaajaaaaaabkbabaaa
abaaaaaadcaaaaalicaabaaaacaaaaaaakaabaiaebaaaaaaabaaaaaabkiacaaa
aaaaaaaaajaaaaaabkbabaaaabaaaaaadgaaaaaffcaabaaaacaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaaabaaaaaakgikcaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8];
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[2], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].y, R2;
ADD R0.z, R2.x, c[2].y;
MAD R0.x, -R0.z, c[8], fragment.texcoord[0];
MOV R0.y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R0.z, c[8], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.y, fragment.texcoord[0];
MAD R1.x, R3, c[3].y, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[7].y, R2;
END
# 60 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.y, r2
add_pp r0.z, r2.x, c2.y
mad_pp r0.x, -r0.z, c8, v0
mov_pp r0.y, v0
texld r1, r0, s0
mov_pp r0.y, v0
mad_pp r0.x, r0.z, c8, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.y, r2
mov_pp r0.x, c3.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c7.y, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedgcinpnmkacjcloomjcmnbjachldgopaiabaaaaaamaagaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaaagaaaa
eaaaaaaaiaabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaangafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalhcaabaaaabaaaaaaegidcaaaaaaaaaaaacaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaadaaaaaaegidcaiaebaaaaaaaaaaaaaaacaaaaaa
agiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaa
bkbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaangafbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaa
dcaaaaakbcaabaaaadaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaaajaaaaaa
akbabaaaabaaaaaadcaaaaalecaabaaaadaaaaaaakaabaiaebaaaaaaacaaaaaa
akiacaaaaaaaaaaaajaaaaaaakbabaaaabaaaaaadgaaaaafkcaabaaaadaaaaaa
fgbfbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egaobaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadoaaaaab
"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8].y;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[2].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].y, R2;
ADD R0.z, R2.x, c[2].y;
MAD R0.y, -R0.z, c[8], fragment.texcoord[0];
MOV R0.x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R0.z, c[8], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.x, fragment.texcoord[0];
MAD R1.y, R3.x, c[3], fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[7].y, R2;
END
# 60 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.y, r2
add_pp r0.z, r2.x, c2.y
mad_pp r0.y, -r0.z, c8, v0
mov_pp r0.x, v0
texld r1, r0, s0
mov_pp r0.x, v0
mad_pp r0.y, r0.z, c8, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.y, r2
mov_pp r0.y, c3
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c7.y, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefieceddpinpkmpknhnafjdanhdhgnphoemdfmeabaaaaaamaagaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaaagaaaa
eaaaaaaaiaabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaahgapbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
lgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalhcaabaaaabaaaaaaegidcaaaaaaaaaaaacaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaadaaaaaaegidcaiaebaaaaaaaaaaaaaaacaaaaaa
fgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaa
akbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
lgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaahgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaalgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaa
dcaaaaakccaabaaaadaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaaajaaaaaa
bkbabaaaabaaaaaadcaaaaalicaabaaaadaaaaaaakaabaiaebaaaaaaacaaaaaa
bkiacaaaaaaaaaaaajaaaaaabkbabaaaabaaaaaadgaaaaaffcaabaaaadaaaaaa
agbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egaobaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadoaaaaab
"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8];
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[2], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].y, R2;
ADD R0.z, R2.x, c[2].y;
MAD R0.x, -R0.z, c[8], fragment.texcoord[0];
MOV R0.y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R0.z, c[8], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.y, fragment.texcoord[0];
MAD R1.x, R3, c[0].z, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[4].z, R2;
END
# 68 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.y, r2
add_pp r0.z, r2.x, c2.y
mad_pp r0.x, -r0.z, c8, v0
mov_pp r0.y, v0
texld r1, r0, s0
mov_pp r0.y, v0
mad_pp r0.x, r0.z, c8, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.y, r2
mov_pp r0.x, c3.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.y, r2
mov_pp r0.x, c0.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c4.z, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefieceddmbbonfbagimmpladfeokaahicamfgenabaaaaaalmahaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpmagaaaa
eaaaaaaalpabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaangafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalhcaabaaaabaaaaaaegidcaaaaaaaaaaaacaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaadaaaaaaegidcaiaebaaaaaaaaaaaaaaacaaaaaa
agiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaa
bkbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaangafbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaa
dcaaaaakbcaabaaaadaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaaajaaaaaa
akbabaaaabaaaaaadcaaaaalecaabaaaadaaaaaaakaabaiaebaaaaaaacaaaaaa
akiacaaaaaaaaaaaajaaaaaaakbabaaaabaaaaaadgaaaaafkcaabaaaadaaaaaa
fgbfbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaal
bcaabaaaabaaaaaaakiacaaaaaaaaaaaadaaaaaaakiacaaaaaaaaaaaajaaaaaa
akbabaaaabaaaaaadgaaaaafkcaabaaaabaaaaaafgbfbaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamecaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaadaaaaaaakiacaaa
aaaaaaaaajaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaa
abaaaaaaagiacaaaaaaaaaaaahaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8].y;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[2].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].y, R2;
ADD R0.z, R2.x, c[2].y;
MAD R0.y, -R0.z, c[8], fragment.texcoord[0];
MOV R0.x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R0.z, c[8], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.x, fragment.texcoord[0];
MAD R1.y, R3.x, c[0].z, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[4].z, R2;
END
# 68 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.y, r2
add_pp r0.z, r2.x, c2.y
mad_pp r0.y, -r0.z, c8, v0
mov_pp r0.x, v0
texld r1, r0, s0
mov_pp r0.x, v0
mad_pp r0.y, r0.z, c8, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.y, r2
mov_pp r0.y, c3
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.y, r2
mov_pp r0.y, c0.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c4.z, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefieceddhabbjlpanigdbenjhghihppddklffpaabaaaaaalmahaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpmagaaaa
eaaaaaaalpabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaahgapbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
lgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalhcaabaaaabaaaaaaegidcaaaaaaaaaaaacaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaadaaaaaaegidcaiaebaaaaaaaaaaaaaaacaaaaaa
fgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaa
akbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
lgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaahgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaalgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaa
dcaaaaakccaabaaaadaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaaajaaaaaa
bkbabaaaabaaaaaadcaaaaalicaabaaaadaaaaaaakaabaiaebaaaaaaacaaaaaa
bkiacaaaaaaaaaaaajaaaaaabkbabaaaabaaaaaadgaaaaaffcaabaaaadaaaaaa
agbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaal
ccaabaaaabaaaaaaakiacaaaaaaaaaaaadaaaaaabkiacaaaaaaaaaaaajaaaaaa
bkbabaaaabaaaaaadgaaaaaffcaabaaaabaaaaaaagbabaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamicaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaadaaaaaabkiacaaa
aaaaaaaaajaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaa
abaaaaaaagiacaaaaaaaaaaaahaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8];
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[2], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].y, R2;
ADD R0.z, R2.x, c[2].y;
MAD R0.x, -R0.z, c[8], fragment.texcoord[0];
MOV R0.y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R0.z, c[8], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.y, fragment.texcoord[0];
MAD R1.x, R3, c[1].z, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[5].z, R2;
END
# 76 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.y, r2
add_pp r0.z, r2.x, c2.y
mad_pp r0.x, -r0.z, c8, v0
mov_pp r0.y, v0
texld r1, r0, s0
mov_pp r0.y, v0
mad_pp r0.x, r0.z, c8, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.y, r2
mov_pp r0.x, c3.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.y, r2
mov_pp r0.x, c0.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.z, r2
mov_pp r0.x, c1.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c5.z, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedklopmbkikdmgdidfhnplgdbfnahfdmdlabaaaaaafmaiaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjmahaaaa
eaaaaaaaohabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaangafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalhcaabaaaabaaaaaaegidcaaaaaaaaaaaacaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaadaaaaaaegidcaiaebaaaaaaaaaaaaaaacaaaaaa
agiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaa
bkbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaangafbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaa
dcaaaaakbcaabaaaadaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaaajaaaaaa
akbabaaaabaaaaaadcaaaaalecaabaaaadaaaaaaakaabaiaebaaaaaaacaaaaaa
akiacaaaaaaaaaaaajaaaaaaakbabaaaabaaaaaadgaaaaafkcaabaaaadaaaaaa
fgbfbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaal
dcaabaaaabaaaaaaegiacaaaaaaaaaaaadaaaaaaagiacaaaaaaaaaaaajaaaaaa
agbabaaaabaaaaaadgaaaaafecaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaigaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaajgafbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamdcaabaaaadaaaaaaegiacaiaebaaaaaaaaaaaaaaadaaaaaa
agiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaafecaabaaaadaaaaaa
bkbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaigaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaajgafbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaa
abaaaaaafgifcaaaaaaaaaaaahaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8].y;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[2].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].y, R2;
ADD R0.z, R2.x, c[2].y;
MAD R0.y, -R0.z, c[8], fragment.texcoord[0];
MOV R0.x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R0.z, c[8], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.x, fragment.texcoord[0];
MAD R1.y, R3.x, c[1].z, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[5].z, R2;
END
# 76 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.y, r2
add_pp r0.z, r2.x, c2.y
mad_pp r0.y, -r0.z, c8, v0
mov_pp r0.x, v0
texld r1, r0, s0
mov_pp r0.x, v0
mad_pp r0.y, r0.z, c8, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.y, r2
mov_pp r0.y, c3
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.y, r2
mov_pp r0.y, c0.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.z, r2
mov_pp r0.y, c1.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c5.z, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedaghdfhflahjighclckffbpdniohphdhfabaaaaaafmaiaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjmahaaaa
eaaaaaaaohabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaahgapbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
lgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalhcaabaaaabaaaaaaegidcaaaaaaaaaaaacaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaadaaaaaaegidcaiaebaaaaaaaaaaaaaaacaaaaaa
fgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaa
akbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
lgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaahgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaalgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaa
dcaaaaakccaabaaaadaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaaajaaaaaa
bkbabaaaabaaaaaadcaaaaalicaabaaaadaaaaaaakaabaiaebaaaaaaacaaaaaa
bkiacaaaaaaaaaaaajaaaaaabkbabaaaabaaaaaadgaaaaaffcaabaaaadaaaaaa
agbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaal
dcaabaaaabaaaaaaegiacaaaaaaaaaaaadaaaaaafgifcaaaaaaaaaaaajaaaaaa
fgbfbaaaabaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaacgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaggakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamdcaabaaaadaaaaaaegiacaiaebaaaaaaaaaaaaaaadaaaaaa
fgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaafecaabaaaadaaaaaa
akbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaa
abaaaaaafgifcaaaaaaaaaaaahaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8];
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[2], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].y, R2;
ADD R0.z, R2.x, c[2].y;
MAD R0.x, -R0.z, c[8], fragment.texcoord[0];
MOV R0.y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R0.z, c[8], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.y, fragment.texcoord[0];
MAD R1.x, R3, c[2].z, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[6].z, R2;
END
# 84 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.y, r2
add_pp r0.z, r2.x, c2.y
mad_pp r0.x, -r0.z, c8, v0
mov_pp r0.y, v0
texld r1, r0, s0
mov_pp r0.y, v0
mad_pp r0.x, r0.z, c8, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.y, r2
mov_pp r0.x, c3.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.y, r2
mov_pp r0.x, c0.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.z, r2
mov_pp r0.x, c1.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.z, r2
mov_pp r0.x, c2.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c6.z, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmgaoiplcaalhhjlkmigoncnacaigcogbabaaaaaaoiaiaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcciaiaaaa
eaaaaaaaakacaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaangafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalhcaabaaaabaaaaaaegidcaaaaaaaaaaaacaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaadaaaaaaegidcaiaebaaaaaaaaaaaaaaacaaaaaa
agiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaa
bkbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaangafbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaa
dcaaaaakbcaabaaaadaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaaajaaaaaa
akbabaaaabaaaaaadcaaaaalecaabaaaadaaaaaaakaabaiaebaaaaaaacaaaaaa
akiacaaaaaaaaaaaajaaaaaaakbabaaaabaaaaaadgaaaaafkcaabaaaadaaaaaa
fgbfbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaaagiacaaaaaaaaaaaajaaaaaa
agbabaaaabaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamhcaabaaaadaaaaaaegiccaiaebaaaaaaaaaaaaaaadaaaaaaagiacaaa
aaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaabkbabaaa
abaaaaaaefaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
aeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaaaaaaaaaa
ahaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaa
ngafbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
adaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaa
acaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaacaaaaaafgifcaaaaaaaaaaaahaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaahaaaaaaegaobaaa
aaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8].y;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[2].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].y, R2;
ADD R0.z, R2.x, c[2].y;
MAD R0.y, -R0.z, c[8], fragment.texcoord[0];
MOV R0.x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R0.z, c[8], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.x, fragment.texcoord[0];
MAD R1.y, R3.x, c[2].z, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[6].z, R2;
END
# 84 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.y, r2
add_pp r0.z, r2.x, c2.y
mad_pp r0.y, -r0.z, c8, v0
mov_pp r0.x, v0
texld r1, r0, s0
mov_pp r0.x, v0
mad_pp r0.y, r0.z, c8, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.y, r2
mov_pp r0.y, c3
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.y, r2
mov_pp r0.y, c0.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.z, r2
mov_pp r0.y, c1.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.z, r2
mov_pp r0.y, c2.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c6.z, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedcihoomfccolppniomiimaffagnnlpiaaabaaaaaaoiaiaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcciaiaaaa
eaaaaaaaakacaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaahgapbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
lgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalhcaabaaaabaaaaaaegidcaaaaaaaaaaaacaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaadaaaaaaegidcaiaebaaaaaaaaaaaaaaacaaaaaa
fgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaa
akbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
lgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaahgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaalgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaa
dcaaaaakccaabaaaadaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaaajaaaaaa
bkbabaaaabaaaaaadcaaaaalicaabaaaadaaaaaaakaabaiaebaaaaaaacaaaaaa
bkiacaaaaaaaaaaaajaaaaaabkbabaaaabaaaaaadgaaaaaffcaabaaaadaaaaaa
agbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaal
hcaabaaaabaaaaaaegiccaaaaaaaaaaaadaaaaaafgifcaaaaaaaaaaaajaaaaaa
fgbfbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamhcaabaaaadaaaaaaegiccaiaebaaaaaaaaaaaaaaadaaaaaafgifcaaa
aaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaaakbabaaa
abaaaaaaefaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
aeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaaaaaaaaaa
ahaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaa
hgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
adaaaaaalgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaa
acaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaacaaaaaafgifcaaaaaaaaaaaahaaaaaaegaobaaaaaaaaaaadcaaaaak
pccabaaaaaaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaahaaaaaaegaobaaa
aaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8];
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[2], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].y, R2;
ADD R0.z, R2.x, c[2].y;
MAD R0.x, -R0.z, c[8], fragment.texcoord[0];
MOV R0.y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R0.z, c[8], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[2].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.y, fragment.texcoord[0];
MAD R1.x, R3, c[3].z, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[7].z, R2;
END
# 92 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.y, r2
add_pp r0.z, r2.x, c2.y
mad_pp r0.x, -r0.z, c8, v0
mov_pp r0.y, v0
texld r1, r0, s0
mov_pp r0.y, v0
mad_pp r0.x, r0.z, c8, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.y, r2
mov_pp r0.x, c3.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.y, r2
mov_pp r0.x, c0.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.z, r2
mov_pp r0.x, c1.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.z, r2
mov_pp r0.x, c2.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.z, r2
mov_pp r0.x, c3.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c7.z, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedoleicfpdflgckcdlembhagofnemkkeobabaaaaaabeakaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfeajaaaa
eaaaaaaaffacaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaangafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalhcaabaaaabaaaaaaegidcaaaaaaaaaaaacaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaadaaaaaaegidcaiaebaaaaaaaaaaaaaaacaaaaaa
agiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaa
bkbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaangafbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaa
dcaaaaakbcaabaaaadaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaaajaaaaaa
akbabaaaabaaaaaadcaaaaalecaabaaaadaaaaaaakaabaiaebaaaaaaacaaaaaa
akiacaaaaaaaaaaaajaaaaaaakbabaaaabaaaaaadgaaaaafkcaabaaaadaaaaaa
fgbfbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadgaaaaaf
kcaabaaaabaaaaaafgbfbaaaabaaaaaadcaaaaalpcaabaaaacaaaaaacgincaaa
aaaaaaaaadaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaaf
bcaabaaaabaaaaaabkaabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaa
egilcaiaebaaaaaaaaaaaaaaadaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaafecaabaaaabaaaaaaakaabaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaaegaobaaaaaaaaaaa
dgaaaaafbcaabaaaabaaaaaackaabaaaacaaaaaadgaaaaafkcaabaaaabaaaaaa
fgbfbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadgaaaaafecaabaaaabaaaaaabkaabaaaaeaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaa
egaobaaaaaaaaaaadgaaaaafbcaabaaaaeaaaaaadkaabaaaacaaaaaadgaaaaaf
kcaabaaaacaaaaaafgbfbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaafecaabaaaacaaaaaa
dkaabaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaakgikcaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadgaaaaafkcaabaaaaeaaaaaafgbfbaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaaabaaaaaapgipcaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8].y;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[2].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].y, R2;
ADD R0.z, R2.x, c[2].y;
MAD R0.y, -R0.z, c[8], fragment.texcoord[0];
MOV R0.x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R0.z, c[8], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[2].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.x, fragment.texcoord[0];
MAD R1.y, R3.x, c[3].z, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[7].z, R2;
END
# 92 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.y, r2
add_pp r0.z, r2.x, c2.y
mad_pp r0.y, -r0.z, c8, v0
mov_pp r0.x, v0
texld r1, r0, s0
mov_pp r0.x, v0
mad_pp r0.y, r0.z, c8, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.y, r2
mov_pp r0.y, c3
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.y, r2
mov_pp r0.y, c0.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.z, r2
mov_pp r0.y, c1.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.z, r2
mov_pp r0.y, c2.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.z, r2
mov_pp r0.y, c3.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c7.z, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmcpgmjappgfdmglpafhaebienbmdehbaabaaaaaabeakaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfeajaaaa
eaaaaaaaffacaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaahgapbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
lgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalhcaabaaaabaaaaaaegidcaaaaaaaaaaaacaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaadaaaaaaegidcaiaebaaaaaaaaaaaaaaacaaaaaa
fgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaa
akbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
lgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaahgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaalgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaa
dcaaaaakccaabaaaadaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaaajaaaaaa
bkbabaaaabaaaaaadcaaaaalicaabaaaadaaaaaaakaabaiaebaaaaaaacaaaaaa
bkiacaaaaaaaaaaaajaaaaaabkbabaaaabaaaaaadgaaaaaffcaabaaaadaaaaaa
agbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadgaaaaaf
fcaabaaaabaaaaaaagbabaaaabaaaaaadcaaaaalpcaabaaaacaaaaaaigincaaa
aaaaaaaaadaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaaf
ccaabaaaabaaaaaaakaabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaa
egiocaiaebaaaaaaaaaaaaaaadaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakaabaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaaegaobaaaaaaaaaaa
dgaaaaafccaabaaaabaaaaaackaabaaaacaaaaaadgaaaaaffcaabaaaabaaaaaa
agbabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadgaaaaaficaabaaaabaaaaaabkaabaaaaeaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaa
egaobaaaaaaaaaaadgaaaaafccaabaaaaeaaaaaadkaabaaaacaaaaaadgaaaaaf
fcaabaaaacaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaaficaabaaaacaaaaaa
ckaabaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaakgikcaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadgaaaaaffcaabaaaaeaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaaabaaaaaapgipcaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8];
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[2], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].y, R2;
ADD R0.z, R2.x, c[2].y;
MAD R0.x, -R0.z, c[8], fragment.texcoord[0];
MOV R0.y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R0.z, c[8], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[2].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].w, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.y, fragment.texcoord[0];
MAD R1.x, R3, c[0].w, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[4].w, R2;
END
# 100 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.y, r2
add_pp r0.z, r2.x, c2.y
mad_pp r0.x, -r0.z, c8, v0
mov_pp r0.y, v0
texld r1, r0, s0
mov_pp r0.y, v0
mad_pp r0.x, r0.z, c8, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.y, r2
mov_pp r0.x, c3.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.y, r2
mov_pp r0.x, c0.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.z, r2
mov_pp r0.x, c1.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.z, r2
mov_pp r0.x, c2.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.z, r2
mov_pp r0.x, c3.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.z, r2
mov_pp r0.x, c0.w
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.w
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c4.w, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedemcmkpjeeeecnihlgemgpdnjeinmndohabaaaaaabaalaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfaakaaaa
eaaaaaaajeacaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaangafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalhcaabaaaabaaaaaaegidcaaaaaaaaaaaacaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaadaaaaaaegidcaiaebaaaaaaaaaaaaaaacaaaaaa
agiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaa
bkbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaangafbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaa
dcaaaaakbcaabaaaadaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaaajaaaaaa
akbabaaaabaaaaaadcaaaaalecaabaaaadaaaaaaakaabaiaebaaaaaaacaaaaaa
akiacaaaaaaaaaaaajaaaaaaakbabaaaabaaaaaadgaaaaafkcaabaaaadaaaaaa
fgbfbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadgaaaaaf
kcaabaaaabaaaaaafgbfbaaaabaaaaaadcaaaaalpcaabaaaacaaaaaacgincaaa
aaaaaaaaadaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaaf
bcaabaaaabaaaaaabkaabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaa
egilcaiaebaaaaaaaaaaaaaaadaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaafecaabaaaabaaaaaaakaabaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaaegaobaaaaaaaaaaa
dgaaaaafbcaabaaaabaaaaaackaabaaaacaaaaaadgaaaaafkcaabaaaabaaaaaa
fgbfbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadgaaaaafecaabaaaabaaaaaabkaabaaaaeaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaa
egaobaaaaaaaaaaadgaaaaafbcaabaaaaeaaaaaadkaabaaaacaaaaaadgaaaaaf
kcaabaaaacaaaaaafgbfbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaafecaabaaaacaaaaaa
dkaabaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaakgikcaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadgaaaaafkcaabaaaaeaaaaaafgbfbaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaapgipcaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadcaaaaalbcaabaaaabaaaaaaakiacaaa
aaaaaaaaaeaaaaaaakiacaaaaaaaaaaaajaaaaaaakbabaaaabaaaaaadgaaaaaf
kcaabaaaabaaaaaafgbfbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamecaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaaaeaaaaaaakiacaaaaaaaaaaaajaaaaaaakbabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaaabaaaaaaagiacaaaaaaaaaaa
aiaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8].y;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[2].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].y, R2;
ADD R0.z, R2.x, c[2].y;
MAD R0.y, -R0.z, c[8], fragment.texcoord[0];
MOV R0.x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R0.z, c[8], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[2].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0].w, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.x, fragment.texcoord[0];
MAD R1.y, R3.x, c[0].w, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[4].w, R2;
END
# 100 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.y, r2
add_pp r0.z, r2.x, c2.y
mad_pp r0.y, -r0.z, c8, v0
mov_pp r0.x, v0
texld r1, r0, s0
mov_pp r0.x, v0
mad_pp r0.y, r0.z, c8, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.y, r2
mov_pp r0.y, c3
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.y, r2
mov_pp r0.y, c0.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.z, r2
mov_pp r0.y, c1.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.z, r2
mov_pp r0.y, c2.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.z, r2
mov_pp r0.y, c3.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.z, r2
mov_pp r0.y, c0.w
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0.w
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c4.w, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedgohoileabjnimadjfgebnbnckbmlpbbgabaaaaaabaalaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcfaakaaaa
eaaaaaaajeacaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaahgapbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
lgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalhcaabaaaabaaaaaaegidcaaaaaaaaaaaacaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaadaaaaaaegidcaiaebaaaaaaaaaaaaaaacaaaaaa
fgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaa
akbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
lgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaahgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaalgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaa
dcaaaaakccaabaaaadaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaaajaaaaaa
bkbabaaaabaaaaaadcaaaaalicaabaaaadaaaaaaakaabaiaebaaaaaaacaaaaaa
bkiacaaaaaaaaaaaajaaaaaabkbabaaaabaaaaaadgaaaaaffcaabaaaadaaaaaa
agbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadgaaaaaf
fcaabaaaabaaaaaaagbabaaaabaaaaaadcaaaaalpcaabaaaacaaaaaaigincaaa
aaaaaaaaadaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaaf
ccaabaaaabaaaaaaakaabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaa
egiocaiaebaaaaaaaaaaaaaaadaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakaabaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaaegaobaaaaaaaaaaa
dgaaaaafccaabaaaabaaaaaackaabaaaacaaaaaadgaaaaaffcaabaaaabaaaaaa
agbabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadgaaaaaficaabaaaabaaaaaabkaabaaaaeaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaa
egaobaaaaaaaaaaadgaaaaafccaabaaaaeaaaaaadkaabaaaacaaaaaadgaaaaaf
fcaabaaaacaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaaficaabaaaacaaaaaa
ckaabaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaakgikcaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadgaaaaaffcaabaaaaeaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaapgipcaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadcaaaaalccaabaaaabaaaaaaakiacaaa
aaaaaaaaaeaaaaaabkiacaaaaaaaaaaaajaaaaaabkbabaaaabaaaaaadgaaaaaf
fcaabaaaabaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamicaabaaaabaaaaaa
akiacaiaebaaaaaaaaaaaaaaaeaaaaaabkiacaaaaaaaaaaaajaaaaaabkbabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaa
acaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaaabaaaaaaagiacaaaaaaaaaaa
aiaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8];
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[2], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].y, R2;
ADD R0.z, R2.x, c[2].y;
MAD R0.x, -R0.z, c[8], fragment.texcoord[0];
MOV R0.y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R0.z, c[8], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[2].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].w, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].w, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].w, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].w, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.y, fragment.texcoord[0];
MAD R1.x, R3, c[1].w, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[5].w, R2;
END
# 108 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.y, r2
add_pp r0.z, r2.x, c2.y
mad_pp r0.x, -r0.z, c8, v0
mov_pp r0.y, v0
texld r1, r0, s0
mov_pp r0.y, v0
mad_pp r0.x, r0.z, c8, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.y, r2
mov_pp r0.x, c3.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.y, r2
mov_pp r0.x, c0.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.z, r2
mov_pp r0.x, c1.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.z, r2
mov_pp r0.x, c2.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.z, r2
mov_pp r0.x, c3.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.z, r2
mov_pp r0.x, c0.w
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.w
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.w, r2
mov_pp r0.x, c1.w
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.w
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c5.w, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedcbdanibnbfeamabfcomdabclpbnhikohabaaaaaalaalaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpaakaaaa
eaaaaaaalmacaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaangafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalhcaabaaaabaaaaaaegidcaaaaaaaaaaaacaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaadaaaaaaegidcaiaebaaaaaaaaaaaaaaacaaaaaa
agiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaa
bkbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaangafbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaa
dcaaaaakbcaabaaaadaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaaajaaaaaa
akbabaaaabaaaaaadcaaaaalecaabaaaadaaaaaaakaabaiaebaaaaaaacaaaaaa
akiacaaaaaaaaaaaajaaaaaaakbabaaaabaaaaaadgaaaaafkcaabaaaadaaaaaa
fgbfbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadgaaaaaf
kcaabaaaabaaaaaafgbfbaaaabaaaaaadcaaaaalpcaabaaaacaaaaaacgincaaa
aaaaaaaaadaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaaf
bcaabaaaabaaaaaabkaabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaa
egilcaiaebaaaaaaaaaaaaaaadaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaafecaabaaaabaaaaaaakaabaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaaegaobaaaaaaaaaaa
dgaaaaafbcaabaaaabaaaaaackaabaaaacaaaaaadgaaaaafkcaabaaaabaaaaaa
fgbfbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadgaaaaafecaabaaaabaaaaaabkaabaaaaeaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaa
egaobaaaaaaaaaaadgaaaaafbcaabaaaaeaaaaaadkaabaaaacaaaaaadgaaaaaf
kcaabaaaacaaaaaafgbfbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaafecaabaaaacaaaaaa
dkaabaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaakgikcaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadgaaaaafkcaabaaaaeaaaaaafgbfbaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaapgipcaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadcaaaaaldcaabaaaabaaaaaaegiacaaa
aaaaaaaaaeaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaaf
ecaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaigaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
jgafbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamdcaabaaa
adaaaaaaegiacaiaebaaaaaaaaaaaaaaaeaaaaaaagiacaaaaaaaaaaaajaaaaaa
agbabaaaabaaaaaadgaaaaafecaabaaaadaaaaaabkbabaaaabaaaaaaefaaaaaj
pcaabaaaaeaaaaaaigaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaadaaaaaajgafbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaa
aaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaak
pcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaaabaaaaaafgifcaaaaaaaaaaa
aiaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8].y;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[2].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].y, R2;
ADD R0.z, R2.x, c[2].y;
MAD R0.y, -R0.z, c[8], fragment.texcoord[0];
MOV R0.x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R0.z, c[8], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[2].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0].w, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0].w, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].w, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].w, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.x, fragment.texcoord[0];
MAD R1.y, R3.x, c[1].w, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[5].w, R2;
END
# 108 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.y, r2
add_pp r0.z, r2.x, c2.y
mad_pp r0.y, -r0.z, c8, v0
mov_pp r0.x, v0
texld r1, r0, s0
mov_pp r0.x, v0
mad_pp r0.y, r0.z, c8, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.y, r2
mov_pp r0.y, c3
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.y, r2
mov_pp r0.y, c0.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.z, r2
mov_pp r0.y, c1.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.z, r2
mov_pp r0.y, c2.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.z, r2
mov_pp r0.y, c3.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.z, r2
mov_pp r0.y, c0.w
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0.w
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.w, r2
mov_pp r0.y, c1.w
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.w
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c5.w, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlpcejakoidcejfcppiljjbdbifiefhohabaaaaaalaalaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpaakaaaa
eaaaaaaalmacaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaahgapbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
lgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalhcaabaaaabaaaaaaegidcaaaaaaaaaaaacaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaadaaaaaaegidcaiaebaaaaaaaaaaaaaaacaaaaaa
fgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaa
akbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
lgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaahgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaalgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaa
dcaaaaakccaabaaaadaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaaajaaaaaa
bkbabaaaabaaaaaadcaaaaalicaabaaaadaaaaaaakaabaiaebaaaaaaacaaaaaa
bkiacaaaaaaaaaaaajaaaaaabkbabaaaabaaaaaadgaaaaaffcaabaaaadaaaaaa
agbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadgaaaaaf
fcaabaaaabaaaaaaagbabaaaabaaaaaadcaaaaalpcaabaaaacaaaaaaigincaaa
aaaaaaaaadaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaaf
ccaabaaaabaaaaaaakaabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaa
egiocaiaebaaaaaaaaaaaaaaadaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakaabaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaaegaobaaaaaaaaaaa
dgaaaaafccaabaaaabaaaaaackaabaaaacaaaaaadgaaaaaffcaabaaaabaaaaaa
agbabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadgaaaaaficaabaaaabaaaaaabkaabaaaaeaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaa
egaobaaaaaaaaaaadgaaaaafccaabaaaaeaaaaaadkaabaaaacaaaaaadgaaaaaf
fcaabaaaacaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaaficaabaaaacaaaaaa
ckaabaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaakgikcaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadgaaaaaffcaabaaaaeaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaapgipcaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadcaaaaaldcaabaaaabaaaaaaegiacaaa
aaaaaaaaaeaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaaf
ecaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaacgakbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ggakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamdcaabaaa
adaaaaaaegiacaiaebaaaaaaaaaaaaaaaeaaaaaafgifcaaaaaaaaaaaajaaaaaa
fgbfbaaaabaaaaaadgaaaaafecaabaaaadaaaaaaakbabaaaabaaaaaaefaaaaaj
pcaabaaaaeaaaaaacgakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaadaaaaaaggakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaa
aaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaak
pcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaaabaaaaaafgifcaaaaaaaaaaa
aiaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8];
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[2], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].y, R2;
ADD R0.z, R2.x, c[2].y;
MAD R0.x, -R0.z, c[8], fragment.texcoord[0];
MOV R0.y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R0.z, c[8], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[2].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].w, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].w, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].w, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].w, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1].w, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].w, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2].w, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.y, fragment.texcoord[0];
MAD R1.x, R3, c[2].w, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[6].w, R2;
END
# 116 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.y, r2
add_pp r0.z, r2.x, c2.y
mad_pp r0.x, -r0.z, c8, v0
mov_pp r0.y, v0
texld r1, r0, s0
mov_pp r0.y, v0
mad_pp r0.x, r0.z, c8, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.y, r2
mov_pp r0.x, c3.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.y, r2
mov_pp r0.x, c0.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.z, r2
mov_pp r0.x, c1.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.z, r2
mov_pp r0.x, c2.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.z, r2
mov_pp r0.x, c3.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.z, r2
mov_pp r0.x, c0.w
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.w
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.w, r2
mov_pp r0.x, c1.w
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.w
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.w, r2
mov_pp r0.x, c2.w
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2.w
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c6.w, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedldedhkmapeignkkkllpfjlbflkpmjgeeabaaaaaadmamaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchmalaaaa
eaaaaaaanpacaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaangafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalhcaabaaaabaaaaaaegidcaaaaaaaaaaaacaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaadaaaaaaegidcaiaebaaaaaaaaaaaaaaacaaaaaa
agiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaa
bkbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaangafbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaa
dcaaaaakbcaabaaaadaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaaajaaaaaa
akbabaaaabaaaaaadcaaaaalecaabaaaadaaaaaaakaabaiaebaaaaaaacaaaaaa
akiacaaaaaaaaaaaajaaaaaaakbabaaaabaaaaaadgaaaaafkcaabaaaadaaaaaa
fgbfbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadgaaaaaf
kcaabaaaabaaaaaafgbfbaaaabaaaaaadcaaaaalpcaabaaaacaaaaaacgincaaa
aaaaaaaaadaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaaf
bcaabaaaabaaaaaabkaabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaa
egilcaiaebaaaaaaaaaaaaaaadaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaafecaabaaaabaaaaaaakaabaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaaegaobaaaaaaaaaaa
dgaaaaafbcaabaaaabaaaaaackaabaaaacaaaaaadgaaaaafkcaabaaaabaaaaaa
fgbfbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadgaaaaafecaabaaaabaaaaaabkaabaaaaeaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaa
egaobaaaaaaaaaaadgaaaaafbcaabaaaaeaaaaaadkaabaaaacaaaaaadgaaaaaf
kcaabaaaacaaaaaafgbfbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaafecaabaaaacaaaaaa
dkaabaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaakgikcaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadgaaaaafkcaabaaaaeaaaaaafgbfbaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaapgipcaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
aaaaaaaaaeaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaaf
icaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaamgaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaadaaaaaa
egiccaiaebaaaaaaaaaaaaaaaeaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaaficaabaaaadaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaamgaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaaegaobaaaaaaaaaaa
efaaaaajpcaabaaaacaaaaaangafbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaangafbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaafgifcaaa
aaaaaaaaaiaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaa
abaaaaaakgikcaaaaaaaaaaaaiaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8].y;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[2].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].y, R2;
ADD R0.z, R2.x, c[2].y;
MAD R0.y, -R0.z, c[8], fragment.texcoord[0];
MOV R0.x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R0.z, c[8], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[2].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0].w, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0].w, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].w, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].w, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].w, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].w, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].w, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.x, fragment.texcoord[0];
MAD R1.y, R3.x, c[2].w, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[6].w, R2;
END
# 116 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.y, r2
add_pp r0.z, r2.x, c2.y
mad_pp r0.y, -r0.z, c8, v0
mov_pp r0.x, v0
texld r1, r0, s0
mov_pp r0.x, v0
mad_pp r0.y, r0.z, c8, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.y, r2
mov_pp r0.y, c3
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.y, r2
mov_pp r0.y, c0.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.z, r2
mov_pp r0.y, c1.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.z, r2
mov_pp r0.y, c2.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.z, r2
mov_pp r0.y, c3.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.z, r2
mov_pp r0.y, c0.w
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0.w
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.w, r2
mov_pp r0.y, c1.w
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.w
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.w, r2
mov_pp r0.y, c2.w
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.w
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c6.w, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlegijpbiliaibfgaglpbjfnalikkpmohabaaaaaadmamaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchmalaaaa
eaaaaaaanpacaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaahgapbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
lgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalhcaabaaaabaaaaaaegidcaaaaaaaaaaaacaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaadaaaaaaegidcaiaebaaaaaaaaaaaaaaacaaaaaa
fgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaa
akbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
lgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaahgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaalgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaa
dcaaaaakccaabaaaadaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaaajaaaaaa
bkbabaaaabaaaaaadcaaaaalicaabaaaadaaaaaaakaabaiaebaaaaaaacaaaaaa
bkiacaaaaaaaaaaaajaaaaaabkbabaaaabaaaaaadgaaaaaffcaabaaaadaaaaaa
agbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadgaaaaaf
fcaabaaaabaaaaaaagbabaaaabaaaaaadcaaaaalpcaabaaaacaaaaaaigincaaa
aaaaaaaaadaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaaf
ccaabaaaabaaaaaaakaabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaa
egiocaiaebaaaaaaaaaaaaaaadaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakaabaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaaegaobaaaaaaaaaaa
dgaaaaafccaabaaaabaaaaaackaabaaaacaaaaaadgaaaaaffcaabaaaabaaaaaa
agbabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadgaaaaaficaabaaaabaaaaaabkaabaaaaeaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaa
egaobaaaaaaaaaaadgaaaaafccaabaaaaeaaaaaadkaabaaaacaaaaaadgaaaaaf
fcaabaaaacaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaaficaabaaaacaaaaaa
ckaabaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaakgikcaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadgaaaaaffcaabaaaaeaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaapgipcaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadcaaaaalhcaabaaaabaaaaaaegiccaaa
aaaaaaaaaeaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaaf
icaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaadgapbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaadaaaaaa
egiccaiaebaaaaaaaaaaaaaaaeaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaadaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
aeaaaaaadgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaacaaaaaaagiacaaaaaaaaaaaaiaaaaaaegaobaaaaaaaaaaa
efaaaaajpcaabaaaacaaaaaahgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaahgapbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaalgapbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaafgifcaaa
aaaaaaaaaiaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaa
abaaaaaakgikcaaaaaaaaaaaaiaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8];
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[2], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].y, R2;
ADD R0.z, R2.x, c[2].y;
MAD R0.x, -R0.z, c[8], fragment.texcoord[0];
MOV R0.y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R0.z, c[8], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3].y, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3].y, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].y, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[2].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[3].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].z, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[0].w, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[0].w, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].w, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[1].w, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[1].w, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].w, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[2].w, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, c[2].w, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].w, R2;
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R3, -c[3].w, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.y, fragment.texcoord[0];
MAD R1.x, R3, c[3].w, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[7].w, R2;
END
# 124 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.y, r2
add_pp r0.z, r2.x, c2.y
mad_pp r0.x, -r0.z, c8, v0
mov_pp r0.y, v0
texld r1, r0, s0
mov_pp r0.y, v0
mad_pp r0.x, r0.z, c8, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.y, r2
mov_pp r0.x, c3.y
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3.y
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.y, r2
mov_pp r0.x, c0.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.z, r2
mov_pp r0.x, c1.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.z, r2
mov_pp r0.x, c2.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.z, r2
mov_pp r0.x, c3.z
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3.z
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.z, r2
mov_pp r0.x, c0.w
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c0.w
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.w, r2
mov_pp r0.x, c1.w
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c1.w
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.w, r2
mov_pp r0.x, c2.w
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c2.w
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.w, r2
mov_pp r0.x, c3.w
mov_pp r0.y, v0
mad_pp r0.x, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.x, c3.w
mov_pp r0.y, v0
mad_pp r0.x, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c7.w, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedipknhljhnnpgaapmmgkjifdfdkcpjbkcabaaaaaagianaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckiamaaaa
eaaaaaaackadaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaangafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalhcaabaaaabaaaaaaegidcaaaaaaaaaaaacaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaadaaaaaaegidcaiaebaaaaaaaaaaaaaaacaaaaaa
agiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaa
bkbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaangafbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaaogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaa
dcaaaaakbcaabaaaadaaaaaaakaabaaaacaaaaaaakiacaaaaaaaaaaaajaaaaaa
akbabaaaabaaaaaadcaaaaalecaabaaaadaaaaaaakaabaiaebaaaaaaacaaaaaa
akiacaaaaaaaaaaaajaaaaaaakbabaaaabaaaaaadgaaaaafkcaabaaaadaaaaaa
fgbfbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadgaaaaaf
kcaabaaaabaaaaaafgbfbaaaabaaaaaadcaaaaalpcaabaaaacaaaaaacgincaaa
aaaaaaaaadaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaaf
bcaabaaaabaaaaaabkaabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaa
egilcaiaebaaaaaaaaaaaaaaadaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaafecaabaaaabaaaaaaakaabaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaaegaobaaaaaaaaaaa
dgaaaaafbcaabaaaabaaaaaackaabaaaacaaaaaadgaaaaafkcaabaaaabaaaaaa
fgbfbaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadgaaaaafecaabaaaabaaaaaabkaabaaaaeaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaa
egaobaaaaaaaaaaadgaaaaafbcaabaaaaeaaaaaadkaabaaaacaaaaaadgaaaaaf
kcaabaaaacaaaaaafgbfbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaafecaabaaaacaaaaaa
dkaabaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaakgikcaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadgaaaaafkcaabaaaaeaaaaaafgbfbaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaapgipcaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadgaaaaafkcaabaaaabaaaaaafgbfbaaa
abaaaaaadcaaaaalpcaabaaaacaaaaaacgincaaaaaaaaaaaaeaaaaaaagiacaaa
aaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaafbcaabaaaabaaaaaabkaabaaa
acaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaaegilcaiaebaaaaaaaaaaaaaa
aeaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaafecaabaaa
abaaaaaaakaabaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaa
agiacaaaaaaaaaaaaiaaaaaaegaobaaaaaaaaaaadgaaaaafbcaabaaaabaaaaaa
ckaabaaaacaaaaaadgaaaaafkcaabaaaabaaaaaafgbfbaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dgaaaaafecaabaaaabaaaaaabkaabaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaafgifcaaaaaaaaaaaaiaaaaaaegaobaaaaaaaaaaadgaaaaaf
bcaabaaaaeaaaaaadkaabaaaacaaaaaadgaaaaafkcaabaaaacaaaaaafgbfbaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadgaaaaafecaabaaaacaaaaaadkaabaaaaeaaaaaaefaaaaaj
pcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaak
pcaabaaaaaaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaaiaaaaaaegaobaaa
aaaaaaaadgaaaaafkcaabaaaaeaaaaaafgbfbaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaogakbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaak
pccabaaaaaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaaegaobaaa
aaaaaaaadoaaaaab"
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
"3.0-!!ARBvp1.0
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
"vs_3_0
dcl_position o0
dcl_texcoord0 o1
dcl_position0 v0
dcl_texcoord0 v1
mov o1.xy, v1
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"3.0-!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R2, R0, c[4].x;
MOV R3.x, c[8].y;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[2].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3].x, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].x, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].y, R2;
ADD R0.z, R2.x, c[2].y;
MAD R0.y, -R0.z, c[8], fragment.texcoord[0];
MOV R0.x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R0.z, c[8], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3], fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].y, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[2].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3].z, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[3].z, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[7].z, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[0].w, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[0].w, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[4].w, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[1].w, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[1].w, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[5].w, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[2].w, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, c[2].w, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
ADD R0, R0, R1;
MAD R2, R0, c[6].w, R2;
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R3.x, -c[3].w, fragment.texcoord[0];
TEX R0, R0, texture[0], 2D;
MOV R1.x, fragment.texcoord[0];
MAD R1.y, R3.x, c[3].w, fragment.texcoord[0];
TEX R1, R1, texture[0], 2D;
ADD R0, R1, R0;
MAD result.color, R0, c[7].w, R2;
END
# 124 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_3_0
dcl_2d s0
dcl_texcoord0 v0.xy
texld r0, v0, s0
mul r2, r0, c4.x
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.x, r2
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.x, r2
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3.x
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.x, r2
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.y, r2
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.y, r2
add_pp r0.z, r2.x, c2.y
mad_pp r0.y, -r0.z, c8, v0
mov_pp r0.x, v0
texld r1, r0, s0
mov_pp r0.x, v0
mad_pp r0.y, r0.z, c8, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.y, r2
mov_pp r0.y, c3
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.y, r2
mov_pp r0.y, c0.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.z, r2
mov_pp r0.y, c1.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.z, r2
mov_pp r0.y, c2.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.z, r2
mov_pp r0.y, c3.z
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3.z
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c7.z, r2
mov_pp r0.y, c0.w
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c0.w
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c4.w, r2
mov_pp r0.y, c1.w
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c1.w
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c5.w, r2
mov_pp r0.y, c2.w
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c2.w
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp r2, r0, c6.w, r2
mov_pp r0.y, c3.w
mov_pp r0.x, v0
mad_pp r0.y, c8, -r0, v0
texld r1, r0, s0
mov_pp r0.y, c3.w
mov_pp r0.x, v0
mad_pp r0.y, c8, r0, v0
texld r0, r0, s0
add_pp r0, r0, r1
mad_pp oC0, r0, c7.w, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkphamhglldegclfoajdfdpaginmmdeababaaaaaagianaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckiamaaaa
eaaaaaaackadaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaahgapbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
lgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalhcaabaaaabaaaaaaegidcaaaaaaaaaaaacaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamhcaabaaaadaaaaaaegidcaiaebaaaaaaaaaaaaaaacaaaaaa
fgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaa
akbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaaagiacaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaa
lgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
aeaaaaaahgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaadaaaaaalgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaa
aaaaaaaibcaabaaaacaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaa
dcaaaaakccaabaaaadaaaaaaakaabaaaacaaaaaabkiacaaaaaaaaaaaajaaaaaa
bkbabaaaabaaaaaadcaaaaalicaabaaaadaaaaaaakaabaiaebaaaaaaacaaaaaa
bkiacaaaaaaaaaaaajaaaaaabkbabaaaabaaaaaadgaaaaaffcaabaaaadaaaaaa
agbabaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegaabaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaogakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
kgikcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaapgipcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadgaaaaaf
fcaabaaaabaaaaaaagbabaaaabaaaaaadcaaaaalpcaabaaaacaaaaaaigincaaa
aaaaaaaaadaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaaf
ccaabaaaabaaaaaaakaabaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaa
egiocaiaebaaaaaaaaaaaaaaadaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakaabaaaaeaaaaaaefaaaaajpcaabaaa
abaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaaagiacaaaaaaaaaaaahaaaaaaegaobaaaaaaaaaaa
dgaaaaafccaabaaaabaaaaaackaabaaaacaaaaaadgaaaaaffcaabaaaabaaaaaa
agbabaaaabaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadgaaaaaficaabaaaabaaaaaabkaabaaaaeaaaaaa
efaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaafgifcaaaaaaaaaaaahaaaaaa
egaobaaaaaaaaaaadgaaaaafccaabaaaaeaaaaaadkaabaaaacaaaaaadgaaaaaf
fcaabaaaacaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaaficaabaaaacaaaaaa
ckaabaaaaeaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaakgikcaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadgaaaaaffcaabaaaaeaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaapgipcaaa
aaaaaaaaahaaaaaaegaobaaaaaaaaaaadgaaaaaffcaabaaaabaaaaaaagbabaaa
abaaaaaadcaaaaalpcaabaaaacaaaaaaigincaaaaaaaaaaaaeaaaaaafgifcaaa
aaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaafccaabaaaabaaaaaaakaabaaa
acaaaaaaefaaaaajpcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaampcaabaaaaeaaaaaaegiocaiaebaaaaaaaaaaaaaa
aeaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaa
abaaaaaaakaabaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaabaaaaaa
agiacaaaaaaaaaaaaiaaaaaaegaobaaaaaaaaaaadgaaaaafccaabaaaabaaaaaa
ckaabaaaacaaaaaadgaaaaaffcaabaaaabaaaaaaagbabaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dgaaaaaficaabaaaabaaaaaabkaabaaaaeaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaafgifcaaaaaaaaaaaaiaaaaaaegaobaaaaaaaaaaadgaaaaaf
ccaabaaaaeaaaaaadkaabaaaacaaaaaadgaaaaaffcaabaaaacaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadgaaaaaficaabaaaacaaaaaackaabaaaaeaaaaaaefaaaaaj
pcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaak
pcaabaaaaaaaaaaaegaobaaaabaaaaaakgikcaaaaaaaaaaaaiaaaaaaegaobaaa
aaaaaaaadgaaaaaffcaabaaaaeaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegaabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaacaaaaaaogakbaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaak
pccabaaaaaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaaiaaaaaaegaobaaa
aaaaaaaadoaaaaab"
}
}
 }
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.x, c[8];
MAD R2.x, R0, -c[1], fragment.texcoord[0];
MOV R2.y, fragment.texcoord[0];
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R0, c[1], fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MUL R0, R0, c[4].x;
ADD R1, R1, R2;
MAD result.color, R1, c[5].x, R0;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl t0.xy
texld r2, t0, s0
mov_pp r0.x, c1
mov_pp r1.x, c1
mad_pp r0.x, c8, -r0, t0
mov_pp r0.y, t0
mov_pp r1.y, t0
mad_pp r1.x, c8, r1, t0
mul r2, r2, c4.x
texld r1, r1, s0
texld r0, r0, s0
add_pp r0, r1, r0
mad_pp r0, r0, c5.x, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjboolgdbbflamckifmmemigkoaindhpdabaaaaaafiacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjiabaaaa
eaaaaaaaggaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaadcaaaaalbcaabaaaaaaaaaaa
bkiacaaaaaaaaaaaabaaaaaaakiacaaaaaaaaaaaajaaaaaaakbabaaaabaaaaaa
dgaaaaafkcaabaaaaaaaaaaafgbfbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamecaabaaa
aaaaaaaabkiacaiaebaaaaaaaaaaaaaaabaaaaaaakiacaaaaaaaaaaaajaaaaaa
akbabaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaogakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaafgifcaaa
aaaaaaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaaabaaaaaa
agiacaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.y, c[8];
MAD R2.y, R0, -c[1].x, fragment.texcoord[0];
MOV R2.x, fragment.texcoord[0];
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R0, c[1].x, fragment.texcoord[0];
TEX R1, R0, texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, R2, texture[0], 2D;
MUL R0, R0, c[4].x;
ADD R1, R1, R2;
MAD result.color, R1, c[5].x, R0;
END
# 11 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl t0.xy
mov_pp r0.x, c1
mad_pp r0.y, c8, -r0.x, t0
mov_pp r1.x, c1
mov_pp r0.x, t0
mad_pp r2.y, c8, r1.x, t0
mov_pp r2.x, t0
texld r1, r2, s0
texld r2, t0, s0
texld r0, r0, s0
mul r2, r2, c4.x
add_pp r0, r1, r0
mad_pp r0, r0, c5.x, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedeicdjimdifhmbodpjlmmcnpikehpfpbaabaaaaaafiacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjiabaaaa
eaaaaaaaggaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaadcaaaaalccaabaaaaaaaaaaa
bkiacaaaaaaaaaaaabaaaaaabkiacaaaaaaaaaaaajaaaaaabkbabaaaabaaaaaa
dgaaaaaffcaabaaaaaaaaaaaagbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egaabaaaaaaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamicaabaaa
aaaaaaaabkiacaiaebaaaaaaaaaaaaaaabaaaaaabkiacaaaaaaaaaaaajaaaaaa
bkbabaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaogakbaaaaaaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
egaobaaaabaaaaaadiaaaaaipcaabaaaaaaaaaaaegaobaaaaaaaaaaafgifcaaa
aaaaaaaaafaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaaabaaaaaa
agiacaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R1.x, c[8];
MAD R0.x, R1, c[1], fragment.texcoord[0];
MAD R0.z, R1.x, -c[2].x, fragment.texcoord[0].x;
MAD R2.x, R1, -c[1], fragment.texcoord[0];
MOV R0.w, fragment.texcoord[0].y;
MOV R2.y, fragment.texcoord[0];
MOV R0.y, fragment.texcoord[0];
MOV R1.y, fragment.texcoord[0];
MAD R1.x, R1, c[2], fragment.texcoord[0];
TEX R3, R1, texture[0], 2D;
TEX R4, R0.zwzw, texture[0], 2D;
TEX R1, R0, texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, R2, texture[0], 2D;
ADD R1, R1, R2;
MUL R0, R0, c[4].x;
MAD R0, R1, c[5].x, R0;
ADD R1, R3, R4;
MAD result.color, R1, c[6].x, R0;
END
# 19 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl t0.xy
mov_pp r0.x, c1
mad_pp r2.x, c8, -r0, t0
mov_pp r0.x, c1
mad_pp r3.x, c8, r0, t0
mov_pp r0.x, c2
mad_pp r4.x, c8, -r0, t0
mov_pp r2.y, t0
mov_pp r3.y, t0
mov_pp r0.x, c2
mov_pp r4.y, t0
mov_pp r0.y, t0
mad_pp r0.x, c8, r0, t0
texld r1, r0, s0
texld r0, r4, s0
texld r3, r3, s0
texld r4, t0, s0
texld r2, r2, s0
mul r4, r4, c4.x
add_pp r2, r3, r2
mad_pp r2, r2, c5.x, r4
add_pp r0, r1, r0
mad_pp r0, r0, c6.x, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhcjnhheleppkbhhhjiaofmdikhkcbmfdabaaaaaapiacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdiacaaaa
eaaaaaaaioaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaldcaabaaa
abaaaaaajgifcaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaafecaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaaigaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaajgafbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamdcaabaaaadaaaaaajgifcaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaa
aaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaafecaabaaaadaaaaaabkbabaaa
abaaaaaaefaaaaajpcaabaaaaeaaaaaaigaabaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaajgafbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
aeaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaa
afaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
afaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaaabaaaaaa
kgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MOV R1.y, c[8];
MAD R0.y, R1, c[1].x, fragment.texcoord[0];
MAD R0.w, R1.y, -c[2].x, fragment.texcoord[0].y;
MAD R2.y, R1, -c[1].x, fragment.texcoord[0];
MOV R0.z, fragment.texcoord[0].x;
MOV R2.x, fragment.texcoord[0];
MOV R0.x, fragment.texcoord[0];
MOV R1.x, fragment.texcoord[0];
MAD R1.y, R1, c[2].x, fragment.texcoord[0];
TEX R3, R1, texture[0], 2D;
TEX R4, R0.zwzw, texture[0], 2D;
TEX R1, R0, texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, R2, texture[0], 2D;
ADD R1, R1, R2;
MUL R0, R0, c[4].x;
MAD R0, R1, c[5].x, R0;
ADD R1, R3, R4;
MAD result.color, R1, c[6].x, R0;
END
# 19 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl t0.xy
mov_pp r0.x, c1
mad_pp r2.y, c8, -r0.x, t0
mov_pp r0.x, c1
mad_pp r3.y, c8, r0.x, t0
mov_pp r0.x, c2
mad_pp r4.y, c8, -r0.x, t0
mov_pp r0.x, c2
mov_pp r2.x, t0
mov_pp r3.x, t0
mov_pp r4.x, t0
mad_pp r1.y, c8, r0.x, t0
mov_pp r1.x, t0
texld r0, r4, s0
texld r1, r1, s0
texld r3, r3, s0
texld r4, t0, s0
texld r2, r2, s0
mul r4, r4, c4.x
add_pp r2, r3, r2
mad_pp r2, r2, c5.x, r4
add_pp r0, r1, r0
mad_pp r0, r0, c6.x, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbjkidjmkhkhpmbmeifcenhbmlpeoemejabaaaaaapiacaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcdiacaaaa
eaaaaaaaioaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaldcaabaaa
abaaaaaajgifcaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaacgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaggakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamdcaabaaaadaaaaaajgifcaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaa
aaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaafecaabaaaadaaaaaaakbabaaa
abaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaadaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaaadaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaa
aeaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaa
afaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaa
afaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaaabaaaaaa
kgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R2.z, c[8].x;
MAD R0.x, R2.z, c[1], fragment.texcoord[0];
MAD R0.z, R2, -c[2].x, fragment.texcoord[0].x;
MOV R0.w, fragment.texcoord[0].y;
MAD R1.x, R2.z, c[2], fragment.texcoord[0];
MOV R1.y, fragment.texcoord[0];
MAD R1.z, R2, -c[3].x, fragment.texcoord[0].x;
MAD R2.x, R2.z, -c[1], fragment.texcoord[0];
MOV R1.w, fragment.texcoord[0].y;
MOV R0.y, fragment.texcoord[0];
MOV R2.w, fragment.texcoord[0].y;
MAD R2.z, R2, c[3].x, fragment.texcoord[0].x;
MOV R2.y, fragment.texcoord[0];
TEX R5, R2.zwzw, texture[0], 2D;
TEX R6, R1.zwzw, texture[0], 2D;
TEX R3, R1, texture[0], 2D;
TEX R4, R0.zwzw, texture[0], 2D;
TEX R1, R0, texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, R2, texture[0], 2D;
ADD R1, R1, R2;
MUL R0, R0, c[4].x;
MAD R0, R1, c[5].x, R0;
ADD R1, R3, R4;
MAD R0, R1, c[6].x, R0;
ADD R1, R5, R6;
MAD result.color, R1, c[7].x, R0;
END
# 27 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl t0.xy
mov_pp r0.x, c1
mad_pp r4.x, c8, -r0, t0
mov_pp r0.x, c1
mad_pp r5.x, c8, r0, t0
mov_pp r0.x, c2
mad_pp r2.x, c8, -r0, t0
mov_pp r0.x, c2
mad_pp r3.x, c8, r0, t0
mov_pp r0.x, c3
mad_pp r6.x, c8, -r0, t0
mov_pp r4.y, t0
mov_pp r5.y, t0
mov_pp r2.y, t0
mov_pp r3.y, t0
mov_pp r0.x, c3
mov_pp r6.y, t0
mov_pp r0.y, t0
mad_pp r0.x, c8, r0, t0
texld r1, r0, s0
texld r0, r6, s0
texld r3, r3, s0
texld r2, r2, s0
texld r5, r5, s0
texld r6, t0, s0
texld r4, r4, s0
mul r6, r6, c4.x
add_pp r4, r5, r4
mad_pp r4, r4, c5.x, r6
add_pp r2, r3, r2
mad_pp r2, r2, c6.x, r4
add_pp r0, r1, r0
mad_pp r0, r0, c7.x, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecednabbbfkaihnbjiffapnbkcknchhppclfabaaaaaaieadaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmeacaaaa
eaaaaaaalbaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaangafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
doaaaaab"
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
MOV R2.w, c[8].y;
MAD R0.y, R2.w, c[1].x, fragment.texcoord[0];
MAD R0.w, R2, -c[2].x, fragment.texcoord[0].y;
MOV R0.z, fragment.texcoord[0].x;
MAD R1.y, R2.w, c[2].x, fragment.texcoord[0];
MOV R1.x, fragment.texcoord[0];
MAD R1.w, R2, -c[3].x, fragment.texcoord[0].y;
MAD R2.y, R2.w, -c[1].x, fragment.texcoord[0];
MOV R1.z, fragment.texcoord[0].x;
MOV R0.x, fragment.texcoord[0];
MOV R2.z, fragment.texcoord[0].x;
MAD R2.w, R2, c[3].x, fragment.texcoord[0].y;
MOV R2.x, fragment.texcoord[0];
TEX R5, R2.zwzw, texture[0], 2D;
TEX R6, R1.zwzw, texture[0], 2D;
TEX R3, R1, texture[0], 2D;
TEX R4, R0.zwzw, texture[0], 2D;
TEX R1, R0, texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, R2, texture[0], 2D;
ADD R1, R1, R2;
MUL R0, R0, c[4].x;
MAD R0, R1, c[5].x, R0;
ADD R1, R3, R4;
MAD R0, R1, c[6].x, R0;
ADD R1, R5, R6;
MAD result.color, R1, c[7].x, R0;
END
# 27 instructions, 7 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl t0.xy
mov_pp r0.x, c1
mad_pp r4.y, c8, -r0.x, t0
mov_pp r0.x, c1
mad_pp r5.y, c8, r0.x, t0
mov_pp r0.x, c2
mad_pp r2.y, c8, -r0.x, t0
mov_pp r0.x, c2
mad_pp r3.y, c8, r0.x, t0
mov_pp r0.x, c3
mad_pp r6.y, c8, -r0.x, t0
mov_pp r0.x, c3
mov_pp r4.x, t0
mov_pp r5.x, t0
mov_pp r2.x, t0
mov_pp r3.x, t0
mov_pp r6.x, t0
mad_pp r1.y, c8, r0.x, t0
mov_pp r1.x, t0
texld r0, r6, s0
texld r1, r1, s0
texld r3, r3, s0
texld r2, r2, s0
texld r5, r5, s0
texld r6, t0, s0
texld r4, r4, s0
mul r6, r6, c4.x
add_pp r4, r5, r4
mad_pp r4, r4, c5.x, r6
add_pp r2, r3, r2
mad_pp r2, r2, c6.x, r4
add_pp r0, r1, r0
mad_pp r0, r0, c7.x, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedgpbihemimhfoehgkkjelllolnknkldenabaaaaaaieadaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmeacaaaa
eaaaaaaalbaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaahgapbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
lgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
doaaaaab"
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
MOV R3.z, c[8].x;
MAD R0.x, R3.z, c[1], fragment.texcoord[0];
MAD R0.z, R3, -c[2].x, fragment.texcoord[0].x;
MOV R0.w, fragment.texcoord[0].y;
MAD R1.x, R3.z, c[2], fragment.texcoord[0];
MAD R1.z, R3, -c[3].x, fragment.texcoord[0].x;
MOV R1.w, fragment.texcoord[0].y;
MAD R2.z, R3, c[3].x, fragment.texcoord[0].x;
MOV R2.w, fragment.texcoord[0].y;
MAD R3.x, R3.z, -c[0].y, fragment.texcoord[0];
MAD R2.x, R3.z, -c[1], fragment.texcoord[0];
MOV R3.y, fragment.texcoord[0];
MOV R0.y, fragment.texcoord[0];
MOV R1.y, fragment.texcoord[0];
MOV R3.w, fragment.texcoord[0].y;
MAD R3.z, R3, c[0].y, fragment.texcoord[0].x;
MOV R2.y, fragment.texcoord[0];
TEX R5, R2.zwzw, texture[0], 2D;
TEX R7, R3.zwzw, texture[0], 2D;
TEX R8, R3, texture[0], 2D;
TEX R6, R1.zwzw, texture[0], 2D;
TEX R3, R1, texture[0], 2D;
TEX R4, R0.zwzw, texture[0], 2D;
TEX R1, R0, texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, R2, texture[0], 2D;
ADD R1, R1, R2;
MUL R0, R0, c[4].x;
MAD R0, R1, c[5].x, R0;
ADD R1, R3, R4;
MAD R0, R1, c[6].x, R0;
ADD R1, R5, R6;
MAD R0, R1, c[7].x, R0;
ADD R1, R7, R8;
MAD result.color, R1, c[4].y, R0;
END
# 35 instructions, 9 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl t0.xy
mov_pp r0.x, c1
mad_pp r6.x, c8, -r0, t0
mov_pp r0.x, c1
mad_pp r7.x, c8, r0, t0
mov_pp r0.x, c2
mad_pp r4.x, c8, -r0, t0
mov_pp r0.x, c2
mad_pp r5.x, c8, r0, t0
mov_pp r0.x, c3
mad_pp r2.x, c8, -r0, t0
mov_pp r0.x, c3
mov_pp r0.y, c0
mad_pp r8.x, c8, -r0.y, t0
mov_pp r0.y, c0
mov_pp r6.y, t0
mov_pp r7.y, t0
mov_pp r4.y, t0
mov_pp r5.y, t0
mov_pp r2.y, t0
mad_pp r3.x, c8, r0, t0
mov_pp r3.y, t0
mov_pp r8.y, t0
mad_pp r1.x, c8, r0.y, t0
mov_pp r1.y, t0
texld r0, r8, s0
texld r1, r1, s0
texld r3, r3, s0
texld r2, r2, s0
texld r5, r5, s0
texld r4, r4, s0
texld r7, r7, s0
texld r8, t0, s0
texld r6, r6, s0
mul r8, r8, c4.x
add_pp r6, r7, r6
mad_pp r6, r6, c5.x, r8
add_pp r4, r5, r4
mad_pp r4, r4, c6.x, r6
add_pp r2, r3, r2
mad_pp r2, r2, c7.x, r4
add_pp r0, r1, r0
mad_pp r0, r0, c4.y, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedghjigegpedblfbolphgcafmkokpficpgabaaaaaaiaaeaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmaadaaaa
eaaaaaaapaaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaangafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalbcaabaaaabaaaaaaakiacaaaaaaaaaaaacaaaaaaakiacaaaaaaaaaaa
ajaaaaaaakbabaaaabaaaaaadgaaaaafkcaabaaaabaaaaaafgbfbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamecaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaacaaaaaa
akiacaaaaaaaaaaaajaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaa
egaobaaaabaaaaaaagiacaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadoaaaaab
"
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
MOV R3.w, c[8].y;
MAD R0.y, R3.w, c[1].x, fragment.texcoord[0];
MAD R0.w, R3, -c[2].x, fragment.texcoord[0].y;
MOV R0.z, fragment.texcoord[0].x;
MAD R1.y, R3.w, c[2].x, fragment.texcoord[0];
MAD R1.w, R3, -c[3].x, fragment.texcoord[0].y;
MOV R1.z, fragment.texcoord[0].x;
MAD R2.w, R3, c[3].x, fragment.texcoord[0].y;
MOV R2.z, fragment.texcoord[0].x;
MAD R3.y, R3.w, -c[0], fragment.texcoord[0];
MAD R2.y, R3.w, -c[1].x, fragment.texcoord[0];
MOV R3.x, fragment.texcoord[0];
MOV R0.x, fragment.texcoord[0];
MOV R1.x, fragment.texcoord[0];
MOV R3.z, fragment.texcoord[0].x;
MAD R3.w, R3, c[0].y, fragment.texcoord[0].y;
MOV R2.x, fragment.texcoord[0];
TEX R5, R2.zwzw, texture[0], 2D;
TEX R7, R3.zwzw, texture[0], 2D;
TEX R8, R3, texture[0], 2D;
TEX R6, R1.zwzw, texture[0], 2D;
TEX R3, R1, texture[0], 2D;
TEX R4, R0.zwzw, texture[0], 2D;
TEX R1, R0, texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, R2, texture[0], 2D;
ADD R1, R1, R2;
MUL R0, R0, c[4].x;
MAD R0, R1, c[5].x, R0;
ADD R1, R3, R4;
MAD R0, R1, c[6].x, R0;
ADD R1, R5, R6;
MAD R0, R1, c[7].x, R0;
ADD R1, R7, R8;
MAD result.color, R1, c[4].y, R0;
END
# 35 instructions, 9 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl t0.xy
mov_pp r0.x, c1
mad_pp r6.y, c8, -r0.x, t0
mov_pp r0.x, c1
mad_pp r7.y, c8, r0.x, t0
mov_pp r0.x, c2
mad_pp r4.y, c8, -r0.x, t0
mov_pp r0.x, c2
mad_pp r5.y, c8, r0.x, t0
mov_pp r0.x, c3
mad_pp r2.y, c8, -r0.x, t0
mov_pp r0.x, c3
mad_pp r3.y, c8, r0.x, t0
mov_pp r0.y, c0
mad_pp r8.y, c8, -r0, t0
mov_pp r6.x, t0
mov_pp r7.x, t0
mov_pp r4.x, t0
mov_pp r5.x, t0
mov_pp r2.x, t0
mov_pp r3.x, t0
mov_pp r0.y, c0
mov_pp r8.x, t0
mov_pp r0.x, t0
mad_pp r0.y, c8, r0, t0
texld r1, r0, s0
texld r0, r8, s0
texld r3, r3, s0
texld r2, r2, s0
texld r5, r5, s0
texld r4, r4, s0
texld r7, r7, s0
texld r8, t0, s0
texld r6, r6, s0
mul r8, r8, c4.x
add_pp r6, r7, r6
mad_pp r6, r6, c5.x, r8
add_pp r4, r5, r4
mad_pp r4, r4, c6.x, r6
add_pp r2, r3, r2
mad_pp r2, r2, c7.x, r4
add_pp r0, r1, r0
mad_pp r0, r0, c4.y, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedphbcfjmlbepjglhaemmbdkaghopcaaloabaaaaaaiaaeaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmaadaaaa
eaaaaaaapaaaaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaahgapbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
lgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaalccaabaaaabaaaaaaakiacaaaaaaaaaaaacaaaaaabkiacaaaaaaaaaaa
ajaaaaaabkbabaaaabaaaaaadgaaaaaffcaabaaaabaaaaaaagbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaamicaabaaaabaaaaaaakiacaiaebaaaaaaaaaaaaaaacaaaaaa
bkiacaaaaaaaaaaaajaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
ogakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaa
egaobaaaabaaaaaaagiacaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadoaaaaab
"
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEMP R9;
TEMP R10;
MOV R4.z, c[8].x;
MAD R0.x, R4.z, c[1], fragment.texcoord[0];
MAD R0.z, R4, -c[2].x, fragment.texcoord[0].x;
MAD R1.x, R4.z, c[2], fragment.texcoord[0];
MAD R1.z, R4, -c[3].x, fragment.texcoord[0].x;
MOV R1.w, fragment.texcoord[0].y;
MAD R2.z, R4, c[3].x, fragment.texcoord[0].x;
MOV R2.w, fragment.texcoord[0].y;
MAD R3.x, R4.z, -c[0].y, fragment.texcoord[0];
MOV R3.y, fragment.texcoord[0];
MAD R3.z, R4, c[0].y, fragment.texcoord[0].x;
MOV R3.w, fragment.texcoord[0].y;
MAD R4.x, R4.z, -c[1].y, fragment.texcoord[0];
MAD R2.x, R4.z, -c[1], fragment.texcoord[0];
MOV R4.y, fragment.texcoord[0];
MOV R0.y, fragment.texcoord[0];
MOV R0.w, fragment.texcoord[0].y;
MOV R1.y, fragment.texcoord[0];
MOV R4.w, fragment.texcoord[0].y;
MAD R4.z, R4, c[1].y, fragment.texcoord[0].x;
MOV R2.y, fragment.texcoord[0];
TEX R5, R2.zwzw, texture[0], 2D;
TEX R9, R4.zwzw, texture[0], 2D;
TEX R10, R4, texture[0], 2D;
TEX R7, R3.zwzw, texture[0], 2D;
TEX R8, R3, texture[0], 2D;
TEX R6, R1.zwzw, texture[0], 2D;
TEX R3, R1, texture[0], 2D;
TEX R4, R0.zwzw, texture[0], 2D;
TEX R1, R0, texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, R2, texture[0], 2D;
ADD R1, R1, R2;
MUL R0, R0, c[4].x;
MAD R0, R1, c[5].x, R0;
ADD R1, R3, R4;
MAD R0, R1, c[6].x, R0;
ADD R1, R5, R6;
MAD R0, R1, c[7].x, R0;
ADD R1, R7, R8;
MAD R0, R1, c[4].y, R0;
ADD R1, R9, R10;
MAD result.color, R1, c[5].y, R0;
END
# 43 instructions, 11 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl t0.xy
mov_pp r0.x, c1
mad_pp r8.x, c8, -r0, t0
mov_pp r0.x, c1
mad_pp r9.x, c8, r0, t0
mov_pp r0.x, c2
mad_pp r6.x, c8, -r0, t0
mov_pp r0.x, c2
mad_pp r7.x, c8, r0, t0
mov_pp r0.x, c3
mad_pp r4.x, c8, -r0, t0
mov_pp r0.x, c3
mov_pp r0.y, c0
mad_pp r2.x, c8, -r0.y, t0
mov_pp r0.y, c0
mad_pp r3.x, c8, r0.y, t0
mov_pp r0.y, c1
mad_pp r10.x, c8, -r0.y, t0
mov_pp r0.y, c1
mov_pp r8.y, t0
mov_pp r9.y, t0
mov_pp r6.y, t0
mov_pp r7.y, t0
mov_pp r4.y, t0
mov_pp r2.y, t0
mov_pp r3.y, t0
mad_pp r5.x, c8, r0, t0
mov_pp r5.y, t0
mov_pp r10.y, t0
mad_pp r1.x, c8, r0.y, t0
mov_pp r1.y, t0
texld r0, r10, s0
texld r1, r1, s0
texld r3, r3, s0
texld r2, r2, s0
texld r5, r5, s0
texld r4, r4, s0
texld r7, r7, s0
texld r6, r6, s0
texld r9, r9, s0
texld r10, t0, s0
texld r8, r8, s0
mul r10, r10, c4.x
add_pp r8, r9, r8
mad_pp r8, r8, c5.x, r10
add_pp r6, r7, r6
mad_pp r6, r6, c6.x, r8
add_pp r4, r5, r4
mad_pp r4, r4, c7.x, r6
add_pp r2, r3, r2
mad_pp r2, r2, c4.y, r4
add_pp r0, r1, r0
mad_pp r0, r0, c5.y, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedadnhenpanegghllldcijgpbpglfpclkbabaaaaaacaafaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgaaeaaaa
eaaaaaaabiabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaangafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaaldcaabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaafecaabaaaabaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaigaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaajgafbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamdcaabaaaadaaaaaaegiacaiaebaaaaaaaaaaaaaa
acaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaafecaabaaa
adaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaigaabaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaajgafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
agiacaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egaobaaaabaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadoaaaaab
"
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEMP R9;
TEMP R10;
MOV R4.w, c[8].y;
MAD R0.y, R4.w, c[1].x, fragment.texcoord[0];
MAD R0.w, R4, -c[2].x, fragment.texcoord[0].y;
MAD R1.y, R4.w, c[2].x, fragment.texcoord[0];
MAD R1.w, R4, -c[3].x, fragment.texcoord[0].y;
MOV R1.z, fragment.texcoord[0].x;
MAD R2.w, R4, c[3].x, fragment.texcoord[0].y;
MOV R2.z, fragment.texcoord[0].x;
MAD R3.y, R4.w, -c[0], fragment.texcoord[0];
MOV R3.x, fragment.texcoord[0];
MAD R3.w, R4, c[0].y, fragment.texcoord[0].y;
MOV R3.z, fragment.texcoord[0].x;
MAD R4.y, R4.w, -c[1], fragment.texcoord[0];
MAD R2.y, R4.w, -c[1].x, fragment.texcoord[0];
MOV R4.x, fragment.texcoord[0];
MOV R0.x, fragment.texcoord[0];
MOV R0.z, fragment.texcoord[0].x;
MOV R1.x, fragment.texcoord[0];
MOV R4.z, fragment.texcoord[0].x;
MAD R4.w, R4, c[1].y, fragment.texcoord[0].y;
MOV R2.x, fragment.texcoord[0];
TEX R5, R2.zwzw, texture[0], 2D;
TEX R9, R4.zwzw, texture[0], 2D;
TEX R10, R4, texture[0], 2D;
TEX R7, R3.zwzw, texture[0], 2D;
TEX R8, R3, texture[0], 2D;
TEX R6, R1.zwzw, texture[0], 2D;
TEX R3, R1, texture[0], 2D;
TEX R4, R0.zwzw, texture[0], 2D;
TEX R1, R0, texture[0], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R2, R2, texture[0], 2D;
ADD R1, R1, R2;
MUL R0, R0, c[4].x;
MAD R0, R1, c[5].x, R0;
ADD R1, R3, R4;
MAD R0, R1, c[6].x, R0;
ADD R1, R5, R6;
MAD R0, R1, c[7].x, R0;
ADD R1, R7, R8;
MAD R0, R1, c[4].y, R0;
ADD R1, R9, R10;
MAD result.color, R1, c[5].y, R0;
END
# 43 instructions, 11 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl t0.xy
mov_pp r0.x, c1
mad_pp r8.y, c8, -r0.x, t0
mov_pp r0.x, c1
mad_pp r9.y, c8, r0.x, t0
mov_pp r0.x, c2
mad_pp r6.y, c8, -r0.x, t0
mov_pp r0.x, c2
mad_pp r7.y, c8, r0.x, t0
mov_pp r0.x, c3
mad_pp r4.y, c8, -r0.x, t0
mov_pp r0.x, c3
mad_pp r5.y, c8, r0.x, t0
mov_pp r0.y, c0
mad_pp r2.y, c8, -r0, t0
mov_pp r0.y, c0
mad_pp r3.y, c8, r0, t0
mov_pp r0.y, c1
mad_pp r10.y, c8, -r0, t0
mov_pp r8.x, t0
mov_pp r9.x, t0
mov_pp r6.x, t0
mov_pp r7.x, t0
mov_pp r4.x, t0
mov_pp r5.x, t0
mov_pp r2.x, t0
mov_pp r3.x, t0
mov_pp r0.y, c1
mov_pp r10.x, t0
mov_pp r0.x, t0
mad_pp r0.y, c8, r0, t0
texld r1, r0, s0
texld r0, r10, s0
texld r3, r3, s0
texld r2, r2, s0
texld r5, r5, s0
texld r4, r4, s0
texld r7, r7, s0
texld r6, r6, s0
texld r9, r9, s0
texld r10, t0, s0
texld r8, r8, s0
mul r10, r10, c4.x
add_pp r8, r9, r8
mad_pp r8, r8, c5.x, r10
add_pp r6, r7, r6
mad_pp r6, r6, c6.x, r8
add_pp r4, r5, r4
mad_pp r4, r4, c7.x, r6
add_pp r2, r3, r2
mad_pp r2, r2, c4.y, r4
add_pp r0, r1, r0
mad_pp r0, r0, c5.y, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbaihddmjpcmhhkkeiakmeafdgjcmgkfgabaaaaaacaafaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcgaaeaaaa
eaaaaaaabiabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaahgapbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
lgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaaldcaabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaacgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamdcaabaaaadaaaaaaegiacaiaebaaaaaaaaaaaaaa
acaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaafecaabaaa
adaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
agiacaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaa
egaobaaaabaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadoaaaaab
"
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEMP R9;
TEMP R10;
TEX R10, fragment.texcoord[0], texture[0], 2D;
MOV R0.x, c[8];
MAD R9.x, R0, -c[1], fragment.texcoord[0];
MOV R9.y, fragment.texcoord[0];
MAD R8.x, R0, c[1], fragment.texcoord[0];
MOV R8.y, fragment.texcoord[0];
MAD R7.x, R0, -c[2], fragment.texcoord[0];
MOV R7.y, fragment.texcoord[0];
MAD R6.x, R0, c[2], fragment.texcoord[0];
MOV R6.y, fragment.texcoord[0];
MAD R5.x, R0, -c[3], fragment.texcoord[0];
MOV R5.y, fragment.texcoord[0];
MAD R4.x, R0, c[3], fragment.texcoord[0];
MOV R4.y, fragment.texcoord[0];
MAD R3.x, R0, -c[0].y, fragment.texcoord[0];
MOV R3.y, fragment.texcoord[0];
MAD R2.x, R0, c[0].y, fragment.texcoord[0];
MAD R1.x, R0, -c[1].y, fragment.texcoord[0];
MOV R2.y, fragment.texcoord[0];
MOV R1.y, fragment.texcoord[0];
MOV R0.y, fragment.texcoord[0];
MAD R0.x, R0, c[1].y, fragment.texcoord[0];
MUL R10, R10, c[4].x;
TEX R1, R1, texture[0], 2D;
TEX R0, R0, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
TEX R3, R3, texture[0], 2D;
TEX R4, R4, texture[0], 2D;
TEX R5, R5, texture[0], 2D;
TEX R6, R6, texture[0], 2D;
TEX R7, R7, texture[0], 2D;
TEX R8, R8, texture[0], 2D;
TEX R9, R9, texture[0], 2D;
ADD R8, R8, R9;
ADD R0, R0, R1;
MAD R8, R8, c[5].x, R10;
ADD R6, R6, R7;
MAD R6, R6, c[6].x, R8;
ADD R4, R4, R5;
MAD R4, R4, c[7].x, R6;
ADD R2, R2, R3;
MAD R2, R2, c[4].y, R4;
MAD R2, R0, c[5].y, R2;
ADD R0.x, R2, c[2].y;
MAD R0.z, R0.x, c[8].x, fragment.texcoord[0].x;
MAD R0.x, -R0, c[8], fragment.texcoord[0];
MOV R0.y, fragment.texcoord[0];
MOV R0.w, fragment.texcoord[0].y;
TEX R1, R0, texture[0], 2D;
TEX R0, R0.zwzw, texture[0], 2D;
ADD R0, R0, R1;
MAD result.color, R0, c[6].y, R2;
END
# 52 instructions, 11 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl t0.xy
mov_pp r0.x, c1
mad_pp r1.x, c8, -r0, t0
mov_pp r3.x, c2
mad_pp r4.x, c8, r3, t0
mov_pp r3.x, c3
mad_pp r5.x, c8, -r3, t0
mov_pp r3.x, c3
mov_pp r3.y, c0
mad_pp r7.x, c8, -r3.y, t0
mov_pp r3.y, c0
mad_pp r8.x, c8, r3.y, t0
mov_pp r3.y, c1
mad_pp r9.x, c8, -r3.y, t0
mov_pp r3.y, c1
mov_pp r0.x, c1
mov_pp r1.y, t0
mov_pp r2.x, c2
mov_pp r4.y, t0
mov_pp r5.y, t0
mov_pp r7.y, t0
mov_pp r8.y, t0
mov_pp r9.y, t0
mad_pp r0.x, c8, r0, t0
mov_pp r0.y, t0
mad_pp r2.x, c8, -r2, t0
mov_pp r2.y, t0
mad_pp r6.x, c8, r3, t0
mad_pp r10.x, c8, r3.y, t0
mov_pp r6.y, t0
mov_pp r10.y, t0
texld r3, r2, s0
texld r2, r0, s0
texld r10, r10, s0
texld r9, r9, s0
texld r8, r8, s0
texld r7, r7, s0
texld r6, r6, s0
texld r5, r5, s0
texld r4, r4, s0
texld r0, t0, s0
texld r1, r1, s0
add_pp r1, r2, r1
mul r0, r0, c4.x
mad_pp r0, r1, c5.x, r0
add_pp r1, r4, r3
mad_pp r0, r1, c6.x, r0
add_pp r1, r6, r5
mad_pp r0, r1, c7.x, r0
add_pp r1, r8, r7
mad_pp r0, r1, c4.y, r0
add_pp r1, r10, r9
mad_pp r2, r1, c5.y, r0
add_pp r0.x, r2, c2.y
mad_pp r1.x, r0, c8, t0
mov_pp r1.y, t0
mad_pp r0.x, -r0, c8, t0
mov_pp r0.y, t0
texld r0, r0, s0
texld r1, r1, s0
add_pp r0, r1, r0
mad_pp r0, r0, c6.y, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedcajpdilgbgdjpnidijjpnjbjlglijgoeabaaaaaadeagaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcheafaaaa
eaaaaaaafnabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaa
abaaaaaadgaaaaaficaabaaaabaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaamgaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaaficaabaaaadaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaamgaabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaangafbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogakbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaangafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
ogakbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaaldcaabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaagiacaaaaaaaaaaa
ajaaaaaaagbabaaaabaaaaaadgaaaaafecaabaaaabaaaaaabkbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaigaabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaajgafbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamdcaabaaaadaaaaaaegiacaiaebaaaaaaaaaaaaaa
acaaaaaaagiacaaaaaaaaaaaajaaaaaaagbabaaaabaaaaaadgaaaaafecaabaaa
adaaaaaabkbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaaigaabaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaajgafbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
agiacaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaaaaaaaaai
bcaabaaaabaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaadcaaaaak
bcaabaaaacaaaaaaakaabaaaabaaaaaaakiacaaaaaaaaaaaajaaaaaaakbabaaa
abaaaaaadcaaaaalecaabaaaacaaaaaaakaabaiaebaaaaaaabaaaaaaakiacaaa
aaaaaaaaajaaaaaaakbabaaaabaaaaaadgaaaaafkcaabaaaacaaaaaafgbfbaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaaabaaaaaakgikcaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaadoaaaaab"
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
}
Program "fp" {
SubProgram "opengl " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[9] = { program.local[0..8] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEMP R7;
TEMP R8;
TEMP R9;
TEMP R10;
TEX R10, fragment.texcoord[0], texture[0], 2D;
MOV R0.y, c[8];
MAD R9.y, R0, -c[1].x, fragment.texcoord[0];
MOV R9.x, fragment.texcoord[0];
MAD R8.y, R0, c[1].x, fragment.texcoord[0];
MOV R8.x, fragment.texcoord[0];
MAD R7.y, R0, -c[2].x, fragment.texcoord[0];
MOV R7.x, fragment.texcoord[0];
MAD R6.y, R0, c[2].x, fragment.texcoord[0];
MOV R6.x, fragment.texcoord[0];
MAD R5.y, R0, -c[3].x, fragment.texcoord[0];
MOV R5.x, fragment.texcoord[0];
MAD R4.y, R0, c[3].x, fragment.texcoord[0];
MOV R4.x, fragment.texcoord[0];
MAD R3.y, R0, -c[0], fragment.texcoord[0];
MOV R3.x, fragment.texcoord[0];
MAD R2.y, R0, c[0], fragment.texcoord[0];
MAD R1.y, R0, -c[1], fragment.texcoord[0];
MOV R2.x, fragment.texcoord[0];
MOV R1.x, fragment.texcoord[0];
MOV R0.x, fragment.texcoord[0];
MAD R0.y, R0, c[1], fragment.texcoord[0];
MUL R10, R10, c[4].x;
TEX R1, R1, texture[0], 2D;
TEX R0, R0, texture[0], 2D;
TEX R2, R2, texture[0], 2D;
TEX R3, R3, texture[0], 2D;
TEX R4, R4, texture[0], 2D;
TEX R5, R5, texture[0], 2D;
TEX R6, R6, texture[0], 2D;
TEX R7, R7, texture[0], 2D;
TEX R8, R8, texture[0], 2D;
TEX R9, R9, texture[0], 2D;
ADD R8, R8, R9;
ADD R0, R0, R1;
MAD R8, R8, c[5].x, R10;
ADD R6, R6, R7;
MAD R6, R6, c[6].x, R8;
ADD R4, R4, R5;
MAD R4, R4, c[7].x, R6;
ADD R2, R2, R3;
MAD R2, R2, c[4].y, R4;
MAD R2, R0, c[5].y, R2;
ADD R0.x, R2, c[2].y;
MAD R0.y, -R0.x, c[8], fragment.texcoord[0];
MAD R0.w, R0.x, c[8].y, fragment.texcoord[0].y;
MOV R0.x, fragment.texcoord[0];
MOV R0.z, fragment.texcoord[0].x;
TEX R1, R0, texture[0], 2D;
TEX R0, R0.zwzw, texture[0], 2D;
ADD R0, R0, R1;
MAD result.color, R0, c[6].y, R2;
END
# 52 instructions, 11 R-regs
"
}
SubProgram "d3d9 " {
Matrix 0 [_offsets]
Matrix 4 [_weights]
Vector 8 [_MainTex_TexelSize]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl t0.xy
mov_pp r0.x, c1
mad_pp r1.y, c8, -r0.x, t0
mov_pp r0.x, c1
mad_pp r0.y, c8, r0.x, t0
mov_pp r2.x, c2
mad_pp r2.y, c8, -r2.x, t0
mov_pp r3.x, c2
mad_pp r4.y, c8, r3.x, t0
mov_pp r3.x, c3
mad_pp r5.y, c8, -r3.x, t0
mov_pp r3.x, c3
mad_pp r6.y, c8, r3.x, t0
mov_pp r3.y, c0
mad_pp r7.y, c8, -r3, t0
mov_pp r3.y, c0
mad_pp r8.y, c8, r3, t0
mov_pp r3.y, c1
mad_pp r9.y, c8, -r3, t0
mov_pp r1.x, t0
mov_pp r4.x, t0
mov_pp r5.x, t0
mov_pp r6.x, t0
mov_pp r7.x, t0
mov_pp r8.x, t0
mov_pp r9.x, t0
mov_pp r3.y, c1
mov_pp r0.x, t0
mov_pp r2.x, t0
mov_pp r3.x, t0
mad_pp r3.y, c8, r3, t0
texld r10, r3, s0
texld r3, r2, s0
texld r2, r0, s0
texld r9, r9, s0
texld r8, r8, s0
texld r7, r7, s0
texld r6, r6, s0
texld r5, r5, s0
texld r4, r4, s0
texld r0, t0, s0
texld r1, r1, s0
add_pp r1, r2, r1
mul r0, r0, c4.x
mad_pp r0, r1, c5.x, r0
add_pp r1, r4, r3
mad_pp r0, r1, c6.x, r0
add_pp r1, r6, r5
mad_pp r0, r1, c7.x, r0
add_pp r1, r8, r7
mad_pp r0, r1, c4.y, r0
add_pp r1, r10, r9
mad_pp r2, r1, c5.y, r0
add_pp r0.x, r2, c2.y
mad_pp r1.y, r0.x, c8, t0
mad_pp r0.y, -r0.x, c8, t0
mov_pp r0.x, t0
mov_pp r1.x, t0
texld r0, r0, s0
texld r1, r1, s0
add_pp r0, r1, r0
mad_pp r0, r0, c6.y, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 176
Matrix 16 [_offsets]
Matrix 80 [_weights]
Vector 144 [_MainTex_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedddfakgnamnjgghoifhemehacnhbbfagpabaaaaaadeagaaaaadaaaaaa
cmaaaaaaieaaaaaaliaaaaaaejfdeheofaaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaeeaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcheafaaaa
eaaaaaaafnabaaaafjaaaaaeegiocaaaaaaaaaaaakaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhcaabaaa
abaaaaaajgihcaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaa
abaaaaaadgaaaaaficaabaaaabaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaa
acaaaaaadgapbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaajgihcaiaebaaaaaaaaaaaaaaabaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaaficaabaaaadaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaaeaaaaaadgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegaobaaaaeaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaafgifcaaaaaaaaaaaafaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegaobaaaaaaaaaaaagiacaaaaaaaaaaaafaaaaaa
egaobaaaacaaaaaaefaaaaajpcaabaaaacaaaaaahgapbaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaalgapbaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaaeaaaaaahgapbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaa
lgapbaaaadaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaa
egaobaaaacaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaa
acaaaaaakgikcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegaobaaaabaaaaaapgipcaaaaaaaaaaaafaaaaaaegaobaaaaaaaaaaa
dcaaaaaldcaabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaafgifcaaaaaaaaaaa
ajaaaaaafgbfbaaaabaaaaaadgaaaaafecaabaaaabaaaaaaakbabaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaacgakbaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaggakbaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamdcaabaaaadaaaaaaegiacaiaebaaaaaaaaaaaaaa
acaaaaaafgifcaaaaaaaaaaaajaaaaaafgbfbaaaabaaaaaadgaaaaafecaabaaa
adaaaaaaakbabaaaabaaaaaaefaaaaajpcaabaaaaeaaaaaacgakbaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaadaaaaaaggakbaaa
adaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaa
egaobaaaabaaaaaaegaobaaaadaaaaaaaaaaaaahpcaabaaaacaaaaaaegaobaaa
acaaaaaaegaobaaaaeaaaaaadcaaaaakpcaabaaaaaaaaaaaegaobaaaacaaaaaa
agiacaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egaobaaaabaaaaaafgifcaaaaaaaaaaaagaaaaaaegaobaaaaaaaaaaaaaaaaaai
bcaabaaaabaaaaaaakaabaaaaaaaaaaackiacaaaaaaaaaaaacaaaaaadcaaaaak
ccaabaaaacaaaaaaakaabaaaabaaaaaabkiacaaaaaaaaaaaajaaaaaabkbabaaa
abaaaaaadcaaaaalicaabaaaacaaaaaaakaabaiaebaaaaaaabaaaaaabkiacaaa
aaaaaaaaajaaaaaabkbabaaaabaaaaaadgaaaaaffcaabaaaacaaaaaaagbabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegaabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaacaaaaaaogakbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egaobaaaacaaaaaadcaaaaakpccabaaaaaaaaaaaegaobaaaabaaaaaakgikcaaa
aaaaaaaaagaaaaaaegaobaaaaaaaaaaadoaaaaab"
}
}
 }
}
Fallback Off
}