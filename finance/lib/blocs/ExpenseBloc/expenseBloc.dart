import 'package:finance/blocs/ExpenseBloc/expenseEvent.dart';
import 'package:finance/blocs/ExpenseBloc/expenseState.dart';
import 'package:finance/utils/expensesRepo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc() : super(ExpenseInitialState()) {
    on<AddExpenseEvent>((event, emit) async {
      await FirestoreDatabase.helper.insertExepense(event.expense);
      emit(ExpenseInitialState());
    });

    on<DeleteExpenseEvent>((event, emit) async {
      var result =
          await FirestoreDatabase.helper.deleteExpense(event.expenseId);
    });

    on<ShowFormEvent>((event, emit) async {
      emit(ExpenseFormState());
    });

    on<BackToListEvent>((event, emit) async {
      emit(ExpenseInitialState());
    });
  }
}
