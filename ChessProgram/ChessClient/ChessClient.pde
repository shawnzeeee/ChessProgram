import processing.net.*;
int[][] board = {
  {-2,-3,-4,-5,-6,-4,-3,-2},
  {-1,-1,-1,-1,-1,-1,-1,-1},
  {0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0},
  {0,0,0,0,0,0,0,0},
  {1,1,1,1,1,1,1,1},
  {2,3,4,5,6,4,3,2}
};
final int EMPTY = 0;
final int filledWhite = 1;
final int filledBlack = -1;
final int WHITE = 2;
final int BLACK = -2;
PImage img;
ArrayList <GameObject> engine;
boolean selected;
boolean click;
Client myClient;
String myMsg, theirMsg;
int coordX, coordY, pieceType;
int turn;
void setup(){
  size (1000,800);
  myClient = new Client(this,"127.0.0.1",1234);
  img = loadImage("board.png");
  engine = new ArrayList<GameObject>();
  int r = 0; int c = 0;
  while (r < 8){
    if (board[r][c] == 1) engine.add(new Pawn(board[r][c],c,r,engine.size()));
    if (board[r][c] == 2) engine.add(new Rook(board[r][c],c,r,engine.size()));
    if (board[r][c] == 3) engine.add(new Knight(board[r][c],c,r,engine.size()));
    if (board[r][c] == 4) engine.add(new Bishop(board[r][c],c,r,engine.size()));
    if (board[r][c] == 5) engine.add(new King(board[r][c],c,r,engine.size()));
    if (board[r][c] == 6) engine.add(new Queen(board[r][c],c,r,engine.size()));
    if (board[r][c] == -1) engine.add(new Pawn(board[r][c],c,r,engine.size()));
    if (board[r][c] == -2) engine.add(new Rook(board[r][c],c,r,engine.size()));
    if (board[r][c] == -3) engine.add(new Knight(board[r][c],c,r,engine.size()));
    if (board[r][c] == -4) engine.add(new Bishop(board[r][c],c,r,engine.size()));
    if (board[r][c] == -5) engine.add(new Queen(board[r][c],c,r,engine.size()));
    if (board[r][c] == -6) engine.add(new King(board[r][c],c,r,engine.size()));
    c += 1;
    if (c > 7){
     r += 1;
     c = 0;
    }
  }
  selected = false;
  click = false;
  turn = 2;
}

void draw(){
  image(img,0,0,800,height);
  fill(#A2A2A2);
  rect(800,0,200,height);
  displayTurn();
  int i = engine.size()-1;
  while (i >= 0){
   GameObject thing = engine.get(i);
   thing.show();
   thing.act();
   if (thing.hasDied() == true){
    engine.remove(i); 
   }

   i -= 1;
  }
 listening();
 movePiece();
}
void displayTurn(){
  fill(0);
  textSize(25);
  text("You are White",825,25);
  text("TURN:",825,height/2-50);
 if (turn == WHITE){
   //fill(255);
   text("YOUR TURN",825,height/2);
 }
 if (turn == BLACK){
   //fill(0);
   text("THEIR TURN",825,height/2);
 }  
}
void listening(){
  if (myClient.available()> 0){
    theirMsg = myClient.readString();
    String[] info = theirMsg.split(",");
    coordY = int(info[0]);
    coordX = int(info[1]);
    pieceType = int(info[2]);
    int i = 0;
    while(i < engine.size()){
     if (engine.get(i).pc == pieceType){
      break; 
     }else i += 1;
    }
    board[engine.get(i).y/100][engine.get(i).x/100] = EMPTY;
    board[coordY][coordX] = filledBlack;
    if (engine.get(i).i < 0){    // if anything happens blame this line of code ;)
    engine.get(i).row = coordY;
    engine.get(i).col = coordX;
    }
    turn *= -1;
  }
  
}
void movePiece(){
if (turn == WHITE){
  if (mousePressed && click == false){
   int i = 0;

   while (i < engine.size()){
     GameObject piece = engine.get(i);
     if ((int)mouseX/100 == piece.x/100 && (int)mouseY/100 == piece.y/100 && piece.i > 0){
      piece.select = true; 
     }
     i += 1;
   }
   click = true;
 } 

} 
  if (!mousePressed){
   click = false; 
  }
}