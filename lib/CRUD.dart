


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class CRUD{

static String id;
  static String imgurl="";
  static String name="Anonymous";

  static final databaseReference = FirebaseDatabase.instance.reference();

  static WritePost() async
  {

    await databaseReference.child("post").push().set({
      'Name': CRUD.name,
      'img_url': CRUD.imgurl,



    });


print("data added");
  }


static Future<void> addData() async {


  Firestore.instance.collection("posts")
      .add({
    'img':imgurl,
    'name':name
  }).catchError((e) {
    print(e);
  });

}





}