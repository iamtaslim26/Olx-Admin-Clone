import 'dart:html';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:olx_admin_practice_app/MainScreen/add_details_page.dart';
import 'package:olx_admin_practice_app/home_page.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../main.dart';

class ApproveAddPage extends StatefulWidget {

  @override
  _ApproveAddPageState createState() => _ApproveAddPageState();
}

class _ApproveAddPageState extends State<ApproveAddPage> {

  FirebaseAuth auth=FirebaseAuth.instance;

  String itemColor;
  String userName;
  String userNumber;
  String itemPrice;
  String itemModel;
  String description;
  String imageUrl;
  String itemLocation;


 // QuerySnapshot ads;


  Future<bool>showItemApprovalBox(selectedDocumentId) {

     showDialog(
         context: context,
         barrierDismissible: false,
         builder: (context){
          return AlertDialog(

            title: Text(
            "Item Approval:",
            style: TextStyle(
              fontSize: 20,

              fontWeight: FontWeight.bold,
            ),
          ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
            children: <Widget>[
               Text("Do you want to approve this product?"),
           ],
          ),
          actions: [
           ElevatedButton(
               onPressed: (){
                  
                 Map<String,dynamic>adsData={
                   "status":"Approved"
                 };
                 FirebaseFirestore.instance.collection("Items").doc(selectedDocumentId).update(adsData)
                 .then((value) {
                   
                   Fluttertoast.showToast(msg: "Data Approved. . .",timeInSecForIosWeb: 2);
                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));
                   
                 });
               },
               child: Text("Approve")
           ),
           ElevatedButton(
               onPressed: (){
                 Navigator.pop(context);
               },
               child: Text("Cancel")
           ),
         ],
       );
     }
     );
   }

  @override
  Widget build(BuildContext context) {

    double screen_width=MediaQuery.of(context).size.width;
    double screen_height=MediaQuery.of(context).size.height;

   Widget showAdsList() {

     if(ads!=null){

       return ListView.builder(

           itemCount: ads.docs.length,
           padding: EdgeInsets.all(8.0),
           itemBuilder: (context,index){
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: <Widget>[

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(ads.docs[index].get("imgPro")),
                              fit: BoxFit.fill,
                            )
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(left: 16,right: 16),
                          child: Text(ads.docs[index].get("userName"),
                            style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.black),
                          ),
                        ),
                        trailing:  Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              GestureDetector(
                                onTap: (){
                                    showItemApprovalBox(ads.docs[index].id);
                                },
                                child: Icon(Icons.fact_check_rounded),
                              ),
                              SizedBox(width: 10.0,),
                              GestureDetector(
                                onTap: (){
                                  showItemApprovalBox(ads.docs[index].id);
                                },
                                child: Text("Approve this add?",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,

                                )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // AddImage
                    SizedBox(height: 20.0,),

                    GestureDetector(

                      onDoubleTap: (){

                        Route newRoute=MaterialPageRoute(builder: (context)=>AddDetailsPage(

                          itemColor:ads.docs[index].get("itemColor"),
                          title:ads.docs[index].get("itemModel"),
                          description:ads.docs[index].get("description"),
                          userNumber:ads.docs[index].get("userNumber"),
                          userName:ads.docs[index].get("userName"),
                          address:ads.docs[index].get("address"),
                          urlImage1:ads.docs[index].get("urlImage1"),
                          urlImage2:ads.docs[index].get("urlImage2"),
                          urlImage3:ads.docs[index].get("urlImage3"),
                          lat:ads.docs[index].get("lat"),
                          lon:ads.docs[index].get("lon"),

                        ));
                        Navigator.pushReplacement(context, newRoute);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.network(ads.docs[index].get("urlImage1"),
                        width: screen_width,
                        height: screen_height/2,),
                      ),
                    ),

                  SizedBox(height: 10.0,),

                    //ItemPrice

                    Text(
                      "\$ " +ads.docs[index].get("itemPrice"),
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                    ),),

                    //ItemModel and DateTime

                    Padding(
                      padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          Row(
                            children: <Widget>[
                              Icon(Icons.image_sharp),

                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Align(
                                  child: Text(ads.docs[index].get("itemModel")),
                                  alignment: Alignment.topLeft,
                                )
                              ),
                            ],
                          ),

                          Row(
                            children: <Widget>[
                              Icon(Icons.watch_later_outlined),

                              Padding(
                                  padding: const EdgeInsets.only(left: 10.0),
                                  child: Align(
                                    child: Text(timeago.format(ads.docs[index].get("time").toDate())),
                                    alignment: Alignment.topLeft


                                    ,
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 20.0,),

                  ],
                ),
              );
           }
       );
     }
     else{
       Center(
         child: Text("Loading. . .. "),
       );
     }

   }


 /*   Widget showAdsList() {
      if(ads != null)
      {
        return ListView.builder(
          itemCount: ads.docs.length,
          padding: EdgeInsets.all(8.0),
          itemBuilder: (context, index)
          {
            return Card(
              clipBehavior: Clip.antiAlias,

                child: Column(
                  children: <Widget>[
                    ListTile(
                        leading: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(ads.docs[index].get("imgPro"),
                              ),
                              fit: BoxFit.cover
                            )
                          ),
                        ),
                      title: Text(ads.docs[index].get("userName"),
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                      trailing: Row(
                          children: <Widget>[
                            GestureDetector(
                              onTap: (){

                              },
                              child: Icon(Icons.fact_check_rounded),
                            ),
                            SizedBox(width: 20,),
                            GestureDetector(
                              onTap: (){

                              },
                              child: Text("Approve this?",
                              style:TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                              ),
                                ),
                            ),

                          ],
                      ),
                    ),

                    // AddImage

                      GestureDetector(
                        onDoubleTap: (){
                          //SendUserToDetailsActivity
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Image.network(ads.docs[index].get("urlImage1"),
                            width: 200,
                            height: 200,
                          ),
                        ),
                      ),

                    // ItemPrice

                    Padding(
                      padding: const EdgeInsets.only(left: 10,right: 10),
                      child: Text(ads.docs[index].get("itemPrice")),
                    ),

                    // Item Model and Time

                    Padding(
                      padding: const EdgeInsets.only(left: 16,right: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Item Model

                        ],



                      ),
                    )

                  ],
                ),

            );
          },
        );
      }
      else
      {
        return Center(
          child: Text(
            "Loading...",
          ),
        );
      }
    }

  */

    return Scaffold(

      appBar: AppBar(
        title: Text("Approve Ads",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
          },
          icon: Icon(Icons.arrow_back),
        ),

        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple,Colors.green],
              begin: FractionalOffset(0.0,0.0),
              end: FractionalOffset(0.0,1.0),
              stops: [0.0,1.0],
              tileMode: TileMode.clamp,
            )
          ),
        ),
        actions: [
          IconButton(
          onPressed: (){

            Navigator.push(context, MaterialPageRoute(builder: (context)=>ApproveAddPage()));
          },
          icon: Icon(Icons.refresh_outlined)
          ),
        ],
      ),

      body: Center(
        child: Container(
          width: screen_width*.5,
          child: showAdsList(),
        ),
      ),

    );
  }




}
