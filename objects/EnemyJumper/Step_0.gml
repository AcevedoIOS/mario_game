// Lógica de salto vertical
switch (state) {
    case JumperState.WAITING:
        waitTimer++;
        if (waitTimer >= waitTime) {
            state = JumperState.JUMPING;
            vsp = jumpSpeed;
        }
        break;

    case JumperState.JUMPING:
        y += vsp;
        vsp += _gravity;
        if (y >= startY) {
            y = startY;
            vsp = 0;
            state = JumperState.WAITING;
            waitTimer = 0;
        }
        break;
}
