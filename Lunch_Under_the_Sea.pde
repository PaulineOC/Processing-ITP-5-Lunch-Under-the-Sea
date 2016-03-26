//Fish Objects: 
Fish self;
Fish[] prey_array = new Fish[10];
Fish[] predator_array = new Fish[7];

int number_of_predator; //Uses to manipulate predator array length for each level
int number_of_prey_eaten; //Uses to manipulate prey array lengths for interactions
int temp_num_prey_eaten; //Changes inside the prey collision for loop and will be set to the prey_eaten after the for loop (without dynamically changing the for loop)
int[] temporary_array_shift = new int[10]; //stores the indexes of all the prey objects that have been eaten

int actual_prey_eaten_per_level; 
/*Will be set to the difference between temporary prey eaten and regular prey eaten and will be used to set the for loop parameters
 Will be use "see" how many fish were consumed per draw loop (not per level)
 */

int index_of_new_array; // 

//Setting level booleans: used to "start" the each level once without it looping and constantly restarting
boolean level_1, level_2, level_3, level_4, level_5;

//Counter that sets parameters of each level:
int total_eat_count;

//Used to control lose screen:
boolean lose;

//Used for controlling special self and prey object (surprise!)
boolean self_surprise; boolean prey_surprise;


PImage sea_win;
PImage diver;
PImage bone;
 PFont font;

void setup() {
  size(900, 700);
  //Set all the booleans true to start each level. They will be used once to intialize the start of each level ONCE 
  level_1=true;
  level_2=true;
  level_3=true;
  level_4=true;
  level_5=true;

  total_eat_count = 0;
  
  number_of_predator = 0;
  initializePrey(247, 77, 214, 25);
  initializePredator(60, 245, 60, 75);
  index_of_new_array=0;
  number_of_prey_eaten = 0;
  temp_num_prey_eaten = 0;
  self = new Fish(0, 0, 0, 40, 1, 1, 0, 0);
  
  lose = false;
  diver = loadImage("Diver.png");
  sea_win = loadImage("Merman.png");
  bone = loadImage("bone.jpg");
   //Set up font:
  font = loadFont("ACaslonPro-Semibold-48.vlw");
  self_surprise = false;
  
}

void draw() {

  if (lose==false){
  background(00, 00, 200);
  //moving self
  
  if (self_surprise == false){
  self.move_Self();
  }
  else if(self_surprise){
      self.changetoMerman();
  }
  //PREDATOR: 
  for (int i=0;i<predator_array.length - number_of_predator;i++) {
    predator_array[i].moveFish();
    if (predator_array[i].checkBoundaries()) {
      predator_array[i].move_back_Fish();
    }
    if (predator_array[i].check_Collision(self)){
      lose = true;
    }
  }

  //PREY:
  index_of_new_array =0;
  //Moving Fish:
  for (int i=0;i<prey_array.length- number_of_prey_eaten;i++) { 
    
    //Use boolean for surprise!
    if (prey_surprise == false){
    
    //Moving fish (and accomodating when it goes out of bounds) 
    prey_array[i].moveFish();
  }
  else if(prey_surprise)
  {
        prey_array[0].draw_diver();
  }
    if (prey_array[i].checkBoundaries()) {
      prey_array[i].move_back_Fish();
    }
    if (prey_array[i].check_Collision(self)) {
      total_eat_count++;
      temp_num_prey_eaten++;
      temporary_array_shift[index_of_new_array]=i;
      index_of_new_array++;
    }
  }
  actual_prey_eaten_per_level = temp_num_prey_eaten - number_of_prey_eaten;
  number_of_prey_eaten = temp_num_prey_eaten;
  for (int i=0;i<actual_prey_eaten_per_level;i++) {
    shifting_index(temporary_array_shift[i]); //For EACH fish that is eaten (for loop), the index of the prey_array will be shifted over
  }

  nextLevel();
  
  
 }
 
 else if(lose == true){
   background (255,0,0);
   image(bone, 300, 400, 200, 150);
   textFont(font, 48); 
    fill(0,0,0);       
    text ( "You've been eaten!" ,200,300); 
 }
   
   
}
//END OF DRAW

