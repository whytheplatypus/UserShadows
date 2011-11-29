/*User shadows using simple-openni
 *David Gage
 */
import SimpleOpenNI.*;


SimpleOpenNI context;
PVector pos = new PVector();
boolean userSet = false;

BadShadows badShadows;
CenterOfTheUniverse centerOfTheUniverse;
int chosenUser = 0;

int selectedView = 0;

IntVector aUsers;

void setup()
{
  size(1024,768,P3D);
  context = new SimpleOpenNI(this);
  // enable mirror
  context.setMirror(true);
  
  
  context.enableDepth();
  //we only really care where the users pixels are, so use scene
  //context.enableScene();
  // enable rgbImage generation
  //context.enableRGB();
  
  // enable skeleton generation for NO joints
  context.enableUser(SimpleOpenNI.SKEL_PROFILE_NONE);
  // enable the scene, to get the floor
  //context.enableScene();

  stroke(255,255,255);
  smooth();  
  perspective(95,
              float(width)/float(height), 
              10,150000);

  aUsers = new IntVector(); 

  badShadows = new BadShadows(context);
  centerOfTheUniverse = new CenterOfTheUniverse(context);
  
}

void draw()
{
  //background(255,255,255);
  // update the cam
  context.update();
  
   // set the scene pos
  translate(width/2, height/2, 0);
  rotateX(radians(180));
  rotateY(radians(0));
  scale(0.5);
  translate(0,0,-1000);
  
  switch(selectedView){
    case 0:
      badShadows.draw(chosenUser);
      break;
    case 1:
      centerOfTheUniverse.draw(chosenUser);
      break;
  }
  
}

void chooseUser(){
  int userCount = context.getNumberOfUsers();
  if(userCount > 0){
    context.getUsers(aUsers);
    chosenUser = aUsers.get(int(random(userCount)));
  } else {
    chosenUser = 0;
  }
  println("choosing user: " + chosenUser);
}

// -----------------------------------------------------------------
// SimpleOpenNI user events

void onNewUser(int userId)
{
  if(chosenUser == 0){
    chooseUser();
  }
  println("onNewUser - userId: " + userId); 
}

void onLostUser(int userId)
{
  if(userId == chosenUser){
    chooseUser();
  }
  println("onLostUser - userId: " + userId);
}


// -----------------------------------------------------------------
// Keyboard events

void keyPressed()
{
  //switch between views
  if(key == 'n'){
    chooseUser();
  } else {
    selectedView = (selectedView+1)%2;
    println("switching to view "+selectedView);
  }
}
