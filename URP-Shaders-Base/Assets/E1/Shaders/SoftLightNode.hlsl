void SoftLightNode_float(float fresnel, float intersection, float scanlines, float hexagons, out float Alpha) {
    float base = fresnel + intersection;
    float blend = scanlines * hexagons;
    Alpha = SoftLight(base, blend).r; 
}
