/// @description Insert description here
// You can write your code in this editor

// Si está aplastado, manejar el temporizador
if (stomped) {
    stomp_timer++;
    if (stomp_timer >= stomp_delay) {
        instance_destroy();
    }
    exit;
}

// Aplicar gravedad
vsp += grv;
if (vsp > 15) vsp = 15;

// Movimiento horizontal
var _can_move = !place_meeting(x + hsp, y + 15, Solid);
if (_can_move) {
    x += hsp;
} else {
    hsp = -hsp;
    x -= sign(hsp);
}

// Aplicar movimiento vertical
if (place_meeting(x, y + vsp, Solid)) {
    while (!place_meeting(x, y + sign(vsp), Solid)) {
        y += sign(vsp);
    }
    vsp = 0;
}
y += vsp;

// Actualizar sprite
sprite_index = spr_npc_gkopa;
image_speed = 0.2;
image_xscale = 1;




























