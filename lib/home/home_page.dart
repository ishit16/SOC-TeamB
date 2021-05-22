import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adai/bloc/authentication_bloc.dart';
import 'package:adai/broadcast/broadcast_form.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class HomePage extends StatelessWidget {
  final _name = TextEditingController();
  final _phoneno = TextEditingController();
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
        theme: ThemeData(
          primarySwatch: Colors.red,
          brightness: Brightness.dark,
        ),
        title: 'FlutterBase',
        home: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
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
          body: Row(
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
          ),
        ));
  }
}
