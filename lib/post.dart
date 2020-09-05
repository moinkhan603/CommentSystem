import 'dart:io';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'CRUD.dart';
class WritePost extends StatefulWidget {
  @override
  _WritePostState createState() => _WritePostState();
}

class _WritePostState extends State<WritePost> {

  bool showSpinner = false;
  File _image;
  String Imgselected="assets/images/add.png";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(backgroundColor: Colors.black,),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child:  Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

            TextField(onChanged: (value){
CRUD.name=value;
            },

             decoration: InputDecoration(

               border: OutlineInputBorder(),
               hintText: "Enter Your Name"
             ),



            ),


              InkWell(
                onTap: ()=>chooseFile(),
                child: 
                    
                Container(child:
                  
                _image!=null?
                Image.file(_image,
                  height: 200,
                  ):
                    Image.asset(
                      Imgselected,
                      height: 200,
                    )

                  ,),
              )

              ,

              FlatButton(child: Text("Post"
              ,style: TextStyle(color: Colors.white),
              ),
              color: Colors.blue,
                onPressed: ()async{
                setState(() {
                  showSpinner=true;
                });
await uploadImagetoStore();

                setState(() {
                  showSpinner=false;
                });

Navigator.pop(context);
                },

              )

            ],),
          ),
        ),
      ),

    );
  }



  void chooseFile() async {
    File selected = await ImagePicker.pickImage(source: ImageSource.gallery);
if(selected!=null)
    this.setState(() {
      _image = selected;
      Imgselected=_image.path;
      print(_image);
    });


  }

  void uploadImagetoStore() async{



    StorageReference storageReference = await FirebaseStorage.instance
        .ref()
        .child('recent/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {

      print(fileURL);
      CRUD.imgurl = fileURL;

      CRUD.addData();

    });


}

}
