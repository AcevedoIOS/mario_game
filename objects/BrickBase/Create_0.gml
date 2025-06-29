// Variables base para bricks
startY = y;
bounce_offset = 0;
bounce_speed = 1;
bounce_height = 4;
bounce_dir = 0; // 0=idle, -1=subiendo, 1=bajando
is_hit = false;

// Función que se llamará cuando el ladrillo sea golpeado
onHit = function(_player) {
    // Se puede sobrescribir en objetos hijos
};
