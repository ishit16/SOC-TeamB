import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:adai/login/bloc/login_bloc.dart';

// ignore: camel_case_types
class broadcastform extends StatefulWidget {
  @override
  State<broadcastform> createState() => _BroadcastFormState();
}

class _BroadcastFormState extends State<broadcastform> {
  File selectedImage;
  final picker = ImagePicker();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future getCameraImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    //var image = await ImagePicker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    //return image;
    Navigator.pop(context);
  }

  Future getGalleryImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    Navigator.pop(context);
  }

  void _onAlertPress() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/gallery.png',
                      width: 50,
                    ),
                    Text('Gallery'),
                  ],
                ),
                onPressed: getGalleryImage,
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'assets/images/take_picture.png',
                      width: 50,
                    ),
                    Text('Take Photo'),
                  ],
                ),
                onPressed: getCameraImage,
              ),
            ],
          );
        });
  }

  Future<void> _getImage() async {
    if (selectedImage != null) {
      // var imageFile = selectedImage;
      /*var image = imageLib.decodeImage(imageFile.readAsBytesSync());
    fileName = basename(imageFile.path);
    image = imageLib.copyResize(image,
        width: (MediaQuery.of(context).size.width * 0.8).toInt(),
        height: (MediaQuery.of(context).size.height * 0.7).toInt());
    _image = image;*/
    }
  }

  @override
  Widget build(BuildContext context) {
    tf() {}
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.red,
          brightness: Brightness.dark,
        ),
        home: Scaffold(
            body: Container(
                child: Form(
                    child: Padding(
                        padding: EdgeInsets.all(40.0),
                        child: SingleChildScrollView(
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                    padding: EdgeInsets.only(
                                        top:
                                            MediaQuery.of(context).size.height *
                                                0.15),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: 'username',
                                          icon: Icon(Icons.person)),
                                      controller: _usernameController,
                                    )),
                                TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'password',
                                      icon: Icon(Icons.security)),
                                  controller: _passwordController,
                                  obscureText: true,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width * 0.5,
                                  height:
                                      MediaQuery.of(context).size.height * 0.25,
                                  margin: EdgeInsets.only(top: 30, bottom: 40),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(top: 10, bottom: 10),
                                    child: FutureBuilder(
                                      future: _getImage(),
                                      builder: (context, snapshot) {
                                        switch (snapshot.connectionState) {
                                          case ConnectionState.none:
                                            return Text('Please wait');
                                          case ConnectionState.waiting:
                                            return Center(
                                                child:
                                                    CircularProgressIndicator());
                                          default:
                                            if (snapshot.hasError)
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            else {
                                              return selectedImage != null
                                                  ? Image.file(selectedImage)
                                                  : Center(
                                                      child: Text(
                                                          "Please Get the Image"),
                                                    );
                                            }
                                        }
                                      },
                                    ),
                                  ),
                                  //padding: EdgeInsets.only(top: 10, bottom: 10),
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: Colors.grey[500])),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.55,
                                  height:
                                      MediaQuery.of(context).size.width * 0.20,
                                  child: Padding(
                                    padding: EdgeInsets.only(top: 20.0),
                                    child: RaisedButton(
                                      onPressed: tf(),
                                      child: Text(
                                        'Broadcast',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                      shape: StadiumBorder(
                                        side: BorderSide(
                                          color: Colors.black,
                                          width: 2,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ]),
                        )))),
            floatingActionButton: FloatingActionButton(
              onPressed: _onAlertPress,
              tooltip: 'Pick Image',
              child: Icon(Icons.add_a_photo),
            )));

    //resize the image
  }
}
