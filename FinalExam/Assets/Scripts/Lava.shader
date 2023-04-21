Shader "Custom/Lava"
{
    Properties
    {
        _MainText("Diffuse", 2D) = "white" {}
        _Amp("Amplitude", Range(0,1)) = 0.5
        _Smoothness("Ramp Smoothness", Range(0, 1)) = 0.5
        _Tint("Colour Tint", Color) = (1,1,1,1)
        _RampText("Ramp Texture", 2D) = "white"{}
        _Frequency("Frequency", Range(0,5)) = 3
        _myEmission("Emission", Color) = (1,1,1,1)
        _Speed("Speed", Range(0, 100)) = 10     
    }
    SubShader
    {
        CGPROGRAM
        #pragma surface surf ToonRamp vertex:vert

        struct Input
        {
            float2 uv_MainText;
            float3 vertColor;
        };

        sampler2D _RampText;
        float4 _Tint;
        float _Frequency;
        float _Speed;
        float _Amp;
        float _Smoothness;
        fixed4 _myEmission;

        struct appdata {
            float4 vertex: POSITION;
            float3 normal: NORMAL;
            float4 texcoord: TEXCOORD0;
            float4 texcoord1: TEXCOORD1;
            float4 texcoord2: TEXCOORD2;
        };
        float4 LightingToonRamp(SurfaceOutput s, fixed3 lightDir, fixed attenu)
        {
            float diff = (dot(s.Normal, lightDir) * 0.5 + 0.5) * attenu;
            float2 rh = diff;
            float3 r = tex2D(_RampText, rh).rgb;
            float4 c;
            c.rgb = s.Albedo * _LightColor0.rgb * (r * _Smoothness);
            c.a = s.Alpha;
            return c;
        }
        void vert(inout appdata v, out Input o) {
            UNITY_INITIALIZE_OUTPUT(Input, o);
            float t = _Time.y * _Speed;
            float waveHeightX = ((_Amp * (step(0.5, (t + v.vertex.x * _Frequency) % 1.0) * 2.0 - 1.0)));
            float waveHeightZ = ((_Amp * (step(0.5, (t + v.vertex.z * _Frequency) % 1.0) * 2.0 - 1.0)));
            float waveHeight = waveHeightX + waveHeightZ;
            v.vertex.y += waveHeight;
            o.vertColor = waveHeight + 2;
        }
        sampler2D _MainText;
        void surf(Input IN, inout SurfaceOutput o) {
            float4 c = tex2D(_MainText, IN.uv_MainText);
            o.Emission = _myEmission.rgb;
            o.Albedo = c * IN.vertColor.rgb;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
