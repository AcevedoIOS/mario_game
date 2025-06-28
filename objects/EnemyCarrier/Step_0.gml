// Basic horizontal movement. Vertical behaviour is handled in onRide
if (place_meeting(x + hsp, y, Solid)) {
    hsp = -hsp;
}
x += hsp;

// Apply vertical speed if any
if (vsp != 0) {
    if (place_meeting(x, y + vsp, Solid)) {
        while (!place_meeting(x, y + sign(vsp), Solid)) {
            y += sign(vsp);
        }
        vsp = 0;
    }
    y += vsp;
}
