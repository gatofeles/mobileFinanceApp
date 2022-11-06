

import 'package:equatable/equatable.dart';
import 'package:finance/utils/httpHelper.dart';

abstract class AuthEvents extends Equatable{
  const AuthEvents();
}

class InitiateEvent extends AuthEvents {

  @override
  List<Object> get props => [];
}

class AddExpenseEvent extends AuthEvents {
  ExpenseBody expense;

  AddExpenseEvent({
    required this.expense,
  });

  @override
  List<Object> get props => [expense];
}

class LoadExpenses extends AuthEvents{
    @override
  List<Object> get props => [];
}

class RemoveExpenseEvent extends AuthEvents {
  ICard expense;

  RemoveExpenseEvent({
    required this.expense,
  });

  @override
  List<Object> get props => [expense];
}

class SelectYearEvent extends AuthEvents {
  String year;

  SelectYearEvent({
    required this.year,
  });

  @override
  List<Object> get props => [year];
}

class AuthenticationEvent extends AuthEvents {
  String token;
  String userId;

  AuthenticationEvent({
    required this.token, required this.userId
  });

   @override
  List<Object> get props => [token, userId];
}
