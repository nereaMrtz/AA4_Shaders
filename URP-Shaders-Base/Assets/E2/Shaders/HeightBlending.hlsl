#ifndef HLSL_CUSTOM
#define HLSL_CUSTOM

void HeightBlend_float(
    float blendFactor, // Overlay result
    float heightA, float heightB, // Heights
    float3 albedoA, float3 albedoB, // Albedo colors
    float3 normalA, float3 normalB, // Normals
    float3 masksA, float3 masksB, // Masks (Metallic, AO, Smoothness)
    
    out float3 outAlbedo, // Albedo output
    out float3 outNormal, // Normal output
    out float3 outMasks // Masks output
)
{
    // Asegurar inicialización de los valores de salida
    outAlbedo = float3(0.0, 0.0, 0.0); // Inicializa outAlbedo
    outNormal = float3(0.0, 0.0, 1.0); // Normal en Tangent Space por defecto
    outMasks = float3(0.0, 0.0, 0.0); // Inicializa outMasks

    // Calcular la diferencia de alturas
    float heightDiff = abs(heightB - heightA);
    // Aplicar smoothstep para suavizar el blending basado en altura
    float blendWeight = smoothstep(0.0, 0.5, heightDiff);
    
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