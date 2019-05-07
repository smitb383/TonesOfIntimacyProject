import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

/*
Thomas Sanchez Lengeling.
 http://codigogenerativo.com/

 KinectPV2, Kinect for Windows v2 library for processing

 Skeleton depth tracking example
 */

import java.util.ArrayList;
import KinectPV2.KJoint;
import KinectPV2.*;



KinectPV2 kinect;
//3D variables 
float zVal = 300;
float rotX = PI;



Minim minim; 

AudioSample samples[];
AudioInput in;
AudioOutput out; 
AudioRecorder recorder;



void setup() {
  size(512, 424, P3D);
  //size(1024, 768, P3D);
  
  minim = new Minim(this);
  in = minim.getLineIn();
  out = minim.getLineOut( Minim.STEREO);
  kinect = new KinectPV2(this);
  

  samples = new AudioSample[27]; 
    samples[0] = minim.loadSample("0.aif"); 
    samples[1] = minim.loadSample("1.aif"); 
    samples[2] = minim.loadSample("2.aif"); 
    samples[3] = minim.loadSample("3.aif"); 
    samples[4] = minim.loadSample("4.aif"); 
    samples[5] = minim.loadSample("5.aif"); 
    samples[6] = minim.loadSample("17.aif"); 
    samples[7] = minim.loadSample("19.aif"); 
    samples[8] = minim.loadSample("11.aif"); 
    samples[9] = minim.loadSample("9.aif"); 
    samples[10] = minim.loadSample("10.aif"); 
    //samples[11] = minim.loadSample("11.aif"); 
    samples[11] = minim.loadSample("23.aif"); 
    samples[12] = minim.loadSample("12.aif"); 
    //samples[13] = minim.loadSample("13.aif"); 
      samples[13] = minim.loadSample("24.aif"); 
    samples[14] = minim.loadSample("14.aif"); 
    samples[15] = minim.loadSample("15.aif"); 
    samples[16] = minim.loadSample("16.aif"); 
    //samples[17] = minim.loadSample("17-old.aif"); 
     samples[17] = minim.loadSample("11.aif"); 
    samples[18] = minim.loadSample("18.aif"); 
    samples[19] = minim.loadSample("20.aif"); 
    //samples[19] = minim.loadSample("11.aif"); 
    samples[20] = minim.loadSample("19.aif"); 
    samples[21] = minim.loadSample("21.aif"); 
    samples[22] = minim.loadSample("22.aif"); 
    samples[23] = minim.loadSample("23.aif"); 
    samples[24] = minim.loadSample("24.aif");
    samples[25] = minim.loadSample("11.aif");
    samples[26] = minim.loadSample("17.aif");

    out = minim.getLineOut( Minim.STEREO); 
    recorder = minim.createRecorder(in, "recordings/myrecording.wav");

//Enables depth and Body tracking 2D
  kinect.enableDepthMaskImg(true);
  kinect.enableSkeletonDepthMap(true);
  
  kinect.init();
  
  textFont(createFont("Arial", 12));
}

void draw() {
  background(0);
  image(kinect.getDepthMaskImage(), 0, 0);
    //image(kinect.getColorImage(), 0, 0, 320, 240);
    
    if (recorder.isRecording() )
    {
      text("Currently is recording...", 5, 15);
    }
    else
    {
      text("Not recording.", 5, 15);
    }


  //get the skeletons as an Arraylist of KSkeletons
  ArrayList<KSkeleton> skeletonArray =  kinect.getSkeletonDepthMap();
 //ArrayList<KSkeleton> skeletonArray =  kinect.getSkeleton3d();
 if(skeletonArray.size()>= 2){
    println("two skeletons on screen"); 

    KSkeleton skeleton = (KSkeleton) skeletonArray.get(0);
   //if the skeleton is being tracked compute the skeleton joints
    if (skeleton.isTracked()) {
      drawSkeleton(skeleton); 
      KJoint[] joints = skeleton.getJoints();
          
   KSkeleton skeleton2 = (KSkeleton) skeletonArray.get(1); 
    //if the skeleton 2 is being tracked compute the skeleton joints
    if (skeleton2.isTracked()) {
      drawSkeleton(skeleton2); 
      KJoint[] joints2 = skeleton2.getJoints();
    
   //look at all the joints of the first skeleton in realtionship to the second skeleton 
   compareSkeletons(joints, joints2); 
 //popMatrix();     
  fill(255, 0, 0);
  text(frameRate, 50, 50);
}
}
}
  }


 void drawSkeleton(KSkeleton skeleton){
   
     KJoint[] joints = skeleton.getJoints();

      color col  = skeleton.getIndexColor();
      fill(col);
      stroke(col);
      drawBody(joints);
      //drawHandState(joints[KinectPV2.JointType_HandRight]);
      //drawHandState(joints[KinectPV2.JointType_HandLeft]);
   
 }
