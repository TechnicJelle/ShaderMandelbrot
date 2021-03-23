#ifdef GL_ES
precision highp float;
#endif

uniform vec2 iResolution;
uniform int Maxit;
uniform vec2 center;
uniform vec2 min;
uniform float zoom;

vec2 imgsq(vec2 c) {
    float temp = c.x * c.x - c.y * c.y;
    c.y = 2.0 * c.x * c.y;
    c.x = temp;
    return c;
}

vec2 imgadd(vec2 c, vec2 z) {
    return vec2(c.x + z.x, c.y + z.y);
}

float imgmagsq(vec2 c) {
    return c.x * c.x + c.y * c.y;
}

void main()
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = gl_FragCoord.xy/iResolution.xy;
	
	vec2 ab = min + uv.xy * zoom;
    
    vec2 c = vec2(ab.x, ab.y);
    vec2 z = vec2(0.0, 0.0);
	
    int it;
    for(it = 0; it < Maxit; ++it) {
        z = imgsq(z);
        z = imgadd(c, z);
        if(imgmagsq(z) >= 4.0)
            break;
    }

    vec3 col = vec3(1.0 - it/Maxit);

    // Output to screen
    gl_FragColor = vec4(col, 1.0);
}
