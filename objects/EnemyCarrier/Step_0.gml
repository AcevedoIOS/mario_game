// Basic horizontal movement. Vertical behaviour is triggered by the player
if (place_meeting(x + hsp, y, Solid)) {
    hsp = -hsp;
}
x += hsp;