void compareSkeletons(KJoint[] joints, KJoint[] joints2){
  //Hands and arms 
      checkJointActivation(KinectPV2.JointType_ElbowLeft, joints, joints2);
      checkJointActivation(KinectPV2.JointType_WristLeft, joints, joints2);
      checkJointActivation(KinectPV2.JointType_HandLeft, joints, joints2);
      checkJointActivation(KinectPV2.JointType_HandTipLeft, joints, joints2);
      checkJointActivation(KinectPV2.JointType_ThumbLeft, joints, joints2);
      checkJointActivation(KinectPV2.JointType_ElbowRight, joints, joints2);
      checkJointActivation(KinectPV2.JointType_WristRight, joints, joints2);
      checkJointActivation(KinectPV2.JointType_HandRight, joints, joints2);
      checkJointActivation(KinectPV2.JointType_HandRight, joints, joints2);
      checkJointActivation(KinectPV2.JointType_ThumbRight, joints, joints2);
      
      //Main Body
      checkJointActivation(KinectPV2.JointType_Head, joints, joints2);
      checkJointActivation(KinectPV2.JointType_Neck, joints, joints2);
      checkJointActivation(KinectPV2.JointType_SpineShoulder, joints, joints2);
      checkJointActivation(KinectPV2.JointType_SpineMid, joints, joints2);
      checkJointActivation(KinectPV2.JointType_ShoulderRight, joints, joints2);
      checkJointActivation(KinectPV2.JointType_ShoulderLeft, joints, joints2);
      checkJointActivation(KinectPV2.JointType_SpineBase, joints, joints2);
      checkJointActivation(KinectPV2.JointType_HipLeft, joints, joints2);
      checkJointActivation(KinectPV2.JointType_HipRight, joints, joints2);
      //Legs
      checkJointActivation(KinectPV2.JointType_KneeLeft, joints, joints2);
      checkJointActivation(KinectPV2.JointType_KneeRight, joints, joints2);
      checkJointActivation(KinectPV2.JointType_AnkleRight, joints, joints2);
      checkJointActivation(KinectPV2.JointType_AnkleLeft, joints, joints2);
      checkJointActivation(KinectPV2.JointType_FootRight, joints, joints2);
      checkJointActivation(KinectPV2.JointType_FootLeft, joints, joints2); 
  
}

void checkJointActivation(int jointType, KJoint[] joints, KJoint[] joints2){
//get the position of the joint you are passing in 
  PVector jointPos;
  jointPos = getJointPos(joints, jointType); 
  //println("skeleton1 hand joint at" + jointPos); 
  pushMatrix(); 
  fill(170,66,244); 
  ellipse(jointPos.x, jointPos.y, 18, 18); 
  popMatrix(); 
  
//create an array of the position of all the points of the other skeleton
PVector[] skeleton2JointsPos = getSkeletonJointPosArray(joints2); 

//loop through array of joints in the second skeleton and compare position to the position of the joint you are checking in teh first skeleton
for (int i=0; i< skeleton2JointsPos.length -1 ; i++){
    //println("skeleleton2 joint " + i  + " is at "+ skeleton2JointsPos[i]);
    //println(skeleton2JointsPos.length);
    float distance = jointPos.dist(skeleton2JointsPos[i]); 
    //println("distnace between points is: " + distance); 
    


 if(distance <= 14){
    //println("skeleton 2 point " + i + "is touching skeleton 1 right hand"); 
    pushMatrix(); 
    fill(0,0,0); 
    ellipse(skeleton2JointsPos[i].x, skeleton2JointsPos[i].y, 40, 40); 
 
    popMatrix();
    println("play sound"); 
    //if(i==1){
    //    samples[23].trigger();    
    //}
    //right hand points 
    // else if(i ==11){
    //   println("WRIST RIGHT"); 
    //    samples[14].trigger();
      
    //  }
    //  else if(i ==19){
    //      samples[23].trigger();
    //  }
    //  else  if(i ==17){
     
    //    samples[20].trigger();
   
    //  }
    //  else  if( i ==13){
    //samples[24].trigger(); 
    //  }
 if(i != 18 && i != 20 && i != 12 && i != 14){ 
          
     samples[i].trigger();  
    }
}

}
}

