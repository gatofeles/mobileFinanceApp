import 'package:equatable/equatable.dart';
import 'package:finance/blocs/ExpenseBloc/expenseEvent.dart';
import 'package:finance/components/card.dart';
import 'package:finance/utils/httpHelper.dart';

abstract class ExpenseState {
  ExpenseState();
}

class ExpenseInitialState extends ExpenseState {}

class ExpenseFormState extends ExpenseState {}

class ExpenseAddedState extends ExpenseState {}

class ExpenseErrorState extends ExpenseState {}
