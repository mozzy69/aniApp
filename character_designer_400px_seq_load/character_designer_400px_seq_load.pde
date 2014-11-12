/*
PIXEL ART CREATOR
 Marion Walton, University of Cape Town
 Creative Code
 http://ikamvacodes.wordpress.com 
 Use a touchscreen to create simple 20*20 pixel art animation sequences
 Suitable for saving a text file of hex values, 
 or for exporting a sequence of raster graphics (png format)
 There is a separate app to convert hex values to vector (pdf) format.
 NB When starting or moving from one set of frames to another
 please check that the value of totalFrames reflects 
 the number of data files present in the folder
 At the moment copying a frame adds the new frame 
 at the end of the sequence.
 Save overwrites the current data in the text file 
 so use with caution
 */

//set up filenames to save frames for animation
String filePrefix = "frame";
int frame=0;
int totalFrames=4;
int exports=0;
int loadFrame=0;
String fileExt=".png";
String fileName=filePrefix+frame+fileExt;
String dataPrefix = "data";
String dataExt=".txt";
String dataName=dataPrefix+frame+dataExt;


//variables for interaction
boolean doOnce=false;

//set up toolbar and controls
String [] tools = {
  "Save Fr", "Clear Fr", "Back", "Next", "Export", "Copy"
};
int toolSelectionNo = 0; // set default button action - save
int toolbarWidth=100;
int toolbarX=95;// starting point for toolbar in x is subtracted from width 
int toolbarY=45;//starting point for toolbar in y axis 
int toolbarS=40;// size - width and height of tools


//set up array of beads
float x;
float y;
int rows = 20;
int columns= 20;
String []columnsStr = new String[columns];
String []rowStr = new String[rows];
color bomvana, mnyama, mhlophe, reflection, green, bomvu, lubhelu, luhlaza, ntsundu, orenji, ngwevu, mfusa, ngqombela, zulu;
color [] colourlist = {
  mnyama = color(0), //black - s
  reflection = color(240), //f
  zulu = color(3, 255, 236), //azure z
  luhlaza = color(4, 2, 124), //blue/green l
  green=color(2, 175, 9), 
  lubhelu = color(213, 229, 0), //yellow -y
  orenji = color(255, 159, 3), //orange o
  bomvu = color(234, 2, 22), //red -r
  bomvana = color(255, 134, 241), //pink - a 
  mfusa = color(185, 0, 147), //purple m
  ngqombela = color(255, 3, 155), //crimson c
  ntsundu = color(142, 84, 21), //brown n
  ngwevu  = color(227), //grey g
  mhlophe = color(255), //white -d
};

int selection=13;
color mycolour = colourlist[selection];
color savedcolour = colourlist[12];//zulu

//set the size for the beads
float beadwidth=25;
float beadheight=24;
float beadcurve=4;
float buttonheight=50;

/* What is this??
int width = int((beadwidth+beadcurve*2)*columns);
int height = int(((beadheight+beadcurve*2)*rows)+buttonheight);
*/

float buttonwidth=width/colourlist.length;  
float buttony =(beadheight+beadcurve*2)*rows+1;

float x0=width/2;
float y0=width/2;
float rcurve=beadcurve/2;

float radius = beadwidth;

float [][] rnd = new float[rows][columns];
color [][] colours = new color[rows][columns];
float rwidth=beadwidth/3;
float rheight=beadheight/3;
//width= int((beadwidth+beadcurve*2)*columns);

void setup()
{
 /* width=toolbarWidth+int((columns+6)*beadwidth+beadcurve*2);
  height=int(((rows+2)*(beadheight+beadcurve*2))+buttonheight);
  size(800, 600);*/
  
  size(displayWidth, displayHeight);
  /*w = width;
  h = height;*/
  
  x=0;  
  y=0;
  for (int i=0; i<rows; i++) {
    for (int j=0; j<columns; j++) {
      float randomno = random(1, 3);
      rnd[i][j]=randomno;
      colours[i][j]=mnyama;
      File f = new File("data0.txt");
      //  if (f.exists()){
      //load existing sketch for first frame
      load(0);
      //    ```}
    }
  }
}