//Other Methods: 

//Initializing Prey/Predator:
void initializePrey(int red, int green, int blue, int size) {
  Fish[] temp = new Fish[10];
  for (int i=0;i<prey_array.length;i++) {
    temp[i] = new Fish(red, green, blue, size, (int)random(0, width), (int)random(0, height), random(-3, 3), random(-3, 3));
  }
  for (int i=0;i<prey_array.length;i++) {
    prey_array[i] = temp[i];
  }
}

void initializePredator(int red, int green, int blue, int size) {
  for (int i=0;i<predator_array.length;i++) {
    predator_array[i] = new Fish(red, green, blue, size, (int)random(0, width), (int)random(0, height), random(-3, 3), random(-3, 3));
  }
}

//"Shifting" remaining uneaten fish over one index to the left
void shifting_index(int index) {
  for (int j = index; j<prey_array.length-1;j++) {
    prey_array[index] = prey_array[index+1];
  }
}
//Next Level functions: 
void nextLevel() {
  int level = 0;
  //Convert number of prey eaten to level amounts: 
  if (total_eat_count <= 9) {
    level = 1;
    if (level_1) {
      initializePrey(247, 77, 214, 25);
      initializePredator(60, 245, 60, 75 );
      self.change_fish_color(255, 255, 255);
      self.change_fish_size(50);
      number_of_prey_eaten=0;
      number_of_predator = 0;
      temp_num_prey_eaten =0;
      level_1=false;
    }
  }
  if (total_eat_count <= 18 && total_eat_count > 9) {
    level = 2;
    if (level_2) {
      initializePrey(255, 255, 255, 50);
      initializePredator(153, 76, 0, 100);
      number_of_prey_eaten=1;
      temp_num_prey_eaten=1;
      number_of_predator = 3;
      self.change_fish_color(60, 245, 60);
      self.change_fish_size(75);
      level_2=false;
    }

  }
  if (total_eat_count <= 23 && total_eat_count > 18 ) {
    level = 3;
    if (level_3) {
      initializePrey(60, 245, 60, 75);    
      initializePredator(135, 31, 166, 175);
      self.change_fish_color(153, 76, 0);
      self.change_fish_size(100);
       number_of_predator = 4;
      number_of_prey_eaten=5;
      temp_num_prey_eaten=5;
      level_3=false;
    }

  }
  if (total_eat_count == 24) {
    level = 4;
    if (level_4) {
      initializePrey(255, 255, 255, 75);
      prey_array[0].draw_diver();
      initializePredator(0, 0, 0, 250);
      self.change_fish_color(132, 224, 247);
      self.change_fish_size(175);
      number_of_prey_eaten=9;
      temp_num_prey_eaten=9;
      number_of_predator = 6;
      prey_surprise = true;
      level_4=false;
    }
    total_eat_count=24;
  }
  if (total_eat_count == 25) {
    level = 5;
    if (level_5) {
      number_of_prey_eaten=10;
      temp_num_prey_eaten=10;
      number_of_predator = 7;
      level_5=false;
    }
    self_surprise = true;
    textFont(font, 36); 
    fill(255,255,255);       
    text ( "You're the king of the sea!" ,250,300); 
  }
  
}//End of next_level function  INSERT PIC OF HUMAN SWIMMING  case 4: initializePrey

//Level reset function: 
void level_reset(){
  //Set all level booleans back so that levels can re-initialize again & reset level_progression variable back to 0
  level_1=true;
  level_2=true;
  level_3=true;
  level_4=true;
  level_5=true;
  total_eat_count = 0;
  self_surprise= false;
  prey_surprise = false;
}

void keyPressed(){
  lose = false;
  //level_reset();
}

