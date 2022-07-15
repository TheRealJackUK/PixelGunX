// Upgrade NOTE: commented out 'float4 unity_LightmapST', a built-in variable
// Upgrade NOTE: commented out 'sampler2D unity_Lightmap', a built-in variable
// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'
// Upgrade NOTE: replaced tex2D unity_Lightmap with UNITY_SAMPLE_TEX2D

Shader "MADFINGER/Environment/Cube env map (Supports Lightmap)" {

Properties 
{
	_MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
	_EnvTex ("Cube env tex", CUBE) = "black" {}
	_Spread("Spread", Range (0.1,0.5)) = 0.5
}

SubShader {
	Tags { "RenderType"="Opaque" "LightMode"="ForwardBase"}
	LOD 100
	
	
	
	CGINCLUDE
	#include "UnityCG.cginc"
	
	sampler2D _MainTex;
	samplerCUBE _EnvTex;
	
	#ifndef LIGHTMAP_OFF
	// float4 unity_LightmapST;
	// sampler2D unity_Lightmap;
	#endif

	float3 _SpecColor;
	float _Shininess;
	float _Spread;
	
	struct v2f {
		float4 pos : SV_POSITION;
		float2 uv : TEXCOORD0;
		#ifndef LIGHTMAP_OFF
		float2 lmap : TEXCOORD1;
		#endif
		float3 refl : TEXCOORD2;
	};

	
	v2f vert (appdata_full v)
	{
		v2f o;
		
		o.pos	= UnityObjectToClipPos(v.vertex);
		o.uv		= v.texcoord;
		
		float3 worldNormal = mul((float3x3)unity_ObjectToWorld, v.normal);
		o.refl = reflect(-WorldSpaceViewDir(v.vertex), worldNormal);
		o.refl.x = -o.refl.x;
		
		#ifndef LIGHTMAP_OFF
		o.lmap = v.texcoord1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
		#endif
		
		
		return o;
	}
	ENDCG


	Pass {
		CGPROGRAM
		#pragma vertex vert
		#pragma fragment frag
		#pragma fragmentoption ARB_precision_hint_fastest		
		fixed4 frag (v2f i) : COLOR
		{
			fixed4 c 	= tex2D (_MainTex, i.uv.xy);
			
			#ifndef LIGHTMAP_OFF
			c.xyz *= DecodeLightmap (UNITY_SAMPLE_TEX2D(unity_Lightmap, i.lmap));
			#endif
			
			c.xyz += texCUBE(_EnvTex,i.refl) * c.a;
			
			return c;
		}
		ENDCG 
	}	
}
}


