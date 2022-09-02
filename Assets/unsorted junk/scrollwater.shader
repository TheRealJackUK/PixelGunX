Shader "Retardation/scrollwater"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_MoveX ("X Movement", float) = 0
        _MoveY ("Y Movement", float) = 16
        _Color ("Color (RGBA)", Color) = (1, 1, 1, 0.3)
	}
	SubShader
	{
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
        ZWrite Off
        Blend SrcAlpha OneMinusSrcAlpha
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert alpha
            #pragma fragment frag alpha
			// make fog work
			#pragma multi_compile_fog
			
			#include "UnityCG.cginc"

			float _MoveX;
            float _MoveY;
            float4 _Color;

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				o.uv.x += _Time * _MoveX;
				o.uv.y += _Time * _MoveY;
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the texture
				fixed4 col = tex2D(_MainTex, i.uv) * _Color;
				// apply fog
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
		}
	}
}
