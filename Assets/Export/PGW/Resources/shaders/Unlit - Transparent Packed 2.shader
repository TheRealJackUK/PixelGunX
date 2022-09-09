Shader "Hidden/Unlit/Transparent Packed 2" {
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
  Blend SrcAlpha OneMinusSrcAlpha
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
		{ -2.0408571, 0.5, 0.50976563, 1 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
ADD R1, fragment.color.primary, -c[2].y;
FLR R1, -R1;
MOV_SAT R1, -R1;
MUL R0, R1, R0;
ADD R0.x, R0, R0.y;
ADD R0.x, R0, R0.z;
ADD R2.x, R0, R0.w;
MAD R0, R1, c[2].z, -fragment.color.primary;
MUL_SAT R0, R0, c[2].x;
ABS R1.zw, fragment.texcoord[1];
ABS R1.xy, fragment.texcoord[1];
ADD R1.zw, -R1, c[2].w;
ADD R1.xy, -R1, c[2].w;
MUL R1.zw, R1, c[1].xyxy;
MUL R1.xy, R1, c[0];
MIN R1.z, R1, R1.w;
MIN R1.x, R1, R1.y;
MIN_SAT R1.x, R1, R1.z;
MUL R0.w, R0, R1.x;
MUL result.color.w, R0, R2.x;
MOV result.color.xyz, R0;
END
# 22 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Vector 0 [_ClipArgs0]
Vector 1 [_ClipArgs1]
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c2, -0.50000000, 0.50976563, -2.04085708, 1.00000000
dcl v0
dcl t0.xy
dcl t1
texld r0, t0, s0
add_pp r1, v0, c2.x
frc_pp r2, -r1
add_pp r1, -r1, -r2
abs r2.xy, t1
add r2.xy, -r2, c2.w
mul r2.xy, r2, c0
mov_pp_sat r1, -r1
mul_pp r0, r1, r0
mad_pp r1, r1, c2.y, -v0
mul_pp_sat r3, r1, c2.z
add_pp r0.x, r0, r0.y
add_pp r0.x, r0, r0.z
min r2.x, r2, r2.y
add_pp r0.x, r0, r0.w
mov r1.y, t1.w
mov r1.x, t1.z
abs r1.xy, r1
add r1.xy, -r1, c2.w
mul r1.xy, r1, c1
min r1.x, r1, r1.y
min_sat r1.x, r2, r1
mul_pp r1.x, r3.w, r1
mov_pp r2.xyz, r3
mul_pp r2.w, r1.x, r0.x
mov_pp oC0, r2
"
}
SubProgram "d3d11 " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Vector 32 [_ClipArgs0]
Vector 64 [_ClipArgs1]
BindCB  "$Globals" 0
"ps_4_0
eefiecedklfkmeeaplibocmdnjmnhcmjgapbocgnabaaaaaakmadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaafdfgfpfa
gphdgjhegjgpgoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcliacaaaaeaaaaaaakoaaaaaafjaaaaae
egiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
aaaaaaakpcaabaaaaaaaaaaaegbobaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalp
aaaaaalpaaaaaalpeccaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaaaaaaaaah
bcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaajbcaabaaa
abaaaaaackaabaaaabaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaanpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaafmipacdpfmipacdp
fmipacdpfmipacdpegbobaiaebaaaaaaabaaaaaadicaaaakpcaabaaaaaaaaaaa
egaobaaaaaaaaaaaaceaaaaalmjmacmalmjmacmalmjmacmalmjmacmaaaaaaaal
pcaabaaaacaaaaaaegbobaiambaaaaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpdiaaaaaigcaabaaaabaaaaaaagabbaaaacaaaaaaagibcaaa
aaaaaaaaacaaaaaadiaaaaaidcaabaaaacaaaaaaogakbaaaacaaaaaaegiacaaa
aaaaaaaaaeaaaaaaddaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaaakaabaaa
acaaaaaaddaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkaabaaaabaaaaaa
ddcaaaahccaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaaabaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaadgaaaaafhccabaaa
aaaaaaaaegacbaaaaaaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaaabaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
SetTexture 0 [_MainTex] 2D 0
ConstBuffer "$Globals" 80
Vector 32 [_ClipArgs0]
Vector 64 [_ClipArgs1]
BindCB  "$Globals" 0
"ps_4_0_level_9_1
eefiecedgidefjicpklgjjghhihkkhfaonfijdoiabaaaaaalaafaaaaaeaaaaaa
daaaaaaadaacaaaapaaeaaaahmafaaaaebgpgodjpiabaaaapiabaaaaaaacpppp
liabaaaaeaaaaaaaacaaciaaaaaaeaaaaaaaeaaaabaaceaaaaaaeaaaaaaaaaaa
aaaaacaaabaaaaaaaaaaaaaaaaaaaeaaabaaabaaaaaaaaaaaaacppppfbaaaaaf
acaaapkaaaaaaalpfmipacdplmjmacmaaaaaiadpbpaaaaacaaaaaaiaaaaacpla
bpaaaaacaaaaaaiaabaaadlabpaaaaacaaaaaaiaacaaaplabpaaaaacaaaaaaja
aaaiapkaecaaaaadaaaacpiaabaaoelaaaaioekaacaaaaadabaacpiaaaaaoela
acaaaakabdaaaaacacaacpiaabaaoeibacaaaaadabaadpiaabaaoeiaacaaoeia
afaaaaadaaaacdiaaaaaoeiaabaaoeiaacaaaaadaaaacbiaaaaaffiaaaaaaaia
aeaaaaaeaaaacbiaaaaakkiaabaakkiaaaaaaaiaaeaaaaaeaaaacbiaaaaappia
abaappiaaaaaaaiaaeaaaaaeabaacpiaabaaoeiaacaaffkaaaaaoelbafaaaaad
abaadpiaabaaoeiaacaakkkacdaaaaacaaaaagiaacaanclaacaaaaadaaaaagia
aaaaoeibacaappkaafaaaaadaaaaagiaaaaaoeiaaaaanckaakaaaaadacaaabia
aaaakkiaaaaaffiacdaaaaacadaaabiaacaakklacdaaaaacadaaaciaacaappla
acaaaaadaaaaagiaadaancibacaappkaafaaaaadaaaaagiaaaaaoeiaabaancka
akaaaaadacaaaciaaaaakkiaaaaaffiaakaaaaadaaaabciaacaaffiaacaaaaia
afaaaaadaaaacciaaaaaffiaabaappiaafaaaaadabaaciiaaaaaaaiaaaaaffia
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefcliacaaaaeaaaaaaakoaaaaaa
fjaaaaaeegiocaaaaaaaaaaaafaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadpcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaaaaaaaakpcaabaaaaaaaaaaaegbobaaaabaaaaaaaceaaaaaaaaaaalp
aaaaaalpaaaaaalpaaaaaalpeccaaaafpcaabaaaaaaaaaaaegaobaaaaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
aaaaaaahbcaabaaaabaaaaaabkaabaaaabaaaaaaakaabaaaabaaaaaadcaaaaaj
bcaabaaaabaaaaaackaabaaaabaaaaaackaabaaaaaaaaaaaakaabaaaabaaaaaa
dcaaaaajbcaabaaaabaaaaaadkaabaaaabaaaaaadkaabaaaaaaaaaaaakaabaaa
abaaaaaadcaaaaanpcaabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaafmipacdp
fmipacdpfmipacdpfmipacdpegbobaiaebaaaaaaabaaaaaadicaaaakpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaaceaaaaalmjmacmalmjmacmalmjmacmalmjmacma
aaaaaaalpcaabaaaacaaaaaaegbobaiambaaaaaaadaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpdiaaaaaigcaabaaaabaaaaaaagabbaaaacaaaaaa
agibcaaaaaaaaaaaacaaaaaadiaaaaaidcaabaaaacaaaaaaogakbaaaacaaaaaa
egiacaaaaaaaaaaaaeaaaaaaddaaaaahicaabaaaabaaaaaabkaabaaaacaaaaaa
akaabaaaacaaaaaaddaaaaahccaabaaaabaaaaaackaabaaaabaaaaaabkaabaaa
abaaaaaaddcaaaahccaabaaaabaaaaaadkaabaaaabaaaaaabkaabaaaabaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaabkaabaaaabaaaaaadgaaaaaf
hccabaaaaaaaaaaaegacbaaaaaaaaaaadiaaaaahiccabaaaaaaaaaaaakaabaaa
abaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapapaaaa
fdfgfpfagphdgjhegjgpgoaaedepemepfcaafeeffiedepepfceeaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback Off
}