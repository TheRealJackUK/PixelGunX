Shader "Decal/Transparent VertexLit" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "LIGHTMODE"="Vertex" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  Lighting On
  Material {
   Ambient [_Color]
   Diffuse [_Color]
  }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
  AlphaTest Greater 0
  ColorMask RGB
  Offset -1, -1
  SetTexture [_MainTex] { combine texture * primary double, texture alpha * primary alpha }
 }
 Pass {
  Tags { "LIGHTMODE"="VertexLM" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  BindChannels {
   Bind "vertex", Vertex
   Bind "normal", Normal
   Bind "texcoord1", TexCoord0
   Bind "texcoord", TexCoord1
  }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
  AlphaTest Greater 0
  ColorMask RGB
  Offset -1, -1
  SetTexture [unity_Lightmap] { Matrix [unity_LightmapMatrix] ConstantColor [_Color] combine texture * constant }
  SetTexture [_MainTex] { combine texture * previous double, texture alpha * primary alpha }
 }
 Pass {
  Tags { "LIGHTMODE"="VertexLMRGBM" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  BindChannels {
   Bind "vertex", Vertex
   Bind "normal", Normal
   Bind "texcoord1", TexCoord0
   Bind "texcoord1", TexCoord1
   Bind "texcoord", TexCoord2
  }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
  AlphaTest Greater 0
  ColorMask RGB
  Offset -1, -1
  SetTexture [unity_Lightmap] { Matrix [unity_LightmapMatrix] combine texture * texture alpha double }
  SetTexture [unity_Lightmap] { ConstantColor [_Color] combine previous * constant }
  SetTexture [_MainTex] { combine texture * previous quad, texture alpha * primary alpha }
 }
}
SubShader { 
 LOD 100
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "LIGHTMODE"="Always" "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  Lighting On
  Material {
   Ambient [_Color]
   Diffuse [_Color]
  }
  ZWrite Off
  Blend SrcAlpha OneMinusSrcAlpha
  AlphaTest Greater 0
  ColorMask RGB
  Offset -1, -1
  SetTexture [_MainTex] { combine texture * primary double, texture alpha * primary alpha }
 }
}
}