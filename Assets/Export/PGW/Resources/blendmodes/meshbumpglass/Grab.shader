Shader "BlendModes/MeshBumpGlass/Grab" {
Properties {
 _BumpAmt ("Distortion", Range(0,128)) = 10
 _MainTex ("Tint Color (RGB)", 2D) = "white" {}
 _BumpMap ("Normalmap", 2D) = "bump" {}
}
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Opaque" }
 GrabPass {
  Name "BASE"
  Tags { "LIGHTMODE"="Always" }
 }
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
ConstBuffer "$Globals" 80
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
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 2, 1 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].x, -c[2].y;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MOV R0.z, fragment.texcoord[0].w;
MAD R0.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
TXP R1.xyz, R0.xyzz, texture[1], 2D;
TEX R0, fragment.texcoord[2], texture[2], 2D;
MIN result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarken" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 2.00000000, -1.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mov r0.zw, t0
mad r0.xy, r0, t0.z, t0
texldp r1, r0, s1
texld r0, t2, s2
min_pp r0.xyz, r0, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDarken" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhfhdhcdjmpedkjbaknmojmkmhkmogmboabaaaaaapaacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcaaacaaaaeaaaaaaaiaaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaddaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarken" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedlddiiigfccbdpohkojlanehkmdfoeoflabaaaaaahmaeaaaaaeaaaaaa
daaaaaaaliabaaaamaadaaaaeiaeaaaaebgpgodjiaabaaaaiaabaaaaaaacpppp
diabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpia
abaaoelaabaioekaaeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaae
abaacciaaaaaffiaacaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaaka
afaaaaadaaaaadiaaaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakkla
aaaaoelaagaaaaacaaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeia
abaaaaacabaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaabaaoeiaacaioekaakaaaaadacaachiaabaaoeiaaaaaoeiaabaaaaac
acaaciiaabaappiaabaaaaacaaaicpiaacaaoeiappppaaaafdeieefcaaacaaaa
eaaaaaaaiaaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaa
aeaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaakgbkbaaaabaaaaaa
egbabaaaabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaapgbpbaaa
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaaddaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab
ejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMMultiply" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 2, 1 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].x, -c[2].y;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MOV R0.z, fragment.texcoord[0].w;
MAD R0.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
TXP R1.xyz, R0.xyzz, texture[1], 2D;
TEX R0, fragment.texcoord[2], texture[2], 2D;
MUL result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMMultiply" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 2.00000000, -1.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mov r0.zw, t0
mad r0.xy, r0, t0.z, t0
texldp r1, r0, s1
texld r0, t2, s2
mul_pp r0.xyz, r0, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMMultiply" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecednjiihfffakghnfklfeibfkifpigcmjjeabaaaaaapaacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcaaacaaaaeaaaaaaaiaaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadiaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMMultiply" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedgkpfkjhnkjmhcebneamcoeeaadifmjocabaaaaaahaaeaaaaaeaaaaaa
daaaaaaakmabaaaaleadaaaadmaeaaaaebgpgodjheabaaaaheabaaaaaaacpppp
cmabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpia
abaaoelaabaioekaaeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaae
abaacciaaaaaffiaacaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaaka
afaaaaadaaaaadiaaaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakkla
aaaaoelaagaaaaacaaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeia
abaaaaacabaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaabaaoeiaacaioekaafaaaaadabaachiaaaaaoeiaabaaoeiaabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefcaaacaaaaeaaaaaaaiaaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaap
dcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaa
aaaaaaaaegaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaa
aaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaa
aaaaaaaaegaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
diaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
amamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMColorBurn" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 1, 2 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].y, -c[2].x;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MAD R1.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
MOV R1.z, fragment.texcoord[0].w;
TEX R0, fragment.texcoord[2], texture[2], 2D;
TXP R1.xyz, R1.xyzz, texture[1], 2D;
RCP R0.x, R0.x;
RCP R0.y, R0.y;
RCP R0.z, R0.z;
ADD R1.xyz, -R1, c[2].x;
MAD result.color.xyz, -R1, R0, c[2].x;
MOV result.color.w, R0;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMColorBurn" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 2.00000000, -1.00000000, 1.00000000, 0
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mov r0.zw, t0
mad r0.xy, r0, t0.z, t0
texldp r1, r0, s1
texld r0, t2, s2
add_pp r1.xyz, -r1, c2.z
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mad_pp r0.xyz, -r1, r0, c2.z
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMColorBurn" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedplikjgbjlpefdaclnhfbocgallioiinmabaaaaaaeiadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfiacaaaaeaaaaaaajgaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaalhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaoaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaaaaaaaaalhccabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMColorBurn" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedpkceionmkbplkolplnodplpimlnihobiabaaaaaaaaafaaaaaeaaaaaa
daaaaaaaoeabaaaaeeaeaaaammaeaaaaebgpgodjkmabaaaakmabaaaaaaacpppp
geabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpaaaaiadpaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpia
abaaoelaabaioekaaeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaae
abaacciaaaaaffiaacaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaaka
afaaaaadaaaaadiaaaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakkla
aaaaoelaagaaaaacaaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeia
abaaaaacabaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaabaaoeiaacaioekaacaaaaadaaaachiaaaaaoeibacaakkkaagaaaaac
acaaabiaabaaaaiaagaaaaacacaaaciaabaaffiaagaaaaacacaaaeiaabaakkia
aeaaaaaeabaachiaaaaaoeiaacaaoeibacaakkkaabaaaaacaaaicpiaabaaoeia
ppppaaaafdeieefcfiacaaaaeaaaaaaajgaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaaaaaaaaa
hgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaa
aaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaa
aaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaa
aaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaalhcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaaoaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaaaaaaaaalhccabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
doaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfagphdgjhegjgpgoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "BMLinearBurn" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 2, 1 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].x, -c[2].y;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MOV R0.z, fragment.texcoord[0].w;
MAD R0.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
TXP R1.xyz, R0.xyzz, texture[1], 2D;
TEX R0, fragment.texcoord[2], texture[2], 2D;
ADD R0.xyz, R0, R1;
ADD result.color.xyz, R0, -c[2].y;
MOV result.color.w, R0;
END
# 11 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearBurn" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 2.00000000, -1.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mov r0.zw, t0
mad r0.xy, r0, t0.z, t0
texldp r1, r0, s1
texld r0, t2, s2
add_pp r0.xyz, r0, r1
add_pp r0.xyz, r0, c2.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearBurn" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedclkimbenihlnhpapbjhfpnaedafmideeabaaaaaabiadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcciacaaaaeaaaaaaaikaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaaaaaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearBurn" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedkikcflkfiolpfnnhnmepejohhcdheenbabaaaaaakiaeaaaaaeaaaaaa
daaaaaaalmabaaaaomadaaaaheaeaaaaebgpgodjieabaaaaieabaaaaaaacpppp
dmabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpia
abaaoelaabaioekaaeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaae
abaacciaaaaaffiaacaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaaka
afaaaaadaaaaadiaaaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakkla
aaaaoelaagaaaaacaaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeia
abaaaaacabaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaabaaoeiaacaioekaacaaaaadaaaachiaaaaaoeiaabaaoeiaacaaaaad
abaachiaaaaaoeiaacaaffkaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefc
ciacaaaaeaaaaaaaikaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
fibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaaaaaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaagiacaaa
aaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaa
aaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaakgbkbaaa
abaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
pgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaa
abaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaa
aaaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMDarkerColor" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[4] = { program.local[0..1],
		{ 0.29907227, 2, 1, 0.58691406 },
		{ 0.11401367 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].y, -c[2].z;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MAD R1.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