//the draw() function executes repeatedly to create the animation
void draw() 
{
  smooth();
  //draw background
  background(mnyama);
  //use 'for' loop to draw rows down the y axis
  for (int i=0; i<rows; i++) {
    y0=i*(beadheight+beadcurve*2);

    for (int j=0; j<columns; j++) {
      x0=j*(beadwidth+beadcurve*2);
      float myrnd=rnd[i][j];
      color mycolor;
      mycolor =bomvu;
      if (j%2==0) {
        mycolor = mnyama;
      } else {
        mycolor=bomvu;
      }
      if (colours[i][j]!=0) {
        savedcolour= colours[i][j];
      }
      drawBead(x0, y0, beadheight, beadwidth, beadcurve+myrnd, myrnd, savedcolour);
      //drawPacman(x0, y0, savedcolour, female, radius, 1);
    }
  }
  colourpicker();
  //draw toolbar
  toolBar(width-toolbarX, toolbarY, toolbarS);


  //this helps you find the coordinates of the points you click
  if (mousePressed &&doOnce==false) {
    
      setColour();
      if (mouseX>width-toolbarX) {
        switch(toolSelectionNo) {
        case 0:
          save(frame);
          break;

        case 1:
          //println("create a new frame by pressing "+toolSelectionNo);  
          clear(mycolour);
          break;

        case 2:
          //println("go back to the previous frame by pressing "+toolSelectionNo);  
          if (frame>0) {
            frame--;
            load(frame);

            println("load frame"+loadFrame);
          }
          break;

        case 3:
          //println("want to exit by pressing "+toolSelectionNo);  
          if (frame<totalFrames-1) {
            frame++;
            load(frame);
            println("load frame"+frame);
          }

          break;
        case 4:
          //println("export png by pressing "+toolSelectionNo+" tool?");  
          export(0, 10);//shape - 0 for rect, 1 for ellipse, size
          break;

        case 5:
          //println("copy "+toolSelectionNo+" tool?");  
          copy(frame);
          break;
        }
        doOnce=true;
      }
    
  }
}

void mouseReleased() {
  doOnce=false;
}
void export(int shape, int mysize) {
  background(200);
  int size=mysize;
  noStroke();
  for (int i=0; i<columns; i++) {
    for (int j=0; j<rows; j++) {
      int colour = colours[j][i];
      // int col = unhex(colour);
      fill(colour);
      if (colours[j][i]!=bomvu) {
        println(colours[i][j]);
        println(unhex("FFEA0216"));
        int shapei=i+1;
        int shapej=j+1;  

        if (shape==0) {
          rect(shapei*size, shapej*size, size, size);
        } else {
          ellipse(shapei*size, shapej*size, size, size);
        }
      }
    }
  }

  save("framex"+exports+".png");
  exports++;
}


void toolBar(float toolsX, float toolsY, float toolS) {
  //int toolbarHeight=(tools.length+1)*toolS;
  //int toolPos=0;
  stroke(255);
  for (int y=0; y<tools.length; y++) {
    float thisX=toolsX;
    float thisY=(toolsY+(y*toolS))-toolS;
    int fill = 255-(20*y);
    fill(fill);
    rect(thisX, thisY, toolS*2, toolS);
    thisX=toolsX+toolS/3;
    thisY=(toolsY+(y*toolS))-toolS/3;
    fill(0);
    //  println(tools[y]);
    String label=tools[y]+": "+frame;
    text(label, thisX, thisY);
    if (mouseX>toolsX) {
      if (((mouseY>=y*toolS) &&(mouseY<=y*toolS+toolS)))
      {
        toolSelectionNo=y;
        //println("you selected "+toolSelectionNo+" tool.");
      }
    }
  }
}

void clear(color clrColor) {
  for (int i=0; i<columns; i++) {
    for (int j=0; j<rows; j++) {
      colours[i][j]=clrColor;
    }
  }
}

void save(int myframe) {
  fileName=filePrefix+myframe+fileExt;

  save(fileName);
  println("you saved "+fileName);
  for (int j=0; j<columns; j++ ) {
    for (int i=0; i<rows; i++) {
      color c = colours[i][j];
      String colour=hex(c);
      rowStr[i] =colour;
      String joinedColours = join(rowStr, ","); 
      //println(joinedColours);  
      columnsStr[j]=joinedColours;
    }
    dataName=dataPrefix+myframe+dataExt;
    saveStrings(dataName, columnsStr);
  }
  println("frame"+myframe);
  println("you saved "+dataName);
}


