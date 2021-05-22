part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  const LoginButtonPressed({@required this.username, @required this.password});

  @override
  List<Object> get props => [username, password];

  @override
  String toString() =>
      'LoginButtonPressed { username: $username, password: $password }';
}

class OTPButtonPressed extends LoginEvent {
  final String phoneno;
  final UserRepository userRepository;

  const OTPButtonPressed({
    @required this.phoneno,
    @required this.userRepository,
  });

  @override
  List<Object> get props => [phoneno];

  @override
  String toString() => 'OTPButtonPressed { phone number: $phoneno }';
}