MOV R1.z, fragment.texcoord[0].w;
TEX R0, fragment.texcoord[2], texture[2], 2D;
TXP R1.xyz, R1.xyzz, texture[1], 2D;
MUL R2.x, R0.y, c[2].w;
MUL R1.w, R1.y, c[2];
MAD R2.x, R0, c[2], R2;
MAD R1.w, R1.x, c[2].x, R1;
MAD R2.x, R0.z, c[3], R2;
MAD R1.w, R1.z, c[3].x, R1;
ADD R1.w, R1, -R2.x;
CMP result.color.xyz, R1.w, R1, R0;
MOV result.color.w, R0;
END
# 17 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarkerColor" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 2.00000000, -1.00000000, 0.58691406, 0.29907227
def c3, 0.11401367, 0, 0, 0
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
texld r2, t2, s2
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mul_pp r1.x, r2.y, c2.z
mad_pp r1.x, r2, c2.w, r1
mad r0.xy, r0, t0.z, t0
mov r0.zw, t0
mad_pp r1.x, r2.z, c3, r1
texldp r3, r0, s1
mul_pp r0.x, r3.y, c2.z
mad_pp r0.x, r3, c2.w, r0
mad_pp r0.x, r3.z, c3, r0
add_pp r0.x, r0, -r1
cmp_pp r0.xyz, r0.x, r2, r3
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDarkerColor" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhonionfhpblofjdflleppooopidikdooabaaaaaageadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcheacaaaaeaaaaaaajnaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaabaaaaaakicaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaabaaaaaakbcaabaaaacaaaaaaegacbaaaabaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaadbaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaacaaaaaadhaaaaajhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarkerColor" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedembghgbeloidhikdhodapekacokofonbabaaaaaaiaafaaaaaeaaaaaa
daaaaaaaeiacaaaameaeaaaaemafaaaaebgpgodjbaacaaaabaacaaaaaaacpppp
miabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpkcefbgdpihbgjjdofbaaaaaf
adaaapkanfhiojdnaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpiaabaaoelaabaioeka
aeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaaeabaacciaaaaaffia
acaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaakaafaaaaadaaaaadia
aaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakklaaaaaoelaagaaaaac
aaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeiaabaaaaacabaaadia
abaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaadabaacpiaabaaoeia
acaioekaafaaaaadaaaaciiaaaaaffiaacaakkkaaeaaaaaeaaaaciiaaaaaaaia
acaappkaaaaappiaaeaaaaaeaaaaciiaaaaakkiaadaaaakaaaaappiaafaaaaad
acaaciiaabaaffiaacaakkkaaeaaaaaeacaacbiaabaaaaiaacaappkaacaappia
aeaaaaaeacaacbiaabaakkiaadaaaakaacaaaaiaacaaaaadaaaaaiiaaaaappia
acaaaaibfiaaaaaeabaachiaaaaappiaabaaoeiaaaaaoeiaabaaaaacaaaicpia
abaaoeiappppaaaafdeieefcheacaaaaeaaaaaaajnaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaabaaaaaakicaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaabaaaaaakbcaabaaaacaaaaaaegacbaaaabaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaadbaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaa
akaabaaaacaaaaaadhaaaaajhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaa
doaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfagphdgjhegjgpgoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "BMLighten" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 2, 1 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].x, -c[2].y;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MOV R0.z, fragment.texcoord[0].w;
MAD R0.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
TXP R1.xyz, R0.xyzz, texture[1], 2D;
TEX R0, fragment.texcoord[2], texture[2], 2D;
MAX result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLighten" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 2.00000000, -1.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mov r0.zw, t0
mad r0.xy, r0, t0.z, t0
texldp r1, r0, s1
texld r0, t2, s2
max_pp r0.xyz, r0, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLighten" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmhfdgecmoeaeojnngcicaooeeknojhekabaaaaaapaacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcaaacaaaaeaaaaaaaiaaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaadeaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLighten" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedpofnjieobfjgmecaomhdemjchmbdcoegabaaaaaahmaeaaaaaeaaaaaa
daaaaaaaliabaaaamaadaaaaeiaeaaaaebgpgodjiaabaaaaiaabaaaaaaacpppp
diabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpia
abaaoelaabaioekaaeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaae
abaacciaaaaaffiaacaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaaka
afaaaaadaaaaadiaaaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakkla
aaaaoelaagaaaaacaaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeia
abaaaaacabaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaabaaoeiaacaioekaalaaaaadacaachiaaaaaoeiaabaaoeiaabaaaaac
acaaciiaabaappiaabaaaaacaaaicpiaacaaoeiappppaaaafdeieefcaaacaaaa
eaaaaaaaiaaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaa
aeaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaakgbkbaaaabaaaaaa
egbabaaaabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaapgbpbaaa
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaadeaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab
ejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMScreen" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 1, 2 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].y, -c[2].x;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MAD R1.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
MOV R1.z, fragment.texcoord[0].w;
TEX R0, fragment.texcoord[2], texture[2], 2D;
TXP R1.xyz, R1.xyzz, texture[1], 2D;
ADD R0.xyz, -R0, c[2].x;
ADD R1.xyz, -R1, c[2].x;
MAD result.color.xyz, -R1, R0, c[2].x;
MOV result.color.w, R0;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMScreen" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 2.00000000, -1.00000000, 1.00000000, 0
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
texld r1, t2, s2
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mad r0.xy, r0, t0.z, t0
mov r0.zw, t0
add_pp r1.xyz, -r1, c2.z
texldp r0, r0, s1
add_pp r0.xyz, -r0, c2.z
mad_pp r0.xyz, -r0, r1, c2.z
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMScreen" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedifninbeghepiahgcfcamnlliblddiacjabaaaaaagaadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefchaacaaaaeaaaaaaajmaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaalhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaaaaaaalhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaanhccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMScreen" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefieceddmpmcieiigifnmdahocpjkfghhflnmcnabaaaaaaaeafaaaaaeaaaaaa
daaaaaaanaabaaaaeiaeaaaanaaeaaaaebgpgodjjiabaaaajiabaaaaaaacpppp
faabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpaaaaiadpaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpia
abaaoelaabaioekaaeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaae
abaacciaaaaaffiaacaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaaka
afaaaaadaaaaadiaaaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakkla
aaaaoelaagaaaaacaaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeia
abaaaaacabaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaabaaoeiaacaioekaacaaaaadaaaachiaaaaaoeibacaakkkaacaaaaad
acaachiaabaaoeibacaakkkaaeaaaaaeabaachiaaaaaoeiaacaaoeibacaakkka
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefchaacaaaaeaaaaaaajmaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
mcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaapdcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaai
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaai
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaaj
dcaabaaaaaaaaaaaegaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
aaaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaalhcaabaaaabaaaaaaegacbaia
ebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaanhccabaaaaaaaaaaaegacbaia
ebaaaaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
heaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfagphdgjhe
gjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "BMColorDodge" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 2, 1 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].x, -c[2].y;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MAD R1.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
MOV R1.z, fragment.texcoord[0].w;
TEX R0, fragment.texcoord[2], texture[2], 2D;
TXP R1.xyz, R1.xyzz, texture[1], 2D;
ADD R0.xyz, -R0, c[2].y;
RCP R0.x, R0.x;
RCP R0.z, R0.z;
RCP R0.y, R0.y;
MUL result.color.xyz, R1, R0;
MOV result.color.w, R0;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMColorDodge" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 2.00000000, -1.00000000, 1.00000000, 0
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mad r1.xy, r0, t0.z, t0
mov r1.zw, t0
texld r0, t2, s2
texldp r1, r1, s1
add_pp r0.xyz, -r0, c2.z
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp r0.xyz, r1, r0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMColorDodge" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedmkhkpimkbggdegiimkncccgjdmbphogpabaaaaaabmadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefccmacaaaaeaaaaaaailaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaal
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaaaoaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMColorDodge" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedkdgccnljlkijdepnnibdndpnphbigdlbabaaaaaanaaeaaaaaeaaaaaa
daaaaaaaoaabaaaabeaeaaaajmaeaaaaebgpgodjkiabaaaakiabaaaaaaacpppp
gaabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpaaaaiadpaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpia
abaaoelaabaioekaaeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaae
abaacciaaaaaffiaacaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaaka
afaaaaadaaaaadiaaaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakkla
aaaaoelaagaaaaacaaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeia
abaaaaacabaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaabaaoeiaacaioekaacaaaaadacaachiaabaaoeibacaakkkaagaaaaac
adaaabiaacaaaaiaagaaaaacadaaaciaacaaffiaagaaaaacadaaaeiaacaakkia
afaaaaadabaachiaaaaaoeiaadaaoeiaabaaaaacaaaicpiaabaaoeiappppaaaa
fdeieefccmacaaaaeaaaaaaailaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaa
acaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaa
agiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaa
egiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
kgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegaabaaa
aaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaa
acaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaalhcaabaaaabaaaaaa
egacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaaaoaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
amamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearDodge" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 2, 1 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].x, -c[2].y;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MOV R0.z, fragment.texcoord[0].w;
MAD R0.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
TXP R1.xyz, R0.xyzz, texture[1], 2D;
TEX R0, fragment.texcoord[2], texture[2], 2D;
ADD result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearDodge" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 2.00000000, -1.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mov r0.zw, t0
mad r0.xy, r0, t0.z, t0
texldp r1, r0, s1
texld r0, t2, s2
add_pp r0.xyz, r0, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearDodge" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedibdmcbfbglfbmjenmibppfgikmiembpfabaaaaaapaacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcaaacaaaaeaaaaaaaiaaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearDodge" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedlnbjkfenhpjmgamfpaofilkmeefijconabaaaaaahaaeaaaaaeaaaaaa
daaaaaaakmabaaaaleadaaaadmaeaaaaebgpgodjheabaaaaheabaaaaaaacpppp
cmabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpia
abaaoelaabaioekaaeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaae
abaacciaaaaaffiaacaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaaka
afaaaaadaaaaadiaaaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakkla
aaaaoelaagaaaaacaaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeia
abaaaaacabaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaabaaoeiaacaioekaacaaaaadabaachiaaaaaoeiaabaaoeiaabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefcaaacaaaaeaaaaaaaiaaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaap
dcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaa
aaaaaaaaegaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaa
aaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaa
aaaaaaaaegaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
amamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLighterColor" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[4] = { program.local[0..1],
		{ 0.29907227, 2, 1, 0.58691406 },
		{ 0.11401367 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].y, -c[2].z;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MAD R1.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
