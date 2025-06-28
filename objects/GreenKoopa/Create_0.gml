/// @description Insert description here
// You can write your code in this editor

// Definir enum para estados
enum KoopaState {
    WALKING,
    SHELL,
    SLIDING
}

// Variables de estado
state = KoopaState.WALKING;
_direction = 1; // -1 izquierda, 1 derecha
speed = 1;
slide_speed = 5;
stomped = false;

// Variables para el tiempo en shell
shell_timer = 0;
shell_duration = room_speed * 5; // 5 segundos en shell antes de desaparecer

// Configurar sprite inicial
sprite_index = spr_npc_gkopa;
image_speed = 0.3;
image_xscale = 1;
image_yscale = 1;

// Variables de movimiento
hsp = -1; // Velocidad horizontal inicial
vsp = 0;
grv = 0.8;
walksp = 1; // Velocidad de caminata

// Variables de estado
stomped = false;
stomp_timer = 0;
stomp_delay = 30; // Frames antes de desaparecer

// Guardar posición inicial
xstart = x;




























