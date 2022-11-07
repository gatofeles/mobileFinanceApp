import 'package:equatable/equatable.dart';
import 'package:finance/utils/httpHelper.dart';

abstract class ExpenseEvent extends Equatable{
  const ExpenseEvent();
}

class AddDbExpenseEvent extends ExpenseEvent {
  ExpenseBody expense;

  AddDbExpenseEvent({
    required this.expense,
  });

  @override
  List<Object> get props => [expense];
}


class DeleteDbExpenseEvent extends ExpenseEvent {
  ICard expense;

  DeleteDbExpenseEvent({
    required this.expense,
  });

  @override
  List<Object> get props => [expense];
}

class LoadExpenseEvent extends ExpenseEvent {
  String userId;

  LoadExpenseEvent({
    required this.userId,
  });

  @override
  List<Object> get props => [userId];
}
