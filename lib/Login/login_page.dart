import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:olx_admin_practice_app/DialogBox/errordialog.dart';
import 'package:olx_admin_practice_app/DialogBox/loadingdialog.dart';
import 'package:olx_admin_practice_app/Login/backgroundPainter.dart';

import '../home_page.dart';

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  String email="";
  String password="";

  FirebaseAuth auth=FirebaseAuth.instance;



  loginAdmin() async{

    User currentUser;

    showDialog(
        context: context,
        builder: (_){
          return LoadingDialogBox();
    }
    );
    await auth.signInWithEmailAndPassword(email: email, password: password)
    .then((value) {

      currentUser=value.user;

    }).catchError((error){

      showDialog(context: context, builder: (_){
        return ErrorDialogBox(
          message: "Failed  "+error.toString(),
        );
      });
    });
    if(auth.currentUser!=null){
      Route newRoute=MaterialPageRoute(builder: (context)=>HomePage());
      Navigator.pushReplacement(context, newRoute);
    }

  }

  @override
  Widget build(BuildContext context) {

    double screenwidth=MediaQuery.of(context).size.width;
    double screenheight=MediaQuery.of(context).size.height;


    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[

          CustomPaint(
            painter: BackgroundPainter(),
            child: Container(
              height: screenheight,
            ),
          ),
          Center(
            child: Container(
              width: screenwidth/2,
              child: Column(
                children: <Widget>[
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Image.asset("images/admin.png",
                      width: 200,
                        height: 200,
                      ),
                    ),
                  ),

                  SizedBox(height: 20.0,),
                  Padding(
                      padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child:
                    TextField(
                      onChanged: (value){
                        email=value;
                      },
                      style: TextStyle(color: Colors.white,fontSize: 15.0),
                      obscureText: false,
                      decoration: InputDecoration(
                          hintText:"Email.....",
                          hintStyle: TextStyle(color: Colors.white,fontSize: 15.0),

                          enabledBorder: OutlineInputBorder(

                              borderSide: BorderSide(color: Colors.green)
                          ),
                          icon: Icon(
                            Icons.person,
                            color: Colors.green,
                          )
                      ),
                    ),

                  ),

                  SizedBox(height: 20.0,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.0),
                    child:   TextField(
                      onChanged: (value){
                        password=value;
                      },
                      style: TextStyle(color: Colors.white,fontSize: 15.0),
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText:"Password. . .",
                          hintStyle: TextStyle(color: Colors.white,fontSize: 15.0),

                          enabledBorder: OutlineInputBorder(

                              borderSide: BorderSide(color: Colors.green)
                          ),
                          icon: Icon(
                            Icons.lock,
                            color: Colors.green,
                          )
                      ),
                    ),

                  ),
                  SizedBox(height: 20.0,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(padding: EdgeInsets.symmetric(horizontal: 50.0),
                          child:  ElevatedButton(
                            onPressed: (){

                              if(email!="" && password!=""){

                                loginAdmin();
                              }

                              },
                              child: Text("Login"),
                      )
                      )],
                  )


                ],
              ),
            ),
          )
        ],
      ),
    );
  }




}
