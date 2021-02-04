abstract class GameObject{
  int i;
  int x,y;
  boolean select;
  PImage img;
  int row, col;
//  boolean click;
  int pieceX, pieceY;
  color red;
  int pc;
 GameObject(){
   red = #FA1219;
   
 }
  
 void show(){
   
   
 }
 
 void act(){
   
   
   
 }
 
 boolean hasDied(){
    if (i > 0){
     if (board[y/100][x/100] == filledBlack){
      return true; 
     }else return false;
    }else {
     if (board[y/100][x/100] == filledWhite){
      return true; 
     }else return false;
    } }
  
}