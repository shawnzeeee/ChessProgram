class King extends GameObject{

  King(int _i, int _x, int _y, int _pc){
    i = _i/abs(_i);
    col = _x;
    row = _y;
    x = col * 100;
    y = row * 100;
    pc = _pc;
    board[_y][_x] = i;
    if (i < 0){
     img = loadImage("blackking.png"); 
    }else img = loadImage("whiteking.png");    
    
    
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
   if (i < 0){
    if (select == true){
     if (mousePressed && click == false){
       row = mouseY/100;
       col = mouseX/100;
      board[y/100][x/100] = EMPTY;
      
          if (board[row][col] == filledWhite || board[row][col] == EMPTY){         
          if (abs(row - y/100) <= 1 && abs(col - x/100) <= 1){
            y = row * 100;
            x = col * 100;
            board[y/100][x/100] = i;
            myServer.write(row +"," + col + "," + pc);
            select = false;
                turn *= -1;
          }else select = false;
         }else select = false;
         
     
         if (board[row][col] == filledBlack){
          if (y/100 == 0){
            int i = 0;
            while (i < engine.size()-1){          //castling
             GameObject piece = engine.get(i);
             if (piece instanceof Rook){
               if (piece.y/100 == 0 && piece.x/100 == col && piece.y/100 == row){
                 if (x/100 <  col){
                  if (board[y/100][x/100 + 1] == EMPTY && board[y/100][x/100 + 2] == EMPTY){
                     piece.x = (x/100 +1) * 100;
                     x = (x/100 + 2) * 100;
                     myServer.write(0 +"," + (x/100 +2) + "," + pc);
                     myServer.write(0 +"," + (x/100 + 1) + "," + piece.pc);
                     select = false;
                  }
                 }
                 if (x/100 > col){
                  if (board[y/100][x/100 - 1] == EMPTY && board[y/100][x/100 - 2] == EMPTY){
                     piece.x = (x/100 -1) * 100;
                     x = (x/100 - 2) * 100;
                     myServer.write(0 +"," + (x/100 +2) + "," + pc);
                     myServer.write(0 +"," + (x/100 + 1) + "," + piece.pc);
                     select = false;
                  }
                 }
               }
             }
             i += 1;
            }
         }
          select = false; 
         }       
      click = true;
     } 
    }
   }
  if (i > 0){
   y = row * 100;
   x = col * 100;
  }
    if (!mousePressed){
     click = false; 
    }      
    
  }
  
}