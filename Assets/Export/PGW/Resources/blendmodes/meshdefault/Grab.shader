Shader "BlendModes/MeshDefault/Grab" {
Properties {
 _Color ("Tint Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB)", 2D) = "white" {}
}
SubShader { 
 Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
 GrabPass {
 }
 Pass {
  Tags { "QUEUE"="Transparent" "RenderType"="Transparent" }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
Keywords { "BMDarken" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarken" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMDarken" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarken" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMMultiply" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMMultiply" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMMultiply" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMMultiply" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMColorBurn" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMColorBurn" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMColorBurn" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMColorBurn" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearBurn" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearBurn" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearBurn" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearBurn" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMDarkerColor" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarkerColor" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMDarkerColor" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarkerColor" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMLighten" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLighten" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMLighten" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLighten" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMScreen" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMScreen" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMScreen" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMScreen" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMColorDodge" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMColorDodge" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMColorDodge" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMColorDodge" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearDodge" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearDodge" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearDodge" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearDodge" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMLighterColor" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLighterColor" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMLighterColor" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLighterColor" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMOverlay" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMOverlay" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMOverlay" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMOverlay" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMSoftLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMSoftLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMSoftLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMSoftLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMHardLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMHardLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMHardLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMHardLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMVividLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMVividLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMVividLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMVividLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMPinLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMPinLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMPinLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMPinLight" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMHardMix" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMHardMix" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMHardMix" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMHardMix" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMDifference" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDifference" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMDifference" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDifference" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMExclusion" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMExclusion" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMExclusion" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMExclusion" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMSubtract" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMSubtract" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMSubtract" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMSubtract" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
SubProgram "opengl " {
Keywords { "BMDivide" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Vector 5 [_MainTex_ST]
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
MOV result.texcoord[1], R0;
MAD result.texcoord[0].xy, vertex.texcoord[0], c[5], c[5].zwzw;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDivide" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_MainTex_ST]
"vs_2_0
dcl_position0 v0
dcl_texcoord0 v1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mov oT1, r0
mad oT0.xy, v1, c4, c4.zwzw
"
}
SubProgram "d3d11 " {
Keywords { "BMDivide" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedapffedefiookpcncdinkgmcfjmdnjkhpabaaaaaafiacaaaaadaaaaaa
cmaaaaaaiaaaaaaapaaaaaaaejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklfdeieefcgaabaaaaeaaaabaafiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaadaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaa
aaaaaaaaabaaaaaagfaaaaaddccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaa
egaobaaaaaaaaaaadcaaaaaldccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaa
aaaaaaaaacaaaaaaogikcaaaaaaaaaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDivide" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 48
Vector 32 [_MainTex_ST]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedapdbblfdnalihglnekpmnekoaibhjghbabaaaaaafaadaaaaaeaaaaaa
daaaaaaaceabaaaaimacaaaaoaacaaaaebgpgodjomaaaaaaomaaaaaaaaacpopp
kmaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaacaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjaaeaaaaaeaaaaadoaabaaoeja
abaaoekaabaaookaafaaaaadaaaaapiaaaaaffjaadaaoekaaeaaaaaeaaaaapia
acaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacabaaapoaaaaaoeia
ppppaaaafdeieefcgaabaaaaeaaaabaafiaaaaaafjaaaaaeegiocaaaaaaaaaaa
adaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaa
fpaaaaaddcbabaaaabaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
dccabaaaabaaaaaagfaaaaadpccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaa
egaobaaaaaaaaaaadgaaaaafpccabaaaacaaaaaaegaobaaaaaaaaaaadcaaaaal
dccabaaaabaaaaaaegbabaaaabaaaaaaegiacaaaaaaaaaaaacaaaaaaogikcaaa
aaaaaaaaacaaaaaadoaaaaabejfdeheoemaaaaaaacaaaaaaaiaaaaaadiaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaaebaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafaepfdejfeejepeoaafeeffiedepepfceeaaklkl
epfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadamaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapaaaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklkl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "BMDarken" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[1].x;
MAD R0.x, fragment.texcoord[1], R0, c[1];
MUL R1.y, R0, c[1];
MUL R1.x, R0, c[1].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, c[0];
MIN result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarken" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, 1.00000000, 0.50000000, 0, 0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c1
mad r0.y, -r1.x, c1, c1.x
mad r0.x, t1, r0, c1
mul r0.x, r0, c1.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, c0
min_pp r0.xyz, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDarken" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedcdopmnecfgdniiikhkndfpplgbcamphkabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckaabaaaaeaaaaaaagiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaa
abaaaaaaddaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarken" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedihaiooimhdachekhliijgmjpgjldehmfabaaaaaajeadaaaaaeaaaaaa
daaaaaaaeiabaaaapaacaaaagaadaaaaebgpgodjbaabaaaabaabaaaaaaacpppp
niaaaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadp
aaaaaalpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadia
aaaaoeiaabaaoekaabaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaaaaaoelaaaaioekaafaaaaadabaacpiaabaaoeiaaaaaoekaakaaaaad
acaachiaabaaoeiaaaaaoeiaabaaaaacacaaciiaabaappiaabaaaaacaaaicpia
acaaoeiappppaaaafdeieefckaabaaaaeaaaaaaagiaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaa
pgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaaddaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMMultiply" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[1].x;
MAD R0.x, fragment.texcoord[1], R0, c[1];
MUL R1.y, R0, c[1];
MUL R1.x, R0, c[1].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, c[0];
MUL result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMMultiply" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, 1.00000000, 0.50000000, 0, 0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c1
mad r0.y, -r1.x, c1, c1.x
mad r0.x, t1, r0, c1
mul r0.x, r0, c1.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, c0
mul_pp r0.xyz, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedimkkhaijaieajpnaopknomngojibbdmmabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckaabaaaaeaaaaaaagiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaa
abaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedclalgimdfjjegcicpfehghgaamfndcogabaaaaaaiiadaaaaaeaaaaaa
daaaaaaadmabaaaaoeacaaaafeadaaaaebgpgodjaeabaaaaaeabaaaaaaacpppp
mmaaaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadp
aaaaaalpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadia
aaaaoeiaabaaoekaabaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaaaaaoelaaaaioekaafaaaaadabaacpiaabaaoeiaaaaaoekaafaaaaad
abaachiaaaaaoeiaabaaoeiaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefc
kaabaaaaeaaaaaaagiaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaa
gcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaak
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadp
dcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadp
abeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMColorBurn" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[1].x;
MAD R0.x, fragment.texcoord[1], R0, c[1];
MUL R1.y, R0, c[1];
MUL R1.x, R0, c[1].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, c[0];
RCP R0.x, R0.x;
RCP R0.y, R0.y;
RCP R0.z, R0.z;
ADD R1.xyz, -R1, c[1].x;
MAD result.color.xyz, -R1, R0, c[1].x;
MOV result.color.w, R0;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMColorBurn" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, 1.00000000, 0.50000000, 0, 0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c1
mad r0.y, -r1.x, c1, c1.x
mad r0.x, t1, r0, c1
mul r0.x, r0, c1.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, c0
add_pp r0.xyz, -r0, c1.x
rcp_pp r1.x, r1.x
rcp_pp r1.z, r1.z
rcp_pp r1.y, r1.y
mad_pp r0.xyz, -r0, r1, c1.x
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjjdgbokpmpfljnkklcnbjmolbdnccmfdabaaaaaanaacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpiabaaaaeaaaaaaahoaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaaabaaaaaaaoaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaa
aaaaaaalhccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedbfpogikocnnblmflnjipchibfhlpaknjabaaaaaabiaeaaaaaeaaaaaa
daaaaaaaheabaaaaheadaaaaoeadaaaaebgpgodjdmabaaaadmabaaaaaaacpppp
aeabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadp
aaaaaalpaaaaiadpaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadia
aaaaoeiaabaaoekaabaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaaaaaoelaaaaioekaacaaaaadaaaachiaaaaaoeibabaakkkaafaaaaad
abaacpiaabaaoeiaaaaaoekaagaaaaacacaaabiaabaaaaiaagaaaaacacaaacia
abaaffiaagaaaaacacaaaeiaabaakkiaaeaaaaaeabaachiaaaaaoeiaacaaoeib
abaakkkaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcpiabaaaaeaaaaaaa
hoaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaaaoaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaaaaaaaaalhccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearBurn" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[1].x;
MAD R0.x, fragment.texcoord[1], R0, c[1];
MUL R1.y, R0, c[1];
MUL R1.x, R0, c[1].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, c[0];
ADD R0.xyz, R0, R1;
ADD result.color.xyz, R0, -c[1].x;
MOV result.color.w, R0;
END
# 11 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearBurn" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, 1.00000000, 0.50000000, -1.00000000, 0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c1
mad r0.y, -r1.x, c1, c1.x
mad r0.x, t1, r0, c1
mul r0.x, r0, c1.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, c0
add_pp r0.xyz, r1, r0
add_pp r0.xyz, r0, c1.z
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedgmfgnadakgfdgjdicflogbhanddcbnkpabaaaaaakmacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcneabaaaaeaaaaaaahfaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
abaaaaaaegacbaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedlolaaccmajdllnonkmojepdpllmpdfpkabaaaaaanaadaaaaaeaaaaaa
daaaaaaafaabaaaacmadaaaajmadaaaaebgpgodjbiabaaaabiabaaaaaaacpppp
oaaaaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadp
aaaaaalpaaaaialpaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadia
aaaaoeiaabaaoekaabaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaaaaaoelaaaaioekaaeaaaaaeaaaachiaabaaoeiaaaaaoekaaaaaoeia
afaaaaadabaaciiaabaappiaaaaappkaacaaaaadabaachiaaaaaoeiaabaakkka
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefcneabaaaaeaaaaaaahfaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaakhcaabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
abaaaaaaegacbaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
aaaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMDarkerColor" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[3] = { program.local[0],
		{ 0.29907227, 1, 0.5, 0.58691406 },
		{ 0.11401367 } };
TEMP R0;
TEMP R1;
TEMP R2;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[1];
MAD R0.x, fragment.texcoord[1], R0, c[1].y;
MUL R1.y, R0, c[1].z;
MUL R1.x, R0, c[1].z;
TEX R1.xyz, R1, texture[1], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, c[0];
MUL R2.x, R0.y, c[1].w;
MUL R1.w, R1.y, c[1];
MAD R2.x, R0, c[1], R2;
MAD R1.w, R1.x, c[1].x, R1;
MAD R2.x, R0.z, c[2], R2;
MAD R1.w, R1.z, c[2].x, R1;
ADD R1.w, R1, -R2.x;
CMP result.color.xyz, R1.w, R1, R0;
MOV result.color.w, R0;
END
# 17 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarkerColor" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, 1.00000000, 0.50000000, 0.58691406, 0.29907227
def c2, 0.11401367, 0, 0, 0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c1
mad r0.x, t1, r0, c1
mad r1.y, -r1.x, c1, c1.x
mul r1.x, r0, c1.y
texld r3, r1, s1
texld r0, t0, s0
mul r2, r0, c0
mul_pp r1.x, r2.y, c1.z
mul_pp r0.x, r3.y, c1.z
mad_pp r1.x, r2, c1.w, r1
mad_pp r0.x, r3, c1.w, r0
mad_pp r1.x, r2.z, c2, r1
mad_pp r0.x, r3.z, c2, r0
add_pp r0.x, r0, -r1
cmp_pp r0.xyz, r0.x, r2, r3
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedideklmomfacohobcbdnibgfbendckmggabaaaaaaomacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbeacaaaaeaaaaaaaifaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
baaaaaakicaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaabaaaaaakbcaabaaaacaaaaaaegacbaaaabaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaadbaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaacaaaaaadhaaaaajhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedhphhjbnagpgcckaljgeokemkijebmdjfabaaaaaajiaeaaaaaeaaaaaa
daaaaaaaniabaaaapeadaaaageaeaaaaebgpgodjkaabaaaakaabaaaaaaacpppp
giabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkanfhiojdn
aaaaaaaaaaaaaaaaaaaaaaaafbaaaaafacaaapkaaaaaaadpaaaaaalpkcefbgdp
ihbgjjdobpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaiaabaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaacaaaaaiiaabaappla
afaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadiaaaaaoeiaacaaoeka
acaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaadabaaapiaaaaaoela
aaaioekaafaaaaadaaaaciiaaaaaffiaacaakkkaaeaaaaaeaaaaciiaaaaaaaia
acaappkaaaaappiaaeaaaaaeaaaaciiaaaaakkiaabaaaakaaaaappiaafaaaaad
abaacpiaabaaoeiaaaaaoekaafaaaaadacaaciiaabaaffiaacaakkkaaeaaaaae
acaacbiaabaaaaiaacaappkaacaappiaaeaaaaaeacaacbiaabaakkiaabaaaaka
acaaaaiaacaaaaadaaaaaiiaaaaappiaacaaaaibfiaaaaaeabaachiaaaaappia
abaaoeiaaaaaoeiaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcbeacaaaa
eaaaaaaaifaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
lcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaak
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaa
aaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaabaaaaaakicaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
ihbgjjdokcefbgdpnfhiojdnaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaabaaaaaakbcaabaaaacaaaaaa
egacbaaaabaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaadbaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaaacaaaaaadhaaaaajhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLighten" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[1].x;
MAD R0.x, fragment.texcoord[1], R0, c[1];
MUL R1.y, R0, c[1];
MUL R1.x, R0, c[1].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, c[0];
MAX result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLighten" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, 1.00000000, 0.50000000, 0, 0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c1
mad r0.y, -r1.x, c1, c1.x
mad r0.x, t1, r0, c1
mul r0.x, r0, c1.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, c0
max_pp r0.xyz, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedahmfkgcbncolggnobejekcpcmhkekoejabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckaabaaaaeaaaaaaagiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaa
abaaaaaadeaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedplnlaehkfoggmmefahodggakfgemphcgabaaaaaajeadaaaaaeaaaaaa
daaaaaaaeiabaaaapaacaaaagaadaaaaebgpgodjbaabaaaabaabaaaaaaacpppp
niaaaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadp
aaaaaalpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadia
aaaaoeiaabaaoekaabaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaaaaaoelaaaaioekaafaaaaadabaacpiaabaaoeiaaaaaoekaalaaaaad
acaachiaaaaaoeiaabaaoeiaabaaaaacacaaciiaabaappiaabaaaaacaaaicpia
acaaoeiappppaaaafdeieefckaabaaaaeaaaaaaagiaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaa
pgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadeaaaaah
hccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMScreen" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[1].x;
MAD R0.x, fragment.texcoord[1], R0, c[1];
MUL R1.y, R0, c[1];
MUL R1.x, R0, c[1].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, c[0];
ADD R0.xyz, -R0, c[1].x;
ADD R1.xyz, -R1, c[1].x;
MAD result.color.xyz, -R1, R0, c[1].x;
MOV result.color.w, R0;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMScreen" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, 1.00000000, 0.50000000, 0, 0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c1
mad r0.y, -r1.x, c1, c1.x
mad r0.x, t1, r0, c1
mul r0.x, r0, c1.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, c0
add_pp r1.xyz, -r1, c1.x
add_pp r0.xyz, -r0, c1.x
mad_pp r0.xyz, -r0, r1, c1.x
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedijkclgngdpiialffakmjmglbbgjnhimhabaaaaaapeacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbmacaaaaeaaaaaaaihaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaohcaabaaaabaaaaaaegacbaia
ebaaaaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaa
aaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaan
hccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedljhfimbcohpmbmiadmjjlpmekfmadkblabaaaaaadiaeaaaaaeaaaaaa
daaaaaaahaabaaaajeadaaaaaeaeaaaaebgpgodjdiabaaaadiabaaaaaaacpppp
aaabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadp
aaaaaalpaaaaiadpaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadia
aaaaoeiaabaaoekaabaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaaaaaoelaaaaioekaacaaaaadaaaachiaaaaaoeibabaakkkaabaaaaac
aaaaaiiaabaakkkaaeaaaaaeabaachiaabaaoeiaaaaaoekbaaaappiaafaaaaad
acaaciiaabaappiaaaaappkaaeaaaaaeacaachiaaaaaoeiaabaaoeibabaakkka
abaaaaacaaaicpiaacaaoeiappppaaaafdeieefcbmacaaaaeaaaaaaaihaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaohcaabaaaabaaaaaaegacbaia
ebaaaaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaa
aaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadcaaaaan
hccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMColorDodge" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[1].x;
MAD R0.x, fragment.texcoord[1], R0, c[1];
MUL R1.y, R0, c[1];
MUL R1.x, R0, c[1].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, c[0];
ADD R0.xyz, -R0, c[1].x;
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
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, 1.00000000, 0.50000000, 0, 0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c1
mad r0.y, -r1.x, c1, c1.x
mad r0.x, t1, r0, c1
mul r0.x, r0, c1.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, c0
add_pp r1.xyz, -r1, c1.x
rcp_pp r1.x, r1.x
rcp_pp r1.z, r1.z
rcp_pp r1.y, r1.y
mul_pp r0.xyz, r0, r1
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedebeoaoeoaeecklopondniacohibpiegjabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcniabaaaaeaaaaaaahgaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaaohcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaa
aaaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaai
icaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaahhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecednceongacnnncjofbgpgnafiiofndllmaabaaaaaaaeaeaaaaaeaaaaaa
daaaaaaaiaabaaaagaadaaaanaadaaaaebgpgodjeiabaaaaeiabaaaaaaacpppp
baabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadp
aaaaaalpaaaaiadpaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadia
aaaaoeiaabaaoekaabaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaaaaaoelaaaaioekaabaaaaacaaaaaiiaabaakkkaaeaaaaaeabaachia
abaaoeiaaaaaoekbaaaappiaafaaaaadacaaciiaabaappiaaaaappkaagaaaaac
adaaabiaabaaaaiaagaaaaacadaaaciaabaaffiaagaaaaacadaaaeiaabaakkia
afaaaaadacaachiaaaaaoeiaadaaoeiaabaaaaacaaaicpiaacaaoeiappppaaaa
fdeieefcniabaaaaeaaaaaaahgaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaa
aaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaohcaabaaaabaaaaaa
egacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
aoaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearDodge" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[1].x;
MAD R0.x, fragment.texcoord[1], R0, c[1];
MUL R1.y, R0, c[1];
MUL R1.x, R0, c[1].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, c[0];
ADD result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearDodge" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, 1.00000000, 0.50000000, 0, 0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c1
mad r0.y, -r1.x, c1, c1.x
mad r0.x, t1, r0, c1
mul r0.x, r0, c1.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, c0
add_pp r0.xyz, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbobpekhbdhbkcncchcgakoklpnfleggmabaaaaaaieacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmabaaaaeaaaaaaaglaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaakhccabaaaaaaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
abaaaaaaegacbaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaakaabaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedidcngeafgfaaenfojpiopmpjhdeniogcabaaaaaajiadaaaaaeaaaaaa
daaaaaaaeaabaaaapeacaaaageadaaaaebgpgodjaiabaaaaaiabaaaaaaacpppp
naaaaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadp
aaaaaalpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadia
aaaaoeiaabaaoekaabaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaaaaaoelaaaaioekaaeaaaaaeaaaachiaabaaoeiaaaaaoekaaaaaoeia
afaaaaadaaaaciiaabaappiaaaaappkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefckmabaaaaeaaaaaaaglaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaa
aaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaa
egacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaaegacbaaaaaaaaaaadiaaaaai
bcaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLighterColor" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[3] = { program.local[0],
		{ 0.29907227, 1, 0.5, 0.58691406 },
		{ 0.11401367 } };
TEMP R0;
TEMP R1;
TEMP R2;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[1];
MAD R0.x, fragment.texcoord[1], R0, c[1].y;
MUL R1.y, R0, c[1].z;
MUL R1.x, R0, c[1].z;
TEX R1.xyz, R1, texture[1], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, c[0];
MUL R2.x, R0.y, c[1].w;
MUL R1.w, R1.y, c[1];
MAD R2.x, R0, c[1], R2;
MAD R1.w, R1.x, c[1].x, R1;
MAD R2.x, R0.z, c[2], R2;
MAD R1.w, R1.z, c[2].x, R1;
ADD R1.w, R1, -R2.x;
CMP result.color.xyz, -R1.w, R1, R0;
MOV result.color.w, R0;
END
# 17 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLighterColor" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, 1.00000000, 0.50000000, 0.58691406, 0.29907227
def c2, 0.11401367, 0, 0, 0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c1
mad r0.x, t1, r0, c1
mad r1.y, -r1.x, c1, c1.x
mul r1.x, r0, c1.y
texld r3, r1, s1
texld r0, t0, s0
mul r2, r0, c0
mul_pp r1.x, r2.y, c1.z
mul_pp r0.x, r3.y, c1.z
mad_pp r1.x, r2, c1.w, r1
mad_pp r0.x, r3, c1.w, r0
mad_pp r1.x, r2.z, c2, r1
mad_pp r0.x, r3.z, c2, r0
add_pp r0.x, r0, -r1
cmp_pp r0.xyz, -r0.x, r2, r3
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecednimdbegicoehbfggodmljgeffffmglfcabaaaaaaomacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbeacaaaaeaaaaaaaifaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
baaaaaakicaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaabaaaaaakbcaabaaaacaaaaaaegacbaaaabaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaadbaaaaahicaabaaaaaaaaaaa
akaabaaaacaaaaaadkaabaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedpollenfafdpjjkhnmcpgdojainpgdhnjabaaaaaajiaeaaaaaeaaaaaa
daaaaaaaniabaaaapeadaaaageaeaaaaebgpgodjkaabaaaakaabaaaaaaacpppp
giabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkanfhiojdn
aaaaaaaaaaaaaaaaaaaaaaaafbaaaaafacaaapkaaaaaaadpaaaaaalpkcefbgdp
ihbgjjdobpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaiaabaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaacaaaaaiiaabaappla
afaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadiaaaaaoeiaacaaoeka
acaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaadabaaapiaaaaaoela
aaaioekaafaaaaadaaaaciiaaaaaffiaacaakkkaaeaaaaaeaaaaciiaaaaaaaia
acaappkaaaaappiaaeaaaaaeaaaaciiaaaaakkiaabaaaakaaaaappiaafaaaaad
abaacpiaabaaoeiaaaaaoekaafaaaaadacaaciiaabaaffiaacaakkkaaeaaaaae
acaacbiaabaaaaiaacaappkaacaappiaaeaaaaaeacaacbiaabaakkiaabaaaaka
acaaaaiaacaaaaadaaaaaiiaaaaappibacaaaaiafiaaaaaeabaachiaaaaappia
abaaoeiaaaaaoeiaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcbeacaaaa
eaaaaaaaifaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaad
lcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaak
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaa
aaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaabaaaaaakicaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
ihbgjjdokcefbgdpnfhiojdnaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaabaaaaaakbcaabaaaacaaaaaa
egacbaaaabaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaadbaaaaah
icaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaaaaaaaaaadhaaaaajhccabaaa
aaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaa
adaaaaaaacaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfcee
aaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMOverlay" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 1, 0.5, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, c[0];
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[1].x;
MAD R0.x, fragment.texcoord[1], R0, c[1];
ADD R3.xyz, -R1, c[1].x;
MUL R0.y, R0, c[1];
MUL R0.x, R0, c[1].y;
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
MUL R1.xyz, R1, R0;
ADD R2.xyz, -R0, c[1].x;
MUL R2.xyz, R2, R3;
MAD R2.xyz, -R2, c[1].z, c[1].x;
MUL R1.xyz, R1, c[1].z;
ADD R0.xyz, R0, -c[1].y;
CMP result.color.xyz, -R0, R2, R1;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMOverlay" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, 1.00000000, 0.50000000, 2.00000000, -0.50000000
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c1
mad r0.y, -r1.x, c1, c1.x
mad r0.x, t1, r0, c1
mul r0.x, r0, c1.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, c0
mul_pp r2.xyz, r1, r0
add_pp r3.xyz, -r1, c1.x
add_pp r1.xyz, -r0, c1.x
mul_pp r1.xyz, r1, r3
mul_pp r2.xyz, r2, c1.z
mad_pp r1.xyz, -r1, c1.z, c1.x
add_pp r0.xyz, r0, c1.w
cmp_pp r0.xyz, -r0, r2, r1
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedpbmalkcddeolkiaecibjiodngiepgablabaaaaaajeadaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclmacaaaaeaaaaaaakpaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaalhcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaaohcaabaaaadaaaaaaegacbaiaebaaaaaa
acaaaaaaegiccaaaaaaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaaanhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaakhcaabaaa
adaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaaaaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaadaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedoadoaijckepkhkddmnjmagmocelmdpababaaaaaacmafaaaaaeaaaaaa
daaaaaaameabaaaaiiaeaaaapiaeaaaaebgpgodjimabaaaaimabaaaaaaacpppp
feabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadp
aaaaaalpaaaaiadpaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadia
aaaaoeiaabaaoekaabaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaaaaaoelaaaaioekaacaaaaadacaachiaaaaaoeibabaakkkaacaaaaad
acaachiaacaaoeiaacaaoeiaabaaaaacaaaaaiiaabaakkkaaeaaaaaeadaachia
abaaoeiaaaaaoekbaaaappiaafaaaaadabaacpiaabaaoeiaaaaaoekaaeaaaaae
acaachiaacaaoeiaadaaoeibabaakkkaacaaaaadadaaahiaaaaaoeibabaaaaka
afaaaaadaaaachiaaaaaoeiaabaaoeiaacaaaaadaaaachiaaaaaoeiaaaaaoeia
fiaaaaaeabaachiaadaaoeiaaaaaoeiaacaaoeiaabaaaaacaaaicpiaabaaoeia
ppppaaaafdeieefclmacaaaaeaaaaaaakpaaaaaafjaaaaaeegiocaaaaaaaaaaa
acaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaa
acaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
aaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaefaaaaaj
pcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaaohcaabaaaadaaaaaaegacbaiaebaaaaaaacaaaaaaegiccaaaaaaaaaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaaipcaabaaa
acaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaanhcaabaaa
abaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadbaaaaakhcaabaaaadaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
acaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
dhaaaaajhccabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaaegacbaaa
aaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMSoftLight" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 1, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, c[0];
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[1].x;
MAD R0.x, fragment.texcoord[1], R0, c[1];
MUL R0.y, R0, c[1];
MUL R0.x, R0, c[1].y;
ADD R3.xyz, -R1, c[1].x;
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
ADD R2.xyz, -R0, c[1].x;
MAD R3.xyz, -R2, R3, c[1].x;
MUL R3.xyz, R0, R3;
MUL R0.xyz, R2, R0;
MAD result.color.xyz, R1, R0, R3;
END
# 15 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMSoftLight" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, 1.00000000, 0.50000000, 0, 0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c1
mad r0.y, -r1.x, c1, c1.x
mad r0.x, t1, r0, c1
mul r0.x, r0, c1.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, c0
add_pp r2.xyz, -r0, c1.x
add_pp r3.xyz, -r1, c1.x
mad_pp r3.xyz, -r2, r3, c1.x
mul_pp r3.xyz, r0, r3
mul_pp r0.xyz, r2, r0
mad_pp r0.xyz, r1, r0, r3
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedadplbnbgpjpkhipekfihbdnfffkghblhabaaaaaafaadaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchiacaaaaeaaaaaaajoaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaalhcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaohcaabaaaadaaaaaaegacbaia
ebaaaaaaacaaaaaaegiccaaaaaaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaa
aaaaaaaaabaaaaaadcaaaaanhcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaah
hcaabaaaabaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaajhccabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedbbldfgedbmpcaoenkjmiliepcajcomkcabaaaaaamiaeaaaaaeaaaaaa
daaaaaaakeabaaaaceaeaaaajeaeaaaaebgpgodjgmabaaaagmabaaaaaaacpppp
deabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadp
aaaaaalpaaaaiadpaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadia
aaaaoeiaabaaoekaabaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaaaaaoelaaaaioekaacaaaaadacaachiaaaaaoeibabaakkkaabaaaaac
aaaaaiiaabaakkkaaeaaaaaeadaachiaabaaoeiaaaaaoekbaaaappiaafaaaaad
abaacpiaabaaoeiaaaaaoekaaeaaaaaeadaachiaacaaoeiaadaaoeibabaakkka
afaaaaadacaachiaaaaaoeiaacaaoeiaafaaaaadaaaachiaaaaaoeiaadaaoeia
aeaaaaaeabaachiaacaaoeiaabaaoeiaaaaaoeiaabaaaaacaaaicpiaabaaoeia
ppppaaaafdeieefchiacaaaaeaaaaaaajoaaaaaafjaaaaaeegiocaaaaaaaaaaa
acaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaa
acaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaaabaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaaohcaabaaaadaaaaaaegacbaiaebaaaaaaacaaaaaaegiccaaa
aaaaaaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaai
pcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaan
hcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaadaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaadaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
adadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMHardLight" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, c[0];
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[1];
MAD R0.x, fragment.texcoord[1], R0, c[1].y;
MUL R0.y, R0, c[1].x;
MUL R0.x, R0, c[1];
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
MUL R2.xyz, R1, R0;
ADD R1.xyz, R1, -c[1].x;
MUL R2.xyz, R2, c[1].z;
MAD R3.xyz, -R1, c[1].z, c[1].y;
ADD R0.xyz, -R0, c[1].y;
MAD R0.xyz, -R0, R3, c[1].y;
CMP result.color.xyz, -R1, R0, R2;
END
# 16 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMHardLight" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, 1.00000000, 0.50000000, -0.50000000, 2.00000000
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c1
mad r0.y, -r1.x, c1, c1.x
mad r0.x, t1, r0, c1
mul r0.x, r0, c1.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, c0
add_pp r2.xyz, r1, c1.z
mul_pp r1.xyz, r1, r0
mad_pp r3.xyz, -r2, c1.w, c1.x
add_pp r0.xyz, -r0, c1.x
mad_pp r0.xyz, -r0, r3, c1.x
mul_pp r1.xyz, r1, c1.w
cmp_pp r0.xyz, -r2, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedpnbgengfndhmihlbpeieljfllgjnelkaabaaaaaaleadaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnmacaaaaeaaaaaaalhaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaalhcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaanhcaabaaaadaaaaaaegacbaaa
acaaaaaaegiccaaaaaaaaaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalp
aaaaaaaadiaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaa
abaaaaaadcaaaabahcaabaaaadaaaaaaegacbaiaebaaaaaaadaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadcaaaaanhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaadbaaaaakhcaabaaaacaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaacaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedhnnpkojlaojocghidfpgmoeandckolgpabaaaaaafeafaaaaaeaaaaaa
daaaaaaammabaaaalaaeaaaacaafaaaaebgpgodjjeabaaaajeabaaaaaaacpppp
fmabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadp
aaaaaalpaaaaiadpaaaaaaeabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadia
aaaaoeiaabaaoekaabaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaaaaaoelaaaaioekaacaaaaadacaachiaaaaaoeibabaakkkaabaaaaac
adaaadiaabaaoekaaeaaaaaeadaacoiaabaabliaaaaablkaadaaffiaaeaaaaae
adaacoiaadaaoeiaabaappkbabaakkkaaeaaaaaeacaachiaacaaoeiaadaablib
abaakkkaafaaaaadaeaacpiaabaaoeiaaaaaoekaaeaaaaaeabaaahiaabaaoeia
aaaaoekbadaaaaiaafaaaaadaaaachiaaaaaoeiaaeaaoeiaacaaaaadaaaachia
aaaaoeiaaaaaoeiafiaaaaaeaeaachiaabaaoeiaaaaaoeiaacaaoeiaabaaaaac
aaaicpiaaeaaoeiappppaaaafdeieefcnmacaaaaeaaaaaaalhaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
acaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaa
aaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaal
hcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaabaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaanhcaabaaaadaaaaaaegacbaaaacaaaaaa
egiccaaaaaaaaaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaa
diaaaaaipcaabaaaacaaaaaaegaobaaaacaaaaaaegiocaaaaaaaaaaaabaaaaaa
dcaaaabahcaabaaaadaaaaaaegacbaiaebaaaaaaadaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
dcaaaaanhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaadaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaaaaaaaaadbaaaaakhcaabaaaacaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaacaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMVividLight" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, c[0];
ADD R2.xyz, R1, -c[1].x;
MUL R1.xyz, R1, c[1].z;
MAD R3.xyz, -R2, c[1].z, c[1].y;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[1];
MAD R0.x, fragment.texcoord[1], R0, c[1].y;
MUL R0.y, R0, c[1].x;
MUL R0.x, R0, c[1];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.z, R1.z;
RCP R3.x, R3.x;
RCP R3.z, R3.z;
RCP R3.y, R3.y;
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
ADD R4.xyz, -R0, c[1].y;
MAD R1.xyz, -R4, R1, c[1].y;
MUL R0.xyz, R0, R3;
CMP result.color.xyz, -R2, R0, R1;
END
# 22 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMVividLight" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, -0.50000000, 1.00000000, 0.50000000, 2.00000000
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c1.y
mad r0.y, -r1.x, c1.z, c1
mad r0.x, t1, r0, c1.y
mul r0.x, r0, c1.z
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, c0
add_pp r2.xyz, r1, c1.x
mul_pp r1.xyz, r1, c1.w
mad_pp r3.xyz, -r2, c1.w, c1.y
rcp_pp r3.x, r3.x
rcp_pp r3.z, r3.z
rcp_pp r3.y, r3.y
mul_pp r3.xyz, r0, r3
add_pp r0.xyz, -r0, c1.y
rcp_pp r1.x, r1.x
rcp_pp r1.z, r1.z
rcp_pp r1.y, r1.y
mad_pp r0.xyz, -r0, r1, c1.y
cmp_pp r0.xyz, -r2, r0, r3
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedjlgbjpoflgobcghplaogfjgfjlackkodabaaaaaamiadaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpaacaaaaeaaaaaaalmaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaanhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
abaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaadiaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaabahcaabaaa
acaaaaaaegacbaiaebaaaaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaoaaaaahhcaabaaa
acaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaalhcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
aaaaaaahhcaabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaaoaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaaaaaaaaalhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadbaaaaakhcaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaa
dhaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefieceddloloelpobecgninfgcbcbeinemckbckabaaaaaalaafaaaaaeaaaaaa
daaaaaaabeacaaaaamafaaaahmafaaaaebgpgodjnmabaaaanmabaaaaaaacpppp
keabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadp
aaaaaalpaaaaaaeaaaaaiadpbpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadia
aaaaoeiaabaaoekaabaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaaaaaoelaaaaioekaabaaaaacacaaadiaabaaoekaaeaaaaaeacaacoia
abaabliaaaaablkaacaaffiaaeaaaaaeacaacoiaacaaoeiaabaakkkbabaappka
agaaaaacadaaabiaacaappiaagaaaaacadaaaciaacaakkiaagaaaaacadaaaeia
acaaffiaafaaaaadacaacoiaaaaabliaadaabliaacaaaaadaaaachiaaaaaoeib
abaappkaafaaaaadadaacpiaabaaoeiaaaaaoekaaeaaaaaeabaaahiaabaaoeia
aaaaoekbacaaaaiaacaaaaadaeaachiaadaaoeiaadaaoeiaagaaaaacafaaabia
aeaaaaiaagaaaaacafaaaciaaeaaffiaagaaaaacafaaaeiaaeaakkiaaeaaaaae
aaaachiaaaaaoeiaafaaoeibabaappkafiaaaaaeadaachiaabaaoeiaaaaaoeia
acaabliaabaaaaacaaaicpiaadaaoeiappppaaaafdeieefcpaacaaaaeaaaaaaa
lmaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaanhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaba
hcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaoaaaaah
hcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaalhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
aoaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaaaaaaaaal
hcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadbaaaaakhcaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMLinearLight" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, c[0];
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[1];
MAD R0.x, fragment.texcoord[1], R0, c[1].y;
MUL R0.y, R0, c[1].x;
MUL R0.x, R0, c[1];
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
MAD R2.xyz, R1, c[1].z, R0;
ADD R1.xyz, R1, -c[1].x;
ADD R2.xyz, R2, -c[1].y;
MAD R0.xyz, R1, c[1].z, R0;
CMP result.color.xyz, -R1, R0, R2;
END
# 14 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMLinearLight" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, 1.00000000, 0.50000000, -0.50000000, 2.00000000
def c2, -1.00000000, 0, 0, 0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c1
mad r0.y, -r1.x, c1, c1.x
mad r0.x, t1, r0, c1
mul r0.x, r0, c1.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, c0
add_pp r2.xyz, r1, c1.z
mad_pp r1.xyz, r1, c1.w, r0
mad_pp r0.xyz, r2, c1.w, r0
add_pp r1.xyz, r1, c2.x
cmp_pp r0.xyz, -r2, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedhmefohladhbmaajjopfgfbgamogcmgemabaaaaaageadaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcimacaaaaeaaaaaaakdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaanhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
abaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaadiaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaamhcaabaaa
acaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
egacbaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaa
dbaaaaakhcaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadhaaaaaj
hccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedcebgpdhdcjmkaiomgdplihhplefnmoemabaaaaaaoeaeaaaaaeaaaaaa
daaaaaaakmabaaaaeaaeaaaalaaeaaaaebgpgodjheabaaaaheabaaaaaaacpppp
dmabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadp
aaaaaalpaaaaaaeaaaaaialpbpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadia
aaaaoeiaabaaoekaabaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaaaaaoelaaaaioekaabaaaaacacaaadiaabaaoekaaeaaaaaeacaacoia
abaabliaaaaablkaacaaffiaaeaaaaaeacaacoiaacaaoeiaabaakkkaaaaablia
afaaaaadadaacpiaabaaoeiaaaaaoekaaeaaaaaeabaaahiaabaaoeiaaaaaoekb
acaaaaiaaeaaaaaeaaaachiaadaaoeiaabaakkkaaaaaoeiaacaaaaadaaaachia
aaaaoeiaabaappkafiaaaaaeadaachiaabaaoeiaaaaaoeiaacaabliaabaaaaac
aaaicpiaadaaoeiappppaaaafdeieefcimacaaaaeaaaaaaakdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
acaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaa
aaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaanhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaa
aceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaadiaaaaaipcaabaaaabaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadcaaaaamhcaabaaaacaaaaaa
egacbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaa
aaaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadbaaaaak
hcaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadhaaaaajhccabaaa
aaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "BMPinLight" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, c[0];
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[1];
MAD R0.x, fragment.texcoord[1], R0, c[1].y;
ADD R2.xyz, R1, -c[1].x;
MUL R3.xyz, R1, c[1].z;
MUL R0.y, R0, c[1].x;
MUL R0.x, R0, c[1];
MUL R1.xyz, R2, c[1].z;
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
MIN R3.xyz, R0, R3;
MAX R0.xyz, R0, R1;
CMP result.color.xyz, -R2, R0, R3;
END
# 15 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMPinLight" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, 1.00000000, 0.50000000, -0.50000000, 2.00000000
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c1
mad r0.y, -r1.x, c1, c1.x
mad r0.x, t1, r0, c1
mul r0.x, r0, c1.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, c0
add_pp r2.xyz, r1, c1.z
mul_pp r3.xyz, r2, c1.w
max_pp r3.xyz, r0, r3
mul_pp r1.xyz, r1, c1.w
min_pp r0.xyz, r0, r1
cmp_pp r0.xyz, -r2, r0, r3
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedlbnmlmmlcoilbobkihmhiipnoboiggdfabaaaaaaemadaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcheacaaaaeaaaaaaajnaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaanhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
abaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaadiaaaaaipcaabaaa
abaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaadeaaaaahhcaabaaaacaaaaaa
egacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaddaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaadaaaaaadbaaaaakhcaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedalajjanpibadhijhpiblkoeihlpnbjhbabaaaaaaneaeaaaaaeaaaaaa
daaaaaaaleabaaaadaaeaaaakaaeaaaaebgpgodjhmabaaaahmabaaaaaaacpppp
eeabaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadp
aaaaaalpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadia
aaaaoeiaabaaoekaabaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaaaaaoelaaaaioekaabaaaaacacaaahiaaaaaoekaaeaaaaaeadaachia
abaaoeiaacaaoeiaabaaffkaacaaaaadadaachiaadaaoeiaadaaoeiaalaaaaad
aeaachiaaaaaoeiaadaaoeiaafaaaaadadaacpiaabaaoeiaaaaaoekaaeaaaaae
abaaahiaabaaoeiaacaaoeibabaaaakaacaaaaadacaachiaadaaoeiaadaaoeia
akaaaaadafaachiaacaaoeiaaaaaoeiafiaaaaaeadaachiaabaaoeiaafaaoeia
aeaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaafdeieefcheacaaaaeaaaaaaa
jnaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaa
acaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaanhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaa
aaaaaaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaadiaaaaai
pcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaaaaaaaaah
hcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaadeaaaaahhcaabaaa
acaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaahhcaabaaaadaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaaddaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaadaaaaaadbaaaaakhcaabaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaa
acaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklkl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMHardMix" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 1, 0.5, 0 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1].x, R0.x, c[1].x;
MAD R0.z, fragment.texcoord[1].y, R0.x, c[1].x;
MUL R0.x, R0.y, c[1].y;
MUL R0.y, R0.z, c[1];
TEX R1.xyz, R0, texture[1], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, c[0];
ADD R1.xyz, -R1, c[1].x;
ADD R0.xyz, R0, -R1;
CMP R0.xyz, -R0, c[1].x, c[1].z;
MOV result.color.xyz, R0;
MOV result.color.w, R0;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMHardMix" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, 1.00000000, 0.50000000, 0.00000000, 0
dcl t0.xy
dcl t1.xyzw
rcp r1.x, t1.w
mad r0.x, t1, r1, c1
mad r1.x, t1.y, r1, c1
mad r0.y, -r1.x, c1, c1.x
mul r0.x, r0, c1.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, c0
add_pp r0.xyz, -r0, c1.x
add_pp r0.xyz, r1, -r0
cmp r0.xyz, -r0, c1.z, c1.x
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedddfeicieoblfoojkokbbndieofdkfcgdabaaaaaammacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpeabaaaaeaaaaaaahnaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaa
abaaaaaaegiocaaaaaaaaaaaabaaaaaadbaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaa
abaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecednbaadkhlmbcmbfogmcaliohlldpkoojdabaaaaaaaeaeaaaaaeaaaaaa
daaaaaaageabaaaagaadaaaanaadaaaaebgpgodjcmabaaaacmabaaaaaaacpppp
peaaaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadp
aaaaaalpaaaaiadpaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadia
aaaaoeiaabaaoekaabaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaaaaaoelaaaaioekaacaaaaadaaaachiaaaaaoeibabaakkkaaeaaaaae
aaaaahiaabaaoeiaaaaaoekbaaaaoeiaafaaaaadabaaciiaabaappiaaaaappka
fiaaaaaeabaachiaaaaaoeiaabaappkaabaakkkaabaaaaacaaaicpiaabaaoeia
ppppaaaafdeieefcpeabaaaaeaaaaaaahnaaaaaafjaaaaaeegiocaaaaaaaaaaa
acaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaa
acaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaa
abaaaaaadbaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaaabaaaaakhccabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaa
fmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaafdfgfpfaepfdejfe
ejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklkl"
}
SubProgram "opengl " {
Keywords { "BMDifference" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[1].x;
MAD R0.x, fragment.texcoord[1], R0, c[1];
MUL R1.y, R0, c[1];
MUL R1.x, R0, c[1].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, c[0];
ADD R0.xyz, -R0, R1;
ABS result.color.xyz, R0;
MOV result.color.w, R0;
END
# 11 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDifference" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, 1.00000000, 0.50000000, 0, 0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c1
mad r0.y, -r1.x, c1, c1.x
mad r0.x, t1, r0, c1
mul r0.x, r0, c1.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, c0
add_pp r0.xyz, -r1, r0
abs_pp r0.xyz, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefieceddlkdckedagppbiiclbokncadojclhikiabaaaaaakaacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcmiabaaaaeaaaaaaahcaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaa
aaaaaaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaa
abaaaaaadkiacaaaaaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadgaaaaaghccabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedcboghbmnhpplnfbdiiehahnjkpgnbpofabaaaaaamaadaaaaaeaaaaaa
daaaaaaaemabaaaabmadaaaaimadaaaaebgpgodjbeabaaaabeabaaaaaaacpppp
nmaaaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadp
aaaaaalpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadia
aaaaoeiaabaaoekaabaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaaaaaoelaaaaioekaaeaaaaaeaaaachiaabaaoeiaaaaaoekbaaaaoeia
afaaaaadabaaciiaabaappiaaaaappkacdaaaaacabaachiaaaaaoeiaabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefcmiabaaaaeaaaaaaahcaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
acaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaa
aaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaa
abaaaaaaegacbaaaaaaaaaaadiaaaaaiicaabaaaaaaaaaaadkaabaaaabaaaaaa
dkiacaaaaaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
dgaaaaaghccabaaaaaaaaaaaegacbaiaibaaaaaaaaaaaaaadoaaaaabejfdeheo
giaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaa
abaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaa
feeffiedepepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "BMExclusion" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 1, 0.5, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, c[0];
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[1].x;
MAD R0.x, fragment.texcoord[1], R0, c[1];
MUL R0.y, R0, c[1];
MUL R0.x, R0, c[1].y;
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
ADD R2.xyz, R1, R0;
MUL R0.xyz, R1, R0;
MAD result.color.xyz, -R0, c[1].z, R2;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMExclusion" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, 1.00000000, 0.50000000, 2.00000000, 0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c1
mad r0.y, -r1.x, c1, c1.x
mad r0.x, t1, r0, c1
mul r0.x, r0, c1.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, c0
add_pp r2.xyz, r1, r0
mul_pp r0.xyz, r1, r0
mad_pp r0.xyz, -r0, c1.z, r2
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedejhnlbfdiomllbdmaimgjmfhkackkcpiabaaaaaaneacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpmabaaaaeaaaaaaahpaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaakhcaabaaaacaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaa
abaaaaaaegacbaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaan
hccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaegacbaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefieceddehidpedjnigoaoamahgbjefcdlboofgabaaaaaaamaeaaaaaeaaaaaa
daaaaaaageabaaaagiadaaaaniadaaaaebgpgodjcmabaaaacmabaaaaaaacpppp
peaaaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadp
aaaaaalpaaaaaaeaaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadia
aaaaoeiaabaaoekaabaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaaaaaoelaaaaioekaaeaaaaaeacaachiaabaaoeiaaaaaoekaaaaaoeia
afaaaaadabaacpiaabaaoeiaaaaaoekaafaaaaadaaaachiaaaaaoeiaabaaoeia
aeaaaaaeabaachiaaaaaoeiaabaakkkbacaaoeiaabaaaaacaaaicpiaabaaoeia
ppppaaaafdeieefcpmabaaaaeaaaaaaahpaaaaaafjaaaaaeegiocaaaaaaaaaaa
acaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
dcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaa
acaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaakhcaabaaa
acaaaaaaegacbaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaaegacbaaaaaaaaaaa
diaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
diaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadcaaaaanhccabaaaaaaaaaaaegacbaia
ebaaaaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaa
acaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMSubtract" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[1].x;
MAD R0.x, fragment.texcoord[1], R0, c[1];
MUL R1.y, R0, c[1];
MUL R1.x, R0, c[1].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, c[0];
ADD result.color.xyz, -R0, R1;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMSubtract" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, 1.00000000, 0.50000000, 0, 0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c1
mad r0.y, -r1.x, c1, c1.x
mad r0.x, t1, r0, c1
mul r0.x, r0, c1.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, c0
add_pp r0.xyz, -r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbahinbddmhkkhheadagngfmaodgjpjpdabaaaaaaiiacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefclaabaaaaeaaaaaaagmaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaalhccabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaaegiccaaa
aaaaaaaaabaaaaaaegacbaaaaaaaaaaadiaaaaaibcaabaaaaaaaaaaadkaabaaa
abaaaaaadkiacaaaaaaaaaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaakaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedbdhaknomegnnnfhpckkbbnhcobolefkpabaaaaaajmadaaaaaeaaaaaa
daaaaaaaeaabaaaapiacaaaagiadaaaaebgpgodjaiabaaaaaiabaaaaaaacpppp
naaaaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadp
aaaaaalpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadia
aaaaoeiaabaaoekaabaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaaaaaoelaaaaioekaaeaaaaaeaaaachiaabaaoeiaaaaaoekbaaaaoeia
afaaaaadaaaaciiaabaappiaaaaappkaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefclaabaaaaeaaaaaaagmaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaa
aaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaalhccabaaaaaaaaaaa
egacbaiaebaaaaaaabaaaaaaegiccaaaaaaaaaaaabaaaaaaegacbaaaaaaaaaaa
diaaaaaibcaabaaaaaaaaaaadkaabaaaabaaaaaadkiacaaaaaaaaaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaa
aaaaaaaaadaaaaaaacaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaafeeffied
epepfceeaaklklklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMDivide" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"!!ARBfp1.0
PARAM c[2] = { program.local[0],
		{ 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[1].x;
MAD R0.x, fragment.texcoord[1], R0, c[1];
MUL R1.y, R0, c[1];
MUL R1.x, R0, c[1].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, c[0];
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
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c1, 1.00000000, 0.50000000, 0, 0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c1
mad r0.y, -r1.x, c1, c1.x
mad r0.x, t1, r0, c1
mul r0.x, r0, c1.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, c0
rcp_pp r1.x, r1.x
rcp_pp r1.z, r1.z
rcp_pp r1.y, r1.y
mul_pp r0.xyz, r0, r1
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0
eefiecedphnkhbbmfmmcjpfpanchjkhhnabhjhhkabaaaaaahiacaaaaadaaaaaa
cmaaaaaajmaaaaaanaaaaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckaabaaaaeaaaaaaagiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaaddcbabaaaabaaaaaagcbaaaadlcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaacaaaaaapgbpbaaaacaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaabaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaaipcaabaaaabaaaaaaegaobaaaabaaaaaaegiocaaaaaaaaaaa
abaaaaaaaoaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_GrabTexture] 2D 1
ConstBuffer "$Globals" 48
Vector 16 [_Color]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedoffdeihmfjcmlbmbjgclophibgaafancabaaaaaakmadaaaaaeaaaaaa
daaaaaaagaabaaaaaiadaaaahiadaaaaebgpgodjciabaaaaciabaaaaaaacpppp
paaaaaaadiaaaaaaabaacmaaaaaadiaaaaaadiaaacaaceaaaaaadiaaaaaaaaaa
abababaaaaaaabaaabaaaaaaaaaaaaaaaaacppppfbaaaaafabaaapkaaaaaaadp
aaaaaalpaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaacdlabpaaaaacaaaaaaia
abaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaabaapplaafaaaaadaaaaadiaaaaappiaabaaoelaaeaaaaaeaaaaadia
aaaaoeiaabaaoekaabaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaaaaaoelaaaaioekaafaaaaadabaacpiaabaaoeiaaaaaoekaagaaaaac
acaaabiaabaaaaiaagaaaaacacaaaciaabaaffiaagaaaaacacaaaeiaabaakkia
afaaaaadabaachiaaaaaoeiaacaaoeiaabaaaaacaaaicpiaabaaoeiappppaaaa
fdeieefckaabaaaaeaaaaaaagiaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaaddcbabaaa
abaaaaaagcbaaaadlcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaacaaaaaapgbpbaaaacaaaaaa
aaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
abaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaaipcaabaaaabaaaaaa
egaobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaaaoaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaadadaaaafmaaaaaaabaaaaaaaaaaaaaaadaaaaaaacaaaaaaapalaaaa
fdfgfpfaepfdejfeejepeoaafeeffiedepepfceeaaklklklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "Diffuse"
}