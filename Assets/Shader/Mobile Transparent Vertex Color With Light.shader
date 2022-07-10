Shader "Mobile/Transparent/Vertex Color With Light" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _SpecColor ("Spec Color", Color) = (1,1,1,0)
 _Emission ("Emmisive Color", Color) = (0,0,0,0)
 _Shininess ("Shininess", Range(0.1,1)) = 0.7
 _MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
}
SubShader { 
 Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
 Pass {
  Tags { "QUEUE"="Transparent" "IGNOREPROJECTOR"="true" "RenderType"="Transparent" }
  Lighting On
  SeparateSpecular On
  Material {
   Ambient [_Color]
   Diffuse [_Color]
   Emission [_Emission]
   Specular [_SpecColor]
   Shininess [_Shininess]
  }
  ZWrite Off
  Fog { Mode Off }
  Blend SrcAlpha OneMinusSrcAlpha
  AlphaTest Greater 0
  ColorMaterial AmbientAndDiffuse
  SetTexture [_MainTex] { combine texture * primary, texture alpha * primary alpha }
  SetTexture [_MainTex] { ConstantColor [_Color] combine previous * constant double, previous alpha * constant alpha }
 }
}
}