PVector[] getSkeletonJointPosArray(KJoint[] joints2){
  
    PVector[] skeleton2JointsPos = new PVector[27]; 
      //check body 
    skeleton2JointsPos[0] = getJointPos(joints2, KinectPV2.JointType_Head);
    skeleton2JointsPos[1]=getJointPos(joints2, KinectPV2.JointType_Neck);
    skeleton2JointsPos[2]  =getJointPos(joints2, KinectPV2.JointType_SpineShoulder);
    skeleton2JointsPos[3] =getJointPos(joints2, KinectPV2.JointType_SpineMid);
    skeleton2JointsPos[4]= getJointPos(joints2, KinectPV2.JointType_ShoulderLeft);
    skeleton2JointsPos[5]= getJointPos(joints2, KinectPV2.JointType_ShoulderRight);
    skeleton2JointsPos[6]= getJointPos(joints2, KinectPV2.JointType_SpineBase);
    skeleton2JointsPos[7]=getJointPos(joints2,  KinectPV2.JointType_HipRight);
    skeleton2JointsPos[8]=getJointPos(joints2, KinectPV2.JointType_HipLeft);
      // Right Arm
    skeleton2JointsPos[9]=getJointPos(joints2, KinectPV2.JointType_ShoulderRight);
    skeleton2JointsPos[10]=getJointPos(joints2, KinectPV2.JointType_ElbowRight);
    skeleton2JointsPos[11]=getJointPos(joints2, KinectPV2.JointType_WristRight);
     skeleton2JointsPos[12] =getJointPos(joints2, KinectPV2.JointType_HandRight);
    skeleton2JointsPos[13] =getJointPos(joints2, KinectPV2.JointType_HandTipRight); 
     skeleton2JointsPos[14] =getJointPos(joints2, KinectPV2.JointType_ThumbRight);
    
      // Left Arm
     skeleton2JointsPos[15] =getJointPos(joints2, KinectPV2.JointType_ShoulderLeft);
    skeleton2JointsPos[16] =getJointPos(joints2, KinectPV2.JointType_ElbowLeft);
     skeleton2JointsPos[17] =getJointPos(joints2, KinectPV2.JointType_WristLeft);
    skeleton2JointsPos[18]=getJointPos(joints2, KinectPV2.JointType_HandLeft);
    skeleton2JointsPos[19] =getJointPos(joints2, KinectPV2.JointType_HandTipLeft); 
     skeleton2JointsPos[20] =getJointPos(joints2, KinectPV2.JointType_ThumbLeft);
      
      // Right Leg
    skeleton2JointsPos[21] =getJointPos(joints2, KinectPV2.JointType_KneeRight);
    skeleton2JointsPos[22] =getJointPos(joints2, KinectPV2.JointType_AnkleRight);
    skeleton2JointsPos[23]=getJointPos(joints2, KinectPV2.JointType_FootRight);
    
      // Left Leg
    skeleton2JointsPos[24] =getJointPos(joints2, KinectPV2.JointType_KneeLeft);
    skeleton2JointsPos[25] =getJointPos(joints2, KinectPV2.JointType_AnkleLeft);
    skeleton2JointsPos[26]=getJointPos(joints2, KinectPV2.JointType_FootLeft);
    
  return  skeleton2JointsPos; 

}


PVector getJointPos(KJoint[] joints,int jointType){
//return new PVector(joints[jointType].getX(), joints[jointType].getY()); 
return new PVector(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());  
}

