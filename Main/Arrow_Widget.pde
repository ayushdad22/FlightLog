
 
class ArrowWidget extends Widget 
{
int arrowWidth = 215;
int arrowHeight = 400;
int marginRight = 20;
int windowWidth = 1024;
int windowHeight = 780;
 
String direction;
 
 
  ArrowWidget(int x, int y, int width, int height, String label, color widgetColor, PFont widgetFont, int event, String direction) 
  {
    super(x, y, width, height, label, widgetColor, widgetFont, event);
    this.direction = direction;
 
  }
  public int getShaftStartX() 
  {
    if(direction.equals("left"))
    {
      return 200;
    }
    else
    {
 
       return 800; 
    }
    }
 
 
    public int getShaftEndX() 
    {
        if(direction.equals("left"))
    {
      return 150;
    }
    else
    {
 
       return 850; 
    }
    }
 
    public int getShaftY() 
    {
        if(direction.equals("left"))
    {
      return 400;
    }
    else
    {
 
       return 400; 
    }
    }
 
 
    public int getHeadBaseStartX() 
    {
        if(direction.equals("left"))
    {
      return 150;
    }
    else
    {
 
       return 850; 
    }
    }
 
 
 
 
 
 
    public int getHeadBaseEndX() 
    {
        if(direction.equals("left"))
    {
      return 135;
    }
    else
    {
 
       return 870; 
    }
    }
 
 
 
 
 
 
void draw() {
    strokeWeight(5);
    stroke(widgetColor);
    fill(widgetColor);
    
    int shaftStartX = direction.equals("left") ? 200 : 800;
    int shaftEndX = direction.equals("left") ? 150 : 850;
    int shaftY = 400; 


    line(shaftStartX, shaftY, shaftEndX, shaftY);

   

  
    int headBaseStartX = direction.equals("left") ? 150 : 850;
    int headBaseEndX = direction.equals("left") ? 135 : 870;
    int headY = 400; 
    
   
    triangle(headBaseStartX, shaftY - 5, headBaseEndX, headY, headBaseStartX, shaftY + 5);
}
}
