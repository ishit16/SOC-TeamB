import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:adai/bloc/authentication_bloc.dart';
import 'package:adai/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:adai/globals.dart' as globals;

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({
    @required this.userRepository,
    @required this.authenticationBloc,
  })  : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginInitial1();

      try {
        final user = await userRepository.authenticate(
          username: event.username,
          password: event.password,
        );

        authenticationBloc.add(LoggedIn(user: user));
        globals.phone = "";
        //Navigator.pop(event.con);
        yield LoginInitial1();
      } catch (error) {
        yield LoginFaliure(error: error.toString());
      }
    }

    if (event is OTPButtonPressed) {
      yield LoginInitial1();
      authenticationBloc.add(OTPsend(
          phoneno: event.phoneno, userRepository: event.userRepository));
    }
  }
}