//draw the body
void drawBody(KJoint[] joints) {
  drawBone(joints, KinectPV2.JointType_Head, KinectPV2.JointType_Neck);
  drawBone(joints, KinectPV2.JointType_Neck, KinectPV2.JointType_SpineShoulder);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_SpineMid);
  drawBone(joints, KinectPV2.JointType_SpineMid, KinectPV2.JointType_SpineBase);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderRight);
  drawBone(joints, KinectPV2.JointType_SpineShoulder, KinectPV2.JointType_ShoulderLeft);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipRight);
  drawBone(joints, KinectPV2.JointType_SpineBase, KinectPV2.JointType_HipLeft);

  // Right Arm
  drawBone(joints, KinectPV2.JointType_ShoulderRight, KinectPV2.JointType_ElbowRight);
  drawBone(joints, KinectPV2.JointType_ElbowRight, KinectPV2.JointType_WristRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_HandRight);
  drawBone(joints, KinectPV2.JointType_HandRight, KinectPV2.JointType_HandTipRight);
  drawBone(joints, KinectPV2.JointType_WristRight, KinectPV2.JointType_ThumbRight);

  // Left Arm
  drawBone(joints, KinectPV2.JointType_ShoulderLeft, KinectPV2.JointType_ElbowLeft);
  drawBone(joints, KinectPV2.JointType_ElbowLeft, KinectPV2.JointType_WristLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_HandLeft);
  drawBone(joints, KinectPV2.JointType_HandLeft, KinectPV2.JointType_HandTipLeft);
  drawBone(joints, KinectPV2.JointType_WristLeft, KinectPV2.JointType_ThumbLeft);

  // Right Leg
  drawBone(joints, KinectPV2.JointType_HipRight, KinectPV2.JointType_KneeRight);
  drawBone(joints, KinectPV2.JointType_KneeRight, KinectPV2.JointType_AnkleRight);
  drawBone(joints, KinectPV2.JointType_AnkleRight, KinectPV2.JointType_FootRight);

  // Left Leg
  drawBone(joints, KinectPV2.JointType_HipLeft, KinectPV2.JointType_KneeLeft);
  drawBone(joints, KinectPV2.JointType_KneeLeft, KinectPV2.JointType_AnkleLeft);
  drawBone(joints, KinectPV2.JointType_AnkleLeft, KinectPV2.JointType_FootLeft);

  //Single joints
  drawJoint(joints, KinectPV2.JointType_HandTipLeft);
  drawJoint(joints, KinectPV2.JointType_HandTipRight);
  drawJoint(joints, KinectPV2.JointType_FootLeft);
  drawJoint(joints, KinectPV2.JointType_FootRight);

  drawJoint(joints, KinectPV2.JointType_ThumbLeft);
  drawJoint(joints, KinectPV2.JointType_ThumbRight);

  drawJoint(joints, KinectPV2.JointType_Head);
}

//draw a single joint
void drawJoint(KJoint[] joints, int jointType) {
  pushMatrix();
  translate(joints[jointType].getX(), joints[jointType].getY(), joints[jointType].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
}

//draw a bone from two joints
void drawBone(KJoint[] joints, int jointType1, int jointType2) {
  pushMatrix();
  translate(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ());
  ellipse(0, 0, 25, 25);
  popMatrix();
  line(joints[jointType1].getX(), joints[jointType1].getY(), joints[jointType1].getZ(), joints[jointType2].getX(), joints[jointType2].getY(), joints[jointType2].getZ());
}

void stop(){
  out.close(); 
  minim.stop(); 
  super.stop(); 
  
}

void keyReleased()
{
  if( key == 'r')
  {
    if ( recorder.isRecording() )
    {
      recorder.endRecord();
    }
    else
    {
      //Removed the JAVA timestamp and the program works now. The downside is that we have to restart/rename the program
      //everytime
      recorder = minim.createRecorder(in, "recordings/32.wav");
      recorder.beginRecord();
    }
    
  }
  
  if ( key == 's' )
  {
    
   recorder.save();
   println("Done Saving.");
  
  }
}
    
