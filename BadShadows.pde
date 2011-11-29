/*User shadows using simple-openni
 *David Gage
 */

class BadShadows{
  SimpleOpenNI context;
  
  boolean userSet = false;
  
  BadShadows(SimpleOpenNI c){
    context = c;
  }
  
  void draw(int chosenUser){
    background(255,255,255);
    
    int[]   depthMap = context.depthMap();
    PVector realWorldPoint;
    
    int steps = 1;
    //int[] myScenemap = new int[context.sceneWidth() * context.sceneHeight()];
    //context.sceneMap(myScenemap);
    int userCount = context.getNumberOfUsers();
    int[] userMap = null;
    if(userCount > 0)
    {
      userMap = context.getUsersPixels(SimpleOpenNI.USERS_ALL);
    }
    int index;
    for(int y=0;y < context.depthHeight();y+=steps)
    {
      for(int x=0;x < context.depthWidth();x+=steps)
      {
        index = x + y * context.depthWidth();
        if(depthMap[index] > 0){
          if(userMap != null && userMap[index] > 0){
            // get the realworld points
            realWorldPoint = context.depthMapRealWorld()[index];
            stroke(100);
            if(userMap[index] == chosenUser){
              PVector pos = new PVector();
              context.getCoM(chosenUser,pos);
              point(pos.x+(pos.x-realWorldPoint.x),realWorldPoint.y,realWorldPoint.z);
          
            } else {
              point(realWorldPoint.x,realWorldPoint.y,realWorldPoint.z);
            }
          }
        }
      }
    }
  }
}
