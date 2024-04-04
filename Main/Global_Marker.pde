import de.fhpotsdam.unfolding.marker.AbstractMarker;
import processing.core.PConstants;
import processing.core.PGraphics;
import processing.core.PImage;

public class ImageMarker extends AbstractMarker {

  PImage img;
  String text;
  int textColor; 
  float latitude;
  float longitude;

  public ImageMarker(Location location, PImage img, String text) {
    super();
    this.location = location;
    this.img = img;
    this.text = text;
  }

  public void draw(PGraphics pg, float x, float y) {
    pg.pushStyle();
    pg.imageMode(PConstants.CORNER);
    pg.image(img, x - 11, y - 37);
    pg.fill(0);
    pg.textSize(20);
    pg.textAlign(PConstants.CENTER, PConstants.BOTTOM);
    pg.text(text, x, y - 40);
    pg.popStyle();
  }

  protected boolean isInside(float checkX, float checkY, float x, float y) {
    return checkX > x && checkX < x + img.width && checkY > y && checkY < y + img.height;
  }
}
