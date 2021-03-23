PShader shader;
boolean newlyFocused = false;
PVector center;
PVector min;
float zoom;

void setup() {
  size(1000, 1000, P2D);
  noStroke();

  center = new PVector(0.0, 0.0);
  zoom = 8.0;
  min = new PVector(center.x - zoom/2.0, center.y - zoom/2.0);
  shader = loadShader("shader.frag");
}

void draw() {
  if (focused && newlyFocused) {
    shader = loadShader("shader.frag");
    newlyFocused = false;
  } else if (!focused) {
    newlyFocused = true;
  }
  drawMandelbrot();
  //println(frameRate);
}

void drawMandelbrot() {
  shader.set("iResolution", float(width), float(height));
  shader.set("Maxit", 500);
  shader.set("center", center.x, center.y);
  shader.set("min", min.x, min.y);
  shader.set("zoom", zoom);
  shader(shader);
  rect(0, 0, width, height); //the shader is drawn on here
}

void mousePressed() {
  min = new PVector(center.x - zoom/2.0, center.y - zoom/2.0);
  center = new PVector(min.x + mouseX / width * zoom, min.y + mouseY / height * zoom);
  zoom = 8.0;
  println(center);
  //zoom /= 2;
  //shader = loadShader("shader.frag");
}
