const chokidar = require('chokidar');
const jetpack = require('fs-jetpack');

const admin = require('firebase-admin'); 
const serviceAccount = require("./admin.json")
const storageBucket = "windowstrial2-6e3f2.appspot.com"; 
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount), 
    databaseURL: "https://windowstrial2-6e3f2.firebaseio.com",
    storageBucket: "gs://" + storageBucket
}); 
const log = console.log.bind(console);

const firestore = admin.firestore(); 
const settings = {timestampsInSnapshots:true}; 
firestore.settings(settings); 
const bucket = admin.storage().bucket(storageBucket); 

const db = admin.database(); 
const ref = db.ref("soundFiles");
// console.log(ref); 

/////////////////WATCH AND FETCH FROM PROJECT FOLDER////////////////////////////////
const watchPath = "/Users/Ola/Desktop/LabFinal - Copy/SkeletonMaskDepthAltered/recordings";
//check node is working
log("node is running"); 
const watcher = chokidar.watch(watchPath);
//get new files created in the folder
watcher
    .on('add', path => {
        //add the path to firebase storage
        saveFile(path);      
    })
 
//variable to keep track of data URLS that are stored
  var counter = 0;   
function saveFile(path) {
    let fileInfo = jetpack.inspect(path);
    log("file info " +fileInfo.type);
    // log("path: " +path); 
    bucket.upload(path, {
    metadata: {
        contentType: 'audio/wav',
    }   
    }).then(data =>{
        console.log("upload success"); 
    }).then(data =>{
        //create a refernce to the cloud url storing the sound file 
        var accessName = "https://storage.googleapis.com/" + storageBucket + '/' + fileInfo.name; 
        counter ++; 
        var userRef = ref.child("files"+ counter); 
        userRef.set({
            name: accessName, 
            number: counter, 
        }, function(error){
            if(error){
                console.log("Data could not be saved" + error); 
            }
            else{
                console.log("data saved successfully"); 
            }
        });  
    })
    . catch(err => {
        console.log('error uploading to storage', err); 
    }); 

 
        }
