/// @description Configuracion inicial del ladrillo
// Heredar configuracion base
event_inherited();

original_y = y;
hit_speed = 0;

// Sobrescribir la funcion onHit para producir un peque\xF1o rebote
onHit = function() {
    if (hit_speed == 0) {
        hit_speed = -3;
    }
};
