// Estados del jugador
enum PlayerState {
    IDLE,
    WALKING,
    RUNNING,
    JUMPING,
    FALLING,
    DEAD
}

// Inicialización de variables
hsp = 0;
vsp = 0;
on_ground = false;
facing = 1;
grv = 0.8;        // Gravedad más fuerte
walksp = 5;       // Velocidad de caminata más rápida
runsp = 8;        // Velocidad de carrera
jumpsp = -15;     // Salto normal
run_jumpsp = -18; // Salto mientras corre
is_running = false;
lives = 3;        // Vidas del jugador

// Sprites
spr_idle = spr_player;    // Sprite por defecto
spr_walk = spr_smario_walk; // Sprite de caminata
spr_jump = spr_smario_jump; // Sprite de salto
spr_dead = spr_smario_dead; // Sprite de muerte

// Estado inicial
state = PlayerState.IDLE;
sprite_index = spr_idle;