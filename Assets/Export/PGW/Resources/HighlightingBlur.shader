Shader "Hidden/Highlighted/Blur" {
Properties {
 _MainTex ("", 2D) = "" {}
 _Intensity ("", Range(0.25,0.5)) = 0.3
}
SubShader { 
 Pass {
  ZTest Always
  ZWrite Off
  Cull Off
  Fog { Mode Off }
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_TexelSize]
Float 6 [_OffsetScale]
"!!ARBvp1.0
PARAM c[7] = { program.local[0],
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
MOV R0.z, c[6].x;
MAD R0.xy, R0.z, -c[5], vertex.texcoord[0];
MAD R0.zw, R0.z, c[5].xyxy, vertex.texcoord[0].xyxy;
MOV result.texcoord[0].xy, R0;
MOV result.texcoord[1].y, R0;
MOV result.texcoord[1].x, R0.z;
MOV result.texcoord[2].xy, R0.zwzw;
MOV result.texcoord[3].y, R0.w;
MOV result.texcoord[3].x, R0;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 13 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_TexelSize]
Float 5 [_OffsetScale]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
mov r0.xy, c4
mad r0.zw, c5.x, -r0.xyxy, v1.xyxy
mov r0.xy, c4
mad r0.xy, c5.x, r0, v1
mov oT0.xy, r0.zwzw
mov oT1.y, r0.w
mov oT1.x, r0
mov oT2.xy, r0
mov oT3.y, r0
mov oT3.x, r0.z
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
Float 32 [_OffsetScale]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedcgkpgccmcajgcdeeagildecphhcpfgpoabaaaaaapiacaaaaadaaaaaa
cmaaaaaaiaaaaaaacaabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
imaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaimaaaaaaacaaaaaa
aaaaaaaaadaaaaaaadaaaaaaadamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaa
aeaaaaaaadamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl
fdeieefcnaabaaaaeaaaabaaheaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
dcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaaddccabaaa
abaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaaddccabaaaadaaaaaagfaaaaad
dccabaaaaeaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaammcaabaaaaaaaaaaaagiecaiaebaaaaaaaaaaaaaa
abaaaaaaagiacaaaaaaaaaaaacaaaaaaagbebaaaabaaaaaadgaaaaafdccabaaa
abaaaaaaogakbaaaaaaaaaaadcaaaaaldcaabaaaaaaaaaaaegiacaaaaaaaaaaa
abaaaaaaagiacaaaaaaaaaaaacaaaaaaegbabaaaabaaaaaadgaaaaafdccabaaa
acaaaaaamgaabaaaaaaaaaaadgaaaaafdccabaaaaeaaaaaaggakbaaaaaaaaaaa
dgaaaaafdccabaaaadaaaaaaegaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 16 [_MainTex_TexelSize]
Float 32 [_OffsetScale]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefieceddnhmmbgdilkeckcbijaicndfplfekbdkabaaaaaadeaeaaaaaeaaaaaa
daaaaaaagiabaaaaeaadaaaajeadaaaaebgpgodjdaabaaaadaabaaaaaaacpopp
paaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
aeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacaaaaadiaabaaoekaaeaaaaaeabaaamiaaaaaeeiaacaaaakbabaaeeja
abaaaaacaaaaadoaabaaooiaaeaaaaaeabaaadiaaaaaoeiaacaaaakaabaaoeja
abaaaaacabaaadoaabaaomiaabaaaaacadaaadoaabaaogiaabaaaaacacaaadoa
abaaoeiappppaaaafdeieefcnaabaaaaeaaaabaaheaaaaaafjaaaaaeegiocaaa
aaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaaddccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaaddccabaaa
adaaaaaagfaaaaaddccabaaaaeaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaammcaabaaaaaaaaaaaagiecaia
ebaaaaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaacaaaaaaagbebaaaabaaaaaa
dgaaaaafdccabaaaabaaaaaaogakbaaaaaaaaaaadcaaaaaldcaabaaaaaaaaaaa
egiacaaaaaaaaaaaabaaaaaaagiacaaaaaaaaaaaacaaaaaaegbabaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaamgaabaaaaaaaaaaadgaaaaafdccabaaaaeaaaaaa
ggakbaaaaaaaaaaadgaaaaafdccabaaaadaaaaaaegaabaaaaaaaaaaadoaaaaab
ejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
faepfdejfeejepeoaafeeffiedepepfceeaaklklepfdeheojiaaaaaaafaaaaaa
aiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaaimaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaa
adamaaaaimaaaaaaadaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Float 0 [_Intensity]
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
MAX R0.xyz, R0, R1;
ADD R0.w, R0, R1;
MAX R0.xyz, R2, R0;
ADD R0.w, R0, R2;
ADD R0.w, R0, R3;
MAX result.color.xyz, R3, R0;
MUL result.color.w, R0, c[0].x;
END
# 11 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Float 0 [_Intensity]
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
max_pp r2.xyz, r3, r2
max_pp r2.xyz, r1, r2
add_pp r1.x, r3.w, r2.w
add_pp r1.x, r1, r1.w
add_pp r1.x, r1, r0.w
max_pp r0.xyz, r0, r2
mul_pp r0.w, r1.x, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 36 [_Intensity]
BindCB  "$Globals" 0
"ps_4_0
eefieceddmfloiadeinehiabanclaefodbmfkaklabaaaaaanmacaaaaadaaaaaa
cmaaaaaammaaaaaaaaabaaaaejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaimaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaa
adaaaaaaaaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
fdeieefcneabaaaaeaaaaaaahfaaaaaafjaaaaaeegiocaaaaaaaaaaaadaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaaddcbabaaaadaaaaaa
gcbaaaaddcbabaaaaeaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaa
abaaaaaadeaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaa
deaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkaabaaaabaaaaaadeaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaaiiccabaaa
aaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 48
Float 36 [_Intensity]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedggkblppdfblhflaecpbnfpmndplabnihabaaaaaabmaeaaaaaeaaaaaa
daaaaaaagmabaaaaeiadaaaaoiadaaaaebgpgodjdeabaaaadeabaaaaaaacpppp
aaabaaaadeaaaaaaabaaciaaaaaadeaaaaaadeaaabaaceaaaaaadeaaaaaaaaaa
aaaaacaaabaaaaaaaaaaaaaaaaacppppbpaaaaacaaaaaaiaaaaacdlabpaaaaac
aaaaaaiaabaacdlabpaaaaacaaaaaaiaacaacdlabpaaaaacaaaaaaiaadaacdla
bpaaaaacaaaaaajaaaaiapkaecaaaaadaaaacpiaaaaaoelaaaaioekaecaaaaad
abaacpiaabaaoelaaaaioekaecaaaaadacaacpiaacaaoelaaaaioekaecaaaaad
adaacpiaadaaoelaaaaioekaacaaaaadaaaaciiaaaaappiaabaappiaalaaaaad
aeaachiaaaaaoeiaabaaoeiaacaaaaadacaaciiaacaappiaaaaappiaalaaaaad
aaaachiaaeaaoeiaacaaoeiaacaaaaadaaaaciiaadaappiaacaappiaalaaaaad
abaachiaaaaaoeiaadaaoeiaafaaaaadabaaciiaaaaappiaaaaaffkaabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefcneabaaaaeaaaaaaahfaaaaaafjaaaaae
egiocaaaaaaaaaaaadaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaaddcbabaaaadaaaaaagcbaaaaddcbabaaaaeaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaadkaabaaaabaaaaaadeaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaadaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaa
aaaaaaaadkaabaaaabaaaaaadeaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaaeaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
dkaabaaaabaaaaaadeaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadiaaaaaiiccabaaaaaaaaaaadkaabaaaaaaaaaaabkiacaaaaaaaaaaa
acaaaaaadoaaaaabejfdeheojiaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaaimaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
imaaaaaaacaaaaaaaaaaaaaaadaaaaaaadaaaaaaadadaaaaimaaaaaaadaaaaaa
aaaaaaaaadaaaaaaaeaaaaaaadadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}