void copy(int myframe) {
  myframe=totalFrames;
  fileName=filePrefix+myframe+fileExt;

  save(fileName);
  println("you copied "+fileName);
  for (int j=0; j<columns; j++ ) {
    for (int i=0; i<rows; i++) {
      color c = colours[i][j];
      String colour=hex(c);
      rowStr[i] =colour;
      String joinedColours = join(rowStr, ","); 
      //println(joinedColours);  
      columnsStr[j]=joinedColours;
    }
    dataName=dataPrefix+myframe+dataExt;
    saveStrings(dataName, columnsStr);
  }
  println("frame"+myframe);
  println("you copied "+dataName);
  totalFrames++;
}


void load(int myFrame) {
  // Load text file as an array of Strings

  String[] data = loadStrings(dataPrefix+myFrame+dataExt);
  if (data!=null) {
    if (rows == data.length) { 
      for (int i = 0; i < data.length; i ++ ) {
        // Each line is split into an array of strings.
        String[] rowColours = split(data[i], "," ); 
        String[][] stringColours = new String[rows][columns];
        for (int j=0; j<columns; j++) {
          int myColour=  unhex(rowColours[j]);
          colours[j][i]=myColour;
        }
      }
    }
  }
}



void drawBead(float x, float y, float bheight, float bwidth, float bcurve, float myrandom, color beadColor)
{
  float x1=x0+bwidth-bwidth/2;
  float y1=y0-bheight+bheight/2;
  fill(beadColor);
  noStroke();

  //bcurve=bcurve+rnd;
  strokeJoin(ROUND);
  beginShape();
  vertex(x, y);
  bezierVertex( x, y, x-bcurve, y-bcurve, x, y-bheight);//left
  bezierVertex( x, y-bheight, x+bcurve, y-bheight-bcurve, x+bwidth, y-bheight );//top

  bezierVertex( x+bwidth, y-bheight, x+bwidth+bcurve, y-bheight+bcurve, x+bwidth, y);//right
  bezierVertex( x+bwidth, y, x+bwidth-bcurve, y+bcurve, x, y );//bottom  
  endShape();    
  //draw reflection
  fill(reflection);
  beginShape();
  vertex(x1, y1);
  bezierVertex( x1, y1, x1-rcurve, y1-rcurve, x1, y1-rheight);//left
  bezierVertex( x1, y1-rheight, x1+rcurve, y1-rheight-rcurve, x1+rwidth, y1-rheight );//top

  bezierVertex( x1+rwidth, y1-rheight, x1+rwidth+rcurve, y1-rheight+rcurve, x1+rwidth, y1);//right
  bezierVertex( x1+rwidth, y1, x1+rwidth-rcurve, y1+rcurve, x1, y1 );//bottom  
  endShape();
}


void setColour() {
  // Joining an array of ints requires first
  // converting to an array of Strings
  int[] coords = new int[2]; 
  coords[0] = mouseX; 
  coords[1] = mouseY;  
  float colvalue=coords[0]/(beadwidth+beadcurve*2);
  colvalue= int(colvalue);
  float rowvalue;
  rowvalue=coords[1]/(beadheight+beadcurve*2);
  if (rowvalue<rows&&rowvalue>0&&colvalue<columns&&colvalue>=0) {
    float myrnd=rnd[int(rowvalue)][int(colvalue)];

    rowvalue= int(rowvalue)+1;
    color newcolor=mycolour;
    drawBead(colvalue*(beadwidth+beadcurve*2), rowvalue*(beadheight+beadcurve*2), beadheight, beadwidth, beadcurve+myrnd, myrnd, bomvu);
    setBead(int(rowvalue), int(colvalue), newcolor);
  }

  String coordPair = join(nf(coords, 0), ", "); 
  fill(0);
  text(coordPair, 50, height-50, 200, 100);
  //save("mapcoords.png");
}

void     setBead(int myrow, int mycol, color myclr) {
  if (myrow<rows&&myrow>0&&mycol<columns&&mycol>=0) { 
    colours[myrow][mycol]=myclr;
  }
}

void colourpicker()
{
  for (int i = 0; i<colourlist.length; i++) {
    String colour=  str(colourlist[i]);
    fill(colourlist[i]);

    rect(i*buttonwidth, buttony, buttonwidth, buttonheight);
    // If the 'A' key is pressed change the colour
    if (mouseY>buttony) {
      if (((mouseX>=i*buttonwidth) &&(mouseX<=i*buttonwidth+buttonwidth)))
      {
        mycolour= colourlist[i];
      }
    }
  }
}



