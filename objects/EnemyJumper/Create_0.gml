event_inherited();

// Estados para saltar desde el suelo o lava
enum JumperState {
    WAITING,
    JUMPING
}

state = JumperState.WAITING;
startY = y;

// Configuración por defecto
jumpSpeed = -8;
gravity = 0.4;
waitTime = room_speed;
waitTimer = irandom(waitTime);

vsp = 0;
