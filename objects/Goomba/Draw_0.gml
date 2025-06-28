if (stomped) {
    // Dibujar sprite de goomba aplastado
    draw_sprite(spr_npc_goomba_dead, 0, x, y);
} else {
    // Dibujar sprite normal
    draw_self();
}