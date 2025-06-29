// Si está muerto, no procesar movimiento
if (state == PlayerState.DEAD) {
    // Aplicar gravedad y movimiento hacia arriba
    vsp += grv;
    y += vsp;
    
    // Si cae fuera de la pantalla, reiniciar
    if (y > room_height + 100) {
        room_restart();
    }
    exit;
}

// Input horizontal
var _right = keyboard_check(vk_right);
var _left = keyboard_check(vk_left);
var _run = keyboard_check(ord("X")); // Tecla X para correr
var _jump = keyboard_check(vk_space); // Mantener el estado del salto

// Movimiento horizontal
var _move = _right - _left;
is_running = _run && _move != 0;
hsp = _move * (is_running ? runsp : walksp);

// Verificar colisión con enemigo antes de moverse
var _enemy = instance_place(x + hsp, y, EnemyStompable);
if (_enemy != noone && !_enemy.stomped) {
    // Si está cayendo sobre el enemigo
    if (vsp > 0 && place_meeting(x, y + 1, _enemy)) {
        // Aplastar enemigo
        _enemy.stomped = true;
        // Pequeño rebote
        vsp = -5;
        on_ground = false;
        state = PlayerState.JUMPING;
    } else {
        // Daño al jugador (colisión lateral o desde abajo)
        state = PlayerState.DEAD;
        vsp = -10; // Pequeño salto al morir
        hsp = 0; // Detener movimiento horizontal
    }
}

// Verificar colisión con enemigo intocable
var _intouchable = instance_place(x + hsp, y, EnemyIntouchable);
if (_intouchable != noone) {
    state = PlayerState.DEAD;
    vsp = -10; // Pequeño salto al morir
    hsp = 0; // Detener movimiento horizontal
}

// Actualizar dirección que mira el jugador
if (_right) {
    image_xscale = 1;
} else if (_left) {
    image_xscale = -1;
}

// Salto
if (keyboard_check_pressed(vk_space) && on_ground) {
    vsp = is_running ? run_jumpsp : jumpsp;
    on_ground = false;
    state = PlayerState.JUMPING;
}

// Control de altura del salto
if (!_jump && vsp < 0) {
    vsp = max(vsp, jumpsp * 0.5); // Reduce la velocidad de subida si se suelta el botón
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
if (place_meeting(x + hsp, y, Solid)) {
    hsp = 0;
}
x += hsp;

// Check collision with carriers from the side
var _carrier_side = instance_place(x, y, EnemyCarrier);
if (_carrier_side != noone && (y + sprite_height > _carrier_side.y)) {
    state = PlayerState.DEAD;
    vsp = -10;
    hsp = 0;
}

// Colisión vertical mejorada
var _vsp_sign = sign(vsp);
var _vsp_abs = abs(vsp);
var _steps = ceil(_vsp_abs);
var stand_carrier = noone;

for (var i = 0; i < _steps; i++) {
    // Verificar colisión con Solid
    if (place_meeting(x, y + _vsp_sign, Solid)) {
        if (_vsp_sign > 0) {
            on_ground = true;
            vsp = 0;
        } else {
            vsp = 0;
        }
        break;
    }

    // Verificar colisión con ladrillos
    var _brick = instance_place(x, y + _vsp_sign, BrickBase);
    if (_brick != noone) {
        if (_vsp_sign < 0) {
            if (is_undefined(_brick.onHit) == false) {
                _brick.onHit();
            }
            vsp = 0;
        } else {
            on_ground = true;
            vsp = 0;
            y = _brick.y - sprite_height;
        }
        break;
    }
    
    // Verificar colisión con SemiSolid
    if (place_meeting(x, y + _vsp_sign, SemiSolid)) {
        // Solo colisionar si está cayendo
        if (_vsp_sign > 0) {
            on_ground = true;
            vsp = 0;
            break;
        }
        // Si está subiendo, permitir atravesar
    }

    // Verificar colisión con enemigos que se pueden pisar (EnemyCarrier)
    var _carrier = instance_place(x, y + _vsp_sign, EnemyCarrier);
    if (_carrier != noone) {
        if (_vsp_sign > 0 && y + sprite_height <= _carrier.y) {
            on_ground = true;
            vsp = 0;
            y = _carrier.y - sprite_height;
            stand_carrier = _carrier;
        } else {
            state = PlayerState.DEAD;
            vsp = -10;
            hsp = 0;
        }
        break;
    }

    // Verificar colisión con enemigo aplastable
    var _enemy = instance_place(x + hsp, y, EnemyStompable); // Primero verificar colisión horizontal
    if (_enemy != noone && !_enemy.stomped) {
        // Si está cayendo sobre el enemigo
        if (vsp > 0 && place_meeting(x, y + 1, _enemy)) {
            // Aplastar enemigo
            _enemy.stomped = true;
            // Pequeño rebote
            vsp = -5;
            on_ground = false;
            state = PlayerState.JUMPING;
        } else {
            // Daño al jugador (colisión lateral o desde abajo)
            state = PlayerState.DEAD;
            vsp = -10; // Pequeño salto al morir
            hsp = 0; // Detener movimiento horizontal
        }
        break;
    }
    
    y += _vsp_sign;
}

// Si no está en el suelo, actualizar on_ground
if (!place_meeting(x, y + 1, Solid) && !place_meeting(x, y + 1, SemiSolid) && !place_meeting(x, y + 1, EnemyCarrier)) {
    on_ground = false;
}

// Trigger carrier behaviour if standing on one
var _stand_carrier = stand_carrier;
if (_stand_carrier == noone) {
    _stand_carrier = instance_place(x, y + 1, EnemyCarrier);
}
if (_stand_carrier != noone && y + sprite_height == _stand_carrier.y) {
    if (is_undefined(_stand_carrier.onRide) == false) {
        _stand_carrier.onRide(self);
        // Mantener al jugador sobre el carrier después de moverlo
        y = _stand_carrier.y - sprite_height;
        on_ground = true;
    }
}

// Máquina de estados
if (state == PlayerState.DEAD) {
    // No cambiar el estado si está muerto
} else if (!on_ground) {
    state = vsp < 0 ? PlayerState.JUMPING : PlayerState.FALLING;
} else if (hsp != 0) {
    state = is_running ? PlayerState.RUNNING : PlayerState.WALKING;
} else {
    state = PlayerState.IDLE;
}

// Actualizar sprite según el estado
switch(state) {
    case PlayerState.IDLE:
        sprite_index = spr_idle;
        image_speed = 1;
        break;
    case PlayerState.WALKING:
        sprite_index = spr_walk;
        image_speed = 1;
        break;
    case PlayerState.RUNNING:
        sprite_index = spr_walk;
        image_speed = 1.5; // Velocidad de animación más rápida al correr
        break;
    case PlayerState.JUMPING:
    case PlayerState.FALLING:
        sprite_index = spr_jump;
        image_speed = 1;
        break;
    case PlayerState.DEAD:
        sprite_index = spr_dead; // Usar sprite de muerte
        image_speed = 0;
        break;
}

// Colisiones con items
var _item = instance_place(x, y, ItemBase);
if (_item != noone) {
    _item.onTouch();
}