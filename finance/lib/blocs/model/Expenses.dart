import 'package:finance/components/card.dart';

import 'expense.dart';

class ExpenseCollection {
  List<String> idList = [];
  List<Expense> expenseList = [];
  List<ECard> cardList = [];

  ExpenseCollection() {
    idList = [];
    expenseList = [];
  }

  int length() {
    return idList.length;
  }

  Expense getExpenseAtIndex(int index) {
    Expense expense = expenseList[index];
   
    return Expense.withData(title: expense.title, cost: expense.cost, date: expense.date);
  }

  String getIdAtIndex(int index) {
    return idList[index];
  }

  int getIndexOfId(String id) {
    for (int i = 0; i < idList.length; i++) {
      if (id == idList[i]) {
        return i;
      }
    }
    return -1;
  }

  insertExpenseOfId(String id, Expense expense) {
      idList.add(id);
      expenseList.add(
        Expense.withData(title: expense.title, cost: expense.cost, date: expense.date),
      );
      cardList.add(ECard(id: id,card: expense));
    }

  deleteExpenseOfId(String id) {
    int index = getIndexOfId(id);
    if (index != -1) {
      expenseList.removeAt(index);
      idList.removeAt(index);
      cardList.removeAt(index);
    }
  }

}