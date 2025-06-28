// Máquina de estados del enemigo que cae y sube
switch (state) {
    case DropperState.IDLE:
        if (shouldDrop()) {
            state = DropperState.DROPPING;
            vsp = verticalSpeed;
        }
        break;

    case DropperState.DROPPING:
        // Mover hacia abajo
        if (place_meeting(x, y + vsp, Solid)) {
            while (!place_meeting(x, y + sign(vsp), Solid)) {
                y += sign(vsp);
            }
            vsp = 0;
            state = DropperState.WAITING;
            waitTimer = 0;
        } else {
            y += vsp;
        }
        break;

    case DropperState.WAITING:
        waitTimer++;
        if (waitTimer >= waitTime) {
            state = DropperState.RISING;
        }
        break;

    case DropperState.RISING:
        y += riseSpeed;
        if (y <= startY) {
            y = startY;
            state = DropperState.IDLE;
        }
        break;
}

