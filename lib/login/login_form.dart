import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adai/login/bloc/login_bloc.dart';
import 'package:adai/repository/user_repository.dart';
import 'package:adai/globals.dart' as globals;
import 'package:http/http.dart' as http;

class LoginForm extends StatefulWidget {
  final UserRepository userRepository;
  LoginForm({this.userRepository});
  @override
  State<LoginForm> createState() => _LoginFormState(userRepository);
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final UserRepository userRepository;
  _LoginFormState(this.userRepository);
  @override
  Widget build(BuildContext context) {
    print("haha");
    Future<void> getotp(String phone) async {
      //print(_tokenURL);
      String phno = "+91" + phone;
      print(Uri.https('adaiapp.herokuapp.com', 'core/generate/'));
      var response = await http.post(
        Uri.https('adaiapp.herokuapp.com', 'core/generate/'),
        // headers: <String, String>{
        //   'Content-Type': 'application/json; charset=UTF-8',
        // },
        body: '{"phone":"$phno"}',
      );
      print(phno);
      print("lol");
      print(response.body);
      if (response.statusCode == 200) {
        print("otp sent successfully");
      } else {
        print("otp not sent successfully");
      }
    }

    _onLoginButtonPressed() {
      getotp(_usernameController.text);
      BlocProvider.of<LoginBloc>(context).add(OTPButtonPressed(
        phoneno: _usernameController.text,
        userRepository: userRepository,
      ));
      globals.phone = "+91" + _usernameController.text;
      print(globals.phone);
    }

    return Container(
      child: Form(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                    labelText: 'Phone No.', icon: Icon(Icons.phone)),
                keyboardType: TextInputType.number,
                //inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                controller: _usernameController,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.width * 0.22,
                child: Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  // ignore: deprecated_member_use
                  child: RaisedButton(
                    onPressed: _onLoginButtonPressed,
                    child: Text(
                      'Send OTP',
                      style: TextStyle(
                        fontSize: 24.0,
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
            ],
          ),
        ),
      ),
    );
  }
}
