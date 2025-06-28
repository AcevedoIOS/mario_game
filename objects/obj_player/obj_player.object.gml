// Variables de movimiento
hsp = 0;
vsp = 0;
grv = 0.8;        // Gravedad más fuerte
walksp = 5;       // Velocidad de caminata más rápida
jumpsp = -15;     // Salto más alto
on_ground = false;
facing = 1;       // Dirección que mira el jugador (1 derecha, -1 izquierda)

// Evento Create
function Create() {
    // Inicialización de variables
    hsp = 0;
    vsp = 0;
    on_ground = false;
    facing = 1;
}

// Evento Step
function Step() {
    // Input horizontal
    var _right = keyboard_check(vk_right);
    var _left = keyboard_check(vk_left);
    
    // Movimiento horizontal
    hsp = (_right - _left) * walksp;
    
    // Actualizar dirección que mira el jugador
    if (hsp != 0) {
        facing = sign(hsp);
        image_xscale = facing;  // Esto volteará el sprite
    }
    
    // Salto
    if (keyboard_check_pressed(vk_space) && on_ground) {
        vsp = jumpsp;
        on_ground = false;
    }
    
    // Aplicar gravedad
    if (!on_ground) {
        vsp += grv;
    }
    
    // Limitar velocidad de caída
    if (vsp > 15) {
        vsp = 15;
    }
    
    // Colisión horizontal
    if (place_meeting(x + hsp, y, obj_solid)) {
        while (!place_meeting(x + sign(hsp), y, obj_solid)) {
            x += sign(hsp);
        }
        hsp = 0;
    }
    x += hsp;
    
    // Colisión vertical
    if (place_meeting(x, y + vsp, obj_solid)) {
        while (!place_meeting(x, y + sign(vsp), obj_solid)) {
            y += sign(vsp);
        }
        if (vsp > 0) {
            on_ground = true;
        }
        vsp = 0;
    } else {
        on_ground = false;
    }
    y += vsp;
}

// Evento Draw
function Draw() {
    // Dibujar sprite
    draw_sprite(spr_player, 0, x, y);
} 