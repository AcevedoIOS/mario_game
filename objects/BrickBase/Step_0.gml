// Detectar golpe desde abajo
if (!is_hit) {
    var _p = instance_place(x, y + sprite_height, Player);
    if (_p != noone && _p.vsp < 0) {
        is_hit = true;
        bounce_dir = -1;
        onHit(_p);
    }
} else {
    // Animación de rebote
    bounce_offset += bounce_dir * bounce_speed;
    y = startY + bounce_offset;
    if (bounce_dir == -1 && bounce_offset <= -bounce_height) {
        bounce_dir = 1;
    } else if (bounce_dir == 1 && bounce_offset >= 0) {
        bounce_dir = 0;
        bounce_offset = 0;
        y = startY;
        is_hit = false;
    }
}
