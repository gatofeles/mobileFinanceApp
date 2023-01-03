import '../model/expense.dart';

abstract class ExpenseEvent {
  const ExpenseEvent();
}

class AddExpenseEvent extends ExpenseEvent {
  Expense expense;

  AddExpenseEvent({required this.expense});
}

class DeleteExpenseEvent extends ExpenseEvent {
  String expenseId;

  DeleteExpenseEvent({
    required this.expenseId,
  });
}

class LoadExpenseEvent extends ExpenseEvent {
  String userId;

  LoadExpenseEvent({
    required this.userId,
  });
}

class ShowFormEvent extends ExpenseEvent {}
