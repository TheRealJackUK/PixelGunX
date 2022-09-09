Shader "BlendModes/SpriteDefault/UnifiedGrab" {
Properties {
[PerRendererData]  _MainTex ("Sprite Texture", 2D) = "white" {}
 _Color ("Tint", Color) = (1,1,1,1)
[MaterialToggle]  PixelSnap ("Pixel snap", Float) = 0
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="true" }
 GrabPass {
  "_BMSharedGT"
 }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="true" }
  ZWrite Off
  Cull Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
Program "vp" {
SubProgram "opengl " {
Keywords { "BMDarken" "DUMMY" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarken" "DUMMY" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMDarken" "DUMMY" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarken" "DUMMY" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "BMDarken" "PIXELSNAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarken" "PIXELSNAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "BMDarken" "PIXELSNAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarken" "PIXELSNAP_ON" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMMultiply" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMMultiply" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMMultiply" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMMultiply" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMMultiply" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMMultiply" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMMultiply" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMMultiply" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMColorBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMColorBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMColorBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMColorBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMColorBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMColorBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMColorBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMColorBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMLinearBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMLinearBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMLinearBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMLinearBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMLinearBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMLinearBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMLinearBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMLinearBurn" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMDarkerColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMDarkerColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMDarkerColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMDarkerColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMDarkerColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMDarkerColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMDarkerColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMDarkerColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMLighten" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMLighten" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMLighten" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMLighten" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMLighten" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMLighten" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMLighten" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMLighten" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMScreen" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMScreen" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMScreen" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMScreen" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMScreen" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMScreen" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMScreen" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMScreen" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMColorDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMColorDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMColorDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMColorDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMColorDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMColorDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMColorDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMColorDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMLinearDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMLinearDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMLinearDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMLinearDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMLinearDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMLinearDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMLinearDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMLinearDodge" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMLighterColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMLighterColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMLighterColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMLighterColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMLighterColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMLighterColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMLighterColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMLighterColor" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMOverlay" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMOverlay" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMOverlay" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMOverlay" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMOverlay" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMOverlay" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMOverlay" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMOverlay" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMSoftLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMSoftLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMSoftLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMSoftLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMSoftLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMSoftLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMSoftLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMSoftLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMHardLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMHardLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMHardLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMHardLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMHardLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMHardLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMHardLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMHardLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMVividLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMVividLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMVividLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMVividLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMVividLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMVividLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMVividLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMVividLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMLinearLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMLinearLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMLinearLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMLinearLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMLinearLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMLinearLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMLinearLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMLinearLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMPinLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMPinLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMPinLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMPinLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMPinLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMPinLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMPinLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMPinLight" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMHardMix" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMHardMix" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMHardMix" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMHardMix" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMHardMix" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMHardMix" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMHardMix" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMHardMix" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMDifference" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMDifference" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMDifference" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMDifference" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMDifference" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMDifference" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMDifference" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMDifference" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMExclusion" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMExclusion" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMExclusion" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMExclusion" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMExclusion" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMExclusion" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMExclusion" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMExclusion" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMSubtract" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMSubtract" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMSubtract" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMSubtract" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMSubtract" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMSubtract" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMSubtract" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMSubtract" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMDivide" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_Color]
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[1], R0;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 8 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMDivide" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_Color]
"vs_2_0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mov oPos, r0
mul oD0, v1, c4
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMDivide" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0
eefiecedpnbmopijedlblilcegmipkhkecfffdlfabaaaaaalaacaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefciaabaaaaeaaaabaagaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaadpcbabaaa
aaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaae
pccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaa
acaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaa
aaaaaaaafgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaa
egaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaa
pgbpbaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaaaaaaaaaegaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMDivide" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerDraw" 1
"vs_4_0_level_9_1
eefiecedphgehmjgplfplkkjkgnhfadediemjlgfabaaaaaalmadaaaaaeaaaaaa
daaaaaaadiabaaaamaacaaaadaadaaaaebgpgodjaaabaaaaaaabaaaaaaacpopp
maaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
acaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefciaabaaaa
eaaaabaagaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaa
abaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
abaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaabaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
dgaaaaafpccabaaaaaaaaaaaegaobaaaaaaaaaaadgaaaaafpccabaaaadaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapaaaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMDivide" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Vector 5 [_ScreenParams]
Vector 6 [_Color]
"!!ARBvp1.0
PARAM c[7] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..6] };
TEMP R0;
TEMP R1;
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
DP4 R1.x, vertex.position, c[1];
RCP R0.z, R1.w;
MUL R0.zw, R1.xyxy, R0.z;
MAD R0.zw, R0, R0.xyxy, c[0].x;
FLR R0.zw, R0;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R0.zwzw, R0;
MUL result.position.xy, R0, R1.w;
MOV result.position.zw, R1;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[1], R1;
MOV result.texcoord[0].xy, vertex.texcoord[0];
END
# 18 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMDivide" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ScreenParams]
Vector 5 [_Color]
"vs_2_0
def c6, 0.50000000, -0.50000000, 0, 0
dcl_position0 v0
dcl_color0 v1
dcl_texcoord0 v2
mov r0.xy, c4
mul r0.zw, c6.x, r0.xyxy
dp4 r2.x, v0, c3
dp4 r0.y, v0, c1
dp4 r0.x, v0, c0
rcp r1.x, r2.x
mul r1.xy, r0, r1.x
mad r1.xy, r1, r0.zwzw, c6.x
frc r1.zw, r1.xyxy
add r1.xy, r1, -r1.zwzw
add r1.xy, r1, c6.yxzw
rcp r0.w, r0.w
rcp r0.z, r0.z
mul r0.zw, r1.xyxy, r0
mul oPos.xy, r0.zwzw, r2.x
dp4 r0.z, v0, c2
mov r0.w, r2.x
mov oPos.zw, r0
mul oD0, v1, c5
mov oT1, r0
mov oT0.xy, v2
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMDivide" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0
eefiecedlfegmahfmedbdhcehmiagobeaciihkababaaaaaahaadaaaaadaaaaaa
cmaaaaaajmaaaaaaciabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklfdeieefceaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaa
aaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaa
acaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaa
fpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaad
pccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaa
giaaaaacacaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaa
acaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaa
agbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
acaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaa
aoaaaaahdcaabaaaabaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaal
mcaabaaaabaaaaaaagiecaaaabaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaa
aaaaaadpaaaaaadpdiaaaaahdcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaa
abaaaaaaeaaaaaafdcaabaaaabaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaa
abaaaaaaegaabaaaabaaaaaaogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaa
pgapbaaaaaaaaaaaegaabaaaabaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaa
aaaaaaaadgaaaaafpccabaaaadaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaa
abaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaa
acaaaaaaegbabaaaacaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMDivide" }
Bind "vertex" Vertex
Bind "color" Color
Bind "texcoord" TexCoord0
ConstBuffer "$Globals" 32
Vector 16 [_Color]
ConstBuffer "UnityPerCamera" 128
Vector 96 [_ScreenParams]
ConstBuffer "UnityPerDraw" 336
Matrix 0 [glstate_matrix_mvp]
BindCB  "$Globals" 0
BindCB  "UnityPerCamera" 1
BindCB  "UnityPerDraw" 2
"vs_4_0_level_9_1
eefiecednemleholgokganipodaalpflemofcnheabaaaaaaeaafaaaaaeaaaaaa
daaaaaaapmabaaaaeeaeaaaaleaeaaaaebgpgodjmeabaaaameabaaaaaaacpopp
hiabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadabaaadiaaaaaoeiaabaaaaiaabaaaaac
acaaabiaahaaaakaafaaaaadabaaamiaacaaaaiaacaaeekaaeaaaaaeabaaadia
abaaoeiaabaaooiaahaaaakabdaaaaacacaaadiaabaaoeiaacaaaaadabaaadia
abaaoeiaacaaoeibagaaaaacacaaabiaabaakkiaagaaaaacacaaaciaabaappia
afaaaaadabaaadiaabaaoeiaacaaoeiaafaaaaadabaaamiaaaaappiaaaaaeeka
aeaaaaaeaaaaadmaabaaoeiaaaaappiaabaaooiaabaaaaacaaaaammaaaaaoeia
abaaaaacacaaapoaaaaaoeiaabaaaaacabaaadoaacaaoejappppaaaafdeieefc
eaacaaaaeaaaabaajaaaaaaafjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaae
egiocaaaabaaaaaaahaaaaaafjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagfaaaaadpccabaaaadaaaaaagiaaaaacacaaaaaadiaaaaai
pcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaaabaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaacaaaaaakgbkbaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
adaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaahdcaabaaaabaaaaaa
egaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaalmcaabaaaabaaaaaaagiecaaa
abaaaaaaagaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaadpaaaaaadpdiaaaaah
dcaabaaaabaaaaaaogakbaaaabaaaaaaegaabaaaabaaaaaaeaaaaaafdcaabaaa
abaaaaaaegaabaaaabaaaaaaaoaaaaahdcaabaaaabaaaaaaegaabaaaabaaaaaa
ogakbaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaaaaaaaaaaegaabaaa
abaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaadgaaaaafpccabaaa
adaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaabejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdej
feejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadamaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apaaaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "BMDarken" "DUMMY" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
MIN result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarken" "DUMMY" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
min_pp r0.xyz, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDarken" "DUMMY" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedfeioalcmhfppcbajippibfohdidmlcaoabaaaaaaimacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcjiabaaaaeaaaaaaaggaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaaddaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarken" "DUMMY" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedfkghbkjchpbhcpdlndnemppaanhpcdbdabaaaaaakiadaaaaaeaaaaaa
daaaaaaaeiabaaaaoiacaaaaheadaaaaebgpgodjbaabaaaabaabaaaaaaacpppp
oeaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaafaaaaadabaacpiaabaaoeiaaaaaoelaakaaaaad
acaachiaabaaoeiaaaaaoeiaabaaaaacacaaciiaabaappiaabaaaaacaaaicpia
acaaoeiappppaaaafdeieefcjiabaaaaeaaaaaaaggaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaa
adaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaaddaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
hkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMDarken" "PIXELSNAP_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
MIN result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarken" "PIXELSNAP_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
min_pp r0.xyz, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDarken" "PIXELSNAP_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedfeioalcmhfppcbajippibfohdidmlcaoabaaaaaaimacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcjiabaaaaeaaaaaaaggaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaaddaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarken" "PIXELSNAP_ON" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedfkghbkjchpbhcpdlndnemppaanhpcdbdabaaaaaakiadaaaaaeaaaaaa
daaaaaaaeiabaaaaoiacaaaaheadaaaaebgpgodjbaabaaaabaabaaaaaaacpppp
oeaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaafaaaaadabaacpiaabaaoeiaaaaaoelaakaaaaad
acaachiaabaaoeiaaaaaoeiaabaaaaacacaaciiaabaappiaabaaaaacaaaicpia
acaaoeiappppaaaafdeieefcjiabaaaaeaaaaaaaggaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaa
adaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaaddaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
hkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
MUL result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
mul_pp r0.xyz, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedkcjmhbddpiaoakokhgdfffofkeocdjigabaaaaaaimacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcjiabaaaaeaaaaaaaggaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefieceddfligmainpodedablgkmlpeahobnfnjlabaaaaaajmadaaaaaeaaaaaa
daaaaaaadmabaaaanmacaaaagiadaaaaebgpgodjaeabaaaaaeabaaaaaaacpppp
niaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaafaaaaadabaacpiaabaaoeiaaaaaoelaafaaaaad
abaachiaaaaaoeiaabaaoeiaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefc
jiabaaaaeaaaaaaaggaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
lcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaak
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaa
aaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egbobaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaabejfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
MUL result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
mul_pp r0.xyz, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedkcjmhbddpiaoakokhgdfffofkeocdjigabaaaaaaimacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcjiabaaaaeaaaaaaaggaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaadiaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefieceddfligmainpodedablgkmlpeahobnfnjlabaaaaaajmadaaaaaeaaaaaa
daaaaaaadmabaaaanmacaaaagiadaaaaebgpgodjaeabaaaaaeabaaaaaaacpppp
niaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaafaaaaadabaacpiaabaaoeiaaaaaoelaafaaaaad
abaachiaaaaaoeiaabaaoeiaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefc
jiabaaaaeaaaaaaaggaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaa
abaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaad
lcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaa
aaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaak
ecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaa
aaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaa
aagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egbobaaaabaaaaaadiaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaabejfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
RCP R0.x, R0.x;
RCP R0.y, R0.y;
RCP R0.z, R0.z;
ADD R1.xyz, -R1, c[0].x;
MAD result.color.xyz, -R1, R0, c[0].x;
MOV result.color.w, R0;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r0.xyz, -r0, c0.x
rcp_pp r1.x, r1.x
rcp_pp r1.z, r1.z
rcp_pp r1.y, r1.y
mad_pp r0.xyz, -r0, r1, c0.x
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedbilnelnidkeghckgnbobgfjakonnfhpaabaaaaaaoeacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpaabaaaaeaaaaaaahmaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaa
abaaaaaaaoaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaaaaaaaaalhccabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedpjjlihbgokogbohaabolpapepfbfihkpabaaaaaacmaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaapiadaaaaebgpgodjdmabaaaadmabaaaaaaacpppp
baabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaiadpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaacaaaaadaaaachiaaaaaoeibaaaakkkaafaaaaad
abaacpiaabaaoeiaaaaaoelaagaaaaacacaaabiaabaaaaiaagaaaaacacaaacia
abaaffiaagaaaaacacaaaeiaabaakkiaaeaaaaaeabaachiaaaaaoeiaacaaoeib
aaaakkkaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcpaabaaaaeaaaaaaa
hmaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegbobaaaabaaaaaaaoaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaaaaaaaaal
hccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
RCP R0.x, R0.x;
RCP R0.y, R0.y;
RCP R0.z, R0.z;
ADD R1.xyz, -R1, c[0].x;
MAD result.color.xyz, -R1, R0, c[0].x;
MOV result.color.w, R0;
END
# 14 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r0.xyz, -r0, c0.x
rcp_pp r1.x, r1.x
rcp_pp r1.z, r1.z
rcp_pp r1.y, r1.y
mad_pp r0.xyz, -r0, r1, c0.x
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedbilnelnidkeghckgnbobgfjakonnfhpaabaaaaaaoeacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpaabaaaaeaaaaaaahmaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaa
abaaaaaaaoaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaaaaaaaaalhccabaaaaaaaaaaa
egacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedpjjlihbgokogbohaabolpapepfbfihkpabaaaaaacmaeaaaaaeaaaaaa
daaaaaaaheabaaaagmadaaaapiadaaaaebgpgodjdmabaaaadmabaaaaaaacpppp
baabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaiadpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaacaaaaadaaaachiaaaaaoeibaaaakkkaafaaaaad
abaacpiaabaaoeiaaaaaoelaagaaaaacacaaabiaabaaaaiaagaaaaacacaaacia
abaaffiaagaaaaacacaaaeiaabaakkiaaeaaaaaeabaachiaaaaaoeiaacaaoeib
aaaakkkaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcpaabaaaaeaaaaaaa
hmaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
aaaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegbobaaaabaaaaaaaoaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaaaaaaaaal
hccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
ADD R0.xyz, R0, R1;
ADD result.color.xyz, R0, -c[0].x;
MOV result.color.w, R0;
END
# 11 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, -1.00000000, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r0.xyz, r1, r0
add_pp r0.xyz, r0, c0.z
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedjlgendbjbmbpjlhnagpnghgflcnobdeaabaaaaaalmacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcmiabaaaaeaaaaaaahcaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkbabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaakhccabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedkbgbjkilcjoikdoedlengldgkpifdkhgabaaaaaaoaadaaaaaeaaaaaa
daaaaaaafaabaaaacaadaaaakmadaaaaebgpgodjbiabaaaabiabaaaaaaacpppp
omaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaialpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaaeaaaaaeaaaachiaabaaoeiaaaaaoelaaaaaoeia
afaaaaadabaaciiaabaappiaaaaapplaacaaaaadabaachiaaaaaoeiaaaaakkka
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefcmiabaaaaeaaaaaaahcaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
adaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaa
aaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaabaaaaaaegacbaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkbabaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaakhccabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadoaaaaab
ejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
ADD R0.xyz, R0, R1;
ADD result.color.xyz, R0, -c[0].x;
MOV result.color.w, R0;
END
# 11 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, -1.00000000, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r0.xyz, r1, r0
add_pp r0.xyz, r0, c0.z
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedjlgendbjbmbpjlhnagpnghgflcnobdeaabaaaaaalmacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcmiabaaaaeaaaaaaahcaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
hcaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkbabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaakhccabaaaaaaaaaaaegacbaaa
aaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedkbgbjkilcjoikdoedlengldgkpifdkhgabaaaaaaoaadaaaaaeaaaaaa
daaaaaaafaabaaaacaadaaaakmadaaaaebgpgodjbiabaaaabiabaaaaaaacpppp
omaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaialpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaaeaaaaaeaaaachiaabaaoeiaaaaaoelaaaaaoeia
afaaaaadabaaciiaabaappiaaaaapplaacaaaaadabaachiaaaaaoeiaaaaakkka
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefcmiabaaaaeaaaaaaahcaaaaaa
fkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaa
adaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
akaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaia
ebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaa
aaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaajhcaabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaabaaaaaaegacbaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkbabaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaaaaaaakhccabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialpaaaaaaaadoaaaaab
ejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[2] = { { 0.29907227, 1, 0.5, 0.58691406 },
		{ 0.11401367 } };
TEMP R0;
TEMP R1;
TEMP R2;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0];
MAD R0.x, fragment.texcoord[1], R0, c[0].y;
MUL R1.y, R0, c[0].z;
MUL R1.x, R0, c[0].z;
TEX R1.xyz, R1, texture[1], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MUL R2.x, R0.y, c[0].w;
MUL R1.w, R1.y, c[0];
MAD R2.x, R0, c[0], R2;
MAD R1.w, R1.x, c[0].x, R1;
MAD R2.x, R0.z, c[1], R2;
MAD R1.w, R1.z, c[1].x, R1;
ADD R1.w, R1, -R2.x;
CMP result.color.xyz, R1.w, R1, R0;
MOV result.color.w, R0;
END
# 17 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0.58691406, 0.29907227
def c1, 0.11401367, 0, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.x, t1, r0, c0
mad r1.y, -r1.x, c0, c0.x
mul r1.x, r0, c0.y
texld r3, r1, s1
texld r0, t0, s0
mul r2, r0, v0
mul_pp r1.x, r2.y, c0.z
mul_pp r0.x, r3.y, c0.z
mad_pp r1.x, r2, c0.w, r1
mad_pp r0.x, r3, c0.w, r0
mad_pp r1.x, r2.z, c1, r1
mad_pp r0.x, r3.z, c1, r0
add_pp r0.x, r0, -r1
cmp_pp r0.xyz, r0.x, r2, r3
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedkkmkkfeoajcjakkmccgoihapmagmjfjfabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcamacaaaaeaaaaaaaidaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaabaaaaaakicaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaa
baaaaaakbcaabaaaacaaaaaaegacbaaaabaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaadbaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
acaaaaaadhaaaaajhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedbdfmgklpaaknbamlclehklfbpabdllenabaaaaaakmaeaaaaaeaaaaaa
daaaaaaaniabaaaaomadaaaahiaeaaaaebgpgodjkaabaaaakaabaaaaaaacpppp
heabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkanfhiojdnaaaaaaaaaaaaaaaaaaaaaaaa
fbaaaaafabaaapkaaaaaaadpaaaaaalpkcefbgdpihbgjjdobpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaiaacaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaacaaaaaiiaacaappla
afaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadiaaaaaoeiaabaaoeka
abaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaadabaaapiaabaaoela
aaaioekaafaaaaadaaaaciiaaaaaffiaabaakkkaaeaaaaaeaaaaciiaaaaaaaia
abaappkaaaaappiaaeaaaaaeaaaaciiaaaaakkiaaaaaaakaaaaappiaafaaaaad
abaacpiaabaaoeiaaaaaoelaafaaaaadacaaciiaabaaffiaabaakkkaaeaaaaae
acaacbiaabaaaaiaabaappkaacaappiaaeaaaaaeacaacbiaabaakkiaaaaaaaka
acaaaaiaacaaaaadaaaaaiiaaaaappiaacaaaaibfiaaaaaeabaachiaaaaappia
abaaoeiaaaaaoeiaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcamacaaaa
eaaaaaaaidaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaabaaaaaakicaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegbobaaaabaaaaaabaaaaaakbcaabaaaacaaaaaaegacbaaaabaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaadbaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaacaaaaaadhaaaaajhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[2] = { { 0.29907227, 1, 0.5, 0.58691406 },
		{ 0.11401367 } };
