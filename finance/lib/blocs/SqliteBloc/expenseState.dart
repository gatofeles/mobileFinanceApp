import 'package:equatable/equatable.dart';
import 'package:finance/blocs/SqliteBloc/expenseEvent.dart';
import 'package:finance/components/card.dart';
import 'package:finance/utils/httpHelper.dart';

abstract class ExpenseState extends Equatable{

  List<ECard> expenses;
  List<ICard> data;
  String userId;

  ExpenseState({required this.userId, required this.expenses, required this.data});

}

class ExpenseInitialState extends ExpenseState{
  ExpenseInitialState():super(userId:"", expenses: [], data:[]);
  @override
  List<Object> get props => [userId, expenses!, data!];
}

class SetUserState extends ExpenseState{
  SetUserState({required List<ICard> data,required List<ECard> expenses,required String userId}):super(userId: userId, expenses: expenses, data: data);
  @override
  List<Object> get props => [userId, expenses??[], data??[]];
}

class LoadExpenseState extends ExpenseState{
  LoadExpenseState({required List<ICard> data,required List<ECard> expenses,required String userId}):super(userId: userId, expenses: expenses, data: data);
  @override
  List<Object> get props => [expenses??[], data??[]];
}