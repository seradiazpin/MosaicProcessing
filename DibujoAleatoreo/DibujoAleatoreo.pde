DibujadorGM dgm = new DibujadorGM();
boolean loadcomplete = false;
int boxsize = 40;
int cols, rows;
PImage[][] colors;
int saved_i = -1;
int saved_j = -1;
int rectX , rectY; 
void setup() {
  size(1400, 1000);
  background(125);
  rectX = width - 350;
  rectY = 50; 
  textSize(20);
    setupGrid(width-400,height);
    drawGrid();
  selectFolder("Select a folder to process:", "folderSelected");

}

void draw() {
   fill(255);
   rect(rectX, rectY, 300, 50);
   fill(0, 102, 153);
   text("Colocar pieza aleatorea",rectX+25, rectY+30);
   if(loadcomplete){
     drawGrid();
   } 
}


PImage dibujarImagenes(){
   int indice = (int)random(dgm.getImages().size());
   return dgm.getImages().get(indice);

}

void folderSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    dgm.listFilesForFolder(selection);
    loadcomplete = true;
    
  }
}


 
void setupGrid(int widthCan, int heightCan) {
  cols = widthCan/boxsize;
  rows = heightCan/boxsize;
  dgm.initEspacios(cols, rows);
  colors = new PImage[cols][rows];
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      colors[i][j] = new PImage();
    }
  }
}

 
void drawGrid() {
  fill(255);
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      
      rect(i*boxsize, j*boxsize, boxsize, boxsize);
      image(colors[i][j],i*boxsize, j*boxsize);
    }
  }
}

 boolean overRect(int x, int y, int width, int height)  {
  if (mouseX >= x && mouseX <= x+width && 
      mouseY >= y && mouseY <= y+height) {
    return true;
  } else {
    return false;
  }
}

void mousePressed() {
   Position ran = dgm.getRandom(); //<>//
   if (overRect(rectX, rectY, 300, 50) && ran.x != -1) {
     colors[ran.x][ran.y] = dibujarImagenes();
  }else{
  for (int i=0; i<cols; i++) {
    for (int j=0; j<rows; j++) {
      int x = i*boxsize;
      int y = j*boxsize;
      if (mouseX > x && mouseX < (x + boxsize) && mouseY > y && mouseY < (y + boxsize)) { //<>//
          dgm.deletePos(i,j);
          colors[i][j] = dibujarImagenes();
          //if (j>0) colors[i][j-1]=dibujarImagenes(); //<>//
          //if (j<rows-1) colors[i][j+1]=dibujarImagenes(); //<>//
          //if (i>0) colors[i-1][j]=dibujarImagenes(); //<>//
          //if (i<cols-1) colors[i+1][j]=dibujarImagenes(); //<>//
          saved_i = i; //<>//
          saved_j = j;
          
        
      }
    }
  }
  }
}