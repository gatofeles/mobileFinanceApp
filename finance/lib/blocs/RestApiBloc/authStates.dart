import 'package:equatable/equatable.dart';
import 'package:finance/components/card.dart';
import 'package:finance/utils/httpHelper.dart';


abstract class AuthStates{
  String? token;
  String? userId;

  AuthStates(
      {this.token, this.userId,});
}

class AuthInitialState extends AuthStates {
  AuthInitialState() : super(token: '', userId: '');

}

class AuthenticationErrorState extends AuthStates {

}

class AuthSuccessState extends AuthStates {
  AuthSuccessState(String userId) : super(userId: userId);

}


class RegisterState extends AuthStates{

}