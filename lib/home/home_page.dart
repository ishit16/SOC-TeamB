import 'package:adai/get_poster.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adai/bloc/authentication_bloc.dart';
import 'package:adai/broadcast/broadcast_form.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:flutter_card_swipper/flutter_card_swiper.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  final _name = TextEditingController();
  final _phoneno = TextEditingController();
  final imageList =['assets/download (1).jpg',
    'assets/spacee-2060x1288.jpg',
  ];
  List<String> poster =  <String>[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPosters();
  }
  getPosters() async{
    GetPoster posterClass = GetPoster();
    await posterClass.getPoster();
    poster = posterClass.posters;

  }

  @override
  Widget build(BuildContext context) {
    void handleClick(String value) {
      //handles on click operation of popdown list of logout and change password
      switch (value) {
        case 'Logout':
          {
            //log_out();
            BlocProvider.of<AuthenticationBloc>(context)
                .add(LoggedOut()); //to logout
            break;
          }
      }
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        /*theme: ThemeData(

          primarySwatch: Colors.deepPurple,
          brightness: Brightness.dark,
        ),*/
        title: 'FlutterBase',
        home: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar:  AppBar(
            backgroundColor: Colors.transparent,

            elevation: 0.0,
            title: Text('HOME'),
            centerTitle: true,
            actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: handleClick,
                itemBuilder: (BuildContext context) {
                  return {'Logout'}.map((String choice) {
                    //pop down list of logout and change password
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  }).toList();
                },
              ),
            ],
          ),

          drawer: Drawer(),
          body:Stack(
            children:[
              Container(
                  height: MediaQuery.of(context).size.height,
                  width:MediaQuery.of(context).size.width,
                  decoration:BoxDecoration(
                    gradient:LinearGradient(
                      colors: [Colors.deepPurpleAccent,Colors.purple[200]],
                    ) ,

                  )
              ),
              Positioned(
                top:100.0,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width:MediaQuery.of(context).size.width,
                  decoration:BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(45.0),
                      topRight: Radius.circular(45.0),
                    ),
                    color:Color(0xFF121B23),
                  ),
                ),
              ),
              Positioned(
                top:120.0,
                height: MediaQuery.of(context).size.height-100.0,
                width:MediaQuery.of(context).size.width,
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  margin:EdgeInsets.fromLTRB(10,0,10,60),
                  child: new Swiper(
                    itemCount: imageList.length,
                    itemBuilder: (context,index){
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(45),
                        child: Image.asset(
                          imageList[index],
                          fit:BoxFit.fill,
                        ),
                      );
                    },
                    itemWidth: 400,
                    itemHeight: 650,
                    layout: SwiperLayout.STACK,
                  ),
                ),
              ),

            ],
          ),
          floatingActionButton: Container(
            height:70.0,
            width:70.0,
            child: FittedBox(
              child: FloatingActionButton(onPressed:(){},
                backgroundColor: Colors.deepPurpleAccent,
                elevation: 15,
                child: Icon(Icons.add),
              ),
            ),
          ),
          extendBody: true,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: Padding(
            padding:const EdgeInsets.fromLTRB(40,0,40,10),
            child: Material(
              elevation: 10,
              borderRadius: BorderRadius.circular(40),
              color:Colors.purple[900],
              child:Container(
                width:double.infinity,
                height:70,
                child:Padding(
                  padding: const EdgeInsets.symmetric(horizontal:40.0),
                  child: Row(
                    mainAxisAlignment : MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.contact_phone_outlined,size: 40.0,color: Colors.purple[50],),
                      Icon(Icons.person_outline_sharp,size: 40.0,color: Colors.purple[50],),
                    ],
                  ),
                ),
              ),
            ),
          ) ,
        ));
  }

  }







/*Row(
mainAxisAlignment: MainAxisAlignment.center,
mainAxisSize: MainAxisSize.max,
crossAxisAlignment: CrossAxisAlignment.center,
children: <Widget>[
// padding: EdgeInsets.all(20),
//margin: EdgeInsets.all(60),
Container(
margin: EdgeInsets.all(60),
padding: EdgeInsets.all(20),
child: RaisedButton(
padding: EdgeInsets.all(20),
focusColor: Colors.red,
onPressed: () {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => broadcastform()),
);
},
child: Text(
'Broadcast Update',
style: TextStyle(
fontSize: 24.0,
color: Colors.white,
),
),
shape: RoundedRectangleBorder(
borderRadius: BorderRadius.circular(10),
side: BorderSide(
color: Colors.black,
width: 2,
),
),
// shape: StadiumBorder(
//   side: BorderSide(
//     color: Colors.black,
//     width: 2,
//   ),
// ),
color: Colors.red,
textColor: Colors.white,
highlightColor: Colors.red,
))
]),
floatingActionButton: FloatingActionButton.extended(
onPressed: () {
Alert(
context: context,
title: "Add a Customer",
content: Column(
children: <Widget>[
TextFormField(
decoration: InputDecoration(
icon: Icon(Icons.queue),
labelText: 'Name',
),
controller: _phoneno,
),
TextFormField(
decoration: InputDecoration(
icon: Icon(Icons.queue),
labelText: 'Phone No.',
),
controller: _name,
),
],
),
buttons: [
DialogButton(
onPressed: () {},
child: Text(
"Add",
style: TextStyle(color: Colors.black, fontSize: 20),
),
)
]).show();
},
icon: Icon(Icons.add),
label: Text('Add new customers'),
),*/