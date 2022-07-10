Shader "Mobile/Diffuse Detail" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _MainTex ("Base (RGB)", 2D) = "white" {}
 _Detail ("Detail (RGB)", 2D) = "gray" {}
}
SubShader { 
 Pass {
  Lighting On
  Material {
   Diffuse [_Color]
  }
  Fog { Mode Off }
  SetTexture [_MainTex] { combine texture * primary double, texture alpha * primary alpha }
  SetTexture [_Detail] { combine previous * texture double, previous alpha }
 }
}
Fallback "VertexLit"
}