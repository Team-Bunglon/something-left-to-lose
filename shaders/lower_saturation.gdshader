shader_type canvas_item;

uniform float desaturation_amount : hint_range(0.0, 1.0) = 0.8;

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);

    // Calculate the grayscale value
    float gray = dot(tex_color.rgb, vec3(0.599, 0.400, 0.100));

    // Mix the original color with grayscale
    vec3 desaturated_color = mix(tex_color.rgb, vec3(gray), desaturation_amount);

    // Set the final color
    COLOR = vec4(desaturated_color, tex_color.a);
}
