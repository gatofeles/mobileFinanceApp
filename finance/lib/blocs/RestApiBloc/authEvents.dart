import 'package:equatable/equatable.dart';
import 'package:finance/utils/httpHelper.dart';

abstract class AuthEvents{
  const AuthEvents();
}

class AuthenticationEvent extends AuthEvents {
  String email;
  String password;

  AuthenticationEvent({
    required this.email, required this.password
  });

}

class RegisterEvent extends AuthEvents{

}

class CreateUserEvent extends AuthEvents{

  String email;
  String password;

  CreateUserEvent({
    required this.email, required this.password
  });

}

class LogoutEvent extends AuthEvents{

}

class Refresh extends AuthEvents{

}

