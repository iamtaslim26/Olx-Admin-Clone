import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:olx_admin_practice_app/Login/login_page.dart';
import 'package:olx_admin_practice_app/MainScreen/all_active_page.dart';
import 'package:olx_admin_practice_app/MainScreen/all_blocked_account_page.dart';
import 'package:olx_admin_practice_app/MainScreen/approve_adds_page.dart';

import 'main.dart';

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String dateString="";
  String timeString="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    FirebaseFirestore.instance.collection("Items")
        .where("status",isEqualTo: "Not Approved")
        .get().then((results) {

      ads=results;
    });
    dateString=formattedDate(DateTime.now());
    timeString=formattedTime(DateTime.now());

    Timer.periodic(Duration(seconds: 1), (Timer t)=>getTime());
  }

  String formattedDate(DateTime dateTime) {

    return DateFormat("dd/MM/yyyy").format(dateTime);
  }
  String formattedTime(DateTime dateTime) {

    return DateFormat("hh:mm:ss a").format(dateTime);
  }

  getTime(){

    DateTime now=DateTime.now();

    final String currentDate=formattedDate(now);
    final String currentTime=formattedTime(now);

    setState(() {
      if(this.mounted){
        dateString=currentDate;
        timeString=currentTime;
      }

    });
  }

  @override
  Widget build(BuildContext context) {
   return SafeArea(
       child: Scaffold(
         backgroundColor: Colors.black87,

         appBar: AppBar(
           title: Text("Admins Home Page",
             style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold),
           ),
           centerTitle: true,
           flexibleSpace: Container(
             decoration: BoxDecoration(
               gradient: LinearGradient(
                 colors: [Colors.deepPurple,Colors.green],
                 tileMode: TileMode.clamp,
                 begin: FractionalOffset(0.0,0.0),
                 end: FractionalOffset(1.0,0.0),
                 stops: [0.0,1.0],
               )
             ),
           ),
           automaticallyImplyLeading: false,
         ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(timeString+"\n \n"+dateString,
                    style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 3.0,

                    ),
                  ),
                ),

                SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    ElevatedButton.icon(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ApproveAddPage()));
                        },
                        icon: Icon(Icons.check_box,color: Colors.white,),
                        label:Text("APPROVE NEW ADDS".toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold
                          ),

                        ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(50.0)),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    ),
                    SizedBox(width: 50.0,),
                    ElevatedButton.icon(
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>AllBlockedAccountPage()));
                        },
                        icon: Icon(Icons.person_pin,color: Colors.white,),
                        label: Text("Active user account".toUpperCase(),

                          style: TextStyle(

                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            letterSpacing: 3.0,
                            color: Colors.white
                          ),
                        ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(50.0)),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    )
                  ],
                ),

                SizedBox(height: 30.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    ElevatedButton.icon(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>AllActivePage()));
                      },
                      icon: Icon(Icons.check_box,color: Colors.white,),
                      label:Text("block User Account".toUpperCase(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold
                        ),

                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(50.0)),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    ),
                    SizedBox(width: 50.0,),
                    ElevatedButton.icon(
                      onPressed: (){
                        FirebaseAuth.instance.signOut().then((value) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPage()));
                        });
                      },
                      icon: Icon(Icons.person_pin,color: Colors.white,),
                      label: Text("logout".toUpperCase(),

                        style: TextStyle(

                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            letterSpacing: 3.0,
                            color: Colors.white
                        ),
                      ),
                      style: ButtonStyle(
                        padding: MaterialStateProperty.all(EdgeInsets.all(50.0)),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30.0,),

              ],
            ),
          ),
       )
   );


  }


}
