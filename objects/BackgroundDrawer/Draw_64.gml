/// @description Insert description here
// You can write your code in this editor

// Dibujar el contador de monedas
draw_set_color(c_white);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

// Dibujar el ícono de la moneda
draw_sprite(spr_item_coin, 0, 20, 20);

// Dibujar el número de monedas
draw_text(50, 20, string(global.coin));




























