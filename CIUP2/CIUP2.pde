PShape s;
float mousex1;
float mousey1;
float mousex2;
float mousey2;
boolean vertexIncomplete = false;
float startX;
float startY;
PShape rot;
int rotations = -1;
float qx;
float qy;
float qz;
float qxC;
PShape q;

void setup(){
size(640, 700, P3D);
background(200);
s = createShape();
s.beginShape();
s.noFill();
line(320, 0, 320, 700);
textSize(20);
text("Click Mouse to Set Points", 20, 30); 
text("Press R to Rotate", 20, 55); 
text("Press X to Reset", 20, 80); 
}

void draw(){
  //Start new Model if n is pressed
  if(keyPressed)
  {
    if(key == 'x' || key == 'X'){
      background(200);
      stroke(0);
      line(320, 0, 320, 700);
      vertexIncomplete = false;
      s = createShape();
      s.beginShape();
      s.noFill();
      rotations = -1;
      text("Click Mouse to Set Points", 20, 30); 
      text("Press R to Rotate", 20, 55); 
      text("Press X to Reset", 20, 80); 
    }
  }
  //Start rotating sketch if r is pressed
  if(keyPressed)
  {
    if(key == 'r' || key == 'R')
    {
      //Make rotation axe lighter
      if(rotations == -1) 
      {
        stroke(200);
        line(320, 0, 320, 700);
        stroke(0);
      }
      //finish collecting points from user
      s.endShape();
      translate(320, 0, 0);
      //Create final model
      rot = createShape(GROUP);
      //Add shape s for verticals
      rot.addChild(s);
      s.rotateY(radians(10));
      rotations +=1;
      //Create q shape for horizontals
      q=createShape();
      q.beginShape();
      q.noFill();
      
      //Compute horizontal lines
      for (int i = 0; i < s.getVertexCount(); i++) 
      {
        PVector v = s.getVertex(i);
        if(rotations <36)
        { //<>//
          qx = v.x;
          qy = v.y;
          qz=  v.z;

          int a = 10*rotations;
          int a2 =10*(rotations+1);
    
          q.vertex( qx*cos(radians(a))+qz*sin(radians(a)), v.y, -qx*sin(radians(a))+qz*cos(radians(a)));
          q.vertex( qx*cos(radians(a2))+qz*sin(radians(a2)), v.y, -qx*sin(radians(a2))+qz*cos(radians(a2)));
          qxC = qx;
          qx =  qx*cos(radians(a2))+qz*sin(radians(a2));
          qz = -qx*sin(radians(a2))+qz*cos(radians(a2));
        }
      }
      //End q shape //<>//
      q.endShape();
      rot.addChild(q);
      //Display rotation shape (Our resulting shape)
      shape(rot);
    }
  }

}

//Get the users points and create shape s
void mouseReleased(){
  if(vertexIncomplete){
    //further vertexes
    line(mousex1, mousey1, mouseX, mouseY);
    mousex1 = mouseX;
    mousey1 = mouseY;
    s.vertex(mouseX -320 , mouseY);
  }
  else{
    //First vertex
    s.beginShape();
    translate(320, 0, 0);
    s.noFill();
    s.vertex(mouseX -320 , mouseY);
    mousex1 = mouseX;
    mousey1 = mouseY;
    startX = mouseX;
    startY = mouseY;
    vertexIncomplete = true;
  }
}
