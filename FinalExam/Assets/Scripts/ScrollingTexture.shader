Shader "Custom/ScrollingTexture"
{
    Properties
    {
        _MainText ("Albedo (RGB)", 2D) = "white" {}
        _XSlider("Slider X", Range(-5,5)) = 1
        _YSlider("Slider Y", Range(-5,5)) = 1
    }
        SubShader
        {
            CGPROGRAM
            #pragma surface surf Lambert
            float _XSlider;
            float _YSlider;

    struct Input {
        float2 uv_MainText;
    };
    sampler2D _MainText;
    void surf(Input IN, inout SurfaceOutput o) {
        float2 newuv = IN.uv_MainText + float2(_XSlider, _YSlider);
        o.Albedo = tex2D(_MainText, newuv);
    }
        ENDCG
    }
    FallBack "Diffuse"
}
