// Inherit from parent if any
event_inherited();

// Estado inicial y constantes
enum DropperState {
    IDLE,
    DROPPING,
    WAITING,
    RISING
}

state = DropperState.IDLE;
startY = y;

// Configuración por defecto
verticalSpeed = 8;
riseSpeed = -2;
waitTime = room_speed; // un segundo
waitTimer = 0;

deviceRange = 64; // rango para detectar al jugador debajo

// Función que puede ser redefinida por los hijos para detectar cuando caer
shouldDrop = function() {
    var _player = instance_nearest(x, y, Player);
    if (_player != noone) {
        return (abs(_player.x - x) < sprite_width / 2) && _player.y > y;
    }
    return false;
};

