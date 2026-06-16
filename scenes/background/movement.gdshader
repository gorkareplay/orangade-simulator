shader_type canvas_item;

uniform vec2 scroll_speed = vec2(0.5, 0.0);

void fragment() {
    vec2 scrolled_uv = fract(UV + scroll_speed * TIME);
    vec4 tex = texture(TEXTURE, scrolled_uv);

    vec4 color_a = vec4(1.0, 0.3, 0.0, 1.0);
    vec4 color_b = vec4(1.0, 1.0, 0.5, 1.0);
    float t = (UV.x + UV.y) / 2.0;
    vec4 tint = mix(color_a, color_b, t);

    COLOR = tex * tint;
}