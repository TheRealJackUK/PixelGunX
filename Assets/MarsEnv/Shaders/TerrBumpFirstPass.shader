Shader "Custom/Mars/Bumped Specular" {
Properties {
	_SpecColor ("Specular Color", Color) = (0.5, 0.5, 0.5, 1)
	_Shininess ("Shininess", Range (0.03, 1)) = 0.078125

	// set by terrain engine
	[HideInInspector] _Control ("Control (RGBA)", 2D) = "red" {}
	[HideInInspector] _Splat3 ("Layer 3 (A)", 2D) = "white" {}
	[HideInInspector] _Splat2 ("Layer 2 (B)", 2D) = "white" {}
	[HideInInspector] _Splat1 ("Layer 1 (G)", 2D) = "white" {}
	[HideInInspector] _Splat0 ("Layer 0 (R)", 2D) = "white" {}
	[HideInInspector] _Normal3 ("Normal 3 (A)", 2D) = "bump" {}
	[HideInInspector] _Normal2 ("Normal 2 (B)", 2D) = "bump" {}
	[HideInInspector] _Normal1 ("Normal 1 (G)", 2D) = "bump" {}
	[HideInInspector] _Normal0 ("Normal 0 (R)", 2D) = "bump" {}
	// used in fallback on old cards & base map
	
	_Mask ("Mask (RGB)", 2D) = "white" {}	
		
	_ColorTex ("ColorMap (RGB)", 2D) = "white" {}	
	_SandColorTex ("SandColorMap (RGB)", 2D) = "white" {}	
	_MainBumpMap ("Normal map (RGB)", 2D) = "white" {}
	_Color ("Main Color", Color) = (1,1,1,1)
}
	
SubShader {
	Tags {
		"SplatCount" = "4"
		"Queue" = "Geometry-100"
		"RenderType" = "Opaque"
	}
CGPROGRAM
#pragma surface surf BlinnPhong vertex:vert
#pragma target 3.0

void vert (inout appdata_full v)
{
	v.tangent.xyz = cross(v.normal, float3(0,0,1));
	v.tangent.w = -1;
}

struct Input {
	float2 uv_Control : TEXCOORD0;
	float2 uv_Splat0 : TEXCOORD1;
	float2 uv_Splat1 : TEXCOORD2;
	float2 uv_Splat2 : TEXCOORD3;
	float2 uv_Splat3 : TEXCOORD4;
	float2 uv_Mask : TEXCOORD0;
	float3 worldPos;
	
	
	float3 worldRefl;
	float3 viewDir;
	INTERNAL_DATA
};

sampler2D _Control;
sampler2D _Mask;
sampler2D _ColorTex;
sampler2D _SandColorTex;
fixed4 _ReflectColor;
sampler2D _MainBumpMap;
sampler2D _Splat0,_Splat1,_Splat2,_Splat3;
sampler2D _Normal0,_Normal1,_Normal2,_Normal3;
half _Shininess;
fixed4 _Color;

samplerCUBE _Cube;


	float3 blend(float4 tex_red, float red, 
				 float4 tex_green, float green,	
				 float4 tex_blue, float blue)
	{ 
		float depth = 0.2;
		float ma = max(max(tex_red.a + red, tex_green.a + green),tex_blue.a + blue) - depth;
		float b1 = max(tex_red.a + red - ma, 0);
		float b2 = max(tex_green.a + green - ma, 0);
		float b3 = max(tex_blue.a + blue - ma, 0);
		return (tex_red.rgb * b1 + tex_green.rgb * b2+tex_blue.rgb * b3) / (b1+b2+b3);
	}
	
void surf (Input IN, inout SurfaceOutput o) {
	
	fixed4 splat_control = tex2D (_Mask, IN.uv_Mask); 
	fixed4 col;
	col  = splat_control.r * tex2D (_Splat0, IN.uv_Splat0);
	col += splat_control.g * tex2D (_Splat1, IN.worldPos.xy /10 );
	col += splat_control.b * tex2D (_Splat2, IN.uv_Splat2);
	col += splat_control.a * tex2D (_Splat3, IN.uv_Splat3);
	
	o.Albedo = 		blend(tex2D(_Splat0,IN.uv_Splat0), 
					splat_control.r, 
					tex2D(_Splat1,IN.worldPos.xy/10), 
					splat_control.g, 
					tex2D(_Splat2,IN.uv_Splat2), 
					splat_control.b) * tex2D(_ColorTex, IN.uv_Mask).rgb * _Color * tex2D(_SandColorTex, IN.uv_Splat0/5).rgb;

	fixed4 nrm;
	nrm  = splat_control.r * tex2D (_Normal0, IN.uv_Splat0);
	nrm += splat_control.g * tex2D (_Normal1, IN.worldPos.xy/10);
	nrm += splat_control.b * tex2D (_Normal2, IN.uv_Splat2);
	nrm += splat_control.a * tex2D (_Normal3, IN.uv_Splat3);
	// Sum of our four splat weights might not sum up to 1, in
	// case of more than 4 total splat maps. Need to lerp towards
	// "flat normal" in that case.
	fixed splatSum = dot(splat_control, fixed4(1,1,1,1));
	fixed4 flatNormal = fixed4(0.5,0.5,1,0.5); // this is "flat normal" in both DXT5nm and xyz*2-1 cases
	nrm = lerp(1.5*flatNormal, nrm, splatSum);
	//o.Normal =  UnpackNormal( tex2D (_Normal0, IN.uv_Splat0)) + UnpackNormal( tex2D(_MainBumpMap, IN.uv_Control));
	o.Normal =  normalize(UnpackNormal(nrm) + UnpackNormal( tex2D(_MainBumpMap, IN.uv_Control)));

	o.Gloss = col.a * tex2D(_ColorTex, IN.uv_Mask).a;
	o.Specular = _Shininess;

}
ENDCG  
}

//Dependency "AddPassShader" = "Hidden/Moon/Terrain/Bumped Specular AddPass"
//Dependency "BaseMapShader" = "Specular"

FallBack "Legacy Shaders/Reflective/Bumped Specular"
}
