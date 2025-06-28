// Rideable enemy logic
var _player = instance_place(x, y - 1, Player);
carrying = (_player != noone && _player.vsp >= 0);

if (carrying) {
    // Move up while carrying player
    vsp = riseSpeed;
    if (place_meeting(x, y + vsp, Solid)) {
        while (!place_meeting(x, y + sign(vsp), Solid)) {
            y += sign(vsp);
        }
        vsp = 0;
    }
    y += vsp;
    // Move player along
    if (_player != noone) {
        _player.y = y - sprite_height;
    }
} else {
    // Horizontal flight
    if (place_meeting(x + hsp, y, Solid)) {
        hsp = -hsp;
    }
    x += hsp;
}
