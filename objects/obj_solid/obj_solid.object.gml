// Evento Create
function Create() {
    // El objeto solid es estático y solo necesita colisiones
    solid = true;
}

// Evento Draw
function Draw() {
    // Dibujar sprite temporal (reemplazar con el sprite de bloques)
    draw_sprite(spr_solid, 0, x, y);
} 