Shader "BlendModes/SpriteDefault/Framebuffer" {
Properties {
[PerRendererData]  _MainTex ("Sprite Texture", 2D) = "white" {}
 _Color ("Tint", Color) = (1,1,1,1)
[MaterialToggle]  PixelSnap ("Pixel snap", Float) = 0
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" "PreviewType"="Plane" "CanUseSpriteAtlas"="true" }
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
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
MUL result.color, vertex.color, c[5];
MOV result.texcoord[0].xy, vertex.texcoord[0];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 6 instructions, 0 R-regs
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
mul oD0, v1, c4
mov oT0.xy, v2
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
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
eefiecediigbeafjpjbhjggjefmfgejdfdhfogkkabaaaaaageacaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefcemabaaaaeaaaabaafdaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaa
fpaaaaadpcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaa
acaaaaaaghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaa
gfaaaaaddccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaa
fgbfbaaaaaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaabaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaak
pcaabaaaaaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaa
aaaaaaaadcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaa
aaaaaaaaegaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaa
egiocaaaaaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaa
doaaaaab"
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
eefiecedgijmfhokodioljkeffdlnoelhmjpmkleabaaaaaageadaaaaaeaaaaaa
daaaaaaacmabaaaaiaacaaaapaacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpopp
leaaaaaaeaaaaaaaacaaceaaaaaadmaaaaaadmaaaaaaceaaabaadmaaaaaaabaa
abaaabaaaaaaaaaaabaaaaaaaeaaacaaaaaaaaaaaaaaaaaaaaacpoppbpaaaaac
afaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaaciaacaaapja
afaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffjaadaaoeka
aeaaaaaeaaaaapiaacaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapiaaeaaoeka
aaaakkjaaaaaoeiaaeaaaaaeaaaaapiaafaaoekaaaaappjaaaaaoeiaaeaaaaae
aaaaadmaaaaappiaaaaaoekaaaaaoeiaabaaaaacaaaaammaaaaaoeiaabaaaaac
abaaadoaacaaoejappppaaaafdeieefcemabaaaaeaaaabaafdaaaaaafjaaaaae
egiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaaeaaaaaafpaaaaad
pcbabaaaaaaaaaaafpaaaaadpcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaa
ghaaaaaepccabaaaaaaaaaaaabaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaad
dccabaaaacaaaaaagiaaaaacabaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaa
aaaaaaaaegiocaaaabaaaaaaabaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaa
abaaaaaaaaaaaaaaagbabaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaa
aaaaaaaaegiocaaaabaaaaaaacaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaa
dcaaaaakpccabaaaaaaaaaaaegiocaaaabaaaaaaadaaaaaapgbpbaaaaaaaaaaa
egaobaaaaaaaaaaadiaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaa
aaaaaaaaabaaaaaadgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab
ejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
fpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeo
aaedepemepfcaafeeffiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaakl"
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
DP4 R0.z, vertex.position, c[4];
MOV R0.x, c[0];
MUL R0.xy, R0.x, c[5];
DP4 R1.y, vertex.position, c[2];
RCP R0.w, R0.z;
DP4 R1.x, vertex.position, c[1];
MUL R1.xy, R1, R0.w;
MAD R1.xy, R1, R0, c[0].x;
FLR R1.xy, R1;
RCP R0.y, R0.y;
RCP R0.x, R0.x;
MUL R0.xy, R1, R0;
MUL result.position.xy, R0, R0.z;
MUL result.color, vertex.color, c[6];
MOV result.texcoord[0].xy, vertex.texcoord[0];
MOV result.position.w, R0.z;
DP4 result.position.z, vertex.position, c[3];
END
# 17 instructions, 2 R-regs
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
dp4 r1.z, v0, c3
mov r0.xy, c4
mul r0.xy, c6.x, r0
rcp r1.x, r1.z
dp4 r0.w, v0, c1
dp4 r0.z, v0, c0
mul r0.zw, r0, r1.x
mad r0.zw, r0, r0.xyxy, c6.x
frc r1.xy, r0.zwzw
add r0.zw, r0, -r1.xyxy
add r0.zw, r0, c6.xyyx
rcp r0.y, r0.y
rcp r0.x, r0.x
mul r0.xy, r0.zwzw, r0
mul oPos.xy, r0, r1.z
mul oD0, v1, c5
mov oT0.xy, v2
mov oPos.w, r1.z
dp4 oPos.z, v0, c2
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
eefiecedafndclmghccgbpkcpnhjflpmknoibooiabaaaaaadiadaaaaadaaaaaa
cmaaaaaajmaaaaaabaabaaaaejfdeheogiaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaafjaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaepfdeheo
gmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaa
apaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaaaaaagcaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaafdfgfpfaepfdejfeejepeoaa
edepemepfcaafeeffiedepepfceeaaklfdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaab"
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
eefiecedkfnpcnfpeaaooandgnhaphlmeofakklhabaaaaaapmaeaaaaaeaaaaaa
daaaaaaapaabaaaabiaeaaaaiiaeaaaaebgpgodjliabaaaaliabaaaaaaacpopp
gmabaaaaemaaaaaaadaaceaaaaaaeiaaaaaaeiaaaaaaceaaabaaeiaaaaaaabaa
abaaabaaaaaaaaaaabaaagaaabaaacaaaaaaaaaaacaaaaaaaeaaadaaaaaaaaaa
aaaaaaaaaaacpoppfbaaaaafahaaapkaaaaaaadpaaaaaaaaaaaaaaaaaaaaaaaa
bpaaaaacafaaaaiaaaaaapjabpaaaaacafaaabiaabaaapjabpaaaaacafaaacia
acaaapjaafaaaaadaaaaapoaabaaoejaabaaoekaafaaaaadaaaaapiaaaaaffja
aeaaoekaaeaaaaaeaaaaapiaadaaoekaaaaaaajaaaaaoeiaaeaaaaaeaaaaapia
afaaoekaaaaakkjaaaaaoeiaaeaaaaaeaaaaapiaagaaoekaaaaappjaaaaaoeia
agaaaaacabaaabiaaaaappiaafaaaaadaaaaadiaaaaaoeiaabaaaaiaabaaaaac
abaaabiaahaaaakaafaaaaadabaaadiaabaaaaiaacaaoekaaeaaaaaeaaaaadia
aaaaoeiaabaaoeiaahaaaakabdaaaaacabaaamiaaaaaeeiaacaaaaadaaaaadia
aaaaoeiaabaaooibagaaaaacacaaabiaabaaaaiaagaaaaacacaaaciaabaaffia
afaaaaadaaaaadiaaaaaoeiaacaaoeiaafaaaaadabaaadiaaaaappiaaaaaoeka
aeaaaaaeaaaaadmaaaaaoeiaaaaappiaabaaoeiaabaaaaacaaaaammaaaaaoeia
abaaaaacabaaadoaacaaoejappppaaaafdeieefccaacaaaaeaaaabaaiiaaaaaa
fjaaaaaeegiocaaaaaaaaaaaacaaaaaafjaaaaaeegiocaaaabaaaaaaahaaaaaa
fjaaaaaeegiocaaaacaaaaaaaeaaaaaafpaaaaadpcbabaaaaaaaaaaafpaaaaad
pcbabaaaabaaaaaafpaaaaaddcbabaaaacaaaaaaghaaaaaepccabaaaaaaaaaaa
abaaaaaagfaaaaadpccabaaaabaaaaaagfaaaaaddccabaaaacaaaaaagiaaaaac
acaaaaaadiaaaaaipcaabaaaaaaaaaaafgbfbaaaaaaaaaaaegiocaaaacaaaaaa
abaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaaaaaaaaaaagbabaaa
aaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaaegiocaaaacaaaaaa
acaaaaaakgbkbaaaaaaaaaaaegaobaaaaaaaaaaadcaaaaakpcaabaaaaaaaaaaa
egiocaaaacaaaaaaadaaaaaapgbpbaaaaaaaaaaaegaobaaaaaaaaaaaaoaaaaah
dcaabaaaaaaaaaaaegaabaaaaaaaaaaapgapbaaaaaaaaaaadiaaaaaldcaabaaa
abaaaaaaegiacaaaabaaaaaaagaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaaaa
aaaaaaaadiaaaaahdcaabaaaaaaaaaaaegaabaaaaaaaaaaaegaabaaaabaaaaaa
eaaaaaafdcaabaaaaaaaaaaaegaabaaaaaaaaaaaaoaaaaahdcaabaaaaaaaaaaa
egaabaaaaaaaaaaaegaabaaaabaaaaaadiaaaaahdccabaaaaaaaaaaapgapbaaa
aaaaaaaaegaabaaaaaaaaaaadgaaaaafmccabaaaaaaaaaaakgaobaaaaaaaaaaa
diaaaaaipccabaaaabaaaaaaegbobaaaabaaaaaaegiocaaaaaaaaaaaabaaaaaa
dgaaaaafdccabaaaacaaaaaaegbabaaaacaaaaaadoaaaaabejfdeheogiaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapapaaaa
fjaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaafpaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafaepfdejfeejepeoaaedepemepfcaafe
effiedepepfceeaaepfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaa
abaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
abaaaaaaapaaaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadamaaaa
fdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "BMDarken" "DUMMY" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MOV result.color.w, R0;
MIN result.color.xyz, R0, c[0].x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarken" "DUMMY" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 1.00000000, 0, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
min_pp r0.xyz, r0, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDarken" "DUMMY" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedjoacpgcncngekhhbmhaichabmbbbiihfabaaaaaakmabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnaaaaaaaeaaaaaaa
deaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaaddaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarken" "DUMMY" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecednfbkeekdnldfgicgmelaklcdpeieahooabaaaaaagmacaaaaaeaaaaaa
daaaaaaaomaaaaaameabaaaadiacaaaaebgpgodjleaaaaaaleaaaaaaaaacpppp
imaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaacpiaaaaaoeiaaaaaoela
akaaaaadabaachiaaaaaoeiaaaaaaakaabaaaaacabaaciiaaaaappiaabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefcnaaaaaaaeaaaaaaadeaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaa
abaaaaaaddaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "BMDarken" "PIXELSNAP_ON" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MOV result.color.w, R0;
MIN result.color.xyz, R0, c[0].x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "BMDarken" "PIXELSNAP_ON" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 1.00000000, 0, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
min_pp r0.xyz, r0, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "BMDarken" "PIXELSNAP_ON" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedjoacpgcncngekhhbmhaichabmbbbiihfabaaaaaakmabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnaaaaaaaeaaaaaaa
deaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaaddaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "BMDarken" "PIXELSNAP_ON" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecednfbkeekdnldfgicgmelaklcdpeieahooabaaaaaagmacaaaaaeaaaaaa
daaaaaaaomaaaaaameabaaaadiacaaaaebgpgodjleaaaaaaleaaaaaaaaacpppp
imaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaacpiaaaaaoeiaaaaaoela
akaaaaadabaachiaaaaaoeiaaaaaaakaabaaaaacabaaciiaaaaappiaabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefcnaaaaaaaeaaaaaaadeaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaa
abaaaaaaddaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL result.color, R0, fragment.color.primary;
END
# 2 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedepjdcgmlmliiikjgjdbkmiompjppgjimabaaaaaahaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjeaaaaaaeaaaaaaa
cfaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedkbibjghbkeagldhllegkjihhlipocnpmabaaaaaapmabaaaaaeaaaaaa
daaaaaaaliaaaaaafeabaaaamiabaaaaebgpgodjiaaaaaaaiaaaaaaaaaacpppp
fiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaac
aaaaaajaaaaiapkaecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaacpia
aaaaoeiaaaaaoelaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcjeaaaaaa
eaaaaaaacfaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL result.color, R0, fragment.color.primary;
END
# 2 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedepjdcgmlmliiikjgjdbkmiompjppgjimabaaaaaahaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjeaaaaaaeaaaaaaa
cfaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMMultiply" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedkbibjghbkeagldhllegkjihhlipocnpmabaaaaaapmabaaaaaeaaaaaa
daaaaaaaliaaaaaafeabaaaamiabaaaaebgpgodjiaaaaaaaiaaaaaaaaaacpppp
fiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaac
aaaaaajaaaaiapkaecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaacpia
aaaaoeiaaaaaoelaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcjeaaaaaa
eaaaaaaacfaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MOV result.color.xyz, c[0].x;
MUL result.color.w, R0, fragment.color.primary;
END
# 3 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 1.00000000, 0, 0, 0
dcl v0.xyzw
dcl t0.xy
texld r0, t0, s0
mov_pp r0.xyz, c0.x
mul r0.w, r0, v0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedaobdlaapnokdiebnikolgemlkjcknngbabaaaaaajaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleaaaaaaeaaaaaaa
cnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedfckgiobpfgaggegaiiopchcnfhloahobabaaaaaaeaacaaaaaeaaaaaa
daaaaaaanmaaaaaajiabaaaaamacaaaaebgpgodjkeaaaaaakeaaaaaaaaacpppp
hmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaaciiaaaaappiaaaaappla
abaaaaacaaaachiaaaaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
leaaaaaaeaaaaaaacnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaihccabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheogmaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MOV result.color.xyz, c[0].x;
MUL result.color.w, R0, fragment.color.primary;
END
# 3 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 1.00000000, 0, 0, 0
dcl v0.xyzw
dcl t0.xy
texld r0, t0, s0
mov_pp r0.xyz, c0.x
mul r0.w, r0, v0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedaobdlaapnokdiebnikolgemlkjcknngbabaaaaaajaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleaaaaaaeaaaaaaa
cnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMColorBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedfckgiobpfgaggegaiiopchcnfhloahobabaaaaaaeaacaaaaaeaaaaaa
daaaaaaanmaaaaaajiabaaaaamacaaaaebgpgodjkeaaaaaakeaaaaaaaaacpppp
hmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaaciiaaaaappiaaaaappla
abaaaaacaaaachiaaaaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
leaaaaaaeaaaaaaacnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaihccabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheogmaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL result.color, R0, fragment.color.primary;
END
# 2 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedepjdcgmlmliiikjgjdbkmiompjppgjimabaaaaaahaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjeaaaaaaeaaaaaaa
cfaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedkbibjghbkeagldhllegkjihhlipocnpmabaaaaaapmabaaaaaeaaaaaa
daaaaaaaliaaaaaafeabaaaamiabaaaaebgpgodjiaaaaaaaiaaaaaaaaaacpppp
fiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaac
aaaaaajaaaaiapkaecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaacpia
aaaaoeiaaaaaoelaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcjeaaaaaa
eaaaaaaacfaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL result.color, R0, fragment.color.primary;
END
# 2 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedepjdcgmlmliiikjgjdbkmiompjppgjimabaaaaaahaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjeaaaaaaeaaaaaaa
cfaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMLinearBurn" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedkbibjghbkeagldhllegkjihhlipocnpmabaaaaaapmabaaaaaeaaaaaa
daaaaaaaliaaaaaafeabaaaamiabaaaaebgpgodjiaaaaaaaiaaaaaaaaaacpppp
fiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaac
aaaaaajaaaaiapkaecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaacpia
aaaaoeiaaaaaoelaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcjeaaaaaa
eaaaaaaacfaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpccabaaaaaaaaaaa
egaobaaaaaaaaaaaegbobaaaabaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.29907227, 0.58691406, 0.11401367 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MUL R1.x, R0.y, c[0].z;
MAD R1.x, R0, c[0].y, R1;
MAD R1.x, R0.z, c[0].w, R1;
ADD R1.x, -R1, c[0];
CMP result.color.xyz, R1.x, c[0].x, R0;
MOV result.color.w, R0;
END
# 8 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 0.58691406, 0.29907227, 0.11401367, 1.00000000
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r1, r0, v0
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
Keywords { "DUMMY" "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedmikeadgondenpapfijcpljgaekdmfcjkabaaaaaapiabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbmabaaaaeaaaaaaa
ehaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaabaaaaaakbcaabaaaabaaaaaaegacbaaaaaaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaadbaaaaahbcaabaaaabaaaaaa
abeaaaaaaaaaiadpakaabaaaabaaaaaadhaaaaamhccabaaaaaaaaaaaagaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedalgajjbjddbdjfokcocijimbdjakanmjabaaaaaapiacaaaaaeaaaaaa
daaaaaaacmabaaaafaacaaaameacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpppp
mmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkakcefbgdpihbgjjdonfhiojdnaaaaiadpbpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaacpiaaaaaoeiaaaaaoela
afaaaaadabaaciiaaaaaffiaaaaaaakaaeaaaaaeabaacbiaaaaaaaiaaaaaffka
abaappiaaeaaaaaeabaacbiaaaaakkiaaaaakkkaabaaaaiaacaaaaadabaaabia
abaaaaibaaaappkafiaaaaaeaaaachiaabaaaaiaaaaaoeiaaaaappkaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcbmabaaaaeaaaaaaaehaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaa
abaaaaaabaaaaaakbcaabaaaabaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaadbaaaaahbcaabaaaabaaaaaaabeaaaaaaaaaiadp
akaabaaaabaaaaaadhaaaaamhccabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.29907227, 0.58691406, 0.11401367 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MUL R1.x, R0.y, c[0].z;
MAD R1.x, R0, c[0].y, R1;
MAD R1.x, R0.z, c[0].w, R1;
ADD R1.x, -R1, c[0];
CMP result.color.xyz, R1.x, c[0].x, R0;
MOV result.color.w, R0;
END
# 8 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 0.58691406, 0.29907227, 0.11401367, 1.00000000
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r1, r0, v0
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
Keywords { "PIXELSNAP_ON" "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedmikeadgondenpapfijcpljgaekdmfcjkabaaaaaapiabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbmabaaaaeaaaaaaa
ehaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaabaaaaaakbcaabaaaabaaaaaaegacbaaaaaaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaadbaaaaahbcaabaaaabaaaaaa
abeaaaaaaaaaiadpakaabaaaabaaaaaadhaaaaamhccabaaaaaaaaaaaagaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMDarkerColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedalgajjbjddbdjfokcocijimbdjakanmjabaaaaaapiacaaaaaeaaaaaa
daaaaaaacmabaaaafaacaaaameacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpppp
mmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkakcefbgdpihbgjjdonfhiojdnaaaaiadpbpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaacpiaaaaaoeiaaaaaoela
afaaaaadabaaciiaaaaaffiaaaaaaakaaeaaaaaeabaacbiaaaaaaaiaaaaaffka
abaappiaaeaaaaaeabaacbiaaaaakkiaaaaakkkaabaaaaiaacaaaaadabaaabia
abaaaaibaaaappkafiaaaaaeaaaachiaabaaaaiaaaaaoeiaaaaappkaabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcbmabaaaaeaaaaaaaehaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaa
abaaaaaabaaaaaakbcaabaaaabaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaadbaaaaahbcaabaaaabaaaaaaabeaaaaaaaaaiadp
akaabaaaabaaaaaadhaaaaamhccabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MOV result.color.w, R0;
MAX result.color.xyz, R0, c[0].x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 1.00000000, 0, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
max_pp r0.xyz, r0, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedlcmjhgchdbmppcbdkiegghghbpdhegacabaaaaaakmabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnaaaaaaaeaaaaaaa
deaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaadeaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedilgifkambmgngmhhgimollbdilhlapimabaaaaaagmacaaaaaeaaaaaa
daaaaaaaomaaaaaameabaaaadiacaaaaebgpgodjleaaaaaaleaaaaaaaaacpppp
imaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaacpiaaaaaoeiaaaaaoela
alaaaaadabaachiaaaaaaakaaaaaoeiaabaaaaacabaaciiaaaaappiaabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefcnaaaaaaaeaaaaaaadeaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaa
abaaaaaadeaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MOV result.color.w, R0;
MAX result.color.xyz, R0, c[0].x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 1.00000000, 0, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
max_pp r0.xyz, r0, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedlcmjhgchdbmppcbdkiegghghbpdhegacabaaaaaakmabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnaaaaaaaeaaaaaaa
deaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaadeaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMLighten" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedilgifkambmgngmhhgimollbdilhlapimabaaaaaagmacaaaaaeaaaaaa
daaaaaaaomaaaaaameabaaaadiacaaaaebgpgodjleaaaaaaleaaaaaaaaacpppp
imaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaacpiaaaaaoeiaaaaaoela
alaaaaadabaachiaaaaaaakaaaaaoeiaabaaaaacabaaciiaaaaappiaabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefcnaaaaaaaeaaaaaaadeaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
abaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaa
abaaaaaadeaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
doaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MOV result.color.xyz, c[0].x;
MUL result.color.w, R0, fragment.color.primary;
END
# 3 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 1.00000000, 0, 0, 0
dcl v0.xyzw
dcl t0.xy
texld r0, t0, s0
mov_pp r0.xyz, c0.x
mul r0.w, r0, v0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedaobdlaapnokdiebnikolgemlkjcknngbabaaaaaajaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleaaaaaaeaaaaaaa
cnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedfckgiobpfgaggegaiiopchcnfhloahobabaaaaaaeaacaaaaaeaaaaaa
daaaaaaanmaaaaaajiabaaaaamacaaaaebgpgodjkeaaaaaakeaaaaaaaaacpppp
hmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaaciiaaaaappiaaaaappla
abaaaaacaaaachiaaaaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
leaaaaaaeaaaaaaacnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaihccabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheogmaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MOV result.color.xyz, c[0].x;
MUL result.color.w, R0, fragment.color.primary;
END
# 3 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 1.00000000, 0, 0, 0
dcl v0.xyzw
dcl t0.xy
texld r0, t0, s0
mov_pp r0.xyz, c0.x
mul r0.w, r0, v0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedaobdlaapnokdiebnikolgemlkjcknngbabaaaaaajaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleaaaaaaeaaaaaaa
cnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMScreen" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedfckgiobpfgaggegaiiopchcnfhloahobabaaaaaaeaacaaaaaeaaaaaa
daaaaaaanmaaaaaajiabaaaaamacaaaaebgpgodjkeaaaaaakeaaaaaaaaacpppp
hmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaaciiaaaaappiaaaaappla
abaaaaacaaaachiaaaaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
leaaaaaaeaaaaaaacnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaihccabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheogmaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
ADD R0.xyz, -R0, c[0].x;
MOV result.color.w, R0;
RCP result.color.x, R0.x;
RCP result.color.y, R0.y;
RCP result.color.z, R0.z;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 1.00000000, 0, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r0.xyz, -r0, c0.x
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedanjgloifdmpbphbdekckpjjgoohnnildabaaaaaaoaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaeabaaaaeaaaaaaa
ebaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaanhcaabaaaaaaaaaaaegacbaia
ebaaaaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaakhccabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedhmimfhdhmicdhbcmbmfcceilndlmnhnlabaaaaaalmacaaaaaeaaaaaa
daaaaaaaaiabaaaabeacaaaaiiacaaaaebgpgodjnaaaaaaanaaaaaaaaaacpppp
kiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadabaaciiaaaaappiaaaaappla
aeaaaaaeaaaachiaaaaaoeiaaaaaoelbaaaaaakaagaaaaacabaacbiaaaaaaaia
agaaaaacabaacciaaaaaffiaagaaaaacabaaceiaaaaakkiaabaaaaacaaaicpia
abaaoeiappppaaaafdeieefcaeabaaaaeaaaaaaaebaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaanhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegbcbaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaaaoaaaaakhccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpegacbaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
ADD R0.xyz, -R0, c[0].x;
MOV result.color.w, R0;
RCP result.color.x, R0.x;
RCP result.color.y, R0.y;
RCP result.color.z, R0.z;
END
# 7 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 1.00000000, 0, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r0.xyz, -r0, c0.x
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedanjgloifdmpbphbdekckpjjgoohnnildabaaaaaaoaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcaeabaaaaeaaaaaaa
ebaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaanhcaabaaaaaaaaaaaegacbaia
ebaaaaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaaoaaaaakhccabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadoaaaaab
"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMColorDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedhmimfhdhmicdhbcmbmfcceilndlmnhnlabaaaaaalmacaaaaaeaaaaaa
daaaaaaaaiabaaaabeacaaaaiiacaaaaebgpgodjnaaaaaaanaaaaaaaaaacpppp
kiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadabaaciiaaaaappiaaaaappla
aeaaaaaeaaaachiaaaaaoeiaaaaaoelbaaaaaakaagaaaaacabaacbiaaaaaaaia
agaaaaacabaacciaaaaaffiaagaaaaacabaaceiaaaaakkiaabaaaaacaaaicpia
abaaoeiappppaaaafdeieefcaeabaaaaeaaaaaaaebaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadcaaaaanhcaabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaegbcbaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadiaaaaahicaabaaa
aaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaaaoaaaaakhccabaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaiadpegacbaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MOV result.color.w, R0;
ADD result.color.xyz, R0, c[0].x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 1.00000000, 0, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r0.xyz, r0, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedbiachafpfklldobocljmoembckjldjkhabaaaaaaieabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckiaaaaaaeaaaaaaa
ckaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampccabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedfaikhejcanfjjcicjkjcpenjjocbmiedabaaaaaacmacaaaaaeaaaaaa
daaaaaaaneaaaaaaieabaaaapiabaaaaebgpgodjjmaaaaaajmaaaaaaaaacpppp
heaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaiadpaaaaiadpaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeaaaacpiaaaaaoeiaaaaaoela
aaaaoekaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefckiaaaaaaeaaaaaaa
ckaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampccabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
doaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MOV result.color.w, R0;
ADD result.color.xyz, R0, c[0].x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 1.00000000, 0, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r0.xyz, r0, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedbiachafpfklldobocljmoembckjldjkhabaaaaaaieabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckiaaaaaaeaaaaaaa
ckaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampccabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
doaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMLinearDodge" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedfaikhejcanfjjcicjkjcpenjjocbmiedabaaaaaacmacaaaaaeaaaaaa
daaaaaaaneaaaaaaieabaaaapiabaaaaebgpgodjjmaaaaaajmaaaaaaaaacpppp
heaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaiadpaaaaiadpaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeaaaacpiaaaaaoeiaaaaaoela
aaaaoekaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefckiaaaaaaeaaaaaaa
ckaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaampccabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
doaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.29907227, 0.58691406, 0.11401367 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MUL R1.x, R0.y, c[0].z;
MAD R1.x, R0, c[0].y, R1;
MAD R1.x, R0.z, c[0].w, R1;
ADD R1.x, -R1, c[0];
CMP result.color.xyz, -R1.x, c[0].x, R0;
MOV result.color.w, R0;
END
# 8 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 0.58691406, 0.29907227, 0.11401367, 1.00000000
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r1, r0, v0
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
Keywords { "DUMMY" "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedncglhnnocfepjlgjijcbbjlggdoeiaemabaaaaaapiabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbmabaaaaeaaaaaaa
ehaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaabaaaaaakbcaabaaaabaaaaaaegacbaaaaaaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaamhccabaaaaaaaaaaaagaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedjlgncijcfmpafcbafebmioigpeembndiabaaaaaapiacaaaaaeaaaaaa
daaaaaaacmabaaaafaacaaaameacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpppp
mmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkakcefbgdpihbgjjdonfhiojdnaaaaialpbpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaacpiaaaaaoeiaaaaaoela
afaaaaadabaaciiaaaaaffiaaaaaaakaaeaaaaaeabaacbiaaaaaaaiaaaaaffka
abaappiaaeaaaaaeabaacbiaaaaakkiaaaaakkkaabaaaaiaacaaaaadabaaabia
abaaaaiaaaaappkafiaaaaaeaaaachiaabaaaaiaaaaaoeiaaaaappkbabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcbmabaaaaeaaaaaaaehaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaa
abaaaaaabaaaaaakbcaabaaaabaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaiadpdhaaaaamhccabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0.29907227, 0.58691406, 0.11401367 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MUL R1.x, R0.y, c[0].z;
MAD R1.x, R0, c[0].y, R1;
MAD R1.x, R0.z, c[0].w, R1;
ADD R1.x, -R1, c[0];
CMP result.color.xyz, -R1.x, c[0].x, R0;
MOV result.color.w, R0;
END
# 8 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 0.58691406, 0.29907227, 0.11401367, 1.00000000
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r1, r0, v0
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
Keywords { "PIXELSNAP_ON" "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedncglhnnocfepjlgjijcbbjlggdoeiaemabaaaaaapiabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbmabaaaaeaaaaaaa
ehaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaabaaaaaakbcaabaaaabaaaaaaegacbaaaaaaaaaaa
aceaaaaaihbgjjdokcefbgdpnfhiojdnaaaaaaaadbaaaaahbcaabaaaabaaaaaa
akaabaaaabaaaaaaabeaaaaaaaaaiadpdhaaaaamhccabaaaaaaaaaaaagaabaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaegacbaaaaaaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMLighterColor" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedjlgncijcfmpafcbafebmioigpeembndiabaaaaaapiacaaaaaeaaaaaa
daaaaaaacmabaaaafaacaaaameacaaaaebgpgodjpeaaaaaapeaaaaaaaaacpppp
mmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkakcefbgdpihbgjjdonfhiojdnaaaaialpbpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaacpiaaaaaoeiaaaaaoela
afaaaaadabaaciiaaaaaffiaaaaaaakaaeaaaaaeabaacbiaaaaaaaiaaaaaffka
abaappiaaeaaaaaeabaacbiaaaaakkiaaaaakkkaabaaaaiaacaaaaadabaaabia
abaaaaiaaaaappkafiaaaaaeaaaachiaabaaaaiaaaaaoeiaaaaappkbabaaaaac
aaaicpiaaaaaoeiappppaaaafdeieefcbmabaaaaeaaaaaaaehaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
acaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaa
abaaaaaabaaaaaakbcaabaaaabaaaaaaegacbaaaaaaaaaaaaceaaaaaihbgjjdo
kcefbgdpnfhiojdnaaaaaaaadbaaaaahbcaabaaaabaaaaaaakaabaaaabaaaaaa
abeaaaaaaaaaiadpdhaaaaamhccabaaaaaaaaaaaagaabaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaa
faaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
acaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepep
fceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MOV result.color.xyz, c[0].x;
MUL result.color.w, R0, fragment.color.primary;
END
# 3 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 1.00000000, 0, 0, 0
dcl v0.xyzw
dcl t0.xy
texld r0, t0, s0
mov_pp r0.xyz, c0.x
mul r0.w, r0, v0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedaobdlaapnokdiebnikolgemlkjcknngbabaaaaaajaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleaaaaaaeaaaaaaa
cnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedfckgiobpfgaggegaiiopchcnfhloahobabaaaaaaeaacaaaaaeaaaaaa
daaaaaaanmaaaaaajiabaaaaamacaaaaebgpgodjkeaaaaaakeaaaaaaaaacpppp
hmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaaciiaaaaappiaaaaappla
abaaaaacaaaachiaaaaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
leaaaaaaeaaaaaaacnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaihccabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheogmaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MOV result.color.xyz, c[0].x;
MUL result.color.w, R0, fragment.color.primary;
END
# 3 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 1.00000000, 0, 0, 0
dcl v0.xyzw
dcl t0.xy
texld r0, t0, s0
mov_pp r0.xyz, c0.x
mul r0.w, r0, v0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedaobdlaapnokdiebnikolgemlkjcknngbabaaaaaajaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleaaaaaaeaaaaaaa
cnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMOverlay" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedfckgiobpfgaggegaiiopchcnfhloahobabaaaaaaeaacaaaaaeaaaaaa
daaaaaaanmaaaaaajiabaaaaamacaaaaebgpgodjkeaaaaaakeaaaaaaaaacpppp
hmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaaciiaaaaappiaaaaappla
abaaaaacaaaachiaaaaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
leaaaaaaeaaaaaaacnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaihccabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheogmaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MOV result.color.xyz, c[0].x;
MUL result.color.w, R0, fragment.color.primary;
END
# 3 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 1.00000000, 0, 0, 0
dcl v0.xyzw
dcl t0.xy
texld r0, t0, s0
mov_pp r0.xyz, c0.x
mul r0.w, r0, v0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedaobdlaapnokdiebnikolgemlkjcknngbabaaaaaajaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleaaaaaaeaaaaaaa
cnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedfckgiobpfgaggegaiiopchcnfhloahobabaaaaaaeaacaaaaaeaaaaaa
daaaaaaanmaaaaaajiabaaaaamacaaaaebgpgodjkeaaaaaakeaaaaaaaaacpppp
hmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaaciiaaaaappiaaaaappla
abaaaaacaaaachiaaaaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
leaaaaaaeaaaaaaacnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaihccabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheogmaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0.w, fragment.texcoord[0], texture[0], 2D;
MOV result.color.xyz, c[0].x;
MUL result.color.w, R0, fragment.color.primary;
END
# 3 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 1.00000000, 0, 0, 0
dcl v0.xyzw
dcl t0.xy
texld r0, t0, s0
mov_pp r0.xyz, c0.x
mul r0.w, r0, v0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedaobdlaapnokdiebnikolgemlkjcknngbabaaaaaajaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcleaaaaaaeaaaaaaa
cnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahiccabaaaaaaaaaaadkaabaaa
aaaaaaaadkbabaaaabaaaaaadgaaaaaihccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMSoftLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedfckgiobpfgaggegaiiopchcnfhloahobabaaaaaaeaacaaaaaeaaaaaa
daaaaaaanmaaaaaajiabaaaaamacaaaaebgpgodjkeaaaaaakeaaaaaaaaacpppp
hmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaaciiaaaaappiaaaaappla
abaaaaacaaaachiaaaaaaakaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
leaaaaaaeaaaaaaacnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadicbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahiccabaaa
aaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaihccabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaabejfdeheogmaaaaaa
adaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapaiaaaagcaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemep
fcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl
"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MUL R1.xyz, R0, c[0].z;
ADD R0.xyz, R0, -c[0].x;
CMP result.color.xyz, -R0, c[0].y, R1;
MOV result.color.w, R0;
END
# 6 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 2.00000000, -0.50000000, 1.00000000, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
mul_pp r1.xyz, r0, c0.x
add_pp r0.xyz, r0, c0.y
cmp_pp r0.xyz, -r0, r1, c0.z
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedagdgoonjbekfjocedefecimchfijcjonabaaaaaapiabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbmabaaaaeaaaaaaa
ehaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaadbaaaaakhcaabaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaaegacbaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadhaaaaamhccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedplbnjckdppbmicfmjbnjanhniiojbfnaabaaaaaaneacaaaaaeaaaaaa
daaaaaaaaiabaaaacmacaaaakaacaaaaebgpgodjnaaaaaaanaaaaaaaaaacpppp
kiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaaahiaaaaaoeiaaaaaoelb
aaaaaakaafaaaaadaaaacpiaaaaaoeiaaaaaoelaacaaaaadacaachiaaaaaoeia
aaaaoeiafiaaaaaeaaaachiaabaaoeiaacaaoeiaaaaaffkaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcbmabaaaaeaaaaaaaehaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaa
dbaaaaakhcaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
egacbaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadhaaaaamhccabaaa
aaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
egacbaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MUL R1.xyz, R0, c[0].z;
ADD R0.xyz, R0, -c[0].x;
CMP result.color.xyz, -R0, c[0].y, R1;
MOV result.color.w, R0;
END
# 6 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 2.00000000, -0.50000000, 1.00000000, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
mul_pp r1.xyz, r0, c0.x
add_pp r0.xyz, r0, c0.y
cmp_pp r0.xyz, -r0, r1, c0.z
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedagdgoonjbekfjocedefecimchfijcjonabaaaaaapiabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcbmabaaaaeaaaaaaa
ehaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaadbaaaaakhcaabaaaabaaaaaaaceaaaaaaaaaaadp
aaaaaadpaaaaaadpaaaaaaaaegacbaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaa
egacbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadhaaaaamhccabaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMHardLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedplbnjckdppbmicfmjbnjanhniiojbfnaabaaaaaaneacaaaaaeaaaaaa
daaaaaaaaiabaaaacmacaaaakaacaaaaebgpgodjnaaaaaaanaaaaaaaaaacpppp
kiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaaadpaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaaahiaaaaaoeiaaaaaoelb
aaaaaakaafaaaaadaaaacpiaaaaaoeiaaaaaoelaacaaaaadacaachiaaaaaoeia
aaaaoeiafiaaaaaeaaaachiaabaaoeiaacaaoeiaaaaaffkaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcbmabaaaaeaaaaaaaehaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaa
dbaaaaakhcaabaaaabaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaa
egacbaaaaaaaaaaaaaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadhaaaaamhccabaaa
aaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
egacbaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 2, 1 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
ADD R1.xyz, R0, -c[0].x;
MAD R0.xyz, -R1, c[0].y, c[0].z;
RCP R0.x, R0.x;
RCP R0.z, R0.z;
RCP R0.y, R0.y;
CMP result.color.xyz, -R1, R0, c[0].z;
MOV result.color.w, R0;
END
# 9 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.50000000, 2.00000000, 1.00000000, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
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
Keywords { "DUMMY" "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedglmmleeoeokcbmabbmaemfgipjhegoeeabaaaaaaheacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjiabaaaaeaaaaaaa
ggaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaadcaaaaba
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaoaaaaak
hcaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaa
abaaaaaadbaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
dhaaaaamhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedmdkjpponfjbchfilkljdoejdnkghglcaabaaaaaaimadaaaaaeaaaaaa
daaaaaaaeeabaaaaoeacaaaafiadaaaaebgpgodjamabaaaaamabaaaaaaacpppp
oeaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaeaaaaaiadpbpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaaahiaaaaaoeiaaaaaoelb
aaaaaakaaeaaaaaeaaaachiaaaaaoeiaaaaaoelaaaaaffkaafaaaaadacaaciia
aaaappiaaaaapplaaeaaaaaeaaaachiaaaaaoeiaaaaakkkbaaaappkaagaaaaac
adaacbiaaaaaaaiaagaaaaacadaacciaaaaaffiaagaaaaacadaaceiaaaaakkia
fiaaaaaeacaachiaabaaoeiaaaaappkaadaaoeiaabaaaaacaaaicpiaacaaoeia
ppppaaaafdeieefcjiabaaaaeaaaaaaaggaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamhcaabaaaabaaaaaaegacbaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaa
aaaaaalpaaaaaalpaaaaaalpaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaadcaaaabahcaabaaaabaaaaaaegacbaiaebaaaaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaaoaaaaakhcaabaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegacbaaaabaaaaaadbaaaaakhcaabaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadhaaaaamhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
doaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 2, 1 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
ADD R1.xyz, R0, -c[0].x;
MAD R0.xyz, -R1, c[0].y, c[0].z;
RCP R0.x, R0.x;
RCP R0.z, R0.z;
RCP R0.y, R0.y;
CMP result.color.xyz, -R1, R0, c[0].z;
MOV result.color.w, R0;
END
# 9 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.50000000, 2.00000000, 1.00000000, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
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
Keywords { "PIXELSNAP_ON" "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedglmmleeoeokcbmabbmaemfgipjhegoeeabaaaaaaheacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcjiabaaaaeaaaaaaa
ggaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaadcaaaaba
hcaabaaaabaaaaaaegacbaiaebaaaaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaoaaaaak
hcaabaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaa
abaaaaaadbaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
dhaaaaamhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMVividLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedmdkjpponfjbchfilkljdoejdnkghglcaabaaaaaaimadaaaaaeaaaaaa
daaaaaaaeeabaaaaoeacaaaafiadaaaaebgpgodjamabaaaaamabaaaaaaacpppp
oeaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaeaaaaaiadpbpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaaahiaaaaaoeiaaaaaoelb
aaaaaakaaeaaaaaeaaaachiaaaaaoeiaaaaaoelaaaaaffkaafaaaaadacaaciia
aaaappiaaaaapplaaeaaaaaeaaaachiaaaaaoeiaaaaakkkbaaaappkaagaaaaac
adaacbiaaaaaaaiaagaaaaacadaacciaaaaaffiaagaaaaacadaaceiaaaaakkia
fiaaaaaeacaachiaabaaoeiaaaaappkaadaaoeiaabaaaaacaaaicpiaacaaoeia
ppppaaaafdeieefcjiabaaaaeaaaaaaaggaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
dcaaaaamhcaabaaaabaaaaaaegacbaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaa
aaaaaalpaaaaaalpaaaaaalpaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaadcaaaabahcaabaaaabaaaaaaegacbaiaebaaaaaa
abaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaaaaaaoaaaaakhcaabaaaabaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegacbaaaabaaaaaadbaaaaakhcaabaaaaaaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadhaaaaamhccabaaaaaaaaaaaegacbaaa
aaaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
doaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
ADD R0.xyz, R1, -c[0].x;
MUL R1.xyz, R1, c[0].z;
MAD R2.xyz, R0, c[0].z, c[0].y;
CMP result.color.xyz, -R0, R2, R1;
MOV result.color.w, R1;
END
# 7 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.50000000, 2.00000000, 1.00000000, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r1.xyz, r0, c0.x
mad_pp r2.xyz, r1, c0.y, c0.z
mul_pp r0.xyz, r0, c0.y
cmp_pp r0.xyz, -r1, r0, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedeapjcdgbkdpohlmabifkbnkookibjcidabaaaaaafiacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchmabaaaaeaaaaaaa
fpaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaadcaaaaap
hcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaakhcaabaaa
acaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaaaaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedobbajgndcgbhcdpcdngphdpgplknhmkpabaaaaaafmadaaaaaeaaaaaa
daaaaaaadaabaaaaleacaaaaciadaaaaebgpgodjpiaaaaaapiaaaaaaaaacpppp
naaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaeaaaaaiadpbpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaachiaaaaaoeiaaaaaoela
aaaaffkaaeaaaaaeabaachiaabaaoeiaaaaakkkaaaaappkaaeaaaaaeacaaahia
aaaaoeiaaaaaoelbaaaaaakaafaaaaadaaaacpiaaaaaoeiaaaaaoelaacaaaaad
adaachiaaaaaoeiaaaaaoeiafiaaaaaeaaaachiaacaaoeiaadaaoeiaabaaoeia
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefchmabaaaaeaaaaaaafpaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaaaaaaaaaa
egbcbaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaadcaaaaaphcaabaaa
abaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaakhcaabaaaacaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaaaaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
ADD R0.xyz, R1, -c[0].x;
MUL R1.xyz, R1, c[0].z;
MAD R2.xyz, R0, c[0].z, c[0].y;
CMP result.color.xyz, -R0, R2, R1;
MOV result.color.w, R1;
END
# 7 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.50000000, 2.00000000, 1.00000000, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r1.xyz, r0, c0.x
mad_pp r2.xyz, r1, c0.y, c0.z
mul_pp r0.xyz, r0, c0.y
cmp_pp r0.xyz, -r1, r0, r2
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedeapjcdgbkdpohlmabifkbnkookibjcidabaaaaaafiacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefchmabaaaaeaaaaaaa
fpaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaadcaaaaap
hcaabaaaabaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaea
aaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaakhcaabaaa
acaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaaaaaaaaa
aaaaaaahhcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaa
acaaaaaaegacbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMLinearLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedobbajgndcgbhcdpcdngphdpgplknhmkpabaaaaaafmadaaaaaeaaaaaa
daaaaaaadaabaaaaleacaaaaciadaaaaebgpgodjpiaaaaaapiaaaaaaaaacpppp
naaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaaaeaaaaaiadpbpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaachiaaaaaoeiaaaaaoela
aaaaffkaaeaaaaaeabaachiaabaaoeiaaaaakkkaaaaappkaaeaaaaaeacaaahia
aaaaoeiaaaaaoelbaaaaaakaafaaaaadaaaacpiaaaaaoeiaaaaaoelaacaaaaad
adaachiaaaaaoeiaaaaaoeiafiaaaaaeaaaachiaacaaoeiaadaaoeiaabaaoeia
abaaaaacaaaicpiaaaaaoeiappppaaaafdeieefchmabaaaaeaaaaaaafpaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaaaaaaaaaa
egbcbaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaadiaaaaah
pcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaadcaaaaaphcaabaaa
abaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaaaeaaaaaaaeaaaaaaaeaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaakhcaabaaaacaaaaaa
aceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaaaaaaaaaaaaaaaaah
hcaabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaa
aaaaaaaadkaabaaaaaaaaaaadhaaaaajhccabaaaaaaaaaaaegacbaaaacaaaaaa
egacbaaaabaaaaaaegacbaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
MUL R2.xyz, R1, c[0].z;
ADD R0.xyz, R1, -c[0].x;
MUL R1.xyz, R0, c[0].z;
MIN R2.xyz, R2, c[0].y;
MAX R1.xyz, R1, c[0].y;
CMP result.color.xyz, -R0, R1, R2;
MOV result.color.w, R1;
END
# 9 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.50000000, 2.00000000, 1.00000000, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
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
Keywords { "DUMMY" "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedjhaoiillbbalcnojpoebfmcgkbkodkelabaaaaaaiiacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmabaaaaeaaaaaaa
glaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadeaaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaddaaaaak
hcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadbaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
dhaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedldckfoblolmjohbchkplhhalohoejiagabaaaaaakiadaaaaaeaaaaaa
daaaaaaaemabaaaaaaadaaaaheadaaaaebgpgodjbeabaaaabeabaaaaaaacpppp
omaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaiadpaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaachiaaaaaoeiaaaaaoela
aaaaffkaacaaaaadabaachiaabaaoeiaabaaoeiaalaaaaadacaachiaaaaakkka
abaaoeiaafaaaaadabaacpiaaaaaoeiaaaaaoelaaeaaaaaeaaaaahiaaaaaoeia
aaaaoelbaaaaaakaacaaaaadadaachiaabaaoeiaabaaoeiaakaaaaadaeaachia
adaaoeiaaaaakkkafiaaaaaeabaachiaaaaaoeiaaeaaoeiaacaaoeiaabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefckmabaaaaeaaaaaaaglaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaaaaaaaaaaegbcbaaa
abaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaadeaaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaddaaaaakhcaabaaaacaaaaaa
egacbaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaak
hcaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadhaaaaajhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab
ejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
gcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 0.5, 1, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R1, R0, fragment.color.primary;
MUL R2.xyz, R1, c[0].z;
ADD R0.xyz, R1, -c[0].x;
MUL R1.xyz, R0, c[0].z;
MIN R2.xyz, R2, c[0].y;
MAX R1.xyz, R1, c[0].y;
CMP result.color.xyz, -R0, R1, R2;
MOV result.color.w, R1;
END
# 9 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, -0.50000000, 2.00000000, 1.00000000, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
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
Keywords { "PIXELSNAP_ON" "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedjhaoiillbbalcnojpoebfmcgkbkodkelabaaaaaaiiacaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefckmabaaaaeaaaaaaa
glaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacadaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaaaaaaaaah
hcaabaaaabaaaaaaegacbaaaabaaaaaaegacbaaaabaaaaaadeaaaaakhcaabaaa
abaaaaaaegacbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
aaaaaaahhcaabaaaacaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaddaaaaak
hcaabaaaacaaaaaaegacbaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadbaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadp
aaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaa
dhaaaaajhccabaaaaaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaa
acaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMPinLight" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedldckfoblolmjohbchkplhhalohoejiagabaaaaaakiadaaaaaeaaaaaa
daaaaaaaemabaaaaaaadaaaaheadaaaaebgpgodjbeabaaaabeabaaaaaaacpppp
omaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaaadpaaaaaalpaaaaiadpaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaachiaaaaaoeiaaaaaoela
aaaaffkaacaaaaadabaachiaabaaoeiaabaaoeiaalaaaaadacaachiaaaaakkka
abaaoeiaafaaaaadabaacpiaaaaaoeiaaaaaoelaaeaaaaaeaaaaahiaaaaaoeia
aaaaoelbaaaaaakaacaaaaadadaachiaabaaoeiaabaaoeiaakaaaaadaeaachia
adaaoeiaaaaakkkafiaaaaaeabaachiaaaaaoeiaaeaaoeiaacaaoeiaabaaaaac
aaaicpiaabaaoeiappppaaaafdeieefckmabaaaaeaaaaaaaglaaaaaafkaaaaad
aagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaa
abaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaac
adaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaa
aagabaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaaaaaaaaaaegbcbaaa
abaaaaaaaceaaaaaaaaaaalpaaaaaalpaaaaaalpaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaaaaaaaaahhcaabaaaabaaaaaa
egacbaaaabaaaaaaegacbaaaabaaaaaadeaaaaakhcaabaaaabaaaaaaegacbaaa
abaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaaaaaaaaahhcaabaaa
acaaaaaaegacbaaaaaaaaaaaegacbaaaaaaaaaaaddaaaaakhcaabaaaacaaaaaa
egacbaaaacaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadbaaaaak
hcaabaaaaaaaaaaaaceaaaaaaaaaaadpaaaaaadpaaaaaadpaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadhaaaaajhccabaaa
aaaaaaaaegacbaaaaaaaaaaaegacbaaaabaaaaaaegacbaaaacaaaaaadoaaaaab
ejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
gcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
CMP R0.xyz, -R0, c[0].x, c[0].y;
MOV result.color.w, R0;
MOV result.color.xyz, R0;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 0.00000000, 1.00000000, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
cmp r0.xyz, -r0, c0.x, c0.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedpliggpmpjbffomanjkoehflpmgkpkaehabaaaaaaneabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpiaaaaaaeaaaaaaa
doaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaadbaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaaabaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedkdhapajfpldckkkhgnebnpbhnehndkbbabaaaaaaimacaaaaaeaaaaaa
daaaaaaaoeaaaaaaoeabaaaafiacaaaaebgpgodjkmaaaaaakmaaaaaaaaacpppp
ieaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaacpiaaaaaoeiaaaaaoela
fiaaaaaeaaaachiaaaaaoeibaaaaaakaaaaaffkaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcpiaaaaaaeaaaaaaadoaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaak
hcaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaabaaaaakhccabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
doaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1, 0 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
CMP R0.xyz, -R0, c[0].x, c[0].y;
MOV result.color.w, R0;
MOV result.color.xyz, R0;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 0.00000000, 1.00000000, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
cmp r0.xyz, -r0, c0.x, c0.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedpliggpmpjbffomanjkoehflpmgkpkaehabaaaaaaneabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpiaaaaaaeaaaaaaa
doaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaadbaaaaakhcaabaaaaaaaaaaaaceaaaaaaaaaaaaa
aaaaaaaaaaaaaaaaaaaaaaaaegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaaabaaaaakhccabaaaaaaaaaaaegacbaaaaaaaaaaaaceaaaaa
aaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMHardMix" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedkdhapajfpldckkkhgnebnpbhnehndkbbabaaaaaaimacaaaaaeaaaaaa
daaaaaaaoeaaaaaaoeabaaaafiacaaaaebgpgodjkmaaaaaakmaaaaaaaaacpppp
ieaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaaaaaaaaaiadpaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaacpiaaaaaoeiaaaaaoela
fiaaaaaeaaaachiaaaaaoeibaaaaaakaaaaaffkaabaaaaacaaaicpiaaaaaoeia
ppppaaaafdeieefcpiaaaaaaeaaaaaaadoaaaaaafkaaaaadaagabaaaaaaaaaaa
fibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaad
dcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaaj
pcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaadbaaaaak
hcaabaaaaaaaaaaaaceaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaegacbaaa
aaaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaaabaaaaakhccabaaa
aaaaaaaaegacbaaaaaaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
doaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaa
adaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaa
apapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfa
epfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaa
abaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaa
fdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
ADD R0.xyz, -R0, c[0].x;
MOV result.color.w, R0;
ABS result.color.xyz, R0;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 1.00000000, 0, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r0.xyz, -r0, c0.x
abs_pp r0.xyz, r0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedfjfcfahcejdibhjjpephjghojndnfabgabaaaaaanaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpeaaaaaaeaaaaaaa
dnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaanhcaabaaaaaaaaaaaegacbaia
ebaaaaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaaghccabaaaaaaaaaaa
egacbaiaibaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedcnbpejpedphokolphiecccigjomnocekabaaaaaajeacaaaaaeaaaaaa
daaaaaaapaaaaaaaomabaaaagaacaaaaebgpgodjliaaaaaaliaaaaaaaaacpppp
jaaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeaaaachiaaaaaoeiaaaaaoelb
aaaaaakaafaaaaadabaaciiaaaaappiaaaaapplacdaaaaacabaachiaaaaaoeia
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefcpeaaaaaaeaaaaaaadnaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaanhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaaghccabaaaaaaaaaaaegacbaia
ibaaaaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
ADD R0.xyz, -R0, c[0].x;
MOV result.color.w, R0;
ABS result.color.xyz, R0;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 1.00000000, 0, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r0.xyz, -r0, c0.x
abs_pp r0.xyz, r0
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedfjfcfahcejdibhjjpephjghojndnfabgabaaaaaanaabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcpeaaaaaaeaaaaaaa
dnaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaanhcaabaaaaaaaaaaaegacbaia
ebaaaaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadiaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaa
dgaaaaaficcabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaaghccabaaaaaaaaaaa
egacbaiaibaaaaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMDifference" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedcnbpejpedphokolphiecccigjomnocekabaaaaaajeacaaaaaeaaaaaa
daaaaaaapaaaaaaaomabaaaagaacaaaaebgpgodjliaaaaaaliaaaaaaaaacpppp
jaaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaaaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeaaaachiaaaaaoeiaaaaaoelb
aaaaaakaafaaaaadabaaciiaaaaappiaaaaapplacdaaaaacabaachiaaaaaoeia
abaaaaacaaaicpiaabaaoeiappppaaaafdeieefcpeaaaaaaeaaaaaaadnaaaaaa
fkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaad
pcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaa
giaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaa
aaaaaaaaaagabaaaaaaaaaaadcaaaaanhcaabaaaaaaaaaaaegacbaiaebaaaaaa
aaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
diaaaaahicaabaaaaaaaaaaadkaabaaaaaaaaaaadkbabaaaabaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadgaaaaaghccabaaaaaaaaaaaegacbaia
ibaaaaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 2, 1 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MAD R0.xyz, -R0, c[0].x, R0;
MOV result.color.w, R0;
ADD result.color.xyz, R0, c[0].y;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 2.00000000, 1.00000000, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
mad_pp r0.xyz, -r0, c0.x, r0
add_pp r0.xyz, r0, c0.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecednhoffpcgeodnpjnokjlchhikabanhddnabaaaaaaoiabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcamabaaaaeaaaaaaa
edaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaadcaaaaan
hccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedmpbicclbifkchhfegidfpdbhapacflgiabaaaaaaleacaaaaaeaaaaaa
daaaaaaapiaaaaaaamacaaaaiaacaaaaebgpgodjmaaaaaaamaaaaaaaaaacpppp
jiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaeaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaachiaaaaaoeiaaaaaoela
aaaaaakaafaaaaadaaaacpiaaaaaoeiaaaaaoelaaeaaaaaeaaaachiaaaaaoeia
aaaaffkbabaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcamabaaaa
eaaaaaaaedaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaa
egacbaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaa
dcaaaaanhccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 2, 1 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MAD R0.xyz, -R0, c[0].x, R0;
MOV result.color.w, R0;
ADD result.color.xyz, R0, c[0].y;
END
# 5 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 2.00000000, 1.00000000, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
mad_pp r0.xyz, -r0, c0.x, r0
add_pp r0.xyz, r0, c0.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecednhoffpcgeodnpjnokjlchhikabanhddnabaaaaaaoiabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcamabaaaaeaaaaaaa
edaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaaegacbaaa
aaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaa
diaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaadcaaaaan
hccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaeaaaaaaaea
aaaaaaeaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaadkaabaaa
aaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMExclusion" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedmpbicclbifkchhfegidfpdbhapacflgiabaaaaaaleacaaaaaeaaaaaa
daaaaaaapiaaaaaaamacaaaaiaacaaaaebgpgodjmaaaaaaamaaaaaaaaaacpppp
jiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaaaeaaaaaaaaaaaaaaaaabpaaaaac
aaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapka
ecaaaaadaaaaapiaabaaoelaaaaioekaaeaaaaaeabaachiaaaaaoeiaaaaaoela
aaaaaakaafaaaaadaaaacpiaaaaaoeiaaaaaoelaaeaaaaaeaaaachiaaaaaoeia
aaaaffkbabaaoeiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefcamabaaaa
eaaaaaaaedaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaa
ffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaad
pccabaaaaaaaaaaagiaaaaacacaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaa
acaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadcaaaaamhcaabaaaabaaaaaa
egacbaaaaaaaaaaaegbcbaaaabaaaaaaaceaaaaaaaaaiadpaaaaiadpaaaaiadp
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaa
dcaaaaanhccabaaaaaaaaaaaegacbaiaebaaaaaaaaaaaaaaaceaaaaaaaaaaaea
aaaaaaeaaaaaaaeaaaaaaaaaegacbaaaabaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MOV result.color.w, R0;
ADD result.color.xyz, -R0, c[0].x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 1.00000000, 0, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r0.xyz, -r0, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefieceddgjijpkeaojlohfaknniffidhihahofiabaaaaaakmabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnaaaaaaaeaaaaaaa
deaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaadcaaaaappccabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaiadpaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedgdcnofkeeodlobijlpmeachgdbconopiabaaaaaaiiacaaaaaeaaaaaa
daaaaaaaaiabaaaaoaabaaaafeacaaaaebgpgodjnaaaaaaanaaaaaaaaaacpppp
kiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaiadpaaaaiadpaaaaaaaafbaaaaaf
abaaapkaaaaaialpaaaaialpaaaaialpaaaaiadpbpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapia
abaaoelaaaaioekaafaaaaadaaaacpiaaaaaoeiaaaaaoelaabaaaaacabaaapia
abaaoekaaeaaaaaeaaaacpiaaaaaoeiaabaaoeiaaaaaoekaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcnaaaaaaaeaaaaaaadeaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaa
dcaaaaappccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaiadpaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab
ejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
gcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
PARAM c[1] = { { 1 } };
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MOV result.color.w, R0;
ADD result.color.xyz, -R0, c[0].x;
END
# 4 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
def c0, 1.00000000, 0, 0, 0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
add_pp r0.xyz, -r0, c0.x
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefieceddgjijpkeaojlohfaknniffidhihahofiabaaaaaakmabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnaaaaaaaeaaaaaaa
deaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaadcaaaaappccabaaaaaaaaaaaegaobaaaaaaaaaaa
aceaaaaaaaaaialpaaaaialpaaaaialpaaaaiadpaceaaaaaaaaaiadpaaaaiadp
aaaaiadpaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMSubtract" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedgdcnofkeeodlobijlpmeachgdbconopiabaaaaaaiiacaaaaaeaaaaaa
daaaaaaaaiabaaaaoaabaaaafeacaaaaebgpgodjnaaaaaaanaaaaaaaaaacpppp
kiaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppfbaaaaafaaaaapkaaaaaiadpaaaaiadpaaaaiadpaaaaaaaafbaaaaaf
abaaapkaaaaaialpaaaaialpaaaaialpaaaaiadpbpaaaaacaaaaaaiaaaaaapla
bpaaaaacaaaaaaiaabaacdlabpaaaaacaaaaaajaaaaiapkaecaaaaadaaaaapia
abaaoelaaaaioekaafaaaaadaaaacpiaaaaaoeiaaaaaoelaabaaaaacabaaapia
abaaoekaaeaaaaaeaaaacpiaaaaaoeiaabaaoeiaaaaaoekaabaaaaacaaaicpia
aaaaoeiappppaaaafdeieefcnaaaaaaaeaaaaaaadeaaaaaafkaaaaadaagabaaa
aaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaa
gcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaa
efaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaa
aaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaa
dcaaaaappccabaaaaaaaaaaaegaobaaaaaaaaaaaaceaaaaaaaaaialpaaaaialp
aaaaialpaaaaiadpaceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaaaaadoaaaaab
ejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaa
aaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaa
gcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfe
ejepeoaaedepemepfcaafeeffiedepepfceeaaklepfdeheocmaaaaaaabaaaaaa
aiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfe
gbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "DUMMY" "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MOV result.color.w, R0;
RCP result.color.x, R0.x;
RCP result.color.y, R0.y;
RCP result.color.z, R0.z;
END
# 6 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DUMMY" "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "DUMMY" "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedlncfgphhccfgiepboblajddagefmenchabaaaaaakmabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnaaaaaaaeaaaaaaa
deaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaaaoaaaaakhccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "DUMMY" "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedefcalheamcdlhkmjffknabjkojiloielabaaaaaafmacaaaaaeaaaaaa
daaaaaaanmaaaaaaleabaaaaciacaaaaebgpgodjkeaaaaaakeaaaaaaaaacpppp
hmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaac
aaaaaajaaaaiapkaecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaacpia
aaaaoeiaaaaaoelaagaaaaacaaaacbiaaaaaaaiaagaaaaacaaaacciaaaaaffia
agaaaaacaaaaceiaaaaakkiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
naaaaaaaeaaaaaaadeaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaaaoaaaaakhccabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
SubProgram "opengl " {
Keywords { "PIXELSNAP_ON" "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
"!!ARBfp1.0
TEMP R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, fragment.color.primary;
MOV result.color.w, R0;
RCP result.color.x, R0.x;
RCP result.color.y, R0.y;
RCP result.color.z, R0.z;
END
# 6 instructions, 1 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "PIXELSNAP_ON" "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
"ps_2_0
dcl_2d s0
dcl v0
dcl t0.xy
texld r0, t0, s0
mul r0, r0, v0
rcp_pp r0.x, r0.x
rcp_pp r0.z, r0.z
rcp_pp r0.y, r0.y
mov_pp oC0, r0
"
}
SubProgram "d3d11 " {
Keywords { "PIXELSNAP_ON" "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0
eefiecedlncfgphhccfgiepboblajddagefmenchabaaaaaakmabaaaaadaaaaaa
cmaaaaaakaaaaaaaneaaaaaaejfdeheogmaaaaaaadaaaaaaaiaaaaaafaaaaaaa
aaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaaadaaaaaaacaaaaaa
adadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeeffiedepepfceeaakl
epfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaaaaaaaaaaadaaaaaa
aaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklklfdeieefcnaaaaaaaeaaaaaaa
deaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaaaaaaaaaaffffaaaa
gcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaagfaaaaadpccabaaa
aaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaaegbabaaaacaaaaaa
eghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaaaaaaaaaaegaobaaa
aaaaaaaaegbobaaaabaaaaaaaoaaaaakhccabaaaaaaaaaaaaceaaaaaaaaaiadp
aaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadgaaaaaficcabaaaaaaaaaaa
dkaabaaaaaaaaaaadoaaaaab"
}
SubProgram "d3d11_9x " {
Keywords { "PIXELSNAP_ON" "BMDivide" }
SetTexture 0 [_MainTex] 2D 0
"ps_4_0_level_9_1
eefiecedefcalheamcdlhkmjffknabjkojiloielabaaaaaafmacaaaaaeaaaaaa
daaaaaaanmaaaaaaleabaaaaciacaaaaebgpgodjkeaaaaaakeaaaaaaaaacpppp
hmaaaaaaciaaaaaaaaaaciaaaaaaciaaaaaaciaaabaaceaaaaaaciaaaaaaaaaa
aaacppppbpaaaaacaaaaaaiaaaaaaplabpaaaaacaaaaaaiaabaacdlabpaaaaac
aaaaaajaaaaiapkaecaaaaadaaaaapiaabaaoelaaaaioekaafaaaaadaaaacpia
aaaaoeiaaaaaoelaagaaaaacaaaacbiaaaaaaaiaagaaaaacaaaacciaaaaaffia
agaaaaacaaaaceiaaaaakkiaabaaaaacaaaicpiaaaaaoeiappppaaaafdeieefc
naaaaaaaeaaaaaaadeaaaaaafkaaaaadaagabaaaaaaaaaaafibiaaaeaahabaaa
aaaaaaaaffffaaaagcbaaaadpcbabaaaabaaaaaagcbaaaaddcbabaaaacaaaaaa
gfaaaaadpccabaaaaaaaaaaagiaaaaacabaaaaaaefaaaaajpcaabaaaaaaaaaaa
egbabaaaacaaaaaaeghobaaaaaaaaaaaaagabaaaaaaaaaaadiaaaaahpcaabaaa
aaaaaaaaegaobaaaaaaaaaaaegbobaaaabaaaaaaaoaaaaakhccabaaaaaaaaaaa
aceaaaaaaaaaiadpaaaaiadpaaaaiadpaaaaiadpegacbaaaaaaaaaaadgaaaaaf
iccabaaaaaaaaaaadkaabaaaaaaaaaaadoaaaaabejfdeheogmaaaaaaadaaaaaa
aiaaaaaafaaaaaaaaaaaaaaaabaaaaaaadaaaaaaaaaaaaaaapaaaaaafmaaaaaa
aaaaaaaaaaaaaaaaadaaaaaaabaaaaaaapapaaaagcaaaaaaaaaaaaaaaaaaaaaa
adaaaaaaacaaaaaaadadaaaafdfgfpfaepfdejfeejepeoaaedepemepfcaafeef
fiedepepfceeaaklepfdeheocmaaaaaaabaaaaaaaiaaaaaacaaaaaaaaaaaaaaa
aaaaaaaaadaaaaaaaaaaaaaaapaaaaaafdfgfpfegbhcghgfheaaklkl"
}
}
 }
}
Fallback "Sprites/Default"
}