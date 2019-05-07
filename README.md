# TonesOfIntimacyProject
Tones of Intimacy Project Code and Web Development: 

This is part of a larger project created with: 
Andy Sun: Creative Director/ Project Manager 
Lizette Ayla and Josefina Biscailuz Santamaria
Herbert Ramirez: Support 

I developed the code  and interaction design for this project on top of the Microsoft Kinect SDK and Thomas Lengeling’s library for skeleton tracking. 

The first part of this project (Skeleton Depth Mask Altered Folder) is a program that used  the Xbox Kinect and skeleton tracking,  to map the overlapping of joints of two bodies to musical notes. For example, if participants hands are within a certain proximity of one another, a  sound will play, or if their shoulder joints are touching a different sound will play. If participants pull away from each other a sound will stop playing. This allows participants to create their own soundscapes over time through their chosen interactions via proximity and touch. 

In addition, this project records the sound files of each interaction to a folder in the processing folder (called recordings). I then build a node application that watched this local folder for new files that were added to the folder using the chokadir and jetpack node modules. I pushed these audio recordings to firebase using the firebase admin node module and google cloud modules for node app development. I then stored the reference URL for these Audio recordings to a database in firebase associated with the project. (this part of the project is in the folder called Brooke App)

Afterwards I created a page using the firebase web development tool kit on our projects website (designed by Josefina Biscailuz Santamaria) that dowloaded each of these audio recordings from the installation as they were recorded directly to the website with the number of each recording. We handed out cards to participants of the instillation so that they could go to the website and listen to and download their audio recording as soon as they were done participating in the installation. 

The project here includes: 
- The processing code and audio inputs and outputs from the installation 
- The node application that created the backend pipeline from the installation project to the cloud 
- The front end web development that pulled these audio files form the cloud into the website

This program will not properly function on other devices because it looks fro a specific path on the local computer I was using to develop this project, however the front end web development page can be run by anyone. 

The node models required to create such a node application are: 

- chokadir 
- Jetpack
- Firebase admin 
- Firebase 

Visit the Life website at: http://tonesofintimacy.glitch.me