TEMP R0;
TEMP R1;
TEMP R2;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0];
MAD R0.x, fragment.texcoord[1], R0, c[0].y;
MUL R1.y, R0, c[0].z;
MUL R1.x, R0, c[0].z;
TEX R1.xyz, R1, texture[1], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MUL R2.x, R0.y, c[0].w;
MUL R1.w, R1.y, c[0];
MAD R2.x, R0, c[0], R2;
MAD R1.w, R1.x, c[0].x, R1;
MAD R2.x, R0.z, c[1], R2;
MAD R1.w, R1.z, c[1].x, R1;
ADD R1.w, R1, -R2.x;
CMP result.color.xyz, R1.w, R1, R0;
MOV result.color.w, R0;
END
# 17 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0.58691406, 0.29907227
def c1, 0.11401367, 0, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.x, t1, r0, c0
mad r1.y, -r1.x, c0, c0.x
mul r1.x, r0, c0.y
texld r3, r1, s1
texld r0, t0, s0
mul r2, r0, v0
mul_pp r1.x, r2.y, c0.z
mul_pp r0.x, r3.y, c0.z
mad_pp r1.x, r2, c0.w, r1
mad_pp r0.x, r3, c0.w, r0
mad_pp r1.x, r2.z, c1, r1
mad_pp r0.x, r3.z, c1, r0
add_pp r0.x, r0, -r1
cmp_pp r0.xyz, r0.x, r2, r3
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedkkmkkfeoajcjakkmccgoihapmagmjfjfabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcamacaaaaeaaaaaaaidaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaabaaaaaakicaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaa
baaaaaakbcaabaaaacaaaaaaegacbaaaabaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaadbaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaaakaabaaa
acaaaaaadhaaaaajhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedbdfmgklpaaknbamlclehklfbpabdllenabaaaaaakmaeaaaaaeaaaaaa
daaaaaaaniabaaaaomadaaaahiaeaaaaebgpgodjkaabaaaakaabaaaaaaacpppp
heabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkanfhiojdnaaaaaaaaaaaaaaaaaaaaaaaa
fbaaaaafabaaapkaaaaaaadpaaaaaalpkcefbgdpihbgjjdobpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaiaacaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaacaaaaaiiaacaappla
afaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadiaaaaaoeiaabaaoeka
abaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaadabaaapiaabaaoela
aaaioekaafaaaaadaaaaciiaaaaaffiaabaakkkaaeaaaaaeaaaaciiaaaaaaaia
abaappkaaaaappiaaeaaaaaeaaaaciiaaaaakkiaaaaaaakaaaaappiaafaaaaad
abaacpiaabaaoeiaaaaaoelaafaaaaadacaaciiaabaaffiaabaakkkaaeaaaaae
acaacbiaabaaaaiaabaappkaacaappiaaeaaaaaeacaacbiaabaakkiaaaaaaaka
acaaaaiaacaaaaadaaaaaiiaaaaappiaacaaaaibfiaaaaaeabaachiaaaaappia
abaaoeiaaaaaoeiaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcamacaaaa
eaaaaaaaidaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaabaaaaaakicaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegbobaaaabaaaaaabaaaaaakbcaabaaaacaaaaaaegacbaaaabaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaadbaaaaahicaabaaaaaaaaaaa
dkaabaaaaaaaaaaaakaabaaaacaaaaaadhaaaaajhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
MAX result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
max_pp r0.xyz, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedpbnameafkifiickddhnjcophombcaipeabaaaaaaimacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcjiabaaaaeaaaaaaaggaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaadeaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedokggodlbcapmdogngocmcepmfkiblociabaaaaaakiadaaaaaeaaaaaa
daaaaaaaeiabaaaaoiacaaaaheadaaaaebgpgodjbaabaaaabaabaaaaaaacpppp
oeaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaafaaaaadabaacpiaabaaoeiaaaaaoelaalaaaaad
acaachiaaaaaoeiaabaaoeiaabaaaaacacaaciiaabaappiaabaaaaacaaaicpia
acaaoeiappppaaaafdeieefcjiabaaaaeaaaaaaaggaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaa
adaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaadeaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
hkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
MAX result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
max_pp r0.xyz, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedpbnameafkifiickddhnjcophombcaipeabaaaaaaimacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcjiabaaaaeaaaaaaaggaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaadeaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedokggodlbcapmdogngocmcepmfkiblociabaaaaaakiadaaaaaeaaaaaa
daaaaaaaeiabaaaaoiacaaaaheadaaaaebgpgodjbaabaaaabaabaaaaaaacpppp
oeaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaafaaaaadabaacpiaabaaoeiaaaaaoelaalaaaaad
acaachiaaaaaoeiaabaaoeiaabaaaaacacaaciiaabaappiaabaaaaacaaaicpia
acaaoeiappppaaaafdeieefcjiabaaaaeaaaaaaaggaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaa
adaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaadeaaaaahhccabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
hkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
ADD R0.xyz, -R0, c[0].x;
ADD R1.xyz, -R1, c[0].x;
MAD result.color.xyz, -R1, R0, c[0].x;
MOV result.color.w, R0;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r1.xyz, -r1, c0.x
add_pp r0.xyz, -r0, c0.x
mad_pp r0.xyz, -r0, r1, c0.x
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedahcflfffocpehdlcdfdagdhnfjfcdnjdabaaaaaaaeadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbaacaaaaeaaaaaaaieaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaanhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaabaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaanhccabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedlkjdlnfkhnpeblllbgfdcfljpahbjidoabaaaaaadmaeaaaaaeaaaaaa
daaaaaaageabaaaahmadaaaaaiaeaaaaebgpgodjcmabaaaacmabaaaaaaacpppp
aaabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaiadpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaacaaaaadaaaachiaaaaaoeibaaaakkkaaeaaaaae
abaachiaabaaoeiaaaaaoelbaaaakkkaafaaaaadacaaciiaabaappiaaaaappla
aeaaaaaeacaachiaaaaaoeiaabaaoeibaaaakkkaabaaaaacaaaicpiaacaaoeia
ppppaaaafdeieefcbaacaaaaeaaaaaaaieaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaa
aaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaaaaaaaaaaegacbaia
ebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaanhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaabaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaanhccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
ADD R0.xyz, -R0, c[0].x;
ADD R1.xyz, -R1, c[0].x;
MAD result.color.xyz, -R1, R0, c[0].x;
MOV result.color.w, R0;
END
# 12 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r1.xyz, -r1, c0.x
add_pp r0.xyz, -r0, c0.x
mad_pp r0.xyz, -r0, r1, c0.x
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedahcflfffocpehdlcdfdagdhnfjfcdnjdabaaaaaaaeadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcbaacaaaaeaaaaaaaieaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaanhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaah
icaabaaaaaaaaaaadkaabaaaabaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadcaaaaanhccabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedlkjdlnfkhnpeblllbgfdcfljpahbjidoabaaaaaadmaeaaaaaeaaaaaa
daaaaaaageabaaaahmadaaaaaiaeaaaaebgpgodjcmabaaaacmabaaaaaaacpppp
aaabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaiadpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaacaaaaadaaaachiaaaaaoeibaaaakkkaaeaaaaae
abaachiaabaaoeiaaaaaoelbaaaakkkaafaaaaadacaaciiaabaappiaaaaappla
aeaaaaaeacaachiaaaaaoeiaabaaoeibaaaakkkaabaaaaacaaaicpiaacaaoeia
ppppaaaafdeieefcbaacaaaaeaaaaaaaieaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaa
aaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaaaaaaaaaaegacbaia
ebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaanhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaaabaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahicaabaaaaaaaaaaa
dkaabaaaabaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadcaaaaanhccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
ADD R0.xyz, -R0, c[0].x;
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
Keywords { "DUMMY" "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r1.xyz, -r1, c0.x
rcp_pp r1.x, r1.x
rcp_pp r1.z, r1.z
rcp_pp r1.y, r1.y
mul_pp r0.xyz, r0, r1
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedcfmomepbgklcdkmoiefadhlbcgcldhepabaaaaaamaacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcmmabaaaaeaaaaaaahdaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaan
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
abaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
aoaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedhpbkigaegbobiebmgefhiijnicpnmlpnabaaaaaaaiaeaaaaaeaaaaaa
daaaaaaaheabaaaaeiadaaaaneadaaaaebgpgodjdmabaaaadmabaaaaaaacpppp
baabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaiadpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaaeaaaaaeabaachiaabaaoeiaaaaaoelbaaaakkka
afaaaaadacaaciiaabaappiaaaaapplaagaaaaacadaaabiaabaaaaiaagaaaaac
adaaaciaabaaffiaagaaaaacadaaaeiaabaakkiaafaaaaadacaachiaaaaaoeia
adaaoeiaabaaaaacaaaicpiaacaaoeiappppaaaafdeieefcmmabaaaaeaaaaaaa
hdaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaanhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaabaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaaaoaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
hkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
ADD R0.xyz, -R0, c[0].x;
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
Keywords { "PIXELSNAP_ON" "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r1.xyz, -r1, c0.x
rcp_pp r1.x, r1.x
rcp_pp r1.z, r1.z
rcp_pp r1.y, r1.y
mul_pp r0.xyz, r0, r1
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedcfmomepbgklcdkmoiefadhlbcgcldhepabaaaaaamaacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcmmabaaaaeaaaaaaahdaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaan
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaa
abaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
aoaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedhpbkigaegbobiebmgefhiijnicpnmlpnabaaaaaaaiaeaaaaaeaaaaaa
daaaaaaaheabaaaaeiadaaaaneadaaaaebgpgodjdmabaaaadmabaaaaaaacpppp
baabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaiadpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaaeaaaaaeabaachiaabaaoeiaaaaaoelbaaaakkka
afaaaaadacaaciiaabaappiaaaaapplaagaaaaacadaaabiaabaaaaiaagaaaaac
adaaaciaabaaffiaagaaaaacadaaaeiaabaakkiaafaaaaadacaachiaaaaaoeia
adaaoeiaabaaaaacaaaicpiaacaaoeiappppaaaafdeieefcmmabaaaaeaaaaaaa
hdaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaae
aahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaa
bkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaaj
pcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaanhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaabaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaaaoaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
abaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
hkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
ADD result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r0.xyz, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecediijbadoilcfnbdinlbdidjamiomoceoeabaaaaaajeacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefckaabaaaaeaaaaaaagiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaadkaabaaaabaaaaaadkbabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedpjobfkfnpnklkpeoaompodeilfaeohogabaaaaaakiadaaaaaeaaaaaa
daaaaaaaeaabaaaaoiacaaaaheadaaaaebgpgodjaiabaaaaaiabaaaaaaacpppp
nmaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaaeaaaaaeaaaachiaabaaoeiaaaaaoelaaaaaoeia
afaaaaadaaaaciiaabaappiaaaaapplaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefckaabaaaaeaaaaaaagiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaak
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadp
dcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadp
abeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
abaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
dkaabaaaabaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaakaabaaa
aaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
hkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
ADD result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r0.xyz, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecediijbadoilcfnbdinlbdidjamiomoceoeabaaaaaajeacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefckaabaaaaeaaaaaaagiaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
hccabaaaaaaaaaaaegacbaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaa
diaaaaahbcaabaaaaaaaaaaadkaabaaaabaaaaaadkbabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedpjobfkfnpnklkpeoaompodeilfaeohogabaaaaaakiadaaaaaeaaaaaa
daaaaaaaeaabaaaaoiacaaaaheadaaaaebgpgodjaiabaaaaaiabaaaaaaacpppp
nmaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaaeaaaaaeaaaachiaabaaoeiaaaaaoelaaaaaoeia
afaaaaadaaaaciiaabaappiaaaaapplaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefckaabaaaaeaaaaaaagiaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaak
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadp
dcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadp
abeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
abaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaa
dkaabaaaabaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaaakaabaaa
aaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
hkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[2] = { { 0.29907227, 1, 0.5, 0.58691406 },
		{ 0.11401367 } };
TEMP R0;
TEMP R1;
TEMP R2;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0];
MAD R0.x, fragment.texcoord[1], R0, c[0].y;
MUL R1.y, R0, c[0].z;
MUL R1.x, R0, c[0].z;
TEX R1.xyz, R1, texture[1], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MUL R2.x, R0.y, c[0].w;
MUL R1.w, R1.y, c[0];
MAD R2.x, R0, c[0], R2;
MAD R1.w, R1.x, c[0].x, R1;
MAD R2.x, R0.z, c[1], R2;
MAD R1.w, R1.z, c[1].x, R1;
ADD R1.w, R1, -R2.x;
CMP result.color.xyz, -R1.w, R1, R0;
MOV result.color.w, R0;
END
# 17 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0.58691406, 0.29907227
def c1, 0.11401367, 0, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.x, t1, r0, c0
mad r1.y, -r1.x, c0, c0.x
mul r1.x, r0, c0.y
texld r3, r1, s1
texld r0, t0, s0
mul r2, r0, v0
mul_pp r1.x, r2.y, c0.z
mul_pp r0.x, r3.y, c0.z
mad_pp r1.x, r2, c0.w, r1
mad_pp r0.x, r3, c0.w, r0
mad_pp r1.x, r2.z, c1, r1
mad_pp r0.x, r3.z, c1, r0
add_pp r0.x, r0, -r1
cmp_pp r0.xyz, -r0.x, r2, r3
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedinifmfhkdfmkincfpnnfagcpnjfiplnfabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcamacaaaaeaaaaaaaidaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaabaaaaaakicaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaa
baaaaaakbcaabaaaacaaaaaaegacbaaaabaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaadbaaaaahicaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaa
aaaaaaaadhaaaaajhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecednnmemmofmcokfbpinckmaobkfoimeoglabaaaaaakmaeaaaaaeaaaaaa
daaaaaaaniabaaaaomadaaaahiaeaaaaebgpgodjkaabaaaakaabaaaaaaacpppp
heabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkanfhiojdnaaaaaaaaaaaaaaaaaaaaaaaa
fbaaaaafabaaapkaaaaaaadpaaaaaalpkcefbgdpihbgjjdobpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaiaacaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaacaaaaaiiaacaappla
afaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadiaaaaaoeiaabaaoeka
abaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaadabaaapiaabaaoela
aaaioekaafaaaaadaaaaciiaaaaaffiaabaakkkaaeaaaaaeaaaaciiaaaaaaaia
abaappkaaaaappiaaeaaaaaeaaaaciiaaaaakkiaaaaaaakaaaaappiaafaaaaad
abaacpiaabaaoeiaaaaaoelaafaaaaadacaaciiaabaaffiaabaakkkaaeaaaaae
acaacbiaabaaaaiaabaappkaacaappiaaeaaaaaeacaacbiaabaakkiaaaaaaaka
acaaaaiaacaaaaadaaaaaiiaaaaappibacaaaaiafiaaaaaeabaachiaaaaappia
abaaoeiaaaaaoeiaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcamacaaaa
eaaaaaaaidaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaabaaaaaakicaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegbobaaaabaaaaaabaaaaaakbcaabaaaacaaaaaaegacbaaaabaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaadbaaaaahicaabaaaaaaaaaaa
akaabaaaacaaaaaadkaabaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[2] = { { 0.29907227, 1, 0.5, 0.58691406 },
		{ 0.11401367 } };
TEMP R0;
TEMP R1;
TEMP R2;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0];
MAD R0.x, fragment.texcoord[1], R0, c[0].y;
MUL R1.y, R0, c[0].z;
MUL R1.x, R0, c[0].z;
TEX R1.xyz, R1, texture[1], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MUL R2.x, R0.y, c[0].w;
MUL R1.w, R1.y, c[0];
MAD R2.x, R0, c[0], R2;
MAD R1.w, R1.x, c[0].x, R1;
MAD R2.x, R0.z, c[1], R2;
MAD R1.w, R1.z, c[1].x, R1;
ADD R1.w, R1, -R2.x;
CMP result.color.xyz, -R1.w, R1, R0;
MOV result.color.w, R0;
END
# 17 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0.58691406, 0.29907227
def c1, 0.11401367, 0, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.x, t1, r0, c0
mad r1.y, -r1.x, c0, c0.x
mul r1.x, r0, c0.y
texld r3, r1, s1
texld r0, t0, s0
mul r2, r0, v0
mul_pp r1.x, r2.y, c0.z
mul_pp r0.x, r3.y, c0.z
mad_pp r1.x, r2, c0.w, r1
mad_pp r0.x, r3, c0.w, r0
mad_pp r1.x, r2.z, c1, r1
mad_pp r0.x, r3.z, c1, r0
add_pp r0.x, r0, -r1
cmp_pp r0.xyz, -r0.x, r2, r3
mov_pp r0.w, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedinifmfhkdfmkincfpnnfagcpnjfiplnfabaaaaaaaaadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcamacaaaaeaaaaaaaidaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaabaaaaaakicaabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaa
efaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaa
baaaaaakbcaabaaaacaaaaaaegacbaaaabaaaaaaaceaaaaaihbgjjdokcefbgdp
nfhiojdnaaaaaaaadbaaaaahicaabaaaaaaaaaaaakaabaaaacaaaaaadkaabaaa
aaaaaaaadhaaaaajhccabaaaaaaaaaaapgapbaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecednnmemmofmcokfbpinckmaobkfoimeoglabaaaaaakmaeaaaaaeaaaaaa
daaaaaaaniabaaaaomadaaaahiaeaaaaebgpgodjkaabaaaakaabaaaaaaacpppp
heabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkanfhiojdnaaaaaaaaaaaaaaaaaaaaaaaa
fbaaaaafabaaapkaaaaaaadpaaaaaalpkcefbgdpihbgjjdobpaaaaacaaaaaaia
aaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaiaacaaaplabpaaaaac
aaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaacaaaaaiiaacaappla
afaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadiaaaaaoeiaabaaoeka
abaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaadabaaapiaabaaoela
aaaioekaafaaaaadaaaaciiaaaaaffiaabaakkkaaeaaaaaeaaaaciiaaaaaaaia
abaappkaaaaappiaaeaaaaaeaaaaciiaaaaakkiaaaaaaakaaaaappiaafaaaaad
abaacpiaabaaoeiaaaaaoelaafaaaaadacaaciiaabaaffiaabaakkkaaeaaaaae
acaacbiaabaaaaiaabaappkaacaappiaaeaaaaaeacaacbiaabaakkiaaaaaaaka
acaaaaiaacaaaaadaaaaaiiaaaaappibacaaaaiafiaaaaaeabaachiaaaaappia
abaaoeiaaaaaoeiaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcamacaaaa
eaaaaaaaidaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaabaaaaaakicaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegbobaaaabaaaaaabaaaaaakbcaabaaaacaaaaaaegacbaaaabaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaadbaaaaahicaabaaaaaaaaaaa
akaabaaaacaaaaaadkaabaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaapgapbaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
ADD R3.xyz, -R1, c[0].x;
MUL R0.y, R0, c[0];
MUL R0.x, R0, c[0].y;
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
MUL R1.xyz, R1, R0;
ADD R2.xyz, -R0, c[0].x;
MUL R2.xyz, R2, R3;
MAD R2.xyz, -R2, c[0].z, c[0].x;
MUL R1.xyz, R1, c[0].z;
ADD R0.xyz, R0, -c[0].y;
CMP result.color.xyz, -R0, R2, R1;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 2.00000000, -0.50000000
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
mul_pp r2.xyz, r1, r0
add_pp r3.xyz, -r1, c0.x
add_pp r1.xyz, -r0, c0.x
mul_pp r1.xyz, r1, r3
mul_pp r2.xyz, r2, c0.z
mad_pp r1.xyz, -r1, c0.z, c0.x
add_pp r0.xyz, r0, c0.w
cmp_pp r0.xyz, -r0, r2, r1
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedgmhpifkgalhehfhfnnecfflnmelailinabaaaaaakeadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefclaacaaaaeaaaaaaakmaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaanhcaabaaaadaaaaaaegacbaiaebaaaaaaacaaaaaaegbcbaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahpcaabaaa
acaaaaaaegaobaaaacaaaaaaegbobaaaabaaaaaadcaaaaanhcaabaaaabaaaaaa
egacbaiaebaaaaaaabaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadbaaaaakhcaabaaaadaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaacaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadhaaaaaj
hccabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedljaibmhjmbcnneelnhgacpfngajgjckhabaaaaaadaafaaaaaeaaaaaa
daaaaaaaliabaaaahaaeaaaapmaeaaaaebgpgodjiaabaaaaiaabaaaaaaacpppp
feabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaiadpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaacaaaaadacaachiaaaaaoeibaaaakkkaacaaaaad
acaachiaacaaoeiaacaaoeiaaeaaaaaeadaachiaabaaoeiaaaaaoelbaaaakkka
afaaaaadabaacpiaabaaoeiaaaaaoelaaeaaaaaeacaachiaacaaoeiaadaaoeib
aaaakkkaacaaaaadadaaahiaaaaaoeibaaaaaakaafaaaaadaaaachiaaaaaoeia
abaaoeiaacaaaaadaaaachiaaaaaoeiaaaaaoeiafiaaaaaeabaachiaadaaoeia
aaaaoeiaacaaoeiaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefclaacaaaa
eaaaaaaakmaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaalhcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaanhcaabaaaadaaaaaaegacbaia
ebaaaaaaacaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegbobaaaabaaaaaa
dcaaaaanhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaadaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaakhcaabaaaadaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
ADD R3.xyz, -R1, c[0].x;
MUL R0.y, R0, c[0];
MUL R0.x, R0, c[0].y;
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
MUL R1.xyz, R1, R0;
ADD R2.xyz, -R0, c[0].x;
MUL R2.xyz, R2, R3;
MAD R2.xyz, -R2, c[0].z, c[0].x;
MUL R1.xyz, R1, c[0].z;
ADD R0.xyz, R0, -c[0].y;
CMP result.color.xyz, -R0, R2, R1;
END
# 17 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 2.00000000, -0.50000000
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
mul_pp r2.xyz, r1, r0
add_pp r3.xyz, -r1, c0.x
add_pp r1.xyz, -r0, c0.x
mul_pp r1.xyz, r1, r3
mul_pp r2.xyz, r2, c0.z
mad_pp r1.xyz, -r1, c0.z, c0.x
add_pp r0.xyz, r0, c0.w
cmp_pp r0.xyz, -r0, r2, r1
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedgmhpifkgalhehfhfnnecfflnmelailinabaaaaaakeadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefclaacaaaaeaaaaaaakmaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaa
efaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaanhcaabaaaadaaaaaaegacbaiaebaaaaaaacaaaaaaegbcbaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahpcaabaaa
acaaaaaaegaobaaaacaaaaaaegbobaaaabaaaaaadcaaaaanhcaabaaaabaaaaaa
egacbaiaebaaaaaaabaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadbaaaaakhcaabaaaadaaaaaaaceaaaaaaaaaaadpaaaaaadp
aaaaaadpaaaaaaaaegacbaaaaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaacaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadhaaaaaj
hccabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedljaibmhjmbcnneelnhgacpfngajgjckhabaaaaaadaafaaaaaeaaaaaa
daaaaaaaliabaaaahaaeaaaapmaeaaaaebgpgodjiaabaaaaiaabaaaaaaacpppp
feabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaiadpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaacaaaaadacaachiaaaaaoeibaaaakkkaacaaaaad
acaachiaacaaoeiaacaaoeiaaeaaaaaeadaachiaabaaoeiaaaaaoelbaaaakkka
afaaaaadabaacpiaabaaoeiaaaaaoelaaeaaaaaeacaachiaacaaoeiaadaaoeib
aaaakkkaacaaaaadadaaahiaaaaaoeibaaaaaakaafaaaaadaaaachiaaaaaoeia
abaaoeiaacaaaaadaaaachiaaaaaoeiaaaaaoeiafiaaaaaeabaachiaadaaoeia
aaaaoeiaacaaoeiaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefclaacaaaa
eaaaaaaakmaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaalhcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahhcaabaaaabaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaanhcaabaaaadaaaaaaegacbaia
ebaaaaaaacaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegbobaaaabaaaaaa
dcaaaaanhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaadaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaakhcaabaaaadaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaacaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaadaaaaaaegacbaaa
abaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R0.y, R0, c[0];
MUL R0.x, R0, c[0].y;
ADD R3.xyz, -R1, c[0].x;
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
ADD R2.xyz, -R0, c[0].x;
MAD R3.xyz, -R2, R3, c[0].x;
MUL R3.xyz, R0, R3;
MUL R0.xyz, R2, R0;
MAD result.color.xyz, R1, R0, R3;
END
# 15 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r2.xyz, -r0, c0.x
add_pp r3.xyz, -r1, c0.x
mad_pp r3.xyz, -r2, r3, c0.x
mul_pp r3.xyz, r0, r3
mul_pp r0.xyz, r2, r0
mad_pp r0.xyz, r1, r0, r3
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedkehgaljcnhajokbhiondkenmbfijfpbhabaaaaaagaadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcgmacaaaaeaaaaaaajlaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaanhcaabaaaadaaaaaaegacbaiaebaaaaaaacaaaaaa
egbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegbobaaaabaaaaaadcaaaaanhcaabaaa
adaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
adaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaacaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedhihimpbfbbdkekdhpaplchffhkignfpjabaaaaaammaeaaaaaeaaaaaa
daaaaaaajiabaaaaamaeaaaajiaeaaaaebgpgodjgaabaaaagaabaaaaaaacpppp
deabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaiadpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaacaaaaadacaachiaaaaaoeibaaaakkkaaeaaaaae
adaachiaabaaoeiaaaaaoelbaaaakkkaafaaaaadabaacpiaabaaoeiaaaaaoela
aeaaaaaeadaachiaacaaoeiaadaaoeibaaaakkkaafaaaaadacaachiaaaaaoeia
acaaoeiaafaaaaadaaaachiaaaaaoeiaadaaoeiaaeaaaaaeabaachiaacaaoeia
abaaoeiaaaaaoeiaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcgmacaaaa
eaaaaaaajlaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaalhcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaanhcaabaaaadaaaaaa
egacbaiaebaaaaaaacaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegbobaaa
abaaaaaadcaaaaanhcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaacaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R0.y, R0, c[0];
MUL R0.x, R0, c[0].y;
ADD R3.xyz, -R1, c[0].x;
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
ADD R2.xyz, -R0, c[0].x;
MAD R3.xyz, -R2, R3, c[0].x;
MUL R3.xyz, R0, R3;
MUL R0.xyz, R2, R0;
MAD result.color.xyz, R1, R0, R3;
END
# 15 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r2.xyz, -r0, c0.x
add_pp r3.xyz, -r1, c0.x
mad_pp r3.xyz, -r2, r3, c0.x
mul_pp r3.xyz, r0, r3
mul_pp r0.xyz, r2, r0
mad_pp r0.xyz, r1, r0, r3
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedkehgaljcnhajokbhiondkenmbfijfpbhabaaaaaagaadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcgmacaaaaeaaaaaaajlaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaanhcaabaaaadaaaaaaegacbaiaebaaaaaaacaaaaaa
egbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaah
pcaabaaaacaaaaaaegaobaaaacaaaaaaegbobaaaabaaaaaadcaaaaanhcaabaaa
adaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadiaaaaahhcaabaaaabaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
adaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaa
egacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaacaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedhihimpbfbbdkekdhpaplchffhkignfpjabaaaaaammaeaaaaaeaaaaaa
daaaaaaajiabaaaaamaeaaaajiaeaaaaebgpgodjgaabaaaagaabaaaaaaacpppp
deabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaiadpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaacaaaaadacaachiaaaaaoeibaaaakkkaaeaaaaae
adaachiaabaaoeiaaaaaoelbaaaakkkaafaaaaadabaacpiaabaaoeiaaaaaoela
aeaaaaaeadaachiaacaaoeiaadaaoeibaaaakkkaafaaaaadacaachiaaaaaoeia
acaaoeiaafaaaaadaaaachiaaaaaoeiaadaaoeiaaeaaaaaeabaachiaacaaoeia
abaaoeiaaaaaoeiaabaaaaacaaaicpiaabaaoeiappppaaaafdeieefcgmacaaaa
eaaaaaaajlaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaa
adaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaa
aaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaah
bcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaa
aaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadp
efaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaa
abaaaaaaaaaaaaalhcaabaaaabaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaanhcaabaaaadaaaaaa
egacbaiaebaaaaaaacaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaaegbobaaa
abaaaaaadcaaaaanhcaabaaaadaaaaaaegacbaiaebaaaaaaabaaaaaaegacbaaa
adaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahhcaabaaa
abaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaadaaaaaadcaaaaajhccabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaacaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0];
MAD R0.x, fragment.texcoord[1], R0, c[0].y;
MUL R0.y, R0, c[0].x;
MUL R0.x, R0, c[0];
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
MUL R2.xyz, R1, R0;
ADD R1.xyz, R1, -c[0].x;
MUL R2.xyz, R2, c[0].z;
MAD R3.xyz, -R1, c[0].z, c[0].y;
ADD R0.xyz, -R0, c[0].y;
MAD R0.xyz, -R0, R3, c[0].y;
CMP result.color.xyz, -R1, R0, R2;
END
# 16 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, -0.50000000, 2.00000000
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r2.xyz, r1, c0.z
mul_pp r1.xyz, r1, r0
mad_pp r3.xyz, -r2, c0.w, c0.x
add_pp r0.xyz, -r0, c0.x
mad_pp r0.xyz, -r0, r3, c0.x
mul_pp r1.xyz, r1, c0.w
cmp_pp r0.xyz, -r2, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedilffaddkiolejpkgmeanoggcafdhkghiabaaaaaameadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcnaacaaaaeaaaaaaaleaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamhcaabaaaadaaaaaaegacbaaaacaaaaaaegbcbaaa
abaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaadiaaaaahpcaabaaa
acaaaaaaegaobaaaacaaaaaaegbobaaaabaaaaaadcaaaabahcaabaaaadaaaaaa
egacbaiaebaaaaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaanhcaabaaaabaaaaaa
egacbaiaebaaaaaaabaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
dbaaaaakhcaabaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
egacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaacaaaaaadhaaaaaj
hccabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedfhpnmakijhafallmihdnpblpmbleklcfabaaaaaafiafaaaaaeaaaaaa
daaaaaaamaabaaaajiaeaaaaceafaaaaebgpgodjiiabaaaaiiabaaaaaaacpppp
fmabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaiadpaaaaaaea
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaacaaaaadacaachiaaaaaoeibaaaakkkaaeaaaaae
adaachiaabaaoeiaaaaaoelaaaaaffkaaeaaaaaeadaachiaadaaoeiaaaaappkb
aaaakkkaaeaaaaaeacaachiaacaaoeiaadaaoeibaaaakkkaafaaaaadadaacpia
abaaoeiaaaaaoelaaeaaaaaeabaaahiaabaaoeiaaaaaoelbaaaaaakaafaaaaad
aaaachiaaaaaoeiaadaaoeiaacaaaaadaaaachiaaaaaoeiaaaaaoeiafiaaaaae
adaachiaabaaoeiaaaaaoeiaacaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaa
fdeieefcnaacaaaaeaaaaaaaleaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaak
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadp
dcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadp
abeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaaegacbaaaacaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalp
aaaaaalpaaaaaalpaaaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egbobaaaabaaaaaadcaaaabahcaabaaaadaaaaaaegacbaiaebaaaaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadcaaaaanhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadbaaaaakhcaabaaaacaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaacaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaacaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheoieaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0];
MAD R0.x, fragment.texcoord[1], R0, c[0].y;
MUL R0.y, R0, c[0].x;
MUL R0.x, R0, c[0];
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
MUL R2.xyz, R1, R0;
ADD R1.xyz, R1, -c[0].x;
MUL R2.xyz, R2, c[0].z;
MAD R3.xyz, -R1, c[0].z, c[0].y;
ADD R0.xyz, -R0, c[0].y;
MAD R0.xyz, -R0, R3, c[0].y;
CMP result.color.xyz, -R1, R0, R2;
END
# 16 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, -0.50000000, 2.00000000
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r2.xyz, r1, c0.z
mul_pp r1.xyz, r1, r0
mad_pp r3.xyz, -r2, c0.w, c0.x
add_pp r0.xyz, -r0, c0.x
mad_pp r0.xyz, -r0, r3, c0.x
mul_pp r1.xyz, r1, c0.w
cmp_pp r0.xyz, -r2, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedilffaddkiolejpkgmeanoggcafdhkghiabaaaaaameadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcnaacaaaaeaaaaaaaleaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaa
abaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaefaaaaajpcaabaaaacaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamhcaabaaaadaaaaaaegacbaaaacaaaaaaegbcbaaa
abaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaadiaaaaahpcaabaaa
acaaaaaaegaobaaaacaaaaaaegbobaaaabaaaaaadcaaaabahcaabaaaadaaaaaa
egacbaiaebaaaaaaadaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadcaaaaanhcaabaaaabaaaaaa
egacbaiaebaaaaaaabaaaaaaegacbaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadiaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaa
dbaaaaakhcaabaaaacaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
egacbaaaacaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaacaaaaaadhaaaaaj
hccabaaaaaaaaaaaegacbaaaacaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedfhpnmakijhafallmihdnpblpmbleklcfabaaaaaafiafaaaaaeaaaaaa
daaaaaaamaabaaaajiaeaaaaceafaaaaebgpgodjiiabaaaaiiabaaaaaaacpppp
fmabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaiadpaaaaaaea
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaacaaaaadacaachiaaaaaoeibaaaakkkaaeaaaaae
adaachiaabaaoeiaaaaaoelaaaaaffkaaeaaaaaeadaachiaadaaoeiaaaaappkb
aaaakkkaaeaaaaaeacaachiaacaaoeiaadaaoeibaaaakkkaafaaaaadadaacpia
abaaoeiaaaaaoelaaeaaaaaeabaaahiaabaaoeiaaaaaoelbaaaaaakaafaaaaad
aaaachiaaaaaoeiaadaaoeiaacaaaaadaaaachiaaaaaoeiaaaaaoeiafiaaaaae
adaachiaabaaoeiaaaaaoeiaacaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaa
fdeieefcnaacaaaaeaaaaaaaleaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacaeaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaak
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadp
dcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadp
abeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaaabaaaaaaegacbaiaebaaaaaa
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaefaaaaajpcaabaaa
acaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaadaaaaaaegacbaaaacaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalp
aaaaaalpaaaaaalpaaaaaaaadiaaaaahpcaabaaaacaaaaaaegaobaaaacaaaaaa
egbobaaaabaaaaaadcaaaabahcaabaaaadaaaaaaegacbaiaebaaaaaaadaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadcaaaaanhcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaa
egacbaaaadaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadbaaaaakhcaabaaaacaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaacaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaacaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheoieaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, fragment.color.primary;
ADD R2.xyz, R1, -c[0].x;
MUL R1.xyz, R1, c[0].z;
MAD R3.xyz, -R2, c[0].z, c[0].y;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0];
MAD R0.x, fragment.texcoord[1], R0, c[0].y;
MUL R0.y, R0, c[0].x;
MUL R0.x, R0, c[0];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.z, R1.z;
RCP R3.x, R3.x;
RCP R3.z, R3.z;
RCP R3.y, R3.y;
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
ADD R4.xyz, -R0, c[0].y;
MAD R1.xyz, -R4, R1, c[0].y;
MUL R0.xyz, R0, R3;
CMP result.color.xyz, -R2, R0, R1;
END
# 22 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.50000000, 1.00000000, 0.50000000, 2.00000000
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0.y
mad r0.y, -r1.x, c0.z, c0
mad r0.x, t1, r0, c0.y
mul r0.x, r0, c0.z
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r2.xyz, r1, c0.x
mul_pp r1.xyz, r1, c0.w
mad_pp r3.xyz, -r2, c0.w, c0.y
rcp_pp r3.x, r3.x
rcp_pp r3.z, r3.z
rcp_pp r3.y, r3.y
mul_pp r3.xyz, r0, r3
add_pp r0.xyz, -r0, c0.y
rcp_pp r1.x, r1.x
rcp_pp r1.z, r1.z
rcp_pp r1.y, r1.y
mad_pp r0.xyz, -r0, r1, c0.y
cmp_pp r0.xyz, -r2, r0, r3
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedhccndaheegcamaahpggbgbdaanlgojmdabaaaaaaniadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcoeacaaaaeaaaaaaaljaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaacaaaaaaegacbaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalp
aaaaaalpaaaaaalpaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egbobaaaabaaaaaadcaaaabahcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaaaoaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaaaaaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaaoaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaadaaaaaaaaaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaakhcaabaaaabaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedgbogbleicmkeidhfdinbffbjmadhlbnhabaaaaaaleafaaaaaeaaaaaa
daaaaaaaaiacaaaapeaeaaaaiaafaaaaebgpgodjnaabaaaanaabaaaaaaacpppp
keabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaeaaaaaiadp
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaaeaaaaaeacaachiaabaaoeiaaaaaoelaaaaaffka
aeaaaaaeacaachiaacaaoeiaaaaakkkbaaaappkaagaaaaacadaaabiaacaaaaia
agaaaaacadaaaciaacaaffiaagaaaaacadaaaeiaacaakkiaafaaaaadacaachia
aaaaoeiaadaaoeiaacaaaaadaaaachiaaaaaoeibaaaappkaafaaaaadadaacpia
abaaoeiaaaaaoelaaeaaaaaeabaaahiaabaaoeiaaaaaoelbaaaaaakaacaaaaad
aeaachiaadaaoeiaadaaoeiaagaaaaacafaaabiaaeaaaaiaagaaaaacafaaacia
aeaaffiaagaaaaacafaaaeiaaeaakkiaaeaaaaaeaaaachiaaaaaoeiaafaaoeib
aaaappkafiaaaaaeadaachiaabaaoeiaaaaaoeiaacaaoeiaabaaaaacaaaicpia
adaaoeiappppaaaafdeieefcoeacaaaaeaaaaaaaljaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaa
adaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaa
acaaaaaaegacbaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalp
aaaaaalpaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaa
abaaaaaadcaaaabahcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaaoaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
aaaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaaoaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
adaaaaaaaaaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaakhcaabaaaabaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, fragment.color.primary;
ADD R2.xyz, R1, -c[0].x;
MUL R1.xyz, R1, c[0].z;
MAD R3.xyz, -R2, c[0].z, c[0].y;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0];
MAD R0.x, fragment.texcoord[1], R0, c[0].y;
MUL R0.y, R0, c[0].x;
MUL R0.x, R0, c[0];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.z, R1.z;
RCP R3.x, R3.x;
RCP R3.z, R3.z;
RCP R3.y, R3.y;
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
ADD R4.xyz, -R0, c[0].y;
MAD R1.xyz, -R4, R1, c[0].y;
MUL R0.xyz, R0, R3;
CMP result.color.xyz, -R2, R0, R1;
END
# 22 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, -0.50000000, 1.00000000, 0.50000000, 2.00000000
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0.y
mad r0.y, -r1.x, c0.z, c0
mad r0.x, t1, r0, c0.y
mul r0.x, r0, c0.z
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r2.xyz, r1, c0.x
mul_pp r1.xyz, r1, c0.w
mad_pp r3.xyz, -r2, c0.w, c0.y
rcp_pp r3.x, r3.x
rcp_pp r3.z, r3.z
rcp_pp r3.y, r3.y
mul_pp r3.xyz, r0, r3
add_pp r0.xyz, -r0, c0.y
rcp_pp r1.x, r1.x
rcp_pp r1.z, r1.z
rcp_pp r1.y, r1.y
mad_pp r0.xyz, -r0, r1, c0.y
cmp_pp r0.xyz, -r2, r0, r3
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedhccndaheegcamaahpggbgbdaanlgojmdabaaaaaaniadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcoeacaaaaeaaaaaaaljaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaacaaaaaaegacbaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalp
aaaaaalpaaaaaalpaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egbobaaaabaaaaaadcaaaabahcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaaaoaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaa
acaaaaaaaaaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaa
abaaaaaaegacbaaaabaaaaaaaoaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaadaaaaaaaaaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaakhcaabaaaabaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedgbogbleicmkeidhfdinbffbjmadhlbnhabaaaaaaleafaaaaaeaaaaaa
daaaaaaaaiacaaaapeaeaaaaiaafaaaaebgpgodjnaabaaaanaabaaaaaaacpppp
keabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaeaaaaaiadp
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaaeaaaaaeacaachiaabaaoeiaaaaaoelaaaaaffka
aeaaaaaeacaachiaacaaoeiaaaaakkkbaaaappkaagaaaaacadaaabiaacaaaaia
agaaaaacadaaaciaacaaffiaagaaaaacadaaaeiaacaakkiaafaaaaadacaachia
aaaaoeiaadaaoeiaacaaaaadaaaachiaaaaaoeibaaaappkaafaaaaadadaacpia
abaaoeiaaaaaoelaaeaaaaaeabaaahiaabaaoeiaaaaaoelbaaaaaakaacaaaaad
aeaachiaadaaoeiaadaaoeiaagaaaaacafaaabiaaeaaaaiaagaaaaacafaaacia
aeaaffiaagaaaaacafaaaeiaaeaakkiaaeaaaaaeaaaachiaaaaaoeiaafaaoeib
aaaappkafiaaaaaeadaachiaabaaoeiaaaaaoeiaacaaoeiaabaaaaacaaaicpia
adaaoeiappppaaaafdeieefcoeacaaaaeaaaaaaaljaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaa
adaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaa
acaaaaaaegacbaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalp
aaaaaalpaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaa
abaaaaaadcaaaabahcaabaaaacaaaaaaegacbaiaebaaaaaaacaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaaoaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
aaaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaaaaaaaahhcaabaaaadaaaaaaegacbaaaabaaaaaa
egacbaaaabaaaaaaaoaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
adaaaaaaaaaaaaalhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaakhcaabaaaabaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaa
aiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaa
apalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0];
MAD R0.x, fragment.texcoord[1], R0, c[0].y;
MUL R0.y, R0, c[0].x;
MUL R0.x, R0, c[0];
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
MAD R2.xyz, R1, c[0].z, R0;
ADD R1.xyz, R1, -c[0].x;
ADD R2.xyz, R2, -c[0].y;
MAD R0.xyz, R1, c[0].z, R0;
CMP result.color.xyz, -R1, R0, R2;
END
# 14 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, -0.50000000, 2.00000000
def c1, -1.00000000, 0, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r2.xyz, r1, c0.z
mad_pp r1.xyz, r1, c0.w, r0
mad_pp r0.xyz, r2, c0.w, r0
add_pp r1.xyz, r1, c1.x
cmp_pp r0.xyz, -r2, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedmhkkhopnfdcnapkfachppkobkfloebdpabaaaaaaheadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefciaacaaaaeaaaaaaakaaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaacaaaaaaegacbaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalp
aaaaaalpaaaaaalpaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egbobaaaabaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaadbaaaaakhcaabaaaabaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecednpcmdijfiiigodphmkmhhiigoagdkkddabaaaaaaoiaeaaaaaeaaaaaa
daaaaaaakaabaaaaciaeaaaaleaeaaaaebgpgodjgiabaaaagiabaaaaaaacpppp
dmabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaeaaaaaialp
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaaeaaaaaeacaachiaabaaoeiaaaaaoelaaaaaffka
aeaaaaaeacaachiaacaaoeiaaaaakkkaaaaaoeiaafaaaaadadaacpiaabaaoeia
aaaaoelaaeaaaaaeabaaahiaabaaoeiaaaaaoelbaaaaaakaaeaaaaaeaaaachia
adaaoeiaaaaakkkaaaaaoeiaacaaaaadaaaachiaaaaaoeiaaaaappkafiaaaaae
adaachiaabaaoeiaaaaaoeiaacaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaa
fdeieefciaacaaaaeaaaaaaakaaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaak
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadp
dcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadp
abeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaa
abaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaadcaaaaam
hcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaegacbaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaadbaaaaakhcaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaa
dhaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
aaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
hkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0];
MAD R0.x, fragment.texcoord[1], R0, c[0].y;
MUL R0.y, R0, c[0].x;
MUL R0.x, R0, c[0];
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
MAD R2.xyz, R1, c[0].z, R0;
ADD R1.xyz, R1, -c[0].x;
ADD R2.xyz, R2, -c[0].y;
MAD R0.xyz, R1, c[0].z, R0;
CMP result.color.xyz, -R1, R0, R2;
END
# 14 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, -0.50000000, 2.00000000
def c1, -1.00000000, 0, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r2.xyz, r1, c0.z
mad_pp r1.xyz, r1, c0.w, r0
mad_pp r0.xyz, r2, c0.w, r0
add_pp r1.xyz, r1, c1.x
cmp_pp r0.xyz, -r2, r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedmhkkhopnfdcnapkfachppkobkfloebdpabaaaaaaheadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefciaacaaaaeaaaaaaakaaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaacaaaaaaegacbaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalp
aaaaaalpaaaaaalpaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egbobaaaabaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaadcaaaaamhcaabaaa
aaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
egacbaaaaaaaaaaaaaaaaaakhcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaialpaaaaialpaaaaialpaaaaaaaadbaaaaakhcaabaaaabaaaaaaaceaaaaa
aaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaa
egacbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecednpcmdijfiiigodphmkmhhiigoagdkkddabaaaaaaoiaeaaaaaeaaaaaa
daaaaaaakaabaaaaciaeaaaaleaeaaaaebgpgodjgiabaaaagiabaaaaaaacpppp
dmabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaeaaaaaialp
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaaeaaaaaeacaachiaabaaoeiaaaaaoelaaaaaffka
aeaaaaaeacaachiaacaaoeiaaaaakkkaaaaaoeiaafaaaaadadaacpiaabaaoeia
aaaaoelaaeaaaaaeabaaahiaabaaoeiaaaaaoelbaaaaaakaaeaaaaaeaaaachia
adaaoeiaaaaakkkaaaaaoeiaacaaaaadaaaachiaaaaaoeiaaaaappkafiaaaaae
adaachiaabaaoeiaaaaaoeiaacaaoeiaabaaaaacaaaicpiaadaaoeiappppaaaa
fdeieefciaacaaaaeaaaaaaakaaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacadaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaak
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadp
dcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadp
abeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaacaaaaaaegacbaaa
abaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaadcaaaaam
hcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaegacbaaaaaaaaaaadcaaaaamhcaabaaaaaaaaaaaegacbaaaabaaaaaa
aceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaaaaaaaaaaaaaaaak
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaialpaaaaialpaaaaialp
aaaaaaaadbaaaaakhcaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaa
dhaaaaajhccabaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaaegacbaaa
aaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaa
hkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0];
MAD R0.x, fragment.texcoord[1], R0, c[0].y;
ADD R2.xyz, R1, -c[0].x;
MUL R3.xyz, R1, c[0].z;
MUL R0.y, R0, c[0].x;
MUL R0.x, R0, c[0];
MUL R1.xyz, R2, c[0].z;
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
Keywords { "DUMMY" "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, -0.50000000, 2.00000000
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r2.xyz, r1, c0.z
mul_pp r3.xyz, r2, c0.w
max_pp r3.xyz, r0, r3
mul_pp r1.xyz, r1, c0.w
min_pp r0.xyz, r0, r1
cmp_pp r0.xyz, -r2, r0, r3
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedhgbhdpjnopeabgiphphmfmfmfpljoofpabaaaaaafmadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcgiacaaaaeaaaaaaajkaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaacaaaaaaegacbaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalp
aaaaaalpaaaaaalpaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egbobaaaabaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaadeaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
aaaaaaahhcaabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaddaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaadbaaaaakhcaabaaa
abaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadhaaaaajhccabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefieceddcahomehoojggibcnhimihepddcgoiakabaaaaaaniaeaaaaaeaaaaaa
daaaaaaakiabaaaabiaeaaaakeaeaaaaebgpgodjhaabaaaahaabaaaaaaacpppp
eeabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaaeaaaaaeacaachiaabaaoeiaaaaaoelaaaaaffka
acaaaaadacaachiaacaaoeiaacaaoeiaalaaaaadadaachiaaaaaoeiaacaaoeia
afaaaaadacaacpiaabaaoeiaaaaaoelaaeaaaaaeabaaahiaabaaoeiaaaaaoelb
aaaaaakaacaaaaadaeaachiaacaaoeiaacaaoeiaakaaaaadafaachiaaeaaoeia
aaaaoeiafiaaaaaeacaachiaabaaoeiaafaaoeiaadaaoeiaabaaaaacaaaicpia
acaaoeiappppaaaafdeieefcgiacaaaaeaaaaaaajkaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaa
adaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaa
acaaaaaaegacbaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalp
aaaaaalpaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaa
abaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
deaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaah
hcaabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaddaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaadbaaaaakhcaabaaaabaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheoieaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0];
MAD R0.x, fragment.texcoord[1], R0, c[0].y;
ADD R2.xyz, R1, -c[0].x;
MUL R3.xyz, R1, c[0].z;
MUL R0.y, R0, c[0].x;
MUL R0.x, R0, c[0];
MUL R1.xyz, R2, c[0].z;
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
Keywords { "PIXELSNAP_ON" "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, -0.50000000, 2.00000000
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r2.xyz, r1, c0.z
mul_pp r3.xyz, r2, c0.w
max_pp r3.xyz, r0, r3
mul_pp r1.xyz, r1, c0.w
min_pp r0.xyz, r0, r1
cmp_pp r0.xyz, -r2, r0, r3
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedhgbhdpjnopeabgiphphmfmfmfpljoofpabaaaaaafmadaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcgiacaaaaeaaaaaaajkaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaam
hcaabaaaacaaaaaaegacbaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalp
aaaaaalpaaaaaalpaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaa
egbobaaaabaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaa
acaaaaaadeaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaa
aaaaaaahhcaabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaddaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaadbaaaaakhcaabaaa
abaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadhaaaaajhccabaaaaaaaaaaa
egacbaaaabaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefieceddcahomehoojggibcnhimihepddcgoiakabaaaaaaniaeaaaaaeaaaaaa
daaaaaaakiabaaaabiaeaaaakeaeaaaaebgpgodjhaabaaaahaabaaaaaaacpppp
eeabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaaeaaaaaeacaachiaabaaoeiaaaaaoelaaaaaffka
acaaaaadacaachiaacaaoeiaacaaoeiaalaaaaadadaachiaaaaaoeiaacaaoeia
afaaaaadacaacpiaabaaoeiaaaaaoelaaeaaaaaeabaaahiaabaaoeiaaaaaoelb
aaaaaakaacaaaaadaeaachiaacaaoeiaacaaoeiaakaaaaadafaachiaaeaaoeia
aaaaoeiafiaaaaaeacaachiaabaaoeiaafaaoeiaadaaoeiaabaaaaacaaaicpia
acaaoeiappppaaaafdeieefcgiacaaaaeaaaaaaajkaaaaaafkaaaaadaagabaaa
aaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
fibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacaeaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaa
adaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaa
abeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaa
abeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaa
aaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaa
acaaaaaaegacbaaaabaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalp
aaaaaalpaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaa
abaaaaaaaaaaaaahhcaabaaaacaaaaaaegacbaaaacaaaaaaegacbaaaacaaaaaa
deaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaacaaaaaaaaaaaaah
hcaabaaaadaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaaddaaaaahhcaabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaadaaaaaadbaaaaakhcaabaaaabaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaabaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaa
abaaaaaaegacbaaaacaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheoieaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 0 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1].x, R0.x, c[0].x;
MAD R0.z, fragment.texcoord[1].y, R0.x, c[0].x;
MUL R0.x, R0.y, c[0].y;
MUL R0.y, R0.z, c[0];
TEX R1.xyz, R0, texture[1], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
ADD R1.xyz, -R1, c[0].x;
ADD R0.xyz, R0, -R1;
CMP R0.xyz, -R0, c[0].x, c[0].z;
MOV result.color.xyz, R0;
MOV result.color.w, R0;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0.00000000, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r1.x, t1.w
mad r0.x, t1, r1, c0
mad r1.x, t1.y, r1, c0
mad r0.y, -r1.x, c0, c0.x
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r0.xyz, -r0, c0.x
add_pp r0.xyz, r1, -r0
cmp r0.xyz, -r0, c0.z, c0.x
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedgpdeffchhnkmgcoggkjdiidahnbifbhkabaaaaaaoaacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcomabaaaaeaaaaaaahlaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaa
abaaaaaadbaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaaabaaaaakhccabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedhjpcipbammobmeeljhedbnpicbldecgdabaaaaaabiaeaaaaaeaaaaaa
daaaaaaageabaaaafiadaaaaoeadaaaaebgpgodjcmabaaaacmabaaaaaaacpppp
aaabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaiadpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaacaaaaadaaaachiaaaaaoeibaaaakkkaaeaaaaae
aaaaahiaabaaoeiaaaaaoelbaaaaoeiaafaaaaadabaaciiaabaappiaaaaappla
fiaaaaaeabaachiaaaaaoeiaaaaappkaaaaakkkaabaaaaacaaaicpiaabaaoeia
ppppaaaafdeieefcomabaaaaeaaaaaaahlaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaa
aaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaaaaaaaaaaegacbaia
ebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaadbaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaaabaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheoieaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 0 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1].x, R0.x, c[0].x;
MAD R0.z, fragment.texcoord[1].y, R0.x, c[0].x;
MUL R0.x, R0.y, c[0].y;
MUL R0.y, R0.z, c[0];
TEX R1.xyz, R0, texture[1], 2D;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
ADD R1.xyz, -R1, c[0].x;
ADD R0.xyz, R0, -R1;
CMP R0.xyz, -R0, c[0].x, c[0].z;
MOV result.color.xyz, R0;
MOV result.color.w, R0;
END
# 13 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0.00000000, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r1.x, t1.w
mad r0.x, t1, r1, c0
mad r1.x, t1.y, r1, c0
mad r0.y, -r1.x, c0, c0.x
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r0.xyz, -r0, c0.x
add_pp r0.xyz, r1, -r0
cmp r0.xyz, -r0, c0.z, c0.x
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedgpdeffchhnkmgcoggkjdiidahnbifbhkabaaaaaaoaacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcomabaaaaeaaaaaaahlaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaa
aaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaa
abaaaaaadbaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaaabaaaaakhccabaaaaaaaaaaa
egacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedhjpcipbammobmeeljhedbnpicbldecgdabaaaaaabiaeaaaaaeaaaaaa
daaaaaaageabaaaafiadaaaaoeadaaaaebgpgodjcmabaaaacmabaaaaaaacpppp
aaabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaiadpaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaacaaaaadaaaachiaaaaaoeibaaaakkkaaeaaaaae
aaaaahiaabaaoeiaaaaaoelbaaaaoeiaafaaaaadabaaciiaabaappiaaaaappla
fiaaaaaeabaachiaaaaaoeiaaaaappkaaaaakkkaabaaaaacaaaicpiaabaaoeia
ppppaaaafdeieefcomabaaaaeaaaaaaahlaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaa
aaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaaaaaaaalhcaabaaaaaaaaaaaegacbaia
ebaaaaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaefaaaaaj
pcaabaaaabaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaadbaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaaabaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheoieaaaaaa
aeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
heaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaa
adaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
ADD R0.xyz, -R0, R1;
ABS result.color.xyz, R0;
MOV result.color.w, R0;
END
# 11 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r0.xyz, -r1, r0
abs_pp r0.xyz, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedmhdbalkiliapppinghpapngedomjppgpabaaaaaalaacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefclmabaaaaeaaaaaaagpaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaaabaaaaaaegacbaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkbabaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaaghccabaaaaaaaaaaa
egacbaiaibaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedbfpdhnkmloamljjclnjgpniaefaaflglabaaaaaanaadaaaaaeaaaaaa
daaaaaaaemabaaaabaadaaaajmadaaaaebgpgodjbeabaaaabeabaaaaaaacpppp
oiaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaaeaaaaaeaaaachiaabaaoeiaaaaaoelbaaaaoeia
afaaaaadabaaciiaabaappiaaaaapplacdaaaaacabaachiaaaaaoeiaabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefclmabaaaaeaaaaaaagpaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaaabaaaaaaegacbaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkbabaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaaghccabaaaaaaaaaaa
egacbaiaibaaaaaaaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
ADD R0.xyz, -R0, R1;
ABS result.color.xyz, R0;
MOV result.color.w, R0;
END
# 11 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r0.xyz, -r1, r0
abs_pp r0.xyz, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedmhdbalkiliapppinghpapngedomjppgpabaaaaaalaacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefclmabaaaaeaaaaaaagpaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaaabaaaaaaegacbaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkbabaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaaghccabaaaaaaaaaaa
egacbaiaibaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedbfpdhnkmloamljjclnjgpniaefaaflglabaaaaaanaadaaaaaeaaaaaa
daaaaaaaemabaaaabaadaaaajmadaaaaebgpgodjbeabaaaabeabaaaaaaacpppp
oiaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaaeaaaaaeaaaachiaabaaoeiaaaaaoelbaaaaoeia
afaaaaadabaaciiaabaappiaaaaapplacdaaaaacabaachiaaaaaoeiaabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefclmabaaaaeaaaaaaagpaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaak
hcaabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaaabaaaaaaegacbaaa
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaabaaaaaadkbabaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaaghccabaaaaaaaaaaa
egacbaiaibaaaaaaaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaa
giaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheo
cmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaa
apaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R0.y, R0, c[0];
MUL R0.x, R0, c[0].y;
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
ADD R2.xyz, R1, R0;
MUL R0.xyz, R1, R0;
MAD result.color.xyz, -R0, c[0].z, R2;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 2.00000000, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r2.xyz, r1, r0
mul_pp r0.xyz, r1, r0
mad_pp r0.xyz, -r0, c0.z, r2
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedikahjchjfppiicfhnifieodpahiacdbjabaaaaaaoeacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpaabaaaaeaaaaaaahmaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaanhccabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaacaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedbmnipbkbdccoiinbnefkhhlmcdjkolocabaaaaaabmaeaaaaaeaaaaaa
daaaaaaageabaaaafmadaaaaoiadaaaaebgpgodjcmabaaaacmabaaaaaaacpppp
aaabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaeaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaaeaaaaaeacaachiaabaaoeiaaaaaoelaaaaaoeia
afaaaaadabaacpiaabaaoeiaaaaaoelaafaaaaadaaaachiaaaaaoeiaabaaoeia
aeaaaaaeabaachiaaaaaoeiaaaaakkkbacaaoeiaabaaaaacaaaicpiaabaaoeia
ppppaaaafdeieefcpaabaaaaeaaaaaaahmaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaa
aaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaanhccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R1, fragment.texcoord[0], texture[0], 2D;
MUL R1, R1, fragment.color.primary;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R0.y, R0, c[0];
MUL R0.x, R0, c[0].y;
MOV result.color.w, R1;
TEX R0.xyz, R0, texture[1], 2D;
ADD R2.xyz, R1, R0;
MUL R0.xyz, R1, R0;
MAD result.color.xyz, -R0, c[0].z, R2;
END
# 12 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 2.00000000, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r2.xyz, r1, r0
mul_pp r0.xyz, r1, r0
mad_pp r0.xyz, -r0, c0.z, r2
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedikahjchjfppiicfhnifieodpahiacdbjabaaaaaaoeacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcpaabaaaaeaaaaaaahmaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaaj
hcaabaaaacaaaaaaegacbaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaa
diaaaaahpcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaadiaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaabaaaaaadcaaaaanhccabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaacaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedbmnipbkbdccoiinbnefkhhlmcdjkolocabaaaaaabmaeaaaaaeaaaaaa
daaaaaaageabaaaafmadaaaaoiadaaaaebgpgodjcmabaaaacmabaaaaaaacpppp
aaabaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaeaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaaeaaaaaeacaachiaabaaoeiaaaaaoelaaaaaoeia
afaaaaadabaacpiaabaaoeiaaaaaoelaafaaaaadaaaachiaaaaaoeiaabaaoeia
aeaaaaaeabaachiaaaaaoeiaaaaakkkbacaaoeiaabaaaaacaaaicpiaabaaoeia
ppppaaaafdeieefcpaabaaaaeaaaaaaahmaaaaaafkaaaaadaagabaaaaaaaaaaa
fkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaae
aahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaa
acaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaa
aaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaa
aaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaa
aaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaa
eghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaajhcaabaaaacaaaaaa
egacbaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaahpcaabaaa
abaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaadiaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
abaaaaaadcaaaaanhccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaa
aaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaegacbaaaacaaaaaadoaaaaabejfdeheo
ieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaahkaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaaaaaaaaaa
adaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
ADD result.color.xyz, -R0, R1;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r0.xyz, -r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecediojpenmjidaenkgdgmppnphjlfabmonpabaaaaaajiacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefckeabaaaaeaaaaaaagjaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaak
hccabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaaabaaaaaaegacbaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaadkaabaaaabaaaaaadkbabaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedemlcnmipgcdkbhbgiihfdekhiolhdmnfabaaaaaakmadaaaaaeaaaaaa
daaaaaaaeaabaaaaomacaaaahiadaaaaebgpgodjaiabaaaaaiabaaaaaaacpppp
nmaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaaeaaaaaeaaaachiaabaaoeiaaaaaoelbaaaaoeia
afaaaaadaaaaciiaabaappiaaaaapplaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefckeabaaaaeaaaaaaagjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaak
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadp
dcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadp
abeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaaegacbaia
ebaaaaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaadkaabaaaabaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
akaabaaaaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
ADD result.color.xyz, -R0, R1;
MOV result.color.w, R0;
END
# 10 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
add_pp r0.xyz, -r1, r0
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecediojpenmjidaenkgdgmppnphjlfabmonpabaaaaaajiacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefckeabaaaaeaaaaaaagjaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaak
hccabaaaaaaaaaaaegacbaiaebaaaaaaabaaaaaaegbcbaaaabaaaaaaegacbaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaadkaabaaaabaaaaaadkbabaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaaakaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedemlcnmipgcdkbhbgiihfdekhiolhdmnfabaaaaaakmadaaaaaeaaaaaa
daaaaaaaeaabaaaaomacaaaahiadaaaaebgpgodjaiabaaaaaiabaaaaaaacpppp
nmaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaaeaaaaaeaaaachiaabaaoeiaaaaaoelbaaaaoeia
afaaaaadaaaaciiaabaappiaaaaapplaabaaaaacaaaicpiaaaaaoeiappppaaaa
fdeieefckeabaaaaeaaaaaaagjaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaak
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadp
dcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadp
abeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaakhccabaaaaaaaaaaaegacbaia
ebaaaaaaabaaaaaaegbcbaaaabaaaaaaegacbaaaaaaaaaaadiaaaaahbcaabaaa
aaaaaaaadkaabaaaabaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
akaabaaaaaaaaaaadoaaaaabejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
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
Keywords { "DUMMY" "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
rcp_pp r1.x, r1.x
rcp_pp r1.z, r1.z
rcp_pp r1.y, r1.y
mul_pp r0.xyz, r0, r1
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedpdfmkgbpkfeacmfljopemhjcfdhfhleoabaaaaaaimacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcjiabaaaaeaaaaaaaggaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaaaoaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedeebmibhmggdffjbaipgpekjcamkkicpmabaaaaaamaadaaaaaeaaaaaa
daaaaaaagaabaaaaaaadaaaaimadaaaaebgpgodjciabaaaaciabaaaaaaacpppp
pmaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaafaaaaadabaacpiaabaaoeiaaaaaoelaagaaaaac
acaaabiaabaaaaiaagaaaaacacaaaciaabaaffiaagaaaaacacaaaeiaabaakkia
afaaaaadabaachiaaaaaoeiaacaaoeiaabaaaaacaaaicpiaabaaoeiappppaaaa
fdeieefcjiabaaaaeaaaaaaaggaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaak
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadp
dcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadp
abeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegbobaaaabaaaaaaaoaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab
ejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.5 } };
TEMP R0;
TEMP R1;
RCP R0.x, fragment.texcoord[1].w;
MAD R0.y, fragment.texcoord[1], R0.x, c[0].x;
MAD R0.x, fragment.texcoord[1], R0, c[0];
MUL R1.y, R0, c[0];
MUL R1.x, R0, c[0].y;
TEX R0, fragment.texcoord[0], texture[0], 2D;
TEX R1.xyz, R1, texture[1], 2D;
MUL R0, R0, fragment.color.primary;
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
Keywords { "PIXELSNAP_ON" "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_2_0
dcl_2d s0
dcl_2d s1
def c0, 1.00000000, 0.50000000, 0, 0
dcl v0
dcl t0.xy
dcl t1.xyzw
rcp r0.x, t1.w
mad r1.x, t1.y, r0, c0
mad r0.y, -r1.x, c0, c0.x
mad r0.x, t1, r0, c0
mul r0.x, r0, c0.y
texld r0, r0, s1
texld r1, t0, s0
mul r1, r1, v0
rcp_pp r1.x, r1.x
rcp_pp r1.z, r1.z
rcp_pp r1.y, r1.y
mul_pp r0.xyz, r0, r1
mov_pp r0.w, r1
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0
eefiecedpdfmkgbpkfeacmfljopemhjcfdhfhleoabaaaaaaimacaaaaadaaaaaa
cmaaaaaaliaaaaaaomaaaaaaejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaahkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaahkaaaaaaabaaaaaaaaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklklfdeieefcjiabaaaaeaaaaaaaggaaaaaafkaaaaad
aagabaaaaaaaaaaafkaaaaadaagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaafibiaaaeaahabaaaabaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaaoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaa
pgbpbaaaadaaaaaaaaaaaaakdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaaaaaaaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaa
aaaaaaaaabeaaaaaaaaaaadpdcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaa
aaaaaaaaabeaaaaaaaaaaadpabeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaa
igaabaaaaaaaaaaaeghobaaaabaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaa
abaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaah
pcaabaaaabaaaaaaegaobaaaabaaaaaaegbobaaaabaaaaaaaoaaaaahhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
SetTexture 1 [_BMSharedGT] 2D 1
"ps_4_0_level_9_1
eefiecedeebmibhmggdffjbaipgpekjcamkkicpmabaaaaaamaadaaaaaeaaaaaa
daaaaaaagaabaaaaaaadaaaaimadaaaaebgpgodjciabaaaaciabaaaaaaacpppp
pmaaaaaacmaaaaaaaaaacmaaaaaacmaaaaaacmaaacaaceaaaaaacmaaaaaaaaaa
abababaaaaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaaaaaaaaaaa
bpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaaia
acaaaplabpaaaaacaaaaaajaaaaiapkabpaaaaacaaaaaajaabaiapkaagaaaaac
aaaaaiiaacaapplaafaaaaadaaaaadiaaaaappiaacaaoelaaeaaaaaeaaaaadia
aaaaoeiaaaaaoekaaaaaaakaecaaaaadaaaacpiaaaaaoeiaabaioekaecaaaaad
abaaapiaabaaoelaaaaioekaafaaaaadabaacpiaabaaoeiaaaaaoelaagaaaaac
acaaabiaabaaaaiaagaaaaacacaaaciaabaaffiaagaaaaacacaaaeiaabaakkia
afaaaaadabaachiaaaaaoeiaacaaoeiaabaaaaacaaaicpiaabaaoeiappppaaaa
fdeieefcjiabaaaaeaaaaaaaggaaaaaafkaaaaadaagabaaaaaaaaaaafkaaaaad
aagabaaaabaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaafibiaaaeaahabaaa
abaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gcbaaaadlcbabaaaadaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
aoaaaaahdcaabaaaaaaaaaaaegbabaaaadaaaaaapgbpbaaaadaaaaaaaaaaaaak
dcaabaaaaaaaaaaaegaabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaaaaa
aaaaaaaadiaaaaahbcaabaaaaaaaaaaaakaabaaaaaaaaaaaabeaaaaaaaaaaadp
dcaaaaakecaabaaaaaaaaaaabkaabaiaebaaaaaaaaaaaaaaabeaaaaaaaaaaadp
abeaaaaaaaaaiadpefaaaaajpcaabaaaaaaaaaaaigaabaaaaaaaaaaaeghobaaa
abaaaaaaaagabaaaabaaaaaaefaaaaajpcaabaaaabaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaabaaaaaaegaobaaa
abaaaaaaegbobaaaabaaaaaaaoaaaaahhccabaaaaaaaaaaaegacbaaaaaaaaaaa
egacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaabaaaaaadoaaaaab
ejfdeheoieaaaaaaaeaaaaaaaiaaaaaagiaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaaheaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
hkaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaahkaaaaaaabaaaaaa
aaaaaaaaadaaaaaaadaaaaaaapalaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
}
 }
}
Fallback "Sprites/Default"
}