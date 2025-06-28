// Inherit the parent event
event_inherited();

// Estados de la planta
enum PlantState {
    HIDDEN,     // Escondida arriba
    LOWERING,   // Bajando
    DOWN,       // Abajo
    RISING      // Subiendo
}

// Variables de estado
state = PlantState.HIDDEN;
wait_timer = 0;
wait_time_up = 180;    // Tiempo que espera arriba (3 segundos)
wait_time_down = 120;  // Tiempo que espera abajo (2 segundos)
rise_speed = -1;     // Velocidad de subida más lenta
lower_speed = 1;     // Velocidad de bajada más lenta
detection_range = 100; // Rango para detectar al jugador

// Sprite inicial
sprite_index = spr_npc_plant_1;
image_speed = 0.2;