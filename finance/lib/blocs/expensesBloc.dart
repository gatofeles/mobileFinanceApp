import 'package:finance/utils/httpHelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../utils/httpHelper.dart' show HttpHelper;
import '../utils/httpHelper.dart' show ICard;

enum ExpenseEvent { get }

class ExpenseState {
  List<ICard>? expenses;

  ExpenseState({this.expenses});
}

class ExpenseBloc extends Bloc<ExpenseEvent, ExpenseState> {
  ExpenseBloc(String token, String userId) : super(ExpenseState()) {
    on<ExpenseEvent>((event, emit) async {
      switch (event) {
        case ExpenseEvent.get:
          var httpHelper = HttpHelper();
          var expenseList = await httpHelper.GetAllExpesenses(userId, token);
          emit(ExpenseState(expenses: expenseList));
          break;
      }
    });
  }
}
