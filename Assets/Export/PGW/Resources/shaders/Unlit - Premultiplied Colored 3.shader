Shader "Hidden/Unlit/Premultiplied Colored 3" {
Properties {
 _MainTex ("Base (RGB), Alpha (A)", 2D) = "black" {}
}
SubShader { 
 LOD 200
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend One OneMinusSrcAlpha
  ColorMask RGB
  Offset -1, -1
Program "vp" {
SubProgram "opengl " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ClipRange0]
Vector 6 [_ClipRange1]
Vector 7 [_ClipArgs1]
Vector 8 [_ClipRange2]
Vector 9 [_ClipArgs2]
"!!ARBvp1.0
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
TEMP R0;
MUL R0.x, vertex.position.y, c[7].z;
MUL R0.y, vertex.position, c[7].w;
MAD R0.x, vertex.position, c[7].w, -R0;
MAD R0.y, vertex.position.x, c[7].z, R0;
MAD result.texcoord[1].zw, R0.xyxy, c[6], c[6].xyxy;
MUL R0.x, vertex.position.y, c[9].z;
MUL R0.y, vertex.position, c[9].w;
MAD R0.x, vertex.position, c[9].w, -R0;
MAD R0.y, vertex.position.x, c[9].z, R0;
MOV result.color, vertex.color;
MOV result.texcoord[0].xy, vertex.texcoord[0];
MAD result.texcoord[1].xy, vertex.position, c[5].zwzw, c[5];
MAD result.texcoord[2].xy, R0, c[8].zwzw, c[8];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 17 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ClipRange0]
Vector 5 [_ClipRange1]
Vector 6 [_ClipArgs1]
Vector 7 [_ClipRange2]
Vector 8 [_ClipArgs2]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mul r0.x, v0.y, c6.z
mul r0.y, v0, c6.w
mad r0.x, v0, c6.w, -r0
mad r0.y, v0.x, c6.z, r0
mad oT1.zw, r0.xyxy, c5, c5.xyxy
mul r0.x, v0.y, c8.z
mul r0.y, v0, c8.w
mad r0.x, v0, c8.w, -r0
mad r0.y, v0.x, c8.z, r0
mov oD0, v1
mov oT0.xy, v2
mad oT1.xy, v0, c4.zwzw, c4
mad oT2.xy, r0, c7.zwzw, c7
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}
SubProgram "d3d11 " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 112
Vector 16 [_ClipRange0]
Vector 48 [_ClipRange1]
Vector 64 [_ClipArgs1]
Vector 80 [_ClipRange2]
Vector 96 [_ClipArgs2]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedemnpledciafcmbjjjafejpmkmcgchifpabaaaaaapmadaaaaadaaaaaa
cmaaaaaajmaaaaaaeaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
jmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaajcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaaacaaaaaaaaaaaaaa
adaaaaaaacaaaaaaamadaaaajcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfagphdgjhegjgpgoaaedepemepfcaafeeffiedepepfceeaakl
fdeieefcleacaaaaeaaaabaaknaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaa
fjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaad
mccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaa
egbobaaaabaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaa
aaaaaaaaagaaaaaadcaaaaalecaabaaaaaaaaaaaakbabaaaaaaaaaaadkiacaaa
aaaaaaaaagaaaaaaakaabaiaebaaaaaaaaaaaaaaapaaaaaiicaabaaaaaaaaaaa
egbabaaaaaaaaaaaogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaacaaaaaa
kgaobaaaaaaaaaaakgiocaaaaaaaaaaaafaaaaaaagiecaaaaaaaaaaaafaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadiaaaaaibcaabaaaaaaaaaaa
bkbabaaaaaaaaaaackiacaaaaaaaaaaaaeaaaaaadcaaaaalecaabaaaaaaaaaaa
akbabaaaaaaaaaaadkiacaaaaaaaaaaaaeaaaaaaakaabaiaebaaaaaaaaaaaaaa
apaaaaaiicaabaaaaaaaaaaaegbabaaaaaaaaaaaogikcaaaaaaaaaaaaeaaaaaa
dcaaaaalmccabaaaadaaaaaakgaobaaaaaaaaaaakgiocaaaaaaaaaaaadaaaaaa
agiecaaaaaaaaaaaadaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaaaaaaaaa
ogikcaaaaaaaaaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 112
Vector 16 [_ClipRange0]
Vector 48 [_ClipRange1]
Vector 64 [_ClipArgs1]
Vector 80 [_ClipRange2]
Vector 96 [_ClipArgs2]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedjgjhkflandcgfooioknojgdmdjhieljlabaaaaaakiafaaaaaeaaaaaa
daaaaaaaniabaaaajeaeaaaaaeafaaaaebgpgodjkaabaaaakaabaaaaaaacpopp
feabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaaaaaadaaaeaaacaaaaaaaaaaabaaaaaaaeaaagaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapja
bpaaaaacafaaaciaacaaapjaaeaaaaaeacaaadoaaaaaoejaabaaookaabaaoeka
afaaaaadaaaaahiaaaaanbjaadaapkkaaeaaaaaeabaaaeiaaaaaaajaadaappka
aaaaaaibacaaaaadabaaaiiaaaaakkiaaaaaffiaaeaaaaaeacaaamoaabaaoeia
acaaoekaacaaeekaafaaaaadaaaaahiaaaaanbjaafaapkkaaeaaaaaeabaaaiia
aaaaaajaafaappkaaaaaaaibacaaaaadabaaaeiaaaaakkiaaaaaffiaaeaaaaae
abaaamoaabaaoeiaaeaalekaaeaabekaafaaaaadaaaaapiaaaaaffjaahaaoeka
aeaaaaaeaaaaapiaagaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaiaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaajaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
aaaaapoaabaaoejaabaaaaacabaaadoaacaaoejappppaaaafdeieefcleacaaaa
eaaaabaaknaaaaaafjaaaaaeegiocaaaaaaaaaaaahaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadmccabaaaacaaaaaa
gfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaaabaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaaaaaaaaaagaaaaaa
dcaaaaalecaabaaaaaaaaaaaakbabaaaaaaaaaaadkiacaaaaaaaaaaaagaaaaaa
akaabaiaebaaaaaaaaaaaaaaapaaaaaiicaabaaaaaaaaaaaegbabaaaaaaaaaaa
ogikcaaaaaaaaaaaagaaaaaadcaaaaalmccabaaaacaaaaaakgaobaaaaaaaaaaa
kgiocaaaaaaaaaaaafaaaaaaagiecaaaaaaaaaaaafaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadiaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaa
ckiacaaaaaaaaaaaaeaaaaaadcaaaaalecaabaaaaaaaaaaaakbabaaaaaaaaaaa
dkiacaaaaaaaaaaaaeaaaaaaakaabaiaebaaaaaaaaaaaaaaapaaaaaiicaabaaa
aaaaaaaaegbabaaaaaaaaaaaogikcaaaaaaaaaaaaeaaaaaadcaaaaalmccabaaa
adaaaaaakgaobaaaaaaaaaaakgiocaaaaaaaaaaaadaaaaaaagiecaaaaaaaaaaa
adaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaaaaaaaaaaogikcaaaaaaaaaaa
abaaaaaaegiacaaaaaaaaaaaabaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedep
epfceeaaepfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apaaaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaajcaaaaaa
acaaaaaaaaaaaaaaadaaaaaaacaaaaaaamadaaaajcaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfagphdgjhegjgpgoaaedepemepfcaafeef
fiedepepfceeaakl"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_ClipArgs0]
Vector 1 [_ClipArgs1]
Vector 2 [_ClipArgs2]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[4] = { program.local[0..2],
		{ 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1, fragment.texcoord[0], texture[0], 2D;
ABS R0.xy, fragment.texcoord[2];
ADD R0.xy, -R0, c[3].x;
MUL R0.xy, R0, c[2];
MIN R2.x, R0, R0.y;
ABS R0.zw, fragment.texcoord[1];
ABS R0.xy, fragment.texcoord[1];
ADD R0.zw, -R0, c[3].x;
ADD R0.xy, -R0, c[3].x;
MUL R0.zw, R0, c[1].xyxy;
MUL R0.xy, R0, c[0];
MUL R1, R1, fragment.color.primary;
MIN R0.z, R0, R0.w;
MIN R0.x, R0, R0.y;
MIN R0.x, R0, R0.z;
MIN_SAT R0.x, R0, R2;
MUL result.color, R0.x, R1;
END
# 17 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_ClipArgs0]
Vector 1 [_ClipArgs1]
Vector 2 [_ClipArgs2]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c3, 1.00000000, 0, 0, 0
dcl v0
dcl t0.xy
dcl t1
dcl t2.xy
texld r1, t0, s0
mul r3, r1, v0
abs r0.xy, t2
add r0.xy, -r0, c3.x
mul r0.xy, r0, c2
abs r2.xy, t1
add r2.xy, -r2, c3.x
mul r2.xy, r2, c0
min r0.x, r0, r0.y
mov r1.y, t1.w
mov r1.x, t1.z
abs r1.xy, r1
add r1.xy, -r1, c3.x
mul r1.xy, r1, c1
min r1.x, r1, r1.y
min r2.x, r2, r2.y
min r1.x, r2, r1
min_sat r0.x, r1, r0
mul_pp r0, r0.x, r3
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 112
Vector 32 [_ClipArgs0]
Vector 64 [_ClipArgs1]
Vector 96 [_ClipArgs2]
BindCB  "$Globals" 0
"ps_4_0
eefiecedidggeebnffehbfokfffmfkhichfeopadabaaaaaaamadaaaaadaaaaaa
cmaaaaaanaaaaaaaaeabaaaaejfdeheojmaaaaaaafaaaaaaaiaaaaaaiaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaimaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaajcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaaacaaaaaaamamaaaajcaaaaaa
abaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfagphdgjhegjgpgoaa
edepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaa
caaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgf
heaaklklfdeieefcaaacaaaaeaaaaaaaiaaaaaaafjaaaaaeegiocaaaaaaaaaaa
ahaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadmcbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaaaaaaaalpcaabaaaaaaaaaaaegbobaiambaaaaaaadaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaiadpdiaaaaaidcaabaaaaaaaaaaaegaabaaa
aaaaaaaaegiacaaaaaaaaaaaacaaaaaadiaaaaaimcaabaaaaaaaaaaakgaobaaa
aaaaaaaaagiecaaaaaaaaaaaaeaaaaaaddaaaaahfcaabaaaaaaaaaaafgahbaaa
aaaaaaaaagacbaaaaaaaaaaaddaaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaa
akaabaaaaaaaaaaaaaaaaaalgcaabaaaaaaaaaaakgblbaiambaaaaaaacaaaaaa
aceaaaaaaaaaaaaaaaaaiadpaaaaiadpaaaaaaaadiaaaaaigcaabaaaaaaaaaaa
fgagbaaaaaaaaaaaagibcaaaaaaaaaaaagaaaaaaddaaaaahccaabaaaaaaaaaaa
ckaabaaaaaaaaaaabkaabaaaaaaaaaaaddcaaaahbcaabaaaaaaaaaaabkaabaaa
aaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegbobaaaabaaaaaadiaaaaahpccabaaaaaaaaaaaagaabaaaaaaaaaaa
egaobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 112
Vector 32 [_ClipArgs0]
Vector 64 [_ClipArgs1]
Vector 96 [_ClipArgs2]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedjagibmnhdfpallplcbmconndmjahngadabaaaaaapaaeaaaaaeaaaaaa
daaaaaaabaacaaaabiaeaaaalmaeaaaaebgpgodjniabaaaaniabaaaaaaacpppp
imabaaaaemaaaaaaadaaciaaaaaaemaaaaaaemaaabaaceaaaaaaemaaaaaaaaaa
aaaaacaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaaaaaaagaaabaaacaa
aaaaaaaaaaacppppfbaaaaafadaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaaaplabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapiaabaaoelaaaaioeka
cdaaaaacabaaadiaacaaoelaacaaaaadabaaadiaabaaoeibadaaaakaafaaaaad
abaaadiaabaaoeiaaaaaoekaakaaaaadacaaaiiaabaaffiaabaaaaiacdaaaaac
abaaabiaacaakklacdaaaaacabaaaciaacaapplaacaaaaadabaaadiaabaaoeib
adaaaakaafaaaaadabaaadiaabaaoeiaabaaoekaakaaaaadacaaabiaabaaffia
abaaaaiaakaaaaadabaaabiaacaaaaiaacaappiacdaaaaacabaaamiaabaaoela
acaaaaadabaaaciaabaappibadaaaakaacaaaaadabaaaeiaabaakkibadaaaaka
afaaaaadabaaagiaabaaoeiaacaanckaakaaaaadacaaabiaabaakkiaabaaffia
akaaaaadadaabiiaacaaaaiaabaaaaiaafaaaaadaaaacpiaaaaaoeiaaaaaoela
afaaaaadabaaciiaadaappiaaaaappiaafaaaaadabaachiaaaaaoeiaadaappia
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefcaaacaaaaeaaaaaaaiaaaaaaa
fjaaaaaeegiocaaaaaaaaaaaahaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadmcbabaaaacaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaaaaaaaalpcaabaaaaaaaaaaaegbobaia
mbaaaaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpdiaaaaai
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaaaaaaaaaaacaaaaaadiaaaaai
mcaabaaaaaaaaaaakgaobaaaaaaaaaaaagiecaaaaaaaaaaaaeaaaaaaddaaaaah
fcaabaaaaaaaaaaafgahbaaaaaaaaaaaagacbaaaaaaaaaaaddaaaaahbcaabaaa
aaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaaaaaaaaalgcaabaaaaaaaaaaa
kgblbaiambaaaaaaacaaaaaaaceaaaaaaaaaaaaaaaaaiadpaaaaiadpaaaaaaaa
diaaaaaigcaabaaaaaaaaaaafgagbaaaaaaaaaaaagibcaaaaaaaaaaaagaaaaaa
ddaaaaahccaabaaaaaaaaaaackaabaaaaaaaaaaabkaabaaaaaaaaaaaddcaaaah
bcaabaaaaaaaaaaabkaabaaaaaaaaaaaakaabaaaaaaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaadiaaaaahpccabaaa
aaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadoaaaaabejfdeheojmaaaaaa
afaaaaaaaiaaaaaaiaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
imaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaajcaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaajcaaaaaaacaaaaaaaaaaaaaaadaaaaaa
acaaaaaaamamaaaajcaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaa
fdfgfpfagphdgjhegjgpgoaaedepemepfcaafeeffiedepepfceeaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend One OneMinusSrcAlpha
  ColorMask RGB
  ColorMaterial AmbientAndDiffuse
  Offset -1, -1
  SetTexture [_MainTex] { combine texture * primary }
 }
}
}