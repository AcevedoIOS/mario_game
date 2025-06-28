// Inherit the parent event
event_inherited();

// Buscar al jugador más cercano
var _player = instance_nearest(x, y, Player);
var _player_near = false;

// Verificar si el jugador está cerca
if (_player != noone) {
    var _dist = point_distance(x, y, _player.x, _player.y);
    _player_near = (_dist < detection_range);
}

// Máquina de estados
switch(state) {
    case PlantState.HIDDEN:
        // Mantener posición arriba
        y = ystart;
        
        // Esperar un tiempo arriba
        wait_timer++;
        
        // Si el jugador está cerca, reiniciar el temporizador
        if (_player_near) {
            wait_timer = 0;
        }
        
        // Si pasó el tiempo de espera y el jugador está lejos, comenzar a bajar
        if (wait_timer >= wait_time_up && !_player_near) {
            state = PlantState.LOWERING;
            wait_timer = 0;
        }
        break;
        
    case PlantState.LOWERING:
        // Bajar hasta la posición final
        y += lower_speed;
        
        // Si llegó abajo, cambiar estado
        if (y >= ystart + sprite_height) {
            y = ystart + sprite_height;
            state = PlantState.DOWN;
            wait_timer = 0;
        }
        break;
        
    case PlantState.DOWN:
        // Mantener posición abajo
        y = ystart + sprite_height;
        
        // Esperar un tiempo abajo
        wait_timer++;
        
        // Si el jugador está cerca, quedarse abajo
        if (_player_near) {
            wait_timer = 0;
        }
        
        // Si pasó el tiempo de espera y el jugador está lejos, comenzar a subir
        if (wait_timer >= wait_time_down && !_player_near) {
            state = PlantState.RISING;
            wait_timer = 0;
        }
        break;
        
    case PlantState.RISING:
        // Subir hasta la posición inicial
        y += rise_speed;
        
        // Si llegó arriba, cambiar estado
        if (y <= ystart) {
            y = ystart;
            state = PlantState.HIDDEN;
            wait_timer = 0;
        }
        break;
}

// Asegurar que la planta no se salga de sus límites sin causar temblor
if (state == PlantState.HIDDEN) {
    y = ystart;
    // Esperar un tiempo arriba antes de bajar
    wait_timer++;
    if (wait_timer >= wait_time_up && !_player_near) {
        state = PlantState.LOWERING;
        wait_timer = 0;
    }
}
if (state == PlantState.DOWN) y = ystart + sprite_height;

