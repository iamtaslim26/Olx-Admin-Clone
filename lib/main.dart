import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:olx_admin_practice_app/home_page.dart';
import 'package:olx_admin_practice_app/Login/login_page.dart';


QuerySnapshot ads;
void main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Olx Admin Practice",
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: FirebaseAuth.instance.currentUser!=null?HomePage():LoginPage(),
    );
  }
}
