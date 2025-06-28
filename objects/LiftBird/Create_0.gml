event_inherited();

// Specific settings for the bird
sprite_index = Sprite19;
image_speed = 0.2;
hsp = 1.5;
riseSpeed = -2.5;

// Save base behaviour and extend it
var _baseRide = onRide;
onRide = function(_player) {
    _baseRide(_player);
    // Give a small extra vertical push for a smoother lift
    vsp += -0.5;
};
