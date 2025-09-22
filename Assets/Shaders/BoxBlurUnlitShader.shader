Shader "Unlit/BoxBlurUnlitShader"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _BlurWidth ("Blur Width", Vector) = (1,1,0,0)
        _BlurIntensity("Blur Intensity", Float) = 1.0
    }
    SubShader
    {
        Tags
        {
            "RenderType"="Opaque"
        }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"
            #include "Includes/Common.cginc"

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
            float4 _MainTex_TexelSize;
            vector _BlurWidth;
            float _BlurIntensity;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o, o.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return box_blur(_MainTex, i.uv, _BlurWidth.xy, _BlurIntensity, _MainTex_TexelSize.xy);
            }
            ENDCG
        }
    }
}