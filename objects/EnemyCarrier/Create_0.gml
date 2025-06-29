// Basic movement for rideable flying enemies
hsp = 1;           // horizontal speed
riseSpeed = -2;    // vertical speed when carrying player
vsp = 0;
carrying = false;

// Called when the player stands on top of the carrier
onRide = function(_player) {
    // Default behaviour: move up while carrying the player
    vsp = riseSpeed;
    if (place_meeting(x, y + vsp, Solid)) {
        while (!place_meeting(x, y + sign(vsp), Solid)) {
            y += sign(vsp);
        }
        vsp = 0;
    }
    y += vsp;
};
