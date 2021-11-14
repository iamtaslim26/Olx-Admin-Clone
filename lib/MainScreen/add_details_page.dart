import 'dart:html';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_slider/image_slider.dart';

class AddDetailsPage extends StatefulWidget {

  final String title,description,userNumber,userName,itemColor,address;
  final String urlImage1,urlImage2,urlImage3;
  final lat,lon;

  const AddDetailsPage({Key key,
    this.title,
    this.description,
    this.userNumber,
    this.userName,
    this.itemColor,
    this.address,
    this.urlImage1,
    this.urlImage2,
    this.urlImage3,
    this.lat,
    this.lon}) : super(key: key);

  @override
  _AddDetailsPageState createState() => _AddDetailsPageState();
}

class _AddDetailsPageState extends State<AddDetailsPage> with SingleTickerProviderStateMixin{

  TabController tabController;
 static List<String>links=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLinks();

    tabController=TabController(length: 3, vsync: this);
  }

  getLinks(){

    links.add(widget.urlImage1);
    links.add(widget.urlImage2);
    links.add(widget.urlImage3);
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

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
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

      body: SingleChildScrollView(
        child: Center(
          child: Container(
            //width: _screenWidth/2,
            child: Column(
             // mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0,left: 6.0,right: 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      //mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Icon(Icons.location_pin,color: Colors.deepPurple,),
                        SizedBox(width: 4,),
                        Expanded(
                            child:Text(widget.address,
                              textAlign: TextAlign.justify,
                              overflow: TextOverflow.fade,
                              style: TextStyle(letterSpacing: 2.0),
                            ),

                        )
                      ],
                    ),
                  ),
                SizedBox(height: 20.0,),

                Container(
                  margin: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    border:Border.all(width: 2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ImageSlider(

                    showTabIndicator: false,
                    autoSlide: true,
                    height: _screenHeight/2,
                    width: _screenWidth/2,
                    curve: Curves.fastOutSlowIn,
                    allowManualSlide: true,
                    duration: new Duration(seconds: 2),
                    tabController: tabController,
                    children:
                      links.map((String link){
                        return ClipRRect(
                            child: Image.network(link,
                              width: _screenWidth,
                              height: 300,
                              fit: BoxFit.fill,
                            ),
                          borderRadius: BorderRadius.circular(10.0),

                        );
                        }).toList(),


                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // index==0
                      tabController.index==0?Container(width: 0,height: 0,)
                          :ElevatedButton(
                             onPressed: (){
                                    tabController.animateTo(tabController.index-1);
                                    setState(() {

                                    });
                            },
                            child: Text("Previous",style: TextStyle(color: Colors.white),),

                          style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple
                        ),

                    ),
                      // index==2

                      tabController.index==2?Container(width: 0,height: 0,)
                          :ElevatedButton(
                          onPressed: (){
                            tabController.animateTo(tabController.index+1)  ;
                            setState(() {

                            });
                          },
                            child: Text("Next",style: TextStyle(color: Colors.white),),

                          style: ElevatedButton.styleFrom(
                            primary: Colors.deepPurple
                          ),

                      ),

                    ],
                  ),
                ),
                SizedBox(height: 20.0,),

                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      // ItemColor
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                        child: Row(
                          children: [
                            Icon(Icons.brush_outlined,),
                            Padding(
                              padding:const EdgeInsets.all(20.0),
                              child: Align(
                                child:Text(widget.itemColor),
                                alignment: Alignment.topLeft,
                              ),

                            ),



                          ],
                        ),

                      ),
                      //UserNumber

                      Row(
                        children: [
                          Icon(Icons.phone_android,),
                          Padding(
                            padding:const EdgeInsets.all(8.0),
                            child: Align(
                              child:Text(widget.userNumber),
                              alignment: Alignment.topLeft,
                            ),

                          ),

                        ],
                      ),


                    ],
                  ),
                ),
                SizedBox(height: 15,),

                Padding(
                  padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                  child: Text(widget.description,
                    style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.bold,color: Colors.black),
                    textAlign: TextAlign.justify,
                  ),
                ),
                SizedBox(height: 20.0,),



              ],
            ),
          ),
        ),
      ),
    );
  }
}
