#ifndef HLSL_CUSTOM
#define HLSL_CUSTOM

void HeightBlend_float(
    float blendFactor, 
    float heightA, float heightB,
    float3 albedoA, float3 albedoB, 
    float3 normalA, float3 normalB, 
    float3 masksA, float3 masksB, 
    float blendPower,

    out float3 outAlbedo,
    out float3 outNormal, 
    out float3 outMasks 
)
{
    // Init valores
    outAlbedo = float3(0.0, 0.0, 0.0); 
    outNormal = float3(0.0, 0.0, 1.0); 
    outMasks = float3(0.0, 0.0, 0.0); 


    // Calcular la diferencia de alturas
    float heightDiff = abs(heightB - heightA);

    // Ajustar el valor de la diferencia de altura con el BlendPower para poder ajustar la simulacion con el slider
    float adjustedHeightDiff = heightDiff * blendPower;

    // Aplicar smoothstep para suavizar el blending basado en altura
    // Aquí el valor ajustado se pasa de 0 a 1
    float blendWeight = smoothstep(0.0, 1.0, adjustedHeightDiff);
    
    // Modificar el peso con el factor de Overlay
    blendWeight *= blendFactor;
    
    // Mezcla de Albedo con Lerp
    outAlbedo = lerp(albedoA, albedoB, blendWeight);
    
    // Mezcla de Normales con Normal Blend (Re-normalizando)
    outNormal = normalize(lerp(normalA, normalB, blendWeight));
    
    // Mezcla de Masks (Metallic, AO, Smoothness)
    outMasks = lerp(masksA, masksB, blendWeight);
}

#endif