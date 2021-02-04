class Knight extends GameObject{

 Knight(int _i,int _x, int _y , int _pc){
    i = _i/abs(_i);
    col = _x;
    row = _y;
    x = col * 100;
    y = row * 100;
    pc = _pc;
    board[_y][_x] = i;
    if (i < 0){
     img = loadImage("blackknight.png"); 
    }else img = loadImage("whiteknight.png");   
   
   
 }
 
 void show(){
    if (select == true){
     fill (red);
     rect(x,y,100,100); 
    }
   image(img,x,y,100,100);
       fill(#14FF00);
    textSize(15);
    text(pc,x,y+50);
}

void act(){
    if (i > 0){
    if (select == true){
     if (mousePressed && click == false){
       row = mouseY/100;
       col = mouseX/100;
      board[y/100][x/100] = EMPTY;
      
          if (board[row][col] == filledBlack || board[row][col] == EMPTY){         
          if (abs(row - y/100) == 2 && abs(col - x/100) == 1 ||abs(row - y/100) == 1 && abs(col - x/100) == 2  ){
            y = row * 100;
            x = col * 100;
            board[y/100][x/100] = i;
            myClient.write(row +"," + col + "," + pc);
            select = false;
                turn *= -1;
          }else select = false;
         }else select = false;
         
     
         if (board[row][col] == filledWhite){
          select = false; 
         }       
      click = true;
     } 
    }
   }
  if (i < 0){
   y = row * 100;
   x = col * 100;
  }
    if (!mousePressed){
     click = false; 
    }   
  
}
  
  
}