class Fish {
  //Fish color: 
  int r;
  int g;
  int b;

  //Fish size
  int fish_width;
  int fish_height;
  int fish_size;

  //Fish position
  int x;
  int y; 

  //Fish speed
  float velocity_x;
  float velocity_y;

  //For when fish is eaten --> variable
  boolean eaten = false;

  //Constructor
  Fish(int _r, int _g, int _b, int _fish_size, int _x, int _y, float _velocity_x, float _velocity_y) {
    r = _r;
    g = _g;
    b = _b;
    fish_size = _fish_size;
    fish_width = 2 * _fish_size;
    fish_height = _fish_size;
    x = _x;
    y = _y;
    velocity_x = _velocity_x;
    velocity_y = _velocity_y;
  }

  void drawFish() {
    stroke(r, g, b);
    fill(r, g, b);
    triangle(x, y, x, y+fish_height, x+ (fish_width/3), y+(fish_height/ 2));
    ellipse((x+((10*fish_width/18))), y+(fish_height/2), ((2*fish_width)/3), (15*fish_height/16));
  }
  void moveFish() {
    x+=velocity_x;
    y+=velocity_y;
    this.drawFish();
  }

  boolean checkBoundaries() {
    boolean out_of_bounds = false;
    //Out of screen (horizontal)
    if (x>(width+(1.5* fish_width))|| x < (0 - (1.5*fish_width))) {
      out_of_bounds = true;
    }

    //Out of screen (vertical)
    if (y>(height+(1.5*fish_height)) || y < (0 - (1.5* fish_height))) {
      out_of_bounds = true;
    }
    return out_of_bounds;
  }

  void move_Self() {
    x = mouseX -(fish_width / 2);
    y = mouseY - (fish_height / 2);
    this.drawFish();
  }

  void move_back_Fish() {
    //Will randomize the side from which the fish returns
    //Will maintain the same magnitude of velocity
    /* Must figure out magnitude from original x and y velocities
     Then use magnitude to determine the new velocities 
     Use random to find new angle of reentry (radians)
     magintude SIN (theta) = y
     magnitude COS (theta) = X
     */

    float theta = random(.1*PI, .9*PI);

    float magnitude = 0;
    magnitude = sqrt((float)(Math.pow(velocity_x, 2))+(float)(Math.pow(velocity_y, 2)));
    int side = (int) random(1, 5);
    switch (side) {
      //Top
    case 1: 
      y = 0 - fish_height; 
      x = width/2;
      velocity_y = (magnitude * sin(theta)); 
      velocity_x = (magnitude * cos(theta)); 
      break;

      //Bottom
    case 2:
      y = height + fish_height;
      x = 450;
      velocity_y = -(magnitude * sin(theta)); 
      velocity_x = (magnitude * cos(theta));
      break;

      //Left
    case 3:
      y = 375;
      x = 0 - fish_width;
      velocity_y = (magnitude * sin(theta)); 
      velocity_x = (magnitude * cos(theta));
      break;
      //Right
    case 4:
      y = 375;
      x = width + fish_width;
      velocity_y = (magnitude * sin(theta)); 
      velocity_x = -(magnitude * cos(theta));
      break;
    }
  }

  //Getter Methods for collision detection 
  int get_X_Position() {
    return x;
  }
  int get_Y_Position() {
    return y;
  }
  int get_fish_Height() {
    return fish_height;
  }

  int get_fish_Width() {
    return fish_width;
  }
  //COLLISION
  boolean check_Collision(Fish temporary) {
    boolean signal = false;
    int temp_x = temporary.get_X_Position();
    int temp_y = temporary.get_Y_Position();
    int temp_fish_height = temporary.get_fish_Height();
    int temp_fish_width = temporary.get_fish_Width();

    if (x < (temp_x + temp_fish_width) && (x+fish_width) > (temp_x )) {   
      if (y < (temp_y + temp_fish_height) && (y+fish_height) > (temp_y )) {
        signal = true;
      }
      else {
        signal = false;
      }
    }
    return signal;
  }

//If prey and  self have collided, sets collided prey to eaten
void set_to_Eaten() {
  eaten = true;
}
  //Getter method to check if fish have been eaten
  boolean get_if_Eaten() {
    return eaten;
  }

//Change fish color:
void change_fish_color(int _r, int _g, int _b){
  r = _r;
  g = _g;
  b = _b;
}

void change_fish_size(int _size){
  fish_size = _size;
  fish_width = 2 * _size;
  fish_height = _size;
}

void draw_diver(){
  float temp_x = x;
  float temp_y = y;
  image (diver, temp_x, temp_y, 150, 75);
  x+=velocity_x;
  y+=velocity_y;
}

void changetoMerman(){
  image(sea_win,mouseX,mouseY,250,400);
    x = mouseX -(fish_width / 2);
    y = mouseY - (fish_height / 2);
    
}
  

  //End of Fish Class
}
