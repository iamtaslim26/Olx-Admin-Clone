import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../home_page.dart';

class AllBlockedAccountPage extends StatefulWidget {


  @override
  _AllBlockedAccountPageState createState() => _AllBlockedAccountPageState();
}

class _AllBlockedAccountPageState extends State<AllBlockedAccountPage> {

  QuerySnapshot users;

  initState(){
    super.initState();

    FirebaseFirestore.instance.collection("Olx Users").where("status",isEqualTo: "Not Approved")
    .get().then((value) {

      setState(() {
        users=value;
      });
    });
  }

  Future showDialogToBlockAccount(String documentId)async {

    showDialog(context: context,
        builder: (_){
          return AlertDialog(

            title: Text("Active this Account",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black
              ),),

            content: Column(
              mainAxisSize: MainAxisSize.min,
              children:<Widget> [

                Text("Do you want to Active this account?"),

              ],

            ),
            actions: [
              ElevatedButton(
                  onPressed: (){

                    Map<String,dynamic>userData={

                      "status":"approved",

                    };
                    FirebaseFirestore.instance.collection("Olx Users").doc(documentId).update(userData)
                        .then((value) {

                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));

                      Fluttertoast.showToast(msg: "Account Activated Successfully. . .",timeInSecForIosWeb: 2);

                    }).catchError((error){

                      Fluttertoast.showToast(msg: "Failed....   "+error.toString(),timeInSecForIosWeb: 2);
                    });

                  },
                  child: Text("yes")
              ),
              SizedBox(width: 5.0,),

              ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  child: Text("No")
              ),
              SizedBox(height: 5.0,),
            ],

          );
        }
    );
  }
  @override
  Widget build(BuildContext context) {

    double _screenWidth = MediaQuery
        .of(context)
        .size
        .width,
        _screenHeight = MediaQuery
            .of(context)
            .size
            .height;

    Widget showAccountList() {

      if(users!=null){

        return ListView.builder(
            itemCount: users.docs.length,
            padding: EdgeInsets.all(12.0),
            itemBuilder: (context,index){

              return Center(
                child: Card(
                    clipBehavior: Clip.antiAlias,

                    child:Column(
                      mainAxisSize: MainAxisSize.min,
                      children:<Widget> [

                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(

                            leading: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image:DecorationImage(
                                    image: NetworkImage(
                                      users.docs[index].get("imageUrl"),
                                    ),
                                    fit: BoxFit.cover,

                                  )

                              ),
                            ),
                            title: Text(users.docs[index].get("userName"),
                              style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black
                              ),),
                            trailing: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.phone_android_outlined),
                                  SizedBox(width: 10.0,),
                                  Text(users.docs[index].get("phone"),
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, letterSpacing: 2.0),)
                                ],
                              ),
                            ),
                          ),

                        ),
                        ElevatedButton.icon(
                          onPressed:(){
                            showDialogToBlockAccount(users.docs[index].id);
                          },
                          icon: Icon(Icons.person_pin_rounded),
                          label: Text("Active this Account".toUpperCase(),
                            style: TextStyle(fontSize: 14.0, color: Colors.white, fontFamily: "Varela", letterSpacing: 3.0),),
                          style: ButtonStyle(

                              padding: MaterialStateProperty.all(EdgeInsets.all(20.0)),
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                              foregroundColor:MaterialStateProperty.all<Color>(Colors.white)
                          ),

                        ),
                        SizedBox(height: 20.0,),
                      ],
                    )
                ),
              );
            }
        );
      }
      else{
        Center(
          child: Text("Loading....."),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("All Blocked Accounts"),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
          },
          icon: Icon(Icons.arrow_back),
        ),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>AllBlockedAccountPage()));
              },
              icon: Icon(Icons.refresh_outlined)
          ),
        ],
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  tileMode: TileMode.clamp,
                  begin: FractionalOffset(0.0,0.0),
                  end: FractionalOffset(0.0,1.0),
                  stops: [1.0,0.0],
                  colors: [Colors.deepPurple,Colors.green]
              )
          ),
        ),
      ),
      body: Center(
        child: Container(
          width: _screenWidth * .5,
          height: _screenHeight*0.5,
          child: showAccountList(),
        ),
      ),
    );
  }
}
