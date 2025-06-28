/// @description Insert description here
// You can write your code in this editor

// Heredar la configuración base
event_inherited();

// Sobrescribir la función onTouch
onTouch = function() {
    global.coin += 1;
    instance_destroy();
}




























