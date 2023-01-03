import 'package:equatable/equatable.dart';
import 'package:finance/blocs/ExpenseBloc/expenseEvent.dart';
import 'package:finance/components/card.dart';
import 'package:finance/utils/httpHelper.dart';

abstract class ExpenseState {
  List<ECard>? expenses;
  List<ICard>? data;
  String? userId;
  String? year = "Select";

  ExpenseState({this.userId, this.expenses, this.data, this.year});
}

class ExpenseInitialState extends ExpenseState {
  ExpenseInitialState() : super(userId: "", expenses: [], data: []);
}

class SetUserState extends ExpenseState {
  SetUserState(
      {required List<ICard> data,
      required List<ECard> expenses,
      required String userId})
      : super(userId: userId, expenses: expenses, data: data);
}

class LoadExpenseState extends ExpenseState {
  LoadExpenseState(
      {required List<ICard> data,
      required List<ECard> expenses,
      required String userId})
      : super(userId: userId, expenses: expenses, data: data);
}

class SelectYearState extends ExpenseState {
  SelectYearState(String year) : super(year: year);
}
