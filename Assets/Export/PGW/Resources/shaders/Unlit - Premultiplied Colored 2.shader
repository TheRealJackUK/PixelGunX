Shader "Hidden/Unlit/Premultiplied Colored 2" {
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
"!!ARBvp1.0
PARAM c[8] = { program.local[0],
		state.matrix.mvp,
		program.local[5..7] };
TEMP R0;
MUL R0.x, vertex.position.y, c[7].z;
MUL R0.y, vertex.position, c[7].w;
MAD R0.x, vertex.position, c[7].w, -R0;
MAD R0.y, vertex.position.x, c[7].z, R0;
MOV result.color, vertex.color;
MOV result.texcoord[0].xy, vertex.texcoord[0];
MAD result.texcoord[1].zw, R0.xyxy, c[6], c[6].xyxy;
MAD result.texcoord[1].xy, vertex.position, c[5].zwzw, c[5];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 12 instructions, 1 R-regs
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
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mul r0.x, v0.y, c6.z
mul r0.y, v0, c6.w
mad r0.x, v0, c6.w, -r0
mad r0.y, v0.x, c6.z, r0
mov oD0, v1
mov oT0.xy, v2
mad oT1.zw, r0.xyxy, c5, c5.xyxy
mad oT1.xy, v0, c4.zwzw, c4
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
ConstBuffer "$Globals" 80
Vector 16 [_ClipRange0]
Vector 48 [_ClipRange1]
Vector 64 [_ClipArgs1]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedhipjpedpaipcofanlidandmohkfpjlccabaaaaaaeaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfagphdgjhegjgpgoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefcbaacaaaaeaaaabaaieaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaabaaaaaaegbobaaa
abaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadiaaaaaibcaabaaa
aaaaaaaabkbabaaaaaaaaaaackiacaaaaaaaaaaaaeaaaaaadcaaaaalecaabaaa
aaaaaaaaakbabaaaaaaaaaaadkiacaaaaaaaaaaaaeaaaaaaakaabaiaebaaaaaa
aaaaaaaaapaaaaaiicaabaaaaaaaaaaaegbabaaaaaaaaaaaogikcaaaaaaaaaaa
aeaaaaaadcaaaaalmccabaaaadaaaaaakgaobaaaaaaaaaaakgiocaaaaaaaaaaa
adaaaaaaagiecaaaaaaaaaaaadaaaaaadcaaaaaldccabaaaadaaaaaaegbabaaa
aaaaaaaaogikcaaaaaaaaaaaabaaaaaaegiacaaaaaaaaaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 80
Vector 16 [_ClipRange0]
Vector 48 [_ClipRange1]
Vector 64 [_ClipArgs1]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedekopiodhleifhpbfhdlmcdgacciegmkdabaaaaaakeaeaaaaaeaaaaaa
daaaaaaajaabaaaakiadaaaabiaeaaaaebgpgodjfiabaaaafiabaaaaaaacpopp
amabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaaaaaadaaacaaacaaaaaaaaaaabaaaaaaaeaaaeaaaaaaaaaa
aaaaaaaaaaacpoppbpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapja
bpaaaaacafaaaciaacaaapjaaeaaaaaeacaaadoaaaaaoejaabaaookaabaaoeka
afaaaaadaaaaahiaaaaanbjaadaapkkaaeaaaaaeabaaaeiaaaaaaajaadaappka
aaaaaaibacaaaaadabaaaiiaaaaakkiaaaaaffiaaeaaaaaeacaaamoaabaaoeia
acaaoekaacaaeekaafaaaaadaaaaapiaaaaaffjaafaaoekaaeaaaaaeaaaaapia
aeaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaakkjaaaaaoeia
aeaaaaaeaaaaapiaahaaoekaaaaappjaaaaaoeiaaeaaaaaeaaaaadmaaaaappia
aaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaacaaaaapoaabaaoeja
abaaaaacabaaadoaacaaoejappppaaaafdeieefcbaacaaaaeaaaabaaieaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaa
diaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaa
kgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaa
abaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaa
abaaaaaaegbobaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
diaaaaaibcaabaaaaaaaaaaabkbabaaaaaaaaaaackiacaaaaaaaaaaaaeaaaaaa
dcaaaaalecaabaaaaaaaaaaaakbabaaaaaaaaaaadkiacaaaaaaaaaaaaeaaaaaa
akaabaiaebaaaaaaaaaaaaaaapaaaaaiicaabaaaaaaaaaaaegbabaaaaaaaaaaa
ogikcaaaaaaaaaaaaeaaaaaadcaaaaalmccabaaaadaaaaaakgaobaaaaaaaaaaa
kgiocaaaaaaaaaaaadaaaaaaagiecaaaaaaaaaaaadaaaaaadcaaaaaldccabaaa
adaaaaaaegbabaaaaaaaaaaaogikcaaaaaaaaaaaabaaaaaaegiacaaaaaaaaaaa
abaaaaaadoaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
faepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapaaaaaafdfgfpfagphdgjhegjgpgoaaedepemepfcaafeeffiedepep
fceeaakl"
}
}
Program "fp" {
SubProgram "opengl " {
Vector 0 [_ClipArgs0]
Vector 1 [_ClipArgs1]
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[3] = { program.local[0..1],
		{ 1 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
ABS R0.zw, fragment.texcoord[1];
ABS R0.xy, fragment.texcoord[1];
ADD R0.zw, -R0, c[2].x;
ADD R0.xy, -R0, c[2].x;
MUL R0.zw, R0, c[1].xyxy;
MUL R0.xy, R0, c[0];
MIN R0.z, R0, R0.w;
MIN R0.x, R0, R0.y;
MIN_SAT R0.x, R0, R0.z;
MUL result.color, R0.x, R1;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_ClipArgs0]
Vector 1 [_ClipArgs1]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c2, 1.00000000, 0, 0, 0
dcl v0
dcl t0.xy
dcl t1
texld r0, t0, s0
mul r2, r0, v0
abs r1.xy, t1
add r1.xy, -r1, c2.x
mul r1.xy, r1, c0
mov r0.y, t1.w
mov r0.x, t1.z
abs r0.xy, r0
add r0.xy, -r0, c2.x
mul r0.xy, r0, c1
min r0.x, r0, r0.y
min r1.x, r1, r1.y
min_sat r0.x, r1, r0
mul_pp r0, r0.x, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Vector 32 [_ClipArgs0]
Vector 64 [_ClipArgs1]
BindCB  "$Globals" 0
"ps_4_0
eefiecedbdoffecgmkljnakcpbblpgbpilcoonaiabaaaaaageacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
gphdgjhegjgpgoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefchaabaaaaeaaaaaaafmaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aaaaaaalpcaabaaaaaaaaaaaegbobaiambaaaaaaadaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdiaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaa
egiacaaaaaaaaaaaacaaaaaadiaaaaaimcaabaaaaaaaaaaakgaobaaaaaaaaaaa
agiecaaaaaaaaaaaaeaaaaaaddaaaaahfcaabaaaaaaaaaaafgahbaaaaaaaaaaa
agacbaaaaaaaaaaaddcaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaa
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaa
abaaaaaadiaaaaahpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Vector 32 [_ClipArgs0]
Vector 64 [_ClipArgs1]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedjjcndobhddonodelabmfdkdkjlhfolmgabaaaaaaoaadaaaaaeaaaaaa
daaaaaaakiabaaaacaadaaaakmadaaaaebgpgodjhaabaaaahaabaaaaaaacpppp
daabaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaacaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaaaaacppppfbaaaaaf
acaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaja
aaaiapkaecaaaaadaaaaapiaabaaoelaaaaioekacdaaaaacabaaadiaacaaoela
acaaaaadabaaadiaabaaoeibacaaaakaafaaaaadabaaadiaabaaoeiaaaaaoeka
akaaaaadacaaaiiaabaaffiaabaaaaiacdaaaaacabaaabiaacaakklacdaaaaac
abaaaciaacaapplaacaaaaadabaaadiaabaaoeibacaaaakaafaaaaadabaaadia
abaaoeiaabaaoekaakaaaaadacaaabiaabaaffiaabaaaaiaakaaaaadabaabbia
acaaaaiaacaappiaafaaaaadaaaacpiaaaaaoeiaaaaaoelaafaaaaadacaaciia
abaaaaiaaaaappiaafaaaaadacaachiaaaaaoeiaabaaaaiaabaaaaacaaaicpia
acaaoeiappppaaaafdeieefchaabaaaaeaaaaaaafmaaaaaafjaaaaaeegiocaaa
aaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
pcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaaaaaaal
pcaabaaaaaaaaaaaegbobaiambaaaaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdiaaaaaidcaabaaaaaaaaaaaegaabaaaaaaaaaaaegiacaaa
aaaaaaaaacaaaaaadiaaaaaimcaabaaaaaaaaaaakgaobaaaaaaaaaaaagiecaaa
aaaaaaaaaeaaaaaaddaaaaahfcaabaaaaaaaaaaafgahbaaaaaaaaaaaagacbaaa
aaaaaaaaddcaaaahbcaabaaaaaaaaaaackaabaaaaaaaaaaaakaabaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaa
diaaaaahpccabaaaaaaaaaaaagaabaaaaaaaaaaaegaobaaaabaaaaaadoaaaaab
ejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfagphdgjhegjgpgoaaedepemep
fcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
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