MOV R1.z, fragment.texcoord[0].w;
TEX R0, fragment.texcoord[2], texture[2], 2D;
TXP R1.xyz, R1.xyzz, texture[1], 2D;
MUL R2.x, R0.y, c[2].w;
MUL R1.w, R1.y, c[2];
MAD R2.x, R0, c[2], R2;
MAD R1.w, R1.x, c[2].x, R1;
MAD R2.x, R0.z, c[3], R2;
MAD R1.w, R1.z, c[3].x, R1;
ADD R1.w, R1, -R2.x;
CMP result.color.xyz, -R1.w, R1, R0;
MOV result.color.w, R0;
END
# 17 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLighterColor" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 2.00000000, -1.00000000, 0.58691406, 0.29907227
def c3, 0.11401367, 0, 0, 0
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
texld r2, t2, s2
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mul_pp r1.x, r2.y, c2.z
mad_pp r1.x, r2, c2.w, r1
mad r0.xy, r0, t0.z, t0
mov r0.zw, t0
mad_pp r1.x, r2.z, c3, r1
texldp r3, r0, s1
mul_pp r0.x, r3.y, c2.z
mad_pp r0.x, r3, c2.w, r0
mad_pp r0.x, r3.z, c3, r0
add_pp r0.x, r0, -r1
cmp_pp r0.xyz, -r0.x, r2, r3
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLighterColor" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedcbngbgpfjgheojaahlddidjacmomkbjdabaaaaaageadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcheacaaaaeaaaaaaajnaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaabaaaaaakicaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaabaaaaaakbcaabaaaacaaaaaaegacbaaaabaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaadbaaaaahicaabaaaaaaaaaaaakaabaaaacaaaaaa
dkaabaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLighterColor" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedpdpmapglkclifddhgmgonncnpjmokgggabaaaaaaiaafaaaaaeaaaaaa
daaaaaaaeiacaaaameaeaaaaemafaaaaebgpgodjbaacaaaabaacaaaaaaacpppp
miabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpkcefbgdpihbgjjdofbaaaaaf
adaaapkanfhiojdnaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpiaabaaoelaabaioeka
aeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaaeabaacciaaaaaffia
acaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaakaafaaaaadaaaaadia
aaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakklaaaaaoelaagaaaaac
aaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeiaabaaaaacabaaadia
abaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaadabaacpiaabaaoeia
acaioekaafaaaaadaaaaciiaaaaaffiaacaakkkaaeaaaaaeaaaaciiaaaaaaaia
acaappkaaaaappiaaeaaaaaeaaaaciiaaaaakkiaadaaaakaaaaappiaafaaaaad
acaaciiaabaaffiaacaakkkaaeaaaaaeacaacbiaabaaaaiaacaappkaacaappia
aeaaaaaeacaacbiaabaakkiaadaaaakaacaaaaiaacaaaaadaaaaaiiaaaaappib
acaaaaiafiaaaaaeabaachiaaaaappiaabaaoeiaaaaaoeiaabaaaaacaaaicpia
abaaoeiappppaaaafdeieefcheacaaaaeaaaaaaajnaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaabaaaaaakicaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaabaaaaaakbcaabaaaacaaaaaaegacbaaaabaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaadbaaaaahicaabaaaaaaaaaaaakaabaaaacaaaaaa
dkaabaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaa
doaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaaheaaaaaa
acaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfagphdgjhegjgpgoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "BMOverlay" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 1, 2, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].y, -c[2].x;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MAD R1.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
MOV R1.z, fragment.texcoord[0].w;
TEX R0, fragment.texcoord[2], texture[2], 2D;
TXP R1.xyz, R1.xyzz, texture[1], 2D;
ADD R3.xyz, -R0, c[2].x;
MUL R0.xyz, R0, R1;
ADD R2.xyz, -R1, c[2].x;
MUL R2.xyz, R2, R3;
MAD R2.xyz, -R2, c[2].y, c[2].x;
MUL R0.xyz, R0, c[2].y;
ADD R1.xyz, R1, -c[2].z;
CMP result.color.xyz, -R1, R2, R0;
MOV result.color.w, R0;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMOverlay" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 2.00000000, -1.00000000, 1.00000000, -0.50000000
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mov r0.zw, t0
mad r0.xy, r0, t0.z, t0
texldp r1, r0, s1
texld r0, t2, s2
mul_pp r2.xyz, r0, r1
add_pp r3.xyz, -r0, c2.z
add_pp r0.xyz, -r1, c2.z
mul_pp r0.xyz, r0, r3
mul_pp r2.xyz, r2, c2.x
mad_pp r0.xyz, -r0, c2.x, c2.z
add_pp r1.xyz, r1, c2.w
cmp_pp r0.xyz, -r1, r2, r0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMOverlay" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedgkhllcalllemjiappcmedlhcljkkogboabaaaaaaaaaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcbaadaaaaeaaaaaaameaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadbaaaaakhcaabaaa
abaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaaaaaaaaa
aaaaaaalhcaabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaaefaaaaajpcaabaaaadaaaaaaogbkbaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaaaaaaaaalhcaabaaaaeaaaaaaegacbaiaebaaaaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaanhcaabaaa
acaaaaaaegacbaiaebaaaaaaacaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaadaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaadaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadhaaaaajhccabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMOverlay" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedmkghjbkkmjjjlfclhcbookbmkjeigkebabaaaaaapiafaaaaaeaaaaaa
daaaaaaaceacaaaadmafaaaameafaaaaebgpgodjomabaaaaomabaaaaaaacpppp
keabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpaaaaaadpaaaaiadpbpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpia
abaaoelaabaioekaaeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaae
abaacciaaaaaffiaacaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaaka
afaaaaadaaaaadiaaaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakkla
aaaaoelaagaaaaacaaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeia
abaaaaacabaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaabaaoeiaacaioekaacaaaaadacaaahiaaaaaoeibacaakkkaacaaaaad
adaachiaaaaaoeibacaappkaacaaaaadadaachiaadaaoeiaadaaoeiaacaaaaad
aeaachiaabaaoeibacaappkaaeaaaaaeadaachiaadaaoeiaaeaaoeibacaappka
afaaaaadaaaachiaaaaaoeiaabaaoeiaacaaaaadaaaachiaaaaaoeiaaaaaoeia
fiaaaaaeabaachiaacaaoeiaaaaaoeiaadaaoeiaabaaaaacaaaicpiaabaaoeia
ppppaaaafdeieefcbaadaaaaeaaaaaaameaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaaaaaaaaa
hgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaa
aaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaa
aaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaa
aaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaadbaaaaakhcaabaaaabaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaaaaaaaaaaaaaaaal
hcaabaaaacaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaefaaaaajpcaabaaaadaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaaaaaaalhcaabaaaaeaaaaaaegacbaiaebaaaaaaadaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaanhcaabaaaacaaaaaa
egacbaiaebaaaaaaacaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
adaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaadaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheo
iaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaheaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaaheaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaamamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMSoftLight" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].y, -c[2].x;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MAD R1.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
MOV R1.z, fragment.texcoord[0].w;
TEX R0, fragment.texcoord[2], texture[2], 2D;
TXP R1.xyz, R1.xyzz, texture[1], 2D;
ADD R2.xyz, -R1, c[2].x;
ADD R3.xyz, -R0, c[2].x;
MAD R3.xyz, -R2, R3, c[2].x;
MUL R3.xyz, R1, R3;
MUL R1.xyz, R2, R1;
MAD result.color.xyz, R0, R1, R3;
MOV result.color.w, R0;
END
# 15 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMSoftLight" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 2.00000000, -1.00000000, 1.00000000, 0
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
texld r1, t2, s2
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mad r0.xy, r0, t0.z, t0
mov r0.zw, t0
add_pp r3.xyz, -r1, c2.z
texldp r0, r0, s1
add_pp r2.xyz, -r0, c2.z
mad_pp r3.xyz, -r2, r3, c2.z
mul_pp r3.xyz, r0, r3
mul_pp r0.xyz, r2, r0
mad_pp r0.xyz, r1, r0, r3
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMSoftLight" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhoeodlnnoomkgcfifiociklonkbdgimjabaaaaaalmadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmmacaaaaeaaaaaaaldaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaalhcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadiaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaadaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaaaaaaaalhcaabaaaaeaaaaaaegacbaiaebaaaaaaadaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaanhcaabaaaabaaaaaaegacbaia
ebaaaaaaabaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dcaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaadaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMSoftLight" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedimlhpdgpgfiicnbhahbfjclkakcefhheabaaaaaajeafaaaaaeaaaaaa
daaaaaaaaeacaaaaniaeaaaagaafaaaaebgpgodjmmabaaaammabaaaaaaacpppp
ieabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpaaaaiadpaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpia
abaaoelaabaioekaaeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaae
abaacciaaaaaffiaacaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaaka
afaaaaadaaaaadiaaaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakkla
aaaaoelaagaaaaacaaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeia
abaaaaacabaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaabaaoeiaacaioekaacaaaaadacaachiaaaaaoeibacaakkkaafaaaaad
adaachiaaaaaoeiaacaaoeiaacaaaaadaeaachiaabaaoeibacaakkkaaeaaaaae
acaachiaacaaoeiaaeaaoeibacaakkkaafaaaaadaaaachiaaaaaoeiaacaaoeia
aeaaaaaeabaachiaadaaoeiaabaaoeiaaaaaoeiaabaaaaacaaaicpiaabaaoeia
ppppaaaafdeieefcmmacaaaaeaaaaaaaldaaaaaafjaaaaaeegiocaaaaaaaaaaa
afaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaad
aagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacafaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaaaaaaaaaa
hgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaa
aaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaa
aaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaa
aaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaalhcaabaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
diaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaadaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaalhcaabaaaaeaaaaaaegacbaiaebaaaaaaadaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadcaaaaanhcaabaaaabaaaaaaegacbaiaebaaaaaa
abaaaaaaegacbaaaaeaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaadaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaadaaaaaadoaaaaabejfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
acaaaaaaamamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMHardLight" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[2], texture[2], 2D;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].z, -c[2].y;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MOV R0.z, fragment.texcoord[0].w;
MAD R0.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
MOV result.color.w, R1;
TXP R0.xyz, R0.xyzz, texture[1], 2D;
MUL R2.xyz, R1, R0;
ADD R1.xyz, R1, -c[2].x;
MUL R2.xyz, R2, c[2].z;
MAD R3.xyz, -R1, c[2].z, c[2].y;
ADD R0.xyz, -R0, c[2].y;
MAD R0.xyz, -R0, R3, c[2].y;
CMP result.color.xyz, -R1, R0, R2;
END
# 16 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMHardLight" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 2.00000000, -1.00000000, 1.00000000, -0.50000000
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
texld r1, t2, s2
mov r0.x, r0.w
add_pp r2.xyz, r1, c2.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mad r0.xy, r0, t0.z, t0
mov r0.zw, t0
mad_pp r3.xyz, -r2, c2.x, c2.z
texldp r0, r0, s1
mul_pp r1.xyz, r1, r0
add_pp r0.xyz, -r0, c2.z
mad_pp r0.xyz, -r0, r3, c2.z
mul_pp r1.xyz, r1, c2.x
cmp_pp r0.xyz, -r2, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMHardLight" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecednionibjbiemplgndiijnmhheeaeconhcabaaaaaacaaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcdaadaaaaeaaaaaaammaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaalhcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaaaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaaaceaaaaa
aaaaaalpaaaaaalpaaaaaalpaaaaaaaadcaaaabahcaabaaaadaaaaaaegacbaia
ebaaaaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaanhcaabaaaabaaaaaaegacbaia
ebaaaaaaabaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadbaaaaak
hcaabaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaa
acaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaacaaaaaadhaaaaajhccabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMHardLight" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedhpojbjgcdmbogebhibiojabfmblmmfnaabaaaaaabmagaaaaaeaaaaaa
daaaaaaaciacaaaagaafaaaaoiafaaaaebgpgodjpaabaaaapaabaaaaaaacpppp
kiabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpaaaaaadpaaaaiadpbpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpia
abaaoelaabaioekaaeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaae
abaacciaaaaaffiaacaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaaka
afaaaaadaaaaadiaaaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakkla
aaaaoelaagaaaaacaaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeia
abaaaaacabaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaabaaoeiaacaioekaacaaaaadacaachiaaaaaoeibacaappkaacaaaaad
adaachiaabaaoeiaacaakkkbaeaaaaaeadaachiaadaaoeiaacaaaakbacaappka
aeaaaaaeacaachiaacaaoeiaadaaoeibacaappkaafaaaaadaaaachiaaaaaoeia
abaaoeiaacaaaaadaaaachiaaaaaoeiaaaaaoeiaacaaaaadadaaahiaabaaoeib
acaakkkafiaaaaaeabaachiaadaaoeiaaaaaoeiaacaaoeiaabaaaaacaaaicpia
abaaoeiappppaaaafdeieefcdaadaaaaeaaaaaaammaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaalhcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaaaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaaaceaaaaa
aaaaaalpaaaaaalpaaaaaalpaaaaaaaadcaaaabahcaabaaaadaaaaaaegacbaia
ebaaaaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaanhcaabaaaabaaaaaaegacbaia
ebaaaaaaabaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadbaaaaak
hcaabaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaa
acaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaacaaaaaadhaaaaajhccabaaa
aaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaab
ejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMVividLight" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 0.5, 2, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1, fragment.texcoord[2], texture[2], 2D;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
ADD R2.xyz, R1, -c[2].x;
MUL R1.xyz, R1, c[2].y;
MAD R3.xyz, -R2, c[2].y, c[2].z;
MAD R0.xy, R0.wyzw, c[2].y, -c[2].z;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MAD R0.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
MOV R0.z, fragment.texcoord[0].w;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.z, R1.z;
RCP R3.x, R3.x;
RCP R3.z, R3.z;
RCP R3.y, R3.y;
MOV result.color.w, R1;
TXP R0.xyz, R0.xyzz, texture[1], 2D;
ADD R4.xyz, -R0, c[2].z;
MAD R1.xyz, -R4, R1, c[2].z;
MUL R0.xyz, R0, R3;
CMP result.color.xyz, -R2, R0, R1;
END
# 22 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMVividLight" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, -0.50000000, 2.00000000, -1.00000000, 1.00000000
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
texld r1, t2, s2
mov r0.x, r0.w
add_pp r2.xyz, r1, c2.x
mul_pp r1.xyz, r1, c2.y
mad_pp r3.xyz, -r2, c2.y, c2.w
mad_pp r0.xy, r0, c2.y, c2.z
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mad r0.xy, r0, t0.z, t0
mov r0.zw, t0
rcp_pp r3.x, r3.x
rcp_pp r3.z, r3.z
rcp_pp r3.y, r3.y
rcp_pp r1.x, r1.x
rcp_pp r1.z, r1.z
rcp_pp r1.y, r1.y
texldp r0, r0, s1
mul_pp r3.xyz, r0, r3
add_pp r0.xyz, -r0, c2.w
mad_pp r0.xyz, -r0, r1, c2.w
cmp_pp r0.xyz, -r2, r0, r3
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMVividLight" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefieceddgeknmhbnbocmcfcplapbknhppgjadhkabaaaaaadeaeaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefceeadaaaaeaaaaaaanbaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaalhcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaaoaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaa
aaaaaaalhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaaaaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaa
aceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaadcaaaabahcaabaaaadaaaaaa
egacbaiaebaaaaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaoaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaadaaaaaadbaaaaakhcaabaaaacaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaacaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMVividLight" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecediaimfhmeoiakfameajjladiebnbinlaeabaaaaaajaagaaaaaeaaaaaa
daaaaaaaiiacaaaaneafaaaafmagaaaaebgpgodjfaacaaaafaacaaaaaaacpppp
aiacaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpaaaaaadpaaaaaalpfbaaaaaf
adaaapkaaaaaaaeaaaaaiadpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaaja
abaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpiaabaaoelaabaioeka
aeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaaeabaacciaaaaaffia
acaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaakaafaaaaadaaaaadia
aaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakklaaaaaoelaagaaaaac
aaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeiaabaaaaacabaaadia
abaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaadabaacpiaabaaoeia
acaioekaacaaaaadacaachiaabaaoeiaacaappkaaeaaaaaeacaachiaacaaoeia
adaaaakbadaaffkaagaaaaacadaaabiaacaaaaiaagaaaaacadaaaciaacaaffia
agaaaaacadaaaeiaacaakkiaafaaaaadacaachiaaaaaoeiaadaaoeiaacaaaaad
aaaachiaaaaaoeibacaaffkbacaaaaadadaachiaabaaoeiaabaaoeiaagaaaaac
aeaaabiaadaaaaiaagaaaaacaeaaaciaadaaffiaagaaaaacaeaaaeiaadaakkia
aeaaaaaeaaaachiaaaaaoeiaaeaaoeibacaaffkbacaaaaadadaaahiaabaaoeib
acaakkkafiaaaaaeabaachiaadaaoeiaaaaaoeiaacaaoeiaabaaaaacaaaicpia
abaaoeiappppaaaafdeieefceeadaaaaeaaaaaaanbaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaalhcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaefaaaaajpcaabaaaacaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaaaoaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaadaaaaaa
aaaaaaalhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaaaaaaaakhcaabaaaadaaaaaaegacbaaaacaaaaaa
aceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaadcaaaabahcaabaaaadaaaaaa
egacbaiaebaaaaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaoaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaadaaaaaadbaaaaakhcaabaaaacaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaacaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaa
amamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearLight" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 0.5, 2, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].y, -c[2].z;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MOV R0.z, fragment.texcoord[0].w;
MAD R0.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
TXP R1.xyz, R0.xyzz, texture[1], 2D;
TEX R0, fragment.texcoord[2], texture[2], 2D;
MAD R2.xyz, R0, c[2].y, R1;
ADD R0.xyz, R0, -c[2].x;
ADD R2.xyz, R2, -c[2].z;
MAD R1.xyz, R0, c[2].y, R1;
CMP result.color.xyz, -R0, R1, R2;
MOV result.color.w, R0;
END
# 14 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearLight" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 2.00000000, -1.00000000, -0.50000000, 0
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mad r1.xy, r0, t0.z, t0
mov r1.zw, t0
texld r0, t2, s2
texldp r1, r1, s1
add_pp r2.xyz, r0, c2.z
mad_pp r0.xyz, r0, c2.x, r1
mad_pp r1.xyz, r2, c2.x, r1
add_pp r0.xyz, r0, c2.y
cmp_pp r0.xyz, -r2, r0, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearLight" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkmpojgafepecdcdibchcjjoacbehnopfabaaaaaanaadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcoaacaaaaeaaaaaaaliaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaak
hcaabaaaacaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalp
aaaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaadbaaaaakhcaabaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearLight" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedjkgccikeofkmjojdkpjjnaingjnneonaabaaaaaakmafaaaaaeaaaaaa
daaaaaaaaiacaaaapaaeaaaahiafaaaaebgpgodjnaabaaaanaabaaaaaaacpppp
iiabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpaaaaaadpaaaaaalpbpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpia
abaaoelaabaioekaaeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaae
abaacciaaaaaffiaacaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaaka
afaaaaadaaaaadiaaaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakkla
aaaaoelaagaaaaacaaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeia
abaaaaacabaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaabaaoeiaacaioekaacaaaaadacaachiaabaaoeiaacaappkaaeaaaaae
acaachiaacaaoeiaacaaaakaaaaaoeiaaeaaaaaeaaaachiaabaaoeiaacaaaaka
aaaaoeiaacaaaaadaaaachiaaaaaoeiaacaaffkaacaaaaadadaaahiaabaaoeib
acaakkkafiaaaaaeabaachiaadaaoeiaaaaaoeiaacaaoeiaabaaaaacaaaicpia
abaaoeiappppaaaafdeieefcoaacaaaaeaaaaaaaliaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaak
hcaabaaaacaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalp
aaaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaa
egacbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaa
aaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialp
aaaaialpaaaaialpaaaaaaaadbaaaaakhcaabaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaa
fdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMPinLight" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 0.5, 2, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].y, -c[2].z;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MAD R1.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
MOV R1.z, fragment.texcoord[0].w;
TEX R0, fragment.texcoord[2], texture[2], 2D;
TXP R1.xyz, R1.xyzz, texture[1], 2D;
MUL R3.xyz, R0, c[2].y;
ADD R2.xyz, R0, -c[2].x;
MUL R0.xyz, R2, c[2].y;
MIN R3.xyz, R1, R3;
MAX R0.xyz, R1, R0;
CMP result.color.xyz, -R2, R0, R3;
MOV result.color.w, R0;
END
# 15 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMPinLight" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 2.00000000, -1.00000000, -0.50000000, 0
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mad r1.xy, r0, t0.z, t0
mov r1.zw, t0
texld r0, t2, s2
texldp r1, r1, s1
add_pp r2.xyz, r0, c2.z
mul_pp r3.xyz, r2, c2.x
mul_pp r0.xyz, r0, c2.x
max_pp r3.xyz, r1, r3
min_pp r0.xyz, r1, r0
cmp_pp r0.xyz, -r2, r0, r3
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMPinLight" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbbimiipeienbhkipoihlacjpoacocndoabaaaaaaliadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcmiacaaaaeaaaaaaalcaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaak
hcaabaaaacaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalp
aaaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
deaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaah
hcaabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaddaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaadbaaaaakhcaabaaaabaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMPinLight" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedbcbhnncfjjjgckoeifnkfoihhplljolmabaaaaaajmafaaaaaeaaaaaa
daaaaaaabaacaaaaoaaeaaaagiafaaaaebgpgodjniabaaaaniabaaaaaaacpppp
jaabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpaaaaaadpaaaaaalpbpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpia
abaaoelaabaioekaaeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaae
abaacciaaaaaffiaacaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaaka
afaaaaadaaaaadiaaaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakkla
aaaaoelaagaaaaacaaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeia
abaaaaacabaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaabaaoeiaacaioekaacaaaaadacaachiaabaaoeiaacaappkaacaaaaad
acaachiaacaaoeiaacaaoeiaalaaaaadadaachiaaaaaoeiaacaaoeiaacaaaaad
acaachiaabaaoeiaabaaoeiaakaaaaadaeaachiaacaaoeiaaaaaoeiaacaaaaad
aaaaahiaabaaoeibacaakkkafiaaaaaeabaachiaaaaaoeiaaeaaoeiaadaaoeia
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefcmiacaaaaeaaaaaaalcaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
mcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaapdcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaai
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaai
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaaj
dcaabaaaaaaaaaaaegaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaaaaaaaakhcaabaaaacaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaalp
aaaaaalpaaaaaalpaaaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaa
egacbaaaacaaaaaadeaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
ddaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaadbaaaaak
hcaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadhaaaaajhccabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaab
ejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
heaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaaheaaaaaaacaaaaaa
aaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfagphdgjhegjgpgoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMHardMix" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 1, 2, 0 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].y, -c[2].x;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MOV R0.z, fragment.texcoord[0].w;
MAD R0.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
TXP R1.xyz, R0.xyzz, texture[1], 2D;
TEX R0, fragment.texcoord[2], texture[2], 2D;
ADD R1.xyz, -R1, c[2].x;
ADD R0.xyz, R0, -R1;
CMP R0.xyz, -R0, c[2].x, c[2].z;
MOV result.color.xyz, R0;
MOV result.color.w, R0;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMHardMix" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 2.00000000, -1.00000000, 1.00000000, 0.00000000
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mov r0.zw, t0
mad r0.xy, r0, t0.z, t0
texldp r1, r0, s1
texld r0, t2, s2
add_pp r1.xyz, -r1, c2.z
add_pp r0.xyz, r0, -r1
cmp r0.xyz, -r0, c2.w, c2.z
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMHardMix" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedkogpecdgedaaeeiphkcfhdlockmfbfbnabaaaaaaeeadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfeacaaaaeaaaaaaajfaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaaaaaaaalhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaa
aagabaaaacaaaaaadbaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaaabaaaaakhccabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMHardMix" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedaeacmdbcadafnhnddicigimekohffjieabaaaaaaoiaeaaaaaeaaaaaa
daaaaaaanaabaaaacmaeaaaaleaeaaaaebgpgodjjiabaaaajiabaaaaaaacpppp
faabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpaaaaiadpaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpia
abaaoelaabaioekaaeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaae
abaacciaaaaaffiaacaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaaka
afaaaaadaaaaadiaaaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakkla
aaaaoelaagaaaaacaaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeia
abaaaaacabaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaabaaoeiaacaioekaacaaaaadaaaachiaaaaaoeibacaakkkaacaaaaad
aaaaahiaabaaoeibaaaaoeiafiaaaaaeabaachiaaaaaoeiaacaappkaacaakkka
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefcfeacaaaaeaaaaaaajfaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
mcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaapdcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaai
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaai
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaaj
dcaabaaaaaaaaaaaegaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
aaaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaa
eghobaaaacaaaaaaaagabaaaacaaaaaadbaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaa
abaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMDifference" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 2, 1 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].x, -c[2].y;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MOV R0.z, fragment.texcoord[0].w;
MAD R0.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
TXP R1.xyz, R0.xyzz, texture[1], 2D;
TEX R0, fragment.texcoord[2], texture[2], 2D;
ADD R0.xyz, -R0, R1;
ABS result.color.xyz, R0;
MOV result.color.w, R0;
END
# 11 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDifference" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 2.00000000, -1.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mov r0.zw, t0
mad r0.xy, r0, t0.z, t0
texldp r1, r0, s1
texld r0, t2, s2
add_pp r0.xyz, -r0, r1
abs_pp r0.xyz, r0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDifference" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedifphnfhmpikicigcogclcomhikphddoaabaaaaaaamadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcbmacaaaaeaaaaaaaihaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaai
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadgaaaaaghccabaaaaaaaaaaaegacbaia
ibaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDifference" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefieceddfhcoflmnggegkjfignliegkdaheamdiabaaaaaajiaeaaaaaeaaaaaa
daaaaaaaliabaaaanmadaaaageaeaaaaebgpgodjiaabaaaaiaabaaaaaaacpppp
diabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpia
abaaoelaabaioekaaeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaae
abaacciaaaaaffiaacaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaaka
afaaaaadaaaaadiaaaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakkla
aaaaoelaagaaaaacaaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeia
abaaaaacabaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaabaaoeiaacaioekaacaaaaadaaaachiaaaaaoeiaabaaoeibcdaaaaac
abaachiaaaaaoeiaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcbmacaaaa
eaaaaaaaihaaaaaafjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaae
aahabaaaacaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadmcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaabaaaaaadcaaaaapdcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaa
aaaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaagiacaaaaaaaaaaa
abaaaaaadiaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaa
aeaaaaaadcaaaaajdcaabaaaaaaaaaaaegaabaaaaaaaaaaakgbkbaaaabaaaaaa
egbabaaaabaaaaaaaoaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaapgbpbaaa
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaa
acaaaaaaaagabaaaacaaaaaaaaaaaaaihcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaiaebaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaa
dgaaaaaghccabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaadoaaaaabejfdeheo
iaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaheaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaaheaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaamamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMExclusion" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 2, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].x, -c[2].y;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MOV R0.z, fragment.texcoord[0].w;
MAD R0.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
TXP R1.xyz, R0.xyzz, texture[1], 2D;
TEX R0, fragment.texcoord[2], texture[2], 2D;
ADD R2.xyz, R0, R1;
MUL R0.xyz, R0, R1;
MAD result.color.xyz, -R0, c[2].x, R2;
MOV result.color.w, R0;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMExclusion" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 2.00000000, -1.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mov r0.zw, t0
mad r0.xy, r0, t0.z, t0
texldp r1, r0, s1
texld r0, t2, s2
add_pp r2.xyz, r0, r1
mul_pp r0.xyz, r0, r1
mad_pp r0.xyz, -r0, c2.x, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMExclusion" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedeflddbenamhjbfpdkaklmbdafbkfogdiabaaaaaaeaadaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcfaacaaaaeaaaaaaajeaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadcaaaaanhccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaacaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMExclusion" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedmoapmapgdbflageakonbficmeaknmlpaabaaaaaaoeaeaaaaaeaaaaaa
daaaaaaanaabaaaaciaeaaaalaaeaaaaebgpgodjjiabaaaajiabaaaaaaacpppp
faabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpia
abaaoelaabaioekaaeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaae
abaacciaaaaaffiaacaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaaka
afaaaaadaaaaadiaaaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakkla
aaaaoelaagaaaaacaaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeia
abaaaaacabaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaabaaoeiaacaioekaacaaaaadacaachiaaaaaoeiaabaaoeiaafaaaaad
aaaachiaaaaaoeiaabaaoeiaaeaaaaaeabaachiaaaaaoeiaacaaaakbacaaoeia
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefcfaacaaaaeaaaaaaajeaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
mcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaapdcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaai
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaai
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaaj
dcaabaaaaaaaaaaaegaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaanhccabaaaaaaaaaaaegacbaia
ebaaaaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaa
acaaaaaadoaaaaabejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
heaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfagphdgjhe
gjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "BMSubtract" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 2, 1 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].x, -c[2].y;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MOV R0.z, fragment.texcoord[0].w;
MAD R0.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
TXP R1.xyz, R0.xyzz, texture[1], 2D;
TEX R0, fragment.texcoord[2], texture[2], 2D;
ADD result.color.xyz, -R0, R1;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMSubtract" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 2.00000000, -1.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mov r0.zw, t0
mad r0.xy, r0, t0.z, t0
texldp r1, r0, s1
texld r0, t2, s2
add_pp r0.xyz, -r0, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMSubtract" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefiecedeelighkdeddpgbpngokpnpbikallngckabaaaaaapeacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcaeacaaaaeaaaaaaaibaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaaaaaaai
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMSubtract" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefieceddmegobebdmdhjfelgkpjpahmjclpbfggabaaaaaaheaeaaaaaeaaaaaa
daaaaaaakmabaaaaliadaaaaeaaeaaaaebgpgodjheabaaaaheabaaaaaaacpppp
cmabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpia
abaaoelaabaioekaaeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaae
abaacciaaaaaffiaacaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaaka
afaaaaadaaaaadiaaaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakkla
aaaaoelaagaaaaacaaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeia
abaaaaacabaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaabaaoeiaacaioekaacaaaaadabaachiaaaaaoeiaabaaoeibabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefcaeacaaaaeaaaaaaaibaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaa
aaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaap
dcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaa
aaaaaaaaegaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaa
aaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaa
aaaaaaaaegaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaa
aaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaa
aaaaaaaihccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaabejfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
acaaaaaaamamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMDivide" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
PARAM c[3] = { program.local[0..1],
		{ 2, 1 } };
