import 'package:equatable/equatable.dart';
import 'package:finance/components/card.dart';
import 'package:finance/utils/httpHelper.dart';


abstract class AuthStates extends Equatable{
  String token;
  String userId;
  bool loged;
  List<ECard>? expenses;
  List<ICard>? data;
  String dropDownSelection;
  AuthStates(
      {required this.token,
      required this.userId,
      required this.loged,
      required this.expenses,
      required this.data,
      required this.dropDownSelection,});
}

class AuthInitialState extends AuthStates {
  AuthInitialState() : super(token: '', userId: '', loged: false, expenses: [], data: [], dropDownSelection: 'Selecione');

  @override
  List<Object> get props => [token, userId, loged, expenses??[],  "initial"];

}

class AuthenticationErrorState extends AuthStates {
  AuthenticationErrorState() : super(token: '', userId: '', loged: false, expenses: [], data: [], dropDownSelection: 'Selecione');
  @override
  List<Object> get props => [token, userId, loged, expenses!, data!, "AuthError"];
}

class AuthSuccessState extends AuthStates {
  AuthSuccessState(String token, String userId) : super(token: token, userId: userId, loged: true, expenses: [], data: [], dropDownSelection: 'Selecione');
  @override
  List<Object> get props => [token, userId, loged,expenses!, data!, "AuthSuccess"];
}

class AuthenticationState extends AuthStates{
  AuthenticationState(String token, String userId)
  :super(token: token, userId: userId, loged: true, expenses: [], data: [], dropDownSelection: 'Selecione');
  @override
  List<Object> get props => [token, userId, loged,expenses!, data!, "AuthSuccess"];
}

class CreateStateFailed extends AuthStates{
  CreateStateFailed(String token, String userId, bool loged, List<ECard> expenses, List<ICard> data, String year)
  :super(token: token, userId: userId, loged: loged, expenses: expenses, data:data, dropDownSelection: year);
  @override
  List<Object> get props => [token, userId, loged,expenses!, data!, "ExpenseFail"];
}

class DeleteStateFailed extends AuthStates{
  DeleteStateFailed(String token, String userId, bool loged, List<ECard> expenses, List<ICard> data, String year)
  :super(token: token, userId: userId, loged: loged, expenses: expenses, data:data, dropDownSelection: year);
  @override
  List<Object> get props => [token, userId, loged,expenses!, data!, "DeleteExpenseFail"];
}

class ExpensesLoadedState extends AuthStates{
  ExpensesLoadedState(String token, String userId, bool loged, List<ECard> expenses, List<ICard> data, String year)
  :super(token: token, userId: userId, loged: loged, expenses: expenses, data:data, dropDownSelection: year);
  @override
  List<Object> get props => [token, userId, loged,expenses!, data!, "LoadSuccess"];
}

class SelectYearState extends AuthStates{
  SelectYearState(String token, String userId, bool loged, List<ECard> expenses, List<ICard> data, String year)
  :super(token: token, userId: userId, loged: loged, expenses: expenses, data:data, dropDownSelection: year);
  @override
  List<Object> get props => [token, userId, loged, expenses!, data!, "LoadSuccess"];
}


class DateSelectedState extends AuthStates{
  DateSelectedState(String token, String userId, bool loged, List<ECard> expenses, List<ICard> data, String date, String year)
  :super(token: token, userId: userId, loged: loged, expenses: expenses, data:data, dropDownSelection:year);
  @override
  List<Object> get props => [token, userId, loged,expenses!, data!, "LoadSuccess"];
}