//String filename = "dineo.gif";
int offsetX = 0; 
int offsetY= -10;
int size=20;
int columns =20;
int rows=20;
int frame=1;
//int exports=1;
String fileExt=".png";
String filePrefix="data";
String fileName=filePrefix+frame+fileExt;
String dataPrefix = "data";
String dataExt=".txt";
String dataName=dataPrefix+frame+dataExt;

String []columnsStr = new String[columns];
String []rowStr = new String[rows];

color [][] colours = new color[rows][columns];


void setup(){
size(columns*size,rows*size);
background(50);
smooth();
}
void draw(){
noStroke();
/*
for(int i=0;i<columns;i++){
    for(int j=0; j<rows;j++){
    int col = colours[i][j];
   // int col = unhex(colour);
    fill(col);
      if (colours[i][j]!="FF000000") {
      int shapei=i+1;
    int shapej=j+1;  
  ellipse(offsetX+shapei*size, offsetY+shapej*size, size, size);
 
   }
   
    }
    
  }
  */
  
  for(int i = 0; i<14; i++){
load(i);

//    save(i);
export(1,size,i);
  
  }
exit();

}

void load(int myFrame){
 // Load text file as an array of Strings
  
  String[] data = loadStrings(dataPrefix+myFrame+dataExt);
  if (data!=null){
  if(rows == data.length){ 
  for (int i = 0; i < data.length; i ++ ) {
      // Each line is split into an array of strings.
      String[] rowColours = split(data[i], "," ); 
      String[][] stringColours = new String[rows][columns];
        for(int j=0; j<columns;j++){
          int myColour=  unhex(rowColours[j]);
          colours[j][i]=myColour;
        } 
    }
  }
  }
}




void export(int shape, int mysize, int exports){
  background(200);
  int size=mysize;
  noStroke();
for(int i=0;i<columns;i++){
    for(int j=0; j<rows;j++){
    int col = colours[j][i];
    //int col = unhex(colour);
    fill(col);
//     if (colours[j][i]!=bomvu) {
      int shapei=i+1;
    int shapej=j+1;  
  
if (shape==0){
  rect(shapei*size, shapej*size, size, size);
     }
     else{
  ellipse(shapei*size, shapej*size, size, size);   
     }
    //}
    }
  }

save("framex"+exports+".png");

}


void save(int myframe){
 fileName=filePrefix+myframe+fileExt;
 
  save(fileName);
   println("you saved "+fileName);
     for(int j=0; j<columns;j++ ){
       for(int i=0; i<rows;i++){
           int c = colours[i][j];
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