TEMP R0;
TEMP R1;
TEX R0.yw, fragment.texcoord[1], texture[0], 2D;
MAD R0.xy, R0.wyzw, c[2].x, -c[2].y;
MUL R0.xy, R0, c[0].x;
MUL R0.xy, R0, c[1];
MAD R1.xy, R0, fragment.texcoord[0].z, fragment.texcoord[0];
MOV R1.z, fragment.texcoord[0].w;
TEX R0, fragment.texcoord[2], texture[2], 2D;
TXP R1.xyz, R1.xyzz, texture[1], 2D;
RCP R0.x, R0.x;
RCP R0.z, R0.z;
RCP R0.y, R0.y;
MUL result.color.xyz, R1, R0;
MOV result.color.w, R0;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDivide" }
Float 0 [_BumpAmt]
Vector 1 [_GrabTexture_TexelSize]
SetTexture 0 [_BumpMap] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
SetTexture 2 [_MainTex] 2D 2
"ps_2_0
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c2, 2.00000000, -1.00000000, 0, 0
dcl t0
dcl t1.xy
dcl t2.xy
texld r0, t1, s0
mov r0.x, r0.w
mad_pp r0.xy, r0, c2.x, c2.y
mul r0.xy, r0, c0.x
mul r0.xy, r0, c1
mad r1.xy, r0, t0.z, t0
mov r1.zw, t0
texld r0, t2, s2
texldp r1, r1, s1
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mul_pp r0.xyz, r1, r0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDivide" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0
eefieceddfaobfdhiaihfckedimhagbihdlfkfboabaaaaaapaacaaaaadaaaaaa
cmaaaaaaleaaaaaaoiaaaaaaejfdeheoiaaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaafdfgfpfa
gphdgjhegjgpgoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklklfdeieefcaaacaaaaeaaaaaaaiaaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaadcaaaaapdcaabaaa
aaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaaidcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaajdcaabaaaaaaaaaaa
egaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaaacaaaaaaaoaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDivide" }
SetTexture 0 [_BumpMap] 2D 1
SetTexture 1 [_GrabTexture] 2D 0
SetTexture 2 [_MainTex] 2D 2
ConstBuffer "$Globals" 80
Float 16 [_BumpAmt]
Vector 64 [_GrabTexture_TexelSize]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedndimkbklgadajkeeghagkjmaekidjpeiabaaaaaajeaeaaaaaeaaaaaa
daaaaaaanaabaaaaniadaaaagaaeaaaaebgpgodjjiabaaaajiabaaaaaaacpppp
faabaaaaeiaaaaaaacaadaaaaaaaeiaaaaaaeiaaadaaceaaaaaaeiaaabaaaaaa
aaababaaacacacaaaaaaabaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaa
aaacppppfbaaaaafacaaapkaaaaaaaeaaaaaialpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaajaaaaiapka
bpaaaaacaaaaaajaabaiapkabpaaaaacaaaaaajaacaiapkaecaaaaadaaaacpia
abaaoelaabaioekaaeaaaaaeabaacbiaaaaappiaacaaaakaacaaffkaaeaaaaae
abaacciaaaaaffiaacaaaakaacaaffkaafaaaaadaaaaadiaabaaoeiaaaaaaaka
afaaaaadaaaaadiaaaaaoeiaabaaoekaaeaaaaaeaaaaadiaaaaaoeiaaaaakkla
aaaaoelaagaaaaacaaaaaeiaaaaapplaafaaaaadaaaaadiaaaaakkiaaaaaoeia
abaaaaacabaaadiaabaabllaecaaaaadaaaacpiaaaaaoeiaaaaioekaecaaaaad
abaacpiaabaaoeiaacaioekaagaaaaacacaaabiaabaaaaiaagaaaaacacaaacia
abaaffiaagaaaaacacaaaeiaabaakkiaafaaaaadabaachiaaaaaoeiaacaaoeia
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefcaaacaaaaeaaaaaaaiaaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafkaaaaadaagabaaaacaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaafibiaaaeaahabaaaacaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
mcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaabaaaaaa
dcaaaaapdcaabaaaaaaaaaaahgapbaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaaaaaaaaaaaaadiaaaaai
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaagiacaaaaaaaaaaaabaaaaaadiaaaaai
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaaeaaaaaadcaaaaaj
dcaabaaaaaaaaaaaegaabaaaaaaaaaaakgbkbaaaabaaaaaaegbabaaaabaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaapgbpbaaaabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaogbkbaaaacaaaaaaeghobaaaacaaaaaaaagabaaa
acaaaaaaaoaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaabejfdeheoiaaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaaheaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaaheaaaaaaacaaaaaaaaaaaaaaadaaaaaa
acaaaaaaamamaaaafdfgfpfagphdgjhegjgpgoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
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