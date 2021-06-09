//import 'package:adai/bloc/authentication_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:adai/login/bloc/login_bloc.dart';
import 'package:adai/globals.dart' as globals;
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class LoginFormotp extends StatefulWidget {
  final String phoneno;
  LoginFormotp(this.phoneno);
  @override
  State<LoginFormotp> createState() => _LoginFormotpState(phoneno);
}

class _LoginFormotpState extends State<LoginFormotp> {
  final String phoneno;
  _LoginFormotpState(this.phoneno);
  String _otpController;

  @override
  Widget build(BuildContext context) {
    _onLoginButtonPressed() {
      BlocProvider.of<LoginBloc>(context).add(LoginButtonPressed(
        username: globals.phone,
        password: _otpController,
      ));
      print(globals.phone);
      print(_otpController);
    }

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginFaliure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('${state.error}'),
            backgroundColor: Colors.red,
          ));
        }
      },
      child: SingleChildScrollView(
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Container(
              child: Form(
                child: Padding(
                  padding: EdgeInsets.all(40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.35),
                        child: OTPTextField(
                          length: 6,
                          width: MediaQuery.of(context).size.width * 0.7,
                          fieldWidth: MediaQuery.of(context).size.width * 0.1,
                          style: TextStyle(fontSize: 17),
                          textFieldAlignment: MainAxisAlignment.spaceAround,
                          fieldStyle: FieldStyle.underline,
                          onCompleted: (pin) {
                            _otpController = pin;
                            print("Completed: " + pin);
                          },
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.width * 0.22,
                        child: Padding(
                          padding: EdgeInsets.only(top: 30.0),
                          // ignore: deprecated_member_use
                          child: RaisedButton(
                            onPressed: state is! LoginLoading
                                ? _onLoginButtonPressed
                                : null,
                            child: Text(
                              'Login',
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
                      Container(
                        child: state is LoginLoading
                            ? CircularProgressIndicator()
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
