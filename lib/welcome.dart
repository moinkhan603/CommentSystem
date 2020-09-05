import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comnt_app/CRUD.dart';
import 'package:comnt_app/Comments.dart';
import 'package:comnt_app/post.dart';
import 'package:flutter/material.dart';
class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {

  StreamSubscription<QuerySnapshot>subscription;

  List<DocumentSnapshot>posts;
  final CollectionReference collectionReference=
  Firestore.instance.collection("posts");



@override
  void initState() {
  // TODO: implement initState
  super.initState();

  subscription = collectionReference.snapshots()
      .listen((datasnapshot) {
    setState(() {
      posts = datasnapshot.documents;
    });
  });
}


@override
  void dispose() {
    // TODO: implement dispose
  subscription?.cancel();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(title: Text("All Posts"),backgroundColor: Colors.black,
centerTitle: true,

),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white70, Colors.black],
          ),
        ),
        child: Stack(

          alignment: Alignment.bottomRight,
          children: <Widget>[
            posts!=null?
            ListView.builder(
              physics: BouncingScrollPhysics(),

          itemCount: posts.length,
itemBuilder: (BuildContext ctxt, int index) {


        String imgPath=posts[index].data['img'];
        String name=posts[index].data['name'];
        String id=  posts[index].documentID.toString();
print(name);
print(imgPath);

return mypost(name,imgPath,id);

},

//                mypost(),
//                mypost(),
//                mypost(),
//                mypost()


              ):new Center(
        child: new CircularProgressIndicator()),

            Padding(
              padding: const EdgeInsets.only(bottom:20.0,right: 25),
              child: FloatingActionButton(

                child: Icon(Icons.edit,color: Colors.white,),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WritePost()),
                  );
                },
                backgroundColor: Colors.black,



              ),
            )


          ],



        ),
      ),

    );
  }


  Widget mypost(name ,imgpath,id){

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        elevation: 10,
        child: Container(

          padding: EdgeInsets.all(20),
          child: Column(children: <Widget>[
            Row(

              children: <Widget>[

              CircleAvatar(child:
                Image.network("https://cdn2.iconfinder.com/data/icons/ui-v-1-circular-glyph/48/UI_v.1-Circular-Glyph-20-512.png"),
              backgroundColor: Colors.white70,
              radius: 30,
              ),
SizedBox(width: 20,),
  Text(name,style: TextStyle(fontWeight: FontWeight.bold,
  fontSize: 20
  ))

            ],),

Divider(height: 15,color: Colors.black,
thickness: 1,),
            Container(
              color: Colors.black38,
              height: 200,
              width: double.infinity,
              child:
              Image.network(imgpath,

              fit: BoxFit.fill,
              )
              ,)
            ,
            Divider(height: 15,color: Colors.black,
              thickness: 1,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(

                children: <Widget>[
Text("",style: TextStyle(fontWeight: FontWeight.bold),),
               Icon(Icons.favorite,color: Colors.red,),

SizedBox(width: 50,),
           Text("",style: TextStyle(fontWeight: FontWeight.bold)),
               InkWell(
                 onTap: (){

                   CRUD.id=id;
                   Navigator.push(
                     context,
                     MaterialPageRoute(builder: (context) => Comments()),
                   );
                 },
                 child: Icon(Icons.message
                 ,color: Colors.black,
                 ),
               )

              ],),
            )
          ],),
        ),
      ),
    );


  }



}
