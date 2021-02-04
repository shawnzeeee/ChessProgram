class Queen extends GameObject{

 Queen(int _i,int _x, int _y , int _pc){
    i = _i/abs(_i);
    col = _x;
    row = _y;
    x = col * 100;
    y = row * 100;
    pc = _pc;
    board[_y][_x] = i;
    if (i < 0){
     img = loadImage("blackqueen.png"); 
    }else img = loadImage("whitequeen.png");   
   
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
          if (row == y/100 || col == x/100){
            y = row * 100;
            x = col * 100;
            board[y/100][x/100] = i;
            myClient.write(row +"," + col + "," + pc);
            select = false;
                turn *= -1;
          }else {
           select = false;
           if (abs((row - y/100) / (col - x/100)) == 1){
            y = row * 100;
            x = col * 100;
            board[y/100][x/100] = i;
            myClient.write(row +"," + col + "," + pc);
                turn *= -1;
           }
          }
         }
         
     
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