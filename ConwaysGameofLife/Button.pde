public class Button {

  public int xPos, yPos;
  public int wwidth, hheight;

  public boolean pressed;

  private String text;

  Button(int xPos, int yPos, int wwidth, int hheight, String text) {
    this.xPos = xPos;
    this.yPos = yPos;
    this.wwidth = wwidth;
    this.hheight = hheight;
    this.text = text;
    pressed = false;
  }

  void draw() {
    if(pressed) fill(255, 20, 20); else fill(200);
    rect(xPos, yPos, wwidth, hheight, 7);

    fill(25);
    textSize(32);
    textAlign(CENTER, CENTER);
    text(text, xPos+(wwidth/2), yPos+(hheight/2.5));
  }
}
