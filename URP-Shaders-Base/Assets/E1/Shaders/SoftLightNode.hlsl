void SoftLightNode_float(float fresnel, float intersection, float scanlines, float hexagons, out float Alpha) {
    float base = fresnel + intersection;
    float blend = scanlines * hexagons;

     blend *= saturate(pow(fresnel, 0.7)); // Ajuste para que las lineas de scanline tambien se difuminen con fresnel

    Alpha = SoftLight(base, blend).r; 
}
