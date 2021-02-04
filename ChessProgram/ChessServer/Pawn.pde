class Pawn extends GameObject{

  Pawn(int _i, int _x, int _y, int _pc){
    i = _i/abs(_i);
    col = _x;
    row = _y;
    x = col * 100;
    y = row * 100;
    pc = _pc;
    board[_y][_x] = i;
    if (i < 0){
     img = loadImage("blackpawn.png"); 
    }else img = loadImage("whitepawn.png");   
    select = false;
    pieceX = 0;
    pieceY = 0;

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
        if (board[row][col] == EMPTY){
         if (y/100 == 1){
          if (row == y/100 +1 && col == x/100 ||row == y/100 +2 && col == x/100){
             y = row * 100; 
             x = col * 100;
             board[y/100][x/100] = i;  
            myServer.write(row +"," + col + "," + pc);
             select = false;
                 turn *= -1;
          }select = false;
         }else{
          if (row == y/100 +1 && col == x/100){
             y = row * 100; 
             x = col * 100;
             board[y/100][x/100] = i;
            myServer.write(row +"," + col + "," + pc);
             select = false;  
                 turn *= -1;
          }else select = false;
         }
        }
        if (board[row][col] == filledWhite){     
          if (row == (y/100) + 1){
            if (col == x/100 + 1 || col == x/100 -1){
             y = row * 100; 
             x = col * 100;
             board[y/100][x/100] = i;
            myServer.write(row +"," + col + "," + pc);
             select = false;
                 turn *= -1;
            }
          }
         }
         if (board[row][col] == filledBlack){
          select = false; 
         }
     
       
      click = true;
     } 
    }
    if (y/100 == 0){
    int i = 0;
     while(i < engine.size()){
      if (engine.get(i).pc == pc){
       break; 
      }else i += 1;
     }
    engine.add(new Queen(-1,x/100,y/100,engine.size()));
    engine.remove(i);
    }
   }
  if (i > 0){
   y = row * 100;
   x = col * 100;
    if (y/100 == 0){
    int i = 0;
     while(i < engine.size()){
      if (engine.get(i).pc == pc){
       break; 
      }else i += 1;
     }
    engine.add(new Queen(1,x/100,y/100,pc));
    engine.remove(i);
    }
  }
    if (!mousePressed){
     click = false; 
    }
    
  }

  
}