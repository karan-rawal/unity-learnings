Shader "Unlit/SphereShader"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 0)
        _Gloss ("Gloss", Float) = 1
    }
    SubShader
    {

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"
            #include "Lighting.cginc"

            struct VertexInput
            {
                float4 vertex : POSITION;
                float2 uv0: TEXCOORD0;
                float3 normal: NORMAL;
            };

            struct VertexOutput
            {
                float4 vertex : SV_POSITION;
                float2 uv0: TEXCOORD0;
                float3 normal: TEXCOORD1;
                float3 wPos: TEXCOORD2;
            };

            uniform float4 _Color;
            uniform float _Gloss;

            VertexOutput vert (VertexInput input)
            {
                VertexOutput o;
                o.vertex = UnityObjectToClipPos(input.vertex);
                o.uv0 = input.uv0;
                o.normal = input.normal;
                o.wPos = mul(unity_ObjectToWorld, input.vertex);
                return o;
            }

            float4 frag (VertexOutput input) : SV_Target
            {
                // Lighting

                // Direct diffuse Light
                float3 lightDir = _WorldSpaceLightPos0.xyz;
                float3 lightColor = _LightColor0.rgb;
                float lightFalloff = saturate(dot(input.normal, lightDir));
                float3 directDiffuseLight = lightColor * lightFalloff;

                // Ambient Light
                float3 ambientLight = float3(0.2, 0.3, 0.4);

                // Direct Specular Light
                float3 camPos = _WorldSpaceCameraPos;
                float3 wPos = input.wPos;
                float3 fragToCam = camPos - wPos;
                float3 viewDir = normalize(fragToCam);
                float3 viewReflect = reflect(-viewDir, input.normal);
                float specularFalloff = max(0, dot(viewReflect, lightDir));
                // Modify gloss
                specularFalloff = pow(specularFalloff, _Gloss);
                    
                return float4(specularFalloff.xxx, 0);

                // Phong
                
                // Blinn-Phong

                // Composite Light
                float3 diffuseLight = ambientLight + directDiffuseLight;
                float3 finalSurfaceColor = diffuseLight * _Color;

                return float4(finalSurfaceColor, 0) * _Color;
            }
            ENDCG
        }
    }
}
