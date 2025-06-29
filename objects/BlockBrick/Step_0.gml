/// @description Maneja el rebote al ser golpeado
if (hit_speed != 0) {
    y += hit_speed;
    hit_speed += 0.5;
    if (y >= original_y) {
        y = original_y;
        hit_speed = 0;
    }
}