// Movimiento simple que sigue al jugador cuando está cerca
var _player = instance_nearest(x, y, Player);

if (_player != noone && point_distance(x, y, _player.x, _player.y) < followRange) {
    target = _player;
} else if (target != noone && point_distance(x, y, target.x, target.y) > followRange * 1.5) {
    target = noone;
}

if (target != noone) {
    var _dir = point_direction(x, y, target.x, target.y);
    hsp = lerp(hsp, lengthdir_x(swimSpeed, _dir), accel);
    vsp = lerp(vsp, lengthdir_y(swimSpeed, _dir), accel);
}

x += hsp;
y += vsp;
