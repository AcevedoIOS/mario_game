// Si está aplastado, manejar el temporizador
if (stomped) {
    stomp_timer++;
    if (stomp_timer >= stomp_delay) {
        instance_destroy();
    }
    // Cuando está aplastado, no se mueve ni colisiona
    exit;
}

// Aplicar gravedad
vsp += grv;

// Limitar velocidad de caída
if (vsp > 15) vsp = 15;

// Colisión horizontal
if (place_meeting(x + hsp, y, Solid)) {
    hsp = -hsp; // Cambiar dirección
}

// Colisión vertical
if (place_meeting(x, y + vsp, Solid)) {
    while (!place_meeting(x, y + sign(vsp), Solid)) {
        y += sign(vsp);
    }
    vsp = 0;
}

// Aplicar movimiento
x += hsp;
y += vsp;

// Verificar si está en el borde de una plataforma
if (!place_meeting(x + hsp, y + 1, Solid)) {
    hsp = -hsp; // Cambiar dirección
}