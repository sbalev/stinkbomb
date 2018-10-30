final float GRAVITY = 0.05;
final float ELASTICITY = 0.95;

class Bomb {
  float x, y; // position of the center
  float radius;
  float vx, vy; // velocity
  
  Bomb(float x, float y, float radius, float velocity, float angle) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    setVelocity(velocity, angle);
  }
  
  Bomb() {
    this(random(10, width - 10), 0, 10, 0, 0);
  }
  
  void setVelocity(float velocity, float angle) {
    vx = velocity * cos(angle);
    vy = velocity * sin(angle);
  }
  
  void display() {
    noStroke();
    fill(255, 0, 0);
    ellipseMode(RADIUS);
    ellipse(x, y, radius, radius);
  }
  
  void move() {
    x += vx;
    y += vy;
    vy += GRAVITY;
    if (y > height - radius) {
      vy *= -ELASTICITY;
    }
  }
}
