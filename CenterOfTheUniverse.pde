/*User shadows using simple-openni
 *David Gage
 */

class CenterOfTheUniverse{
  SimpleOpenNI context;

  color[]      userColors = { color(255,0,0), color(0,255,0), color(0,0,255), color(255,255,0), color(255,0,255), color(0,255,255) };
  color[]      userCoMColors = { color(255,100,100), color(100,255,100), color(100,100,255), color(255,255,100), color(255,100,255), color(100,255,255) };

  CenterOfTheUniverse(SimpleOpenNI c){
    context = c;
  }
  
  void draw(int chosenUser){

    background(255,255,255);
  
  
    int[]   depthMap = context.depthMap();
    int     steps   = 1;  // to speed up the drawing, draw every third point
    int     index;
    PVector realWorldPoint;
  
    int userCount = context.getNumberOfUsers();
    int[] userMap = null;
    if(userCount > 0){
      userMap = context.getUsersPixels(SimpleOpenNI.USERS_ALL);
    }
  
    for(int y=0;y < context.depthHeight();y+=steps){
      for(int x=0;x < context.depthWidth();x+=steps){
        index = x + y * context.depthWidth();
        if(depthMap[index] > 0){ 
          // get the realworld points
          // check if there is a user
          if(userMap != null && userMap[index] > 0){  // calc the user color
            //int colorIndex = userMap[index] % userColors.length;
            //stroke(userColors[colorIndex]); 
            realWorldPoint = context.depthMapRealWorld()[index];
            stroke(100);
            if(userMap[index] == chosenUser){
              PVector pos = new PVector();
              context.getCoM(chosenUser,pos);
              point(realWorldPoint.x-pos.x,realWorldPoint.y,realWorldPoint.z);
          
            } else {
              point(realWorldPoint.x,realWorldPoint.y,realWorldPoint.z);
            }
          
          }
        }
      } 
    } 
  }
}
