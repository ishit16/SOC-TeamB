part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final User user;

  const LoggedIn({@required this.user});

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'LoggedIn { user: $user.username.toString() }';
}

class LoggedOut extends AuthenticationEvent {}

class OTPsend extends AuthenticationEvent {
  final String phoneno;
  final UserRepository userRepository;

  const OTPsend({@required this.phoneno, @required this.userRepository});

  @override
  List<Object> get props => [phoneno];

  @override
  String toString() => 'OTPsent { phoneno: $phoneno }';
}
