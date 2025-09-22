#ifndef SHADER_COMMON
#define SHADER_COMMON
#endif

float4 box_blur(sampler2D tex, float2 uv, float2 size, float intensity, float2 texel_size_reciprocal)
{
    float4 left = tex2D(tex, uv + float2(-size.x * intensity, 0) * texel_size_reciprocal);
    float4 right = tex2D(tex, uv + float2(size.x * intensity, 0) * texel_size_reciprocal);
    float4 top = tex2D(tex, uv + float2(0, size.y * intensity) * texel_size_reciprocal);
    float4 bottom = tex2D(tex, uv + float2(0, -size.y * intensity) * texel_size_reciprocal);
    float4 middle = tex2D(tex, uv);
    float4 top_left = tex2D(tex, uv + float2(-size.x * intensity, size.y * intensity) * texel_size_reciprocal);
    float4 top_right = tex2D(tex, uv + float2(size.x * intensity, size.y * intensity) * texel_size_reciprocal);
    float4 bottom_left = tex2D(tex, uv + float2(-size.x * intensity, -size.y * intensity) * texel_size_reciprocal);
    float4 bottom_right = tex2D(tex, uv + float2(-size.x * intensity, size.y * intensity) * texel_size_reciprocal);
    return (left + right + top + bottom + middle + top_left + top_right + bottom_left + bottom_right) / 9.0;
}
