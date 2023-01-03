import 'package:finance/blocs/ExpenseBloc/monitorBloc.dart';
import 'package:finance/blocs/RestApiBloc/authStates.dart';
import 'package:finance/pages/expenses.dart';
import 'package:finance/pages/noFormExpenses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/ExpenseBloc/expenseBloc.dart';
import '../blocs/ExpenseBloc/expenseState.dart';

class ExpensesWrapper extends StatefulWidget {
  const ExpensesWrapper({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ExpensesWrapperState();
  }
}

class ExpensesWrapperState extends State<ExpensesWrapper> {
  @override
  Widget build(BuildContext context) {
    MonitorBloc monitor = context.watch<MonitorBloc>();
    return BlocConsumer<ExpenseBloc, ExpenseState>(
      listener: (context, state) {
        if (state is ExpenseErrorState) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Expenses Manager Error"),
                  content: Text("Could not add or load expense."),
                );
              });
        }
      },
      builder: (context, state) {
        if (state is ExpenseInitialState) {
          monitor.add(AskNewList());
          return NoFormExpenses();
        } else {
          return Expenses();
        }
      },
    );
  }
}
