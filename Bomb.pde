final float GRAVITY = 0.05;
final float ELASTICITY = 0.95;
final int TRACE_SIZE = 16;

class Bomb {
  float x, y; // position of the center
  float radius;
  float vx, vy; // velocity
  boolean toxic;
  FloatList traceX, traceY;
  
  Bomb(float x, float y, float radius, float velocity, float angle) {
    this.x = x;
    this.y = y;
    this.radius = radius;
    setVelocity(velocity, angle);
    traceX = new FloatList();
    traceY = new FloatList();
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
    // draw the trace with increasing alpha and decreasing size from aincient to recent
    for (int i = 0; i < traceX.size(); i++) {
      fill(191, map(i, 0, TRACE_SIZE, 0, 255));
      float r = map(i, 0, TRACE_SIZE, 4 * radius, 0);
      ellipse(traceX.get(i), traceY.get(i), r, r);
    }
  }
  
  void move() {
    x += vx;
    y += vy;
    vy += GRAVITY;
    if (y > height - radius) {
      vy *= -ELASTICITY;
      // the bomb starts stinking when it hits the ground
      toxic = true;
    }
    if (toxic) {
      traceX.append(x);
      traceY.append(y);
    }
    if (traceX.size() > TRACE_SIZE) {
      traceX.remove(0);
      traceY.remove(0);
    }
  }
  
  boolean isOutside() {
    boolean out = isOutsideHelper(x, radius);
    // make suer that the trace is also outside
    if (traceX.size() > 0) {
      out = out && isOutsideHelper(traceX.get(0), 4 * radius);
    }
    return out;
  }
}

boolean isOutsideHelper(float x, float tolerance) {
  return x < -tolerance || x > width + tolerance;
}
