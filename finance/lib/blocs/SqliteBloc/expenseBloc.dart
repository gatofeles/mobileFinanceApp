import 'package:finance/blocs/SqliteBloc/expenseEvent.dart';
import 'package:finance/blocs/SqliteBloc/expenseState.dart';
import 'package:finance/blocs/model/Expense.dart';
import 'package:finance/components/card.dart';
import 'package:finance/utils/httpHelper.dart';
import 'package:finance/utils/sqliteRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {


  ExpenseBloc() : super(ExpenseInitialState()) {
    on<AddDbExpenseEvent>((event, emit) async {
      Expense newExpense = Expense(
          userId: event.expense.userId,
          title: event.expense.title,
          cost: event.expense.cost,
          date: event.expense.date);

      await DataBaseProvider.instance.createExpense(newExpense);
    });

    on<DeleteDbExpenseEvent>((event, emit) async {
      var result = await DataBaseProvider.instance.deleteExpense(int.parse(event.expense.id));
    });

    on<LoadExpenseEvent>((event, emit) async {
      List<ECard> expensesEcard = [];
      List<ICard> expensesIcard = [];
      if (event.userId != "") {
        final dbData = await DataBaseProvider.instance.getExpenses(event.userId);
        dbData.forEach((expense) {
          ICard card = ICard(expense.title, expense.cost, "", expense.date,
              expense.id.toString());
          expensesIcard.add(card);
        });

        expensesIcard.forEach((icard) {
          expensesEcard.add(ECard(card: icard));
        });

        emit(LoadExpenseState(
            data: expensesIcard,
            expenses: expensesEcard,
            userId: state.userId));
      }
    });
  }
}
