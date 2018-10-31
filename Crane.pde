// how much of its speed the wrecking ball gives to a bomb when it hits it
final float VELOCITY_AMPLIFICATION = 5.0;

class Crane {
  float x, y; // point where the cable of the wrecking ball is attached
  float cableLength;
  float ballRadius;
  float angle;
  float angularVelocity;
  
  Crane(float x, float y, float cableLength, float ballRadius, float angularVelocity) {
    this.x = x;
    this.y = y;
    this.cableLength = cableLength;
    this.ballRadius = ballRadius;
    angle = HALF_PI;
    this.angularVelocity = angularVelocity;
  }
  
  Crane() {
    this(width / 2, height - 110, 80, 20, TWO_PI / 240);
  }
  
  void display() {
    // the wrecking ball
    float ballX = x + cableLength * cos(angle);
    float ballY = y + cableLength * sin(angle);
    stroke(0);
    strokeWeight(3);
    line(x, y, ballX, ballY);
    noStroke();
    fill(0);
    ellipseMode(RADIUS);
    ellipse(ballX, ballY, ballRadius, ballRadius);
    
    // the crane
    float x1 = x + 2 * ballRadius;
    float y1 = y + cableLength + ballRadius;
    float x2 = x1 + cableLength;
    float y2 = y1;
    stroke(0);
    strokeWeight(5);
    line(x, y, x1, y1);
    line(x1, y1, x2, y2);
    line(x2, y2, x, y);
    line((x + x1) / 2, (y + y1) / 2, (x + x2) / 2, (y + y2) / 2);
    line(x1, y1, (x + x2) / 2, (y + y2) / 2);
    line((x1 + x2) / 2, (y1 + y2) / 2, (x2 + x) / 2, (y2 + y) / 2);
    
    // the wheels
    noStroke();
    ellipse(x1 + cableLength / 4, y1, ballRadius / 2, ballRadius / 2);
    ellipse(x2 - cableLength / 4, y1, ballRadius / 2, ballRadius / 2);
  }
  
  void turn() {
    angle += angularVelocity;
  }
  
  void move() {
    x = mouseX;
  }
  
  void hit(Bomb bomb) {
    float ballX = x + cableLength * cos(angle);
    float ballY = y + cableLength * sin(angle);
    // check if the wrecking ball and the bomb intersect
    if (dist(ballX, ballY, bomb.x, bomb.y) < ballRadius + bomb.radius) {
      bomb.setVelocity(VELOCITY_AMPLIFICATION * cableLength * angularVelocity, angle + HALF_PI);
    }
  }
  
  void changeDir() {
    angularVelocity *= -1;
  }
}
