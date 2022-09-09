Shader "BlendModes/MeshBumpGlass/Framebuffer" {
Properties {
 _BumpAmt ("Distortion", Range(0,128)) = 10
 _MainTex ("Tint Color (RGB)", 2D) = "white" {}
 _BumpMap ("Normalmap", 2D) = "bump" {}
}
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Opaque" }
 Pass {
  Name "BASE"
  Tags { "LIGHTMODE"="Always" "QUEUE"="Transparent" "RenderType"="Opaque" }
Program "vp" {
SubProgram "opengl " {
Keywords { "BMDarken" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarken" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMDarken" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarken" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMMultiply" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMMultiply" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMMultiply" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMMultiply" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMColorBurn" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMColorBurn" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMColorBurn" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMColorBurn" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearBurn" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearBurn" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearBurn" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearBurn" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMDarkerColor" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarkerColor" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMDarkerColor" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarkerColor" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMLighten" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLighten" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMLighten" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMLighten" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMScreen" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMScreen" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMScreen" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMScreen" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMColorDodge" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMColorDodge" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMColorDodge" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMColorDodge" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearDodge" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearDodge" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearDodge" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearDodge" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMLighterColor" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLighterColor" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMLighterColor" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMLighterColor" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMOverlay" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMOverlay" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMOverlay" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMOverlay" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMSoftLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMSoftLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMSoftLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMSoftLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMHardLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMHardLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMHardLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMHardLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMVividLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMVividLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMVividLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMVividLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMPinLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMPinLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMPinLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMPinLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMHardMix" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMHardMix" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMHardMix" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMHardMix" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMDifference" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDifference" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMDifference" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMDifference" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMExclusion" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMExclusion" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMExclusion" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMExclusion" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMSubtract" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMSubtract" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMSubtract" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMSubtract" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMDivide" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_BumpMap_ST]
Vector 6 [_MainTex_ST]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[2];
DP4 R0.z, vertex.position, c[4];
DP4 R0.x, vertex.position, c[1];
MOV R1.w, R0.z;
DP4 R1.z, vertex.position, c[3];
MOV R1.x, R0;
MOV R0.y, R0.w;
MOV R1.y, R0.w;
ADD R0.xy, R0.z, R0;
MOV result.position, R1;
MOV result.texcoord[0].zw, R1;
MUL result.texcoord[0].xy, R0, c[0].x;
MAD result.texcoord[1].xy, vertex.texcoord[0], c[5], c[5].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[0], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDivide" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_BumpMap_ST]
Vector 5 [_MainTex_ST]
"vs_2_0
def c6, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c1
dp4 r0.z, v0, c3
dp4 r0.x, v0, c0
mov r1.w, r0.z
dp4 r1.z, v0, c2
mov r1.x, r0
mov r0.y, -r0.w
mov r1.y, r0.w
add r0.xy, r0.z, r0
mov oPos, r1
mov oT0.zw, r1
mul oT0.xy, r0, c6.x
mad oT1.xy, v1, c4, c4.zwzw
mad oT2.xy, v1, c5, c5.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMDivide" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedgdchbkkpeeckkblldadhffgkgkgapnplabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaiaaaaaaaaiabaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklfdeieefcpaabaaaaeaaaabaahmaaaaaafjaaaaaeegiocaaa
aaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaa
gfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaa
acaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaa
egiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
aaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaamdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaialpaaaaaaaaaaaaaaaa
pgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaakgaobaaaaaaaaaaadiaaaaak
dccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaa
acaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaalmccabaaaacaaaaaaagbebaaa
abaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaaaaaaaaaaadaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMDivide" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 64
Vector 32 [_BumpMap_ST]
Vector 48 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedpibfpbdheofpfbkopiogijocoaooicojabaaaaaaeiaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaamaadaaaaebgpgodjdmabaaaadmabaaaaaaacpopp
pmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
acaaabaaaaaaaaaaabaaaaaaaeaaadaaaaaaaaaaaaaaaaaaaaacpoppfbaaaaaf
ahaaapkaaaaaiadpaaaaialpaaaaaadpaaaaaaaabpaaaaacafaaaaiaaaaaapja
bpaaaaacafaaabiaabaaapjaafaaaaadaaaaapiaaaaaffjaaeaaoekaaeaaaaae
aaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaakkja
aaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeiaaeaaaaaeabaaadia
aaaaoeiaahaaoekaaaaappiaafaaaaadaaaaadoaabaaoeiaahaakkkaaeaaaaae
abaaadoaabaaoejaabaaoekaabaaookaaeaaaaaeabaaamoaabaabejaacaabeka
acaalekaaeaaaaaeaaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaamma
aaaaoeiaabaaaaacaaaaamoaaaaaoeiappppaaaafdeieefcpaabaaaaeaaaabaa
hmaaaaaafjaaaaaeegiocaaaaaaaaaaaaeaaaaaafjaaaaaeegiocaaaabaaaaaa
aeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadmccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaamdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaialpaaaaaaaaaaaaaaaapgapbaaaaaaaaaaadgaaaaafmccabaaaabaaaaaa
kgaobaaaaaaaaaaadiaaaaakdccabaaaabaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaaaaaaaaaaaadcaaaaaldccabaaaacaaaaaaegbabaaa
abaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadcaaaaal
mccabaaaacaaaaaaagbebaaaabaaaaaaagiecaaaaaaaaaaaadaaaaaakgiocaaa
aaaaaaaaadaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamadaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "BMDarken" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0, fragment.texcoord[2], texture[1], 2D;
MOV result.color.w, R0;
MIN result.color.xyz, R0, c[0].x;
END
# 3 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarken" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
def c0, 1.00000000, 0, 0, 0
dcl t2.xy
texld r0, t2, s1
min_pp r0.xyz, r0, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDarken" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedmdjmdephmjligfpfghgbgljefbmjcbpcabaaaaaajiabaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckiaaaaaaeaaaaaaackaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaddaaaaakhccabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarken" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedngmnekfbbaiehhehaehfdjmmhcaodaedabaaaaaaeiacaaaaaeaaaaaa
daaaaaaanmaaaaaaimabaaaabeacaaaaebgpgodjkeaaaaaakeaaaaaaaaacpppp
hmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkaabaaaaacaaaaadiaabaablla
ecaaaaadaaaacpiaaaaaoeiaaaaioekaakaaaaadabaachiaaaaaoeiaaaaaaaka
abaaaaacabaaciiaaaaappiaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefc
kiaaaaaaeaaaaaaackaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaddaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMMultiply" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
TEX result.color, fragment.texcoord[2], texture[1], 2D;
END
# 1 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMMultiply" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
dcl t2.xy
texld r0, t2, s1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedciakhggkfpbdfbllnplgapailkhlbnbhabaaaaaafeabaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcgeaaaaaaeaaaaaaabjaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaaefaaaaajpccabaaaaaaaaaaaogbkbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedjmpljbmihenicljgncjkikjcbdcihjgmabaaaaaanaabaaaaaeaaaaaa
daaaaaaakiaaaaaabeabaaaajmabaaaaebgpgodjhaaaaaaahaaaaaaaaaacpppp
eiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppbpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkaabaaaaac
aaaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcgeaaaaaaeaaaaaaabjaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaaefaaaaajpccabaaaaaaaaaaaogbkbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
amamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMColorBurn" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 1 } };
TEX result.color.w, fragment.texcoord[2], texture[1], 2D;
MOV result.color.xyz, c[0].x;
END
# 2 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMColorBurn" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
def c0, 1.00000000, 0, 0, 0
dcl t2.xy
texld r0, t2, s1
mov_pp r0.xyz, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedffpkpmfdbolbnjlhbelkeibhggbafocgabaaaaaajaabaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckaaaaaaaeaaaaaaaciaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedhnpljgaejedajmgdomjnhcdnhgpjpelgabaaaaaadaacaaaaaeaaaaaa
daaaaaaammaaaaaaheabaaaapmabaaaaebgpgodjjeaaaaaajeaaaaaaaaacpppp
gmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkaabaaaaacaaaaadiaabaablla
ecaaaaadaaaacpiaaaaaoeiaaaaioekaabaaaaacaaaachiaaaaaaakaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefckaaaaaaaeaaaaaaaciaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaa
aaaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
amamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearBurn" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
TEX result.color, fragment.texcoord[2], texture[1], 2D;
END
# 1 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearBurn" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
dcl t2.xy
texld r0, t2, s1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedciakhggkfpbdfbllnplgapailkhlbnbhabaaaaaafeabaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcgeaaaaaaeaaaaaaabjaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaaefaaaaajpccabaaaaaaaaaaaogbkbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedjmpljbmihenicljgncjkikjcbdcihjgmabaaaaaanaabaaaaaeaaaaaa
daaaaaaakiaaaaaabeabaaaajmabaaaaebgpgodjhaaaaaaahaaaaaaaaaacpppp
eiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppbpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkaabaaaaac
aaaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcgeaaaaaaeaaaaaaabjaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaaefaaaaajpccabaaaaaaaaaaaogbkbaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
amamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMDarkerColor" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 1, 0.29907227, 0.58691406, 0.11401367 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[2], texture[1], 2D;
MUL R1.x, R0.y, c[0].z;
MAD R1.x, R0, c[0].y, R1;
MAD R1.x, R0.z, c[0].w, R1;
ADD R1.x, -R1, c[0];
CMP result.color.xyz, R1.x, c[0].x, R0;
MOV result.color.w, R0;
END
# 7 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarkerColor" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
def c0, 0.58691406, 0.29907227, 0.11401367, 1.00000000
dcl t2.xy
texld r1, t2, s1
mul_pp r0.x, r1.y, c0
mad_pp r0.x, r1, c0.y, r0
mad_pp r0.x, r1.z, c0.z, r0
add_pp r0.x, -r0, c0.w
cmp_pp r0.xyz, r0.x, r1, c0.w
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecediadomfiddkfpbammlogmdheilnmokganabaaaaaaoeabaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcpeaaaaaaeaaaaaaadnaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabaaaaaakbcaabaaa
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
eefiecedmpfjohdobllkgohcemphmilhnlklnemgabaaaaaaneacaaaaaeaaaaaa
daaaaaaabmabaaaabiacaaaakaacaaaaebgpgodjoeaaaaaaoeaaaaaaaaacpppp
lmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkakcefbgdpihbgjjdonfhiojdnaaaaiadpbpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkaabaaaaacaaaaadiaabaablla
ecaaaaadaaaacpiaaaaaoeiaaaaioekaafaaaaadabaaciiaaaaaffiaaaaaaaka
aeaaaaaeabaacbiaaaaaaaiaaaaaffkaabaappiaaeaaaaaeabaacbiaaaaakkia
aaaakkkaabaaaaiaacaaaaadabaaabiaabaaaaibaaaappkafiaaaaaeaaaachia
abaaaaiaaaaaoeiaaaaappkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
peaaaaaaeaaaaaaadnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaabaaaaaakbcaabaaaabaaaaaaegacbaaaaaaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaadbaaaaahbcaabaaaabaaaaaa
abeaaaaaaaaaiadpakaabaaaabaaaaaadhaaaaamhccabaaaaaaaaaaaagaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
acaaaaaaamamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLighten" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0, fragment.texcoord[2], texture[1], 2D;
MOV result.color.w, R0;
MAX result.color.xyz, R0, c[0].x;
END
# 3 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLighten" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
def c0, 1.00000000, 0, 0, 0
dcl t2.xy
texld r0, t2, s1
max_pp r0.xyz, r0, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedndpaggopockhmmianfpmkdemcdmngopeabaaaaaajiabaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckiaaaaaaeaaaaaaackaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadeaaaaakhccabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecednhonlejhhfadfbibnhjglgdcgflaigdoabaaaaaaeiacaaaaaeaaaaaa
daaaaaaanmaaaaaaimabaaaabeacaaaaebgpgodjkeaaaaaakeaaaaaaaaacpppp
hmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkaabaaaaacaaaaadiaabaablla
ecaaaaadaaaacpiaaaaaoeiaaaaioekaalaaaaadabaachiaaaaaaakaaaaaoeia
abaaaaacabaaciiaaaaappiaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefc
kiaaaaaaeaaaaaaackaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadeaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMScreen" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 1 } };
TEX result.color.w, fragment.texcoord[2], texture[1], 2D;
MOV result.color.xyz, c[0].x;
END
# 2 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMScreen" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
def c0, 1.00000000, 0, 0, 0
dcl t2.xy
texld r0, t2, s1
mov_pp r0.xyz, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedffpkpmfdbolbnjlhbelkeibhggbafocgabaaaaaajaabaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckaaaaaaaeaaaaaaaciaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedhnpljgaejedajmgdomjnhcdnhgpjpelgabaaaaaadaacaaaaaeaaaaaa
daaaaaaammaaaaaaheabaaaapmabaaaaebgpgodjjeaaaaaajeaaaaaaaaacpppp
gmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkaabaaaaacaaaaadiaabaablla
ecaaaaadaaaacpiaaaaaoeiaaaaioekaabaaaaacaaaachiaaaaaaakaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefckaaaaaaaeaaaaaaaciaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaa
aaaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
amamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMColorDodge" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0.xyz, -R0, c[0].x;
MOV result.color.w, R0;
RCP result.color.x, R0.x;
RCP result.color.y, R0.y;
RCP result.color.z, R0.z;
END
# 6 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMColorDodge" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
def c0, 1.00000000, 0, 0, 0
dcl t2.xy
texld r0, t2, s1
add_pp r0.xyz, -r0, c0.x
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecednpmhandahneddjjadbaopmkakgldoeeiabaaaaaameabaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcneaaaaaaeaaaaaaadfaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaalhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaakhccabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedikeapgikcjbldkdbdjlfnaijpilblfapabaaaaaaimacaaaaaeaaaaaa
daaaaaaapeaaaaaanaabaaaafiacaaaaebgpgodjlmaaaaaalmaaaaaaaaacpppp
jeaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkaabaaaaacaaaaadiaabaablla
ecaaaaadaaaacpiaaaaaoeiaaaaioekaacaaaaadabaachiaaaaaoeibaaaaaaka
agaaaaacaaaacbiaabaaaaiaagaaaaacaaaacciaabaaffiaagaaaaacaaaaceia
abaakkiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcneaaaaaaeaaaaaaa
dfaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaaaoaaaaakhccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpegacbaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearDodge" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0, fragment.texcoord[2], texture[1], 2D;
MOV result.color.w, R0;
ADD result.color.xyz, R0, c[0].x;
END
# 3 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearDodge" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
def c0, 1.00000000, 0, 0, 0
dcl t2.xy
texld r0, t2, s1
add_pp r0.xyz, r0, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedpaolncffhahiehpmhbmhcaomnodlgccgabaaaaaaieabaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcjeaaaaaaeaaaaaaacfaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaakpccabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedfmpiomafbfjnobhkicajkgfbmbnmokgeabaaaaaaciacaaaaaeaaaaaa
daaaaaaanaaaaaaagmabaaaapeabaaaaebgpgodjjiaaaaaajiaaaaaaaaacpppp
haaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaiadpaaaaiadpaaaaaaaabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkaabaaaaacaaaaadiaabaablla
ecaaaaadaaaacpiaaaaaoeiaaaaioekaacaaaaadaaaacpiaaaaaoeiaaaaaoeka
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcjeaaaaaaeaaaaaaacfaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
mcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
aaaaaaakpccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLighterColor" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 1, 0.29907227, 0.58691406, 0.11401367 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[2], texture[1], 2D;
MUL R1.x, R0.y, c[0].z;
MAD R1.x, R0, c[0].y, R1;
MAD R1.x, R0.z, c[0].w, R1;
ADD R1.x, -R1, c[0];
CMP result.color.xyz, -R1.x, c[0].x, R0;
MOV result.color.w, R0;
END
# 7 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLighterColor" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
def c0, 0.58691406, 0.29907227, 0.11401367, 1.00000000
dcl t2.xy
texld r1, t2, s1
mul_pp r0.x, r1.y, c0
mad_pp r0.x, r1, c0.y, r0
mad_pp r0.x, r1.z, c0.z, r0
add_pp r0.x, -r0, c0.w
cmp_pp r0.xyz, -r0.x, r1, c0.w
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecediegpdcnghhigkpbbfcnkjoiagjamaolfabaaaaaaoeabaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcpeaaaaaaeaaaaaaadnaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaabaaaaaakbcaabaaa
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
eefiecedjpbmembkoimeaacackmbjghkjmmgjacbabaaaaaaneacaaaaaeaaaaaa
daaaaaaabmabaaaabiacaaaakaacaaaaebgpgodjoeaaaaaaoeaaaaaaaaacpppp
lmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkakcefbgdpihbgjjdonfhiojdnaaaaialpbpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkaabaaaaacaaaaadiaabaablla
ecaaaaadaaaacpiaaaaaoeiaaaaioekaafaaaaadabaaciiaaaaaffiaaaaaaaka
aeaaaaaeabaacbiaaaaaaaiaaaaaffkaabaappiaaeaaaaaeabaacbiaaaaakkia
aaaakkkaabaaaaiaacaaaaadabaaabiaabaaaaiaaaaappkafiaaaaaeaaaachia
abaaaaiaaaaaoeiaaaaappkbabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
peaaaaaaeaaaaaaadnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaabaaaaaakbcaabaaaabaaaaaaegacbaaaaaaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaamhccabaaaaaaaaaaaagaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
acaaaaaaamamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMOverlay" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 1 } };
TEX result.color.w, fragment.texcoord[2], texture[1], 2D;
MOV result.color.xyz, c[0].x;
END
# 2 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMOverlay" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
def c0, 1.00000000, 0, 0, 0
dcl t2.xy
texld r0, t2, s1
mov_pp r0.xyz, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedffpkpmfdbolbnjlhbelkeibhggbafocgabaaaaaajaabaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckaaaaaaaeaaaaaaaciaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedhnpljgaejedajmgdomjnhcdnhgpjpelgabaaaaaadaacaaaaaeaaaaaa
daaaaaaammaaaaaaheabaaaapmabaaaaebgpgodjjeaaaaaajeaaaaaaaaacpppp
gmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkaabaaaaacaaaaadiaabaablla
ecaaaaadaaaacpiaaaaaoeiaaaaioekaabaaaaacaaaachiaaaaaaakaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefckaaaaaaaeaaaaaaaciaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaa
aaaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
amamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMSoftLight" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 1 } };
TEX result.color.w, fragment.texcoord[2], texture[1], 2D;
MOV result.color.xyz, c[0].x;
END
# 2 instructions, 0 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMSoftLight" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
def c0, 1.00000000, 0, 0, 0
dcl t2.xy
texld r0, t2, s1
mov_pp r0.xyz, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedffpkpmfdbolbnjlhbelkeibhggbafocgabaaaaaajaabaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckaaaaaaaeaaaaaaaciaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedhnpljgaejedajmgdomjnhcdnhgpjpelgabaaaaaadaacaaaaaeaaaaaa
daaaaaaammaaaaaaheabaaaapmabaaaaebgpgodjjeaaaaaajeaaaaaaaaacpppp
gmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkaabaaaaacaaaaadiaabaablla
ecaaaaadaaaacpiaaaaaoeiaaaaioekaabaaaaacaaaachiaaaaaaakaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefckaaaaaaaeaaaaaaaciaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaa
aaaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
amamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMHardLight" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[2], texture[1], 2D;
MUL R1.xyz, R0, c[0].z;
ADD R0.xyz, R0, -c[0].x;
CMP result.color.xyz, -R0, c[0].y, R1;
MOV result.color.w, R0;
END
# 5 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMHardLight" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
def c0, 2.00000000, -0.50000000, 1.00000000, 0
dcl t2.xy
texld r0, t2, s1
mul_pp r1.xyz, r0, c0.x
add_pp r0.xyz, r0, c0.y
cmp_pp r0.xyz, -r0, r1, c0.z
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedgcibocafpobmnfabfhhnhagoaoodgfloabaaaaaaoeabaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcpeaaaaaaeaaaaaaadnaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadbaaaaakhcaabaaa
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
eefiecedjjfjgghbmhmhlleabnhgkaffmfacjnlfabaaaaaakmacaaaaaeaaaaaa
daaaaaaapeaaaaaapaabaaaahiacaaaaebgpgodjlmaaaaaalmaaaaaaaaacpppp
jeaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkaabaaaaacaaaaadiaabaablla
ecaaaaadaaaacpiaaaaaoeiaaaaioekaacaaaaadabaaahiaaaaaoeibaaaaaaka
acaaaaadacaachiaaaaaoeiaaaaaoeiafiaaaaaeaaaachiaabaaoeiaacaaoeia
aaaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcpeaaaaaaeaaaaaaa
dnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadbaaaaakhcaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaaegacbaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadhaaaaam
hccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMVividLight" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 0.5, 2, 1 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R1.xyz, R0, -c[0].x;
MAD R0.xyz, -R1, c[0].y, c[0].z;
RCP R0.x, R0.x;
RCP R0.z, R0.z;
RCP R0.y, R0.y;
CMP result.color.xyz, -R1, R0, c[0].z;
MOV result.color.w, R0;
END
# 8 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMVividLight" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
def c0, -0.50000000, 2.00000000, 1.00000000, 0
dcl t2.xy
texld r0, t2, s1
add_pp r1.xyz, r0, c0.x
mad_pp r0.xyz, -r1, c0.y, c0.z
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
eefiecedfckdmdjeaebnebionblhabhaelofpnojabaaaaaafiacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcgiabaaaaeaaaaaaafkaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaakhcaabaaa
abaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaa
dcaaaabahcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
aoaaaaakhcaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadp
egacbaaaabaaaaaadbaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadhaaaaamhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedndmbmbgapemoehbnfljhboomfgdcbjlhabaaaaaafiadaaaaaeaaaaaa
daaaaaaacmabaaaajmacaaaaceadaaaaebgpgodjpeaaaaaapeaaaaaaaaacpppp
mmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaeaaaaaiadpbpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkaabaaaaacaaaaadiaabaablla
ecaaaaadaaaacpiaaaaaoeiaaaaioekaacaaaaadabaaahiaaaaaoeibaaaaaaka
acaaaaadacaachiaaaaaoeiaaaaaffkaaeaaaaaeacaachiaacaaoeiaaaaakkkb
aaaappkaagaaaaacadaacbiaacaaaaiaagaaaaacadaacciaacaaffiaagaaaaac
adaaceiaacaakkiafiaaaaaeaaaachiaabaaoeiaaaaappkaadaaoeiaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcgiabaaaaeaaaaaaafkaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaak
hcaabaaaabaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalp
aaaaaaaadcaaaabahcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaaoaaaaakhcaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaiadpegacbaaaabaaaaaadbaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadhaaaaamhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheo
iaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadaaaaaaheaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaamamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearLight" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R1.xyz, R0, -c[0].x;
MUL R0.xyz, R0, c[0].z;
MAD R2.xyz, R1, c[0].z, c[0].y;
CMP result.color.xyz, -R1, R2, R0;
MOV result.color.w, R0;
END
# 6 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearLight" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
def c0, -0.50000000, 2.00000000, 1.00000000, 0
dcl t2.xy
texld r0, t2, s1
add_pp r1.xyz, r0, c0.x
mad_pp r2.xyz, r1, c0.y, c0.z
mul_pp r0.xyz, r0, c0.y
cmp_pp r0.xyz, -r1, r0, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedhkgpeapackpfbceakhfhpakfdfdmdigeabaaaaaadmacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcemabaaaaeaaaaaaafdaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaakhcaabaaa
abaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaa
dcaaaaaphcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaak
hcaabaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaa
aaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaa
egacbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedjgmcdgednkmlggdaibnjpaineihpmmifabaaaaaaciadaaaaaeaaaaaa
daaaaaaabiabaaaagmacaaaapeacaaaaebgpgodjoaaaaaaaoaaaaaaaaaacpppp
liaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaeaaaaaiadpbpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkaabaaaaacaaaaadiaabaablla
ecaaaaadaaaacpiaaaaaoeiaaaaioekaacaaaaadabaachiaaaaaoeiaaaaaffka
aeaaaaaeabaachiaabaaoeiaaaaakkkaaaaappkaacaaaaadacaaahiaaaaaoeib
aaaaaakaacaaaaadadaachiaaaaaoeiaaaaaoeiafiaaaaaeaaaachiaacaaoeia
adaaoeiaabaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcemabaaaa
eaaaaaaafdaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaaalpaaaaaalpaaaaaalpaaaaaaaadcaaaaaphcaabaaaabaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadbaaaaakhcaabaaaacaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaaegacbaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaa
egacbaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMPinLight" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[2], texture[1], 2D;
MUL R2.xyz, R0, c[0].z;
ADD R1.xyz, R0, -c[0].x;
MUL R0.xyz, R1, c[0].z;
MIN R2.xyz, R2, c[0].y;
MAX R0.xyz, R0, c[0].y;
CMP result.color.xyz, -R1, R0, R2;
MOV result.color.w, R0;
END
# 8 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMPinLight" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
def c0, -0.50000000, 2.00000000, 1.00000000, 0
dcl t2.xy
texld r0, t2, s1
add_pp r1.xyz, r0, c0.x
mul_pp r2.xyz, r1, c0.y
mul_pp r0.xyz, r0, c0.y
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
eefiecedgdgojkealipamojllnbdgjbglgpopnlkabaaaaaagmacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefchmabaaaaeaaaaaaafpaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaakhcaabaaa
abaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadeaaaaak
hcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
ddaaaaakhcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadbaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedlahgcdebjbjmhmnagefnpdgabfiaimdfabaaaaaaheadaaaaaeaaaaaa
daaaaaaadeabaaaaliacaaaaeaadaaaaebgpgodjpmaaaaaapmaaaaaaaaacpppp
neaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaiadpaaaaaaaabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkaabaaaaacaaaaadiaabaablla
ecaaaaadaaaacpiaaaaaoeiaaaaioekaacaaaaadabaachiaaaaaoeiaaaaaffka
acaaaaadabaachiaabaaoeiaabaaoeiaalaaaaadacaachiaaaaakkkaabaaoeia
acaaaaadabaachiaaaaaoeiaaaaaoeiaakaaaaadadaachiaabaaoeiaaaaakkka
acaaaaadabaaahiaaaaaoeibaaaaaakafiaaaaaeaaaachiaabaaoeiaadaaoeia
acaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefchmabaaaaeaaaaaaa
fpaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaaaaaaaaakhcaabaaaabaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaaalp
aaaaaalpaaaaaalpaaaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaadeaaaaakhcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaaddaaaaakhcaabaaaacaaaaaaegacbaaaacaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaakhcaabaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
acaaaaaaamamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMHardMix" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 1, 0 } };
TEMP R0;
TEX R0, fragment.texcoord[2], texture[1], 2D;
CMP R0.xyz, -R0, c[0].x, c[0].y;
MOV result.color.w, R0;
MOV result.color.xyz, R0;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMHardMix" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
def c0, 0.00000000, 1.00000000, 0, 0
dcl t2.xy
texld r0, t2, s1
cmp r0.xyz, -r0, c0.x, c0.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedfhomldimgnfhaeaebnfplbojojonbjhhabaaaaaamaabaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcnaaaaaaaeaaaaaaadeaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadbaaaaakhcaabaaa
aaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaabaaaaakhccabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedlgpbmmoobkdbfdiiebbbjbdccmnblafaabaaaaaagiacaaaaaeaaaaaa
daaaaaaaneaaaaaakmabaaaadeacaaaaebgpgodjjmaaaaaajmaaaaaaaaacpppp
heaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkaabaaaaacaaaaadiaabaablla
ecaaaaadaaaacpiaaaaaoeiaaaaioekafiaaaaaeaaaachiaaaaaoeibaaaaaaka
aaaaffkaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcnaaaaaaaeaaaaaaa
deaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
efaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadbaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
abaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMDifference" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0, fragment.texcoord[2], texture[1], 2D;
ADD R0.xyz, -R0, c[0].x;
MOV result.color.w, R0;
ABS result.color.xyz, R0;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDifference" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
def c0, 1.00000000, 0, 0, 0
dcl t2.xy
texld r0, t2, s1
add_pp r0.xyz, -r0, c0.x
abs_pp r0.xyz, r0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedbifnmcllfmnahcenbabpgkpfdbapmmkdabaaaaaaleabaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmeaaaaaaeaaaaaaadbaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaalhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaaghccabaaa
aaaaaaaaegacbaiaibaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedjpgnimpmpcblfehcnagaggohkdmjfmdfabaaaaaageacaaaaaeaaaaaa
daaaaaaanmaaaaaakiabaaaadaacaaaaebgpgodjkeaaaaaakeaaaaaaaaacpppp
hmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkaabaaaaacaaaaadiaabaablla
ecaaaaadaaaacpiaaaaaoeiaaaaioekaacaaaaadabaachiaaaaaoeibaaaaaaka
cdaaaaacaaaachiaabaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
meaaaaaaeaaaaaaadbaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaaaaaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadgaaaaaghccabaaaaaaaaaaaegacbaiaibaaaaaa
aaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadaaaaaa
heaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfagphdgjhe
gjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "BMExclusion" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 2, 1 } };
TEMP R0;
TEX R0, fragment.texcoord[2], texture[1], 2D;
MAD R0.xyz, -R0, c[0].x, R0;
MOV result.color.w, R0;
ADD result.color.xyz, R0, c[0].y;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMExclusion" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
def c0, 2.00000000, 1.00000000, 0, 0
dcl t2.xy
texld r0, t2, s1
mad_pp r0.xyz, -r0, c0.x, r0
add_pp r0.xyz, r0, c0.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedhdfbjopameidmnammglneaihikcefehkabaaaaaammabaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcnmaaaaaaeaaaaaaadhaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaakhcaabaaa
abaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
dcaaaaanhccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedepiecpogckdciippnbgchllmkbjdnbdfabaaaaaaieacaaaaaeaaaaaa
daaaaaaaoeaaaaaamiabaaaafaacaaaaebgpgodjkmaaaaaakmaaaaaaaaacpppp
ieaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaeaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkaabaaaaacaaaaadiaabaablla
ecaaaaadaaaacpiaaaaaoeiaaaaioekaacaaaaadabaachiaaaaaoeiaaaaaaaka
aeaaaaaeaaaachiaaaaaoeiaaaaaffkbabaaoeiaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcnmaaaaaaeaaaaaaadhaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaaaaaaakhcaabaaaabaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaan
hccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadaaaaaa
heaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfagphdgjhe
gjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "BMSubtract" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0, fragment.texcoord[2], texture[1], 2D;
MOV result.color.w, R0;
ADD result.color.xyz, -R0, c[0].x;
END
# 3 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMSubtract" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
def c0, 1.00000000, 0, 0, 0
dcl t2.xy
texld r0, t2, s1
add_pp r0.xyz, -r0, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedkpbmmhmjfkgmcmnebnodmdjbhljocnddabaaaaaajiabaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckiaaaaaaeaaaaaaackaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaappccabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaiadp
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedchllkfekgmncmkmbebnhaeniebiebnejabaaaaaageacaaaaaeaaaaaa
daaaaaaapiaaaaaakiabaaaadaacaaaaebgpgodjmaaaaaaamaaaaaaaaaacpppp
jiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaialpaaaaialpaaaaialpaaaaiadpfbaaaaaf
abaaapkaaaaaiadpaaaaiadpaaaaiadpaaaaaaaabpaaaaacaaaaaaiaabaaapla
bpaaaaacaaaaaajaaaaiapkaabaaaaacaaaaadiaabaabllaecaaaaadaaaacpia
aaaaoeiaaaaioekaabaaaaacabaaapiaaaaaoekaaeaaaaaeaaaacpiaaaaaoeia
abaaoeiaabaaoekaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefckiaaaaaa
eaaaaaaackaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
abaaaaaaefaaaaajpcaabaaaaaaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaappccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaiadpaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadaaaaaa
heaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfagphdgjhe
gjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "BMDivide" }
SetTexture 1 [_MainTex] 2D 1
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
TEMP R0;
TEX R0, fragment.texcoord[2], texture[1], 2D;
MOV result.color.w, R0;
RCP result.color.x, R0.x;
RCP result.color.y, R0.y;
RCP result.color.z, R0.z;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDivide" }
SetTexture 1 [_MainTex] 2D 1
"ps_2_0
dcl_2d s1
dcl t2.xy
texld r0, t2, s1
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedipmjdamcflgflnlhkihnlojplpijchjbabaaaaaajiabaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaaaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adaaaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefckiaaaaaaeaaaaaaackaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
ogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaoaaaaakhccabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedeofogepbimlkfkgbnbnnkppookkkglilabaaaaaadiacaaaaaeaaaaaa
daaaaaaammaaaaaahmabaaaaaeacaaaaebgpgodjjeaaaaaajeaaaaaaaaacpppp
gmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppbpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkaabaaaaac
aaaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaagaaaaacaaaacbia
aaaaaaiaagaaaaacaaaacciaaaaaffiaagaaaaacaaaaceiaaaaakkiaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefckiaaaaaaeaaaaaaackaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadmcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaa
aaaaaaaaogbkbaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaaaoaaaaak
hccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheo
iaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaaheaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadaaaaaaheaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaamamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Opaque" }
 Pass {
  Name "BASE"
  Tags { "QUEUE"="Transparent" "RenderType"="Opaque" }
  Blend DstColor Zero
  SetTexture [_MainTex] { combine texture }
 }
